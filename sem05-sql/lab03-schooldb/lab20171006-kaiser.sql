DROP DATABASE IF EXISTS school_db;
CREATE DATABASE school_db DEFAULT CHARACTER SET utf8;
USE school_db;

-- CREATE TABLES

CREATE TABLE t_teachers (
  t_id VARCHAR(5) NOT NULL,
  t_name VARCHAR(100) NOT NULL,
  t_firstname VARCHAR(100) NOT NULL,
  t_birthdate DATE NULL,
  t_salary DECIMAL(10,2) NULL,
  t_t_boss VARCHAR(5) NULL,
  PRIMARY KEY (t_id)
) ENGINE = InnoDB;

CREATE TABLE c_classes (
  c_id VARCHAR(7) NOT NULL PRIMARY KEY,
  c_text VARCHAR(45) NULL,
  c_p_classrep INT NULL,
  c_p_classrepsubst INT NULL,
  c_t_classteacher VARCHAR(5)
) ENGINE = InnoDB;

CREATE TABLE p_pupils (
  p_pupilnr INT NOT NULL PRIMARY KEY,
  p_name VARCHAR(100) NOT NULL,
  p_firstname VARCHAR(100) NOT NULL,
  p_birthdate DATE NOT NULL,
  p_address VARCHAR(100) NOT NULL,
  p_c_class VARCHAR(7) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE r_rooms (
  r_id VARCHAR(4) NOT NULL,
  r_seats INT,
  PRIMARY KEY (r_id)
) ENGINE = InnoDB;

CREATE TABLE e_exams (
  e_date DATE NOT NULL,
  e_p_cand INT,
  e_t_teacher VARCHAR(5) NOT NULL,
  e_s_subject VARCHAR(4) NOT NULL,
  e_type VARCHAR(4),
  e_mark INT,
  PRIMARY KEY (e_date, e_p_cand, e_t_teacher, e_s_subject)
) ENGINE = InnoDB;

CREATE TABLE s_subjects (
  s_id VARCHAR(4) NOT NULL PRIMARY KEY,
  s_text VARCHAR(100)
) ENGINE = InnoDB;

CREATE TABLE l_lessons (
  l_c_class VARCHAR(7) NOT NULL,
  l_t_teacher VARCHAR(5) NOT NULL,
  l_s_subject VARCHAR(4) NOT NULL,
  l_hour VARCHAR(3) NOT NULL,
  l_r_room VARCHAR(4) NOT NULL,
  PRIMARY KEY (l_c_class, l_t_teacher, l_s_subject, l_hour)
) ENGINE = InnoDB;

CREATE TABLE b_bosses (
  b_t_boss VARCHAR(5) NOT NULL,
  b_type VARCHAR(20) NOT NULL,
  b_t_subordinate VARCHAR(5) NOT NULL,
  PRIMARY KEY (b_t_boss, b_t_subordinate)
) ENGINE = InnoDB;

-- LOAD DATA

LOAD DATA LOCAL INFILE './subjects.txt' INTO TABLE s_subjects
  FIELDS TERMINATED BY ';' ENCLOSED BY '"'
  LINES TERMINATED BY '\n';

-- INSERT DATA

INSERT INTO c_classes VALUES ("01VL", "Vorber.LG", NULL, NULL, NULL);
INSERT INTO c_classes VALUES ("03TA", "Kolleg 03ta", 1, 122, "BE");
INSERT INTO c_classes VALUES ("03TB", "Kolleg 03tb", 1266, 111, "BI");

INSERT INTO t_teachers VALUES ("B1", "Berger", "Alfred", "1945-02-03", 400.00, NULL);
INSERT INTO t_teachers VALUES ("PI", "Pirkner", "Walter", "1955-06-26", 220.00, "B1");
INSERT INTO t_teachers VALUES ("AS", "Aschauer", "Anton", "1961-08-09", 180.00, "PI");
INSERT INTO t_teachers VALUES ("LN", "Lenau", "Nikolaus", "1938-02-22", 180.00, "HA");
INSERT INTO t_teachers VALUES ("AU", "Auwald", "Herbert", "1946-09-07", 150.00, "LN");
INSERT INTO t_teachers VALUES ("HA", "Hanke", "Gustav", "1950-12-12", 300.00, "B1");
INSERT INTO t_teachers VALUES ("BE", "Beringer", "Alfred", "1961-07-15", 220.00, "HA");
INSERT INTO t_teachers VALUES ("BI", "Bilek", "Hans", "1932-03-03", 280.00, "HA");
INSERT INTO t_teachers VALUES ("LI", "Lindner", "Kristine", "1958-12-12", 300.00, "HA");
INSERT INTO t_teachers VALUES ("MY", "Mayer", "Walter", "1947-04-01", 120.00, "LN");
INSERT INTO t_teachers VALUES ("PS", "Preißl", "Johann", "1956-07-05", 82.00, "HA");
INSERT INTO t_teachers VALUES ("SG", "Siegel", "Heinz", NULL, NULL, NULL);
INSERT INTO t_teachers VALUES ("WA", "Walter", "Hans", "1949-11-11", 115.00, "PI");

INSERT INTO p_pupils VALUES (1, "Adler", "Richard", "1966-03-12", "Gumpendorf", "03TA");
INSERT INTO p_pupils VALUES (4, "Kneippp", "Sebastian", "1967-12-24", "Fuenfhaus", "03TA");
INSERT INTO p_pupils VALUES (16, "Geyer", "Walli", "1966-07-23", "Simmering", "03TA");
INSERT INTO p_pupils VALUES (19, "Sitzenbleiber", "Eusebius", "1951-02-22", "Schweiz", "03TA");
INSERT INTO p_pupils VALUES (22, "Huber", "Seppl", "1968-02-02", "Margareten", "03TA");
INSERT INTO p_pupils VALUES (55, "Schulz", "Xandl", "1964-09-03", "Doebling", "03TB");
INSERT INTO p_pupils VALUES (74, "Hundertwasser", "Friederike", "1961-02-02", "Landstrasse", "03TA");
INSERT INTO p_pupils VALUES (77, "Berger", "Balduin", "1964-03-13", "Favoriten", "03TB");
INSERT INTO p_pupils VALUES (84, "Feuerstein", "Bebbles", "1966-06-12", "Steintal", "03TB");
INSERT INTO p_pupils VALUES (88, "Mayer", "Barbara", "1965-05-03", "Ottakring", "03TB");
INSERT INTO p_pupils VALUES (111, "Sandler", "Eberhard", "1959-04-19", "Hoechststaettpl", "03TB");
INSERT INTO p_pupils VALUES (122, "Graf", "Bobby", "1962-01-01", "Doebling", "03TA");
INSERT INTO p_pupils VALUES (1266, "Schlager", "Ronnie", "1963-04-23", "Ottakring", "03TB");

INSERT INTO r_rooms VALUES ("B1", 22);
INSERT INTO r_rooms VALUES ("B2", 24);
INSERT INTO r_rooms VALUES ("LA1", 10);
INSERT INTO r_rooms VALUES ("LA2", 18);
INSERT INTO r_rooms VALUES ("LA3", 2);

INSERT INTO e_exams VALUES ("1987-12-24", 55, "LI", "TDO", "M", 5);
INSERT INTO e_exams VALUES ("1988-01-01", 1, "PS", "TDO", "M", 1);
INSERT INTO e_exams VALUES ("1988-01-04", 1266, "BI", "BO", "M", 3);
INSERT INTO e_exams VALUES ("1988-01-12", 22, "PS", "TDO", "M", 2);
INSERT INTO e_exams VALUES ("1988-02-06", 111, "HA", "AM", "M", 4);
INSERT INTO e_exams VALUES ("1988-04-15", 19, "SG", "TDO", "M", 5);
INSERT INTO e_exams VALUES ("1988-06-07", 111, "SG", "TDO", "M", 1);
INSERT INTO e_exams VALUES ("1989-03-15", 1, "AU", "BO", "121", 2);
INSERT INTO e_exams VALUES ("1989-03-15", 22, "AU", "BO", "121", 4);
INSERT INTO e_exams VALUES ("1989-03-15", 111, "SG", "TDO", "F", 4);
INSERT INTO e_exams VALUES ("1989-04-01", 1, "AS", "AM", NULL, 2);
INSERT INTO e_exams VALUES ("1989-04-01", 1, "HA", "AM", "M", 4);
INSERT INTO e_exams VALUES ("1989-04-01", 4, "AS", "AM", NULL, 5);
-- Schüler 3 existiert nicht
-- INSERT INTO e_exams VALUES ("1988-01-12", 3, "SG", "TDO", "M", 1);

-- INSERT INTO s_subjects VALUES ("AM", "Mathematik");
-- INSERT INTO s_subjects VALUES ("BO", "Betriebliche Org.");
-- INSERT INTO s_subjects VALUES ("PR", "Programmieren");
-- INSERT INTO s_subjects VALUES ("PRRV", "Prozessrechnerverb.");
-- INSERT INTO s_subjects VALUES ("RW", "Rechnungswesen");
-- INSERT INTO s_subjects VALUES ("SEP", "System-Einsatzplan.");
-- INSERT INTO s_subjects VALUES ("TDO", "Technische Datenorg.");

INSERT INTO l_lessons VALUES ("03TA", "BI", "BO", "DI1", "B1");
INSERT INTO l_lessons VALUES ("03TA", "BI", "BO", "DI2", "B1");
INSERT INTO l_lessons VALUES ("03TA", "HA", "PR", "DI3", "LA3");
INSERT INTO l_lessons VALUES ("03TA", "HA", "PR", "DI4", "LA3");
INSERT INTO l_lessons VALUES ("03TA", "HA", "PR", "DI5", "LA3");
INSERT INTO l_lessons VALUES ("03TA", "B1", "AM", "DO1", "B1");
INSERT INTO l_lessons VALUES ("03TA", "B1", "AM", "DO2", "B1");
INSERT INTO l_lessons VALUES ("03TA", "BI", "BO", "DO3", "B1");
INSERT INTO l_lessons VALUES ("03TA", "BE", "PR", "DO4", "LA1");
INSERT INTO l_lessons VALUES ("03TA", "BE", "PR", "DO5", "LA1");
INSERT INTO l_lessons VALUES ("03TA", "PS", "TDO", "MI1", "LA2");
INSERT INTO l_lessons VALUES ("03TA", "PS", "TDO", "MI2", "LA2");
INSERT INTO l_lessons VALUES ("03TA", "PS", "TDO", "MI3", "B1");
INSERT INTO l_lessons VALUES ("03TA", "BI", "RWO", "MI4", "B1");
INSERT INTO l_lessons VALUES ("03TA", "BI", "RWO", "MI5", "B1");
INSERT INTO l_lessons VALUES ("03TA", "LI", "TDO", "MO1", "B1");
INSERT INTO l_lessons VALUES ("03TA", "LI", "TDO", "MO2", "B1");
INSERT INTO l_lessons VALUES ("03TA", "LI", "TDO", "MO3", "B1");
INSERT INTO l_lessons VALUES ("03TA", "BE", "SEP", "MO4", "B1");
INSERT INTO l_lessons VALUES ("03TA", "BE", "SEP", "MO5", "B1");
INSERT INTO l_lessons VALUES ("03TA", "PS", "PR", "MO7", "LA1");
INSERT INTO l_lessons VALUES ("03TA", "PS", "PR", "MO8", "LA1");
INSERT INTO l_lessons VALUES ("03TB", "PS", "PR", "DI1", "LA1");
INSERT INTO l_lessons VALUES ("03TB", "PS", "PR", "DI2", "LA1");
INSERT INTO l_lessons VALUES ("03TB", "HA", "PR", "DI3", "LA2");
INSERT INTO l_lessons VALUES ("03TB", "HA", "PR", "DI4", "LA2");
INSERT INTO l_lessons VALUES ("03TB", "HA", "PR", "DI5", "LA2");
INSERT INTO l_lessons VALUES ("03TB", "PS", "TDO", "DO1", "B2");
INSERT INTO l_lessons VALUES ("03TB", "PS", "TDO", "DO2", "B2");
INSERT INTO l_lessons VALUES ("03TB", "B1", "AM", "DO3", "B2");
INSERT INTO l_lessons VALUES ("03TB", "B1", "AM", "DO4", "B2");
INSERT INTO l_lessons VALUES ("03TB", "BI", "RW", "MI1", "B2");
INSERT INTO l_lessons VALUES ("03TB", "BI", "RW", "MI2", "B2");
INSERT INTO l_lessons VALUES ("03TB", "BI", "RW", "MI3", "B2");
INSERT INTO l_lessons VALUES ("03TB", "LI", "TDO", "MI4", "B2");
INSERT INTO l_lessons VALUES ("03TB", "LI", "TDO", "MI5", "B2");
INSERT INTO l_lessons VALUES ("03TB", "BI", "BO", "MO1", "B2");
INSERT INTO l_lessons VALUES ("03TB", "BI", "BO", "MO2", "B2");
INSERT INTO l_lessons VALUES ("03TB", "BI", "BO", "MO3", "B2");
INSERT INTO l_lessons VALUES ("03TB", "BE", "SEP", "MO4", "B2");
INSERT INTO l_lessons VALUES ("03TB", "BE", "SEP", "MO5", "B2");

INSERT INTO b_bosses VALUES ("B1", "Direktor", "BE");
INSERT INTO b_bosses VALUES ("B1", "Direktor", "BI");
INSERT INTO b_bosses VALUES ("B1", "Direktor", "HA");
INSERT INTO b_bosses VALUES ("B1", "Direktor", "LI");
INSERT INTO b_bosses VALUES ("B1", "Direktor", "PS");
INSERT INTO b_bosses VALUES ("BE", "Fgrp Prog", "PS");
INSERT INTO b_bosses VALUES ("BI", "Fgrp RW", "LI");
INSERT INTO b_bosses VALUES ("HA", "AV", "BE");
INSERT INTO b_bosses VALUES ("HA", "AV", "BI");
INSERT INTO b_bosses VALUES ("HA", "AV", "LI");
INSERT INTO b_bosses VALUES ("HA", "AV", "PS");

-- ADD FOREIGN KEYS

ALTER TABLE t_teachers
  ADD FOREIGN KEY (t_t_boss) REFERENCES t_teachers(t_id);

ALTER TABLE p_pupils
  ADD FOREIGN KEY (p_c_class) REFERENCES c_classes (c_id);

ALTER TABLE c_classes
  ADD FOREIGN KEY (c_p_classrep) REFERENCES p_pupils (p_pupilnr)
    ON DELETE SET NULL;

ALTER TABLE c_classes
  ADD FOREIGN KEY (c_p_classrepsubst) REFERENCES p_pupils (p_pupilnr);

ALTER TABLE c_classes
  ADD FOREIGN KEY (c_t_classteacher) REFERENCES t_teachers (t_id);

ALTER TABLE e_exams
  ADD FOREIGN KEY (e_p_cand) REFERENCES p_pupils (p_pupilnr),
  ADD FOREIGN KEY (e_t_teacher) REFERENCES t_teachers (t_id),
  ADD FOREIGN KEY (e_s_subject) REFERENCES s_subjects (s_id);
