const { promisify } = require('util');
const mysql = require('mysql');
const { generate } = require('shortid');

const generateClasses = require('./generate-classes');
const flatten = require('./flatten');

const arg = process.argv[process.argv.length - 1];

const SCHUELER_PRO_KLASSE = 20;
const KLASSEN_EBENEN = 3;
const KLASSEN_LIMIT = Number(arg) || 10000;
const KLASSEN_GRADE = 5;

const grades = Array(KLASSEN_GRADE)
  .fill(null)
  .map((_, i) => i + 1);

const makeSchuelerQuery = klasse =>
  `INSERT INTO s_schueler
  VALUES("${generate()}", "${generate()}", "${klasse}")`;

const makeKlasseQuery = k =>
  `INSERT INTO k_klassen VALUES("${k}", "${generate()}")`;

console.info('settings:', {
  KLASSEN_LIMIT,
  KLASSEN_GRADE,
  KLASSEN_EBENEN
});

console.info('date:', new Date());

// console.log('Klassen werden generiert...');
console.time('generate_klassen');
const klassen = generateClasses(KLASSEN_EBENEN)(grades).slice(0, KLASSEN_LIMIT);
console.timeEnd('generate_klassen');
console.info('count klassen:', klassen.length);

// console.log('Schüler werden generiert...');
console.time('generate_schueler');
const schueler = flatten(klassen.map(k => Array(SCHUELER_PRO_KLASSE).fill(k)));
console.timeEnd('generate_schueler');
console.info('count schueler:', schueler.length);
console.info('count records:', schueler.length + klassen.length);

const pool = mysql.createPool({
  connectionLimit: 10,
  host: 'localhost',
  user: 'root',
  password: process.env.password,
  database: 'schooldb_indexes'
});

const createSchuelerQuery = `
  CREATE TABLE s_schueler (
    s_schnr VARCHAR(20) PRIMARY KEY,
    s_name VARCHAR(20),
    s_k_klasse VARCHAR(20)
  ) ENGINE = InnoDB;
`;

const createKlassenQuery = `
  CREATE TABLE k_klassen (
    k_id VARCHAR(20) PRIMARY KEY,
    k_klavstd VARCHAR(20)
  ) ENGINE = InnoDB;
`;

const addForeignKey = `
  ALTER TABLE s_schueler
    ADD FOREIGN KEY (s_k_klasse) REFERENCES k_klassen (k_id);
`;

pool.getConnection(async (err, connection) => {
  const query = promisify(connection.query).bind(connection);

  if (err) console.error(err);

  // console.log('Datenbank wird vorbereitet...');
  // console.time('preparation');
  await query('DROP TABLE IF EXISTS s_schueler');
  await query('DROP TABLE IF EXISTS k_klassen');
  await query(createSchuelerQuery);
  await query(createKlassenQuery);
  // console.timeEnd('preparation');

  // console.log('Klassen werden eingefügt...');
  console.time('klassen');
  await Promise.all(klassen.map(makeKlasseQuery).map(async q => query(q)));
  console.timeEnd('klassen');

  // console.log('Schüler werden eingefügt...');
  console.time('schueler');
  await Promise.all(schueler.map(makeSchuelerQuery).map(async q => query(q)));
  console.timeEnd('schueler');

  // console.log('Foreign Key wird eingesetzt...');
  console.time('foreign_key');
  await query(addForeignKey);
  console.timeEnd('foreign_key');
  // console.log('Done');
  pool.end();
});
