const fs = require('fs');
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

const makeSchuelerLine = klasse =>
  `"${generate()}","${generate()}","${klasse}"`;

const makeKlasseLine = k => `"${k}","${generate()}"`;

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

// const pool = mysql.createPool({
//   connectionLimit: 10,
//   host: 'localhost',
//   user: 'root',
//   password: process.env.password,
//   database: 'schooldb_indexes'
// });

// console.log('Klassen werden eingefügt...');
console.time('klassen');
fs.writeFileSync('klassen.csv', klassen.map(makeKlasseLine).join('\n'));
console.timeEnd('klassen');

// console.log('Schüler werden eingefügt...');
console.time('schueler');
fs.writeFileSync('schueler.csv', schueler.map(makeSchuelerLine).join('\n'));
console.timeEnd('schueler');
