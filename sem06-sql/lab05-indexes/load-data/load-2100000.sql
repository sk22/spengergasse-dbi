RENAME TABLE k_klassen TO k1;
RENAME TABLE s_schueler TO s1;
CREATE TABLE k_klassen LIKE k1;
CREATE TABLE s_schueler LIKE s1;
DROP TABLE k1;
DROP TABLE s1;

LOAD DATA LOCAL INFILE 'klassen-100000.csv'
  INTO TABLE k_klassen
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"';

LOAD DATA LOCAL INFILE 'schueler-100000-2000000.csv'
  INTO TABLE k_klassen
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"';