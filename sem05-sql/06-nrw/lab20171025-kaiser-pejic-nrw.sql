DROP DATABASE IF EXISTS 20171025KaiserPejicNRW;
CREATE DATABASE 20171025KaiserPejicNRW DEFAULT CHARACTER SET utf8;
USE 20171025KaiserPejicNRW;

CREATE TABLE s_stimmbezirke (
  s_name VARCHAR(30) PRIMARY KEY,
  s_r_regionalwahlkreis VARCHAR(2),
  s_l_landeswahlkreis INT,
  s_art VARCHAR(20)
) ENGINE = InnoDB;

LOAD DATA LOCAL INFILE 'data/stimmbezirke.csv' INTO TABLE s_stimmbezirke
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\r\n'
  IGNORE 1 LINES;

CREATE TABLE l_landeswahlkreise (
  l_wahlkreis INT PRIMARY KEY,
  l_bundesland VARCHAR(16)
) ENGINE = InnoDB;

LOAD DATA LOCAL INFILE 'data/landeswahlkreise.csv'
  INTO TABLE l_landeswahlkreise
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;

CREATE TABLE r_regionalwahlkreise (
  r_wahlkreisnummer VARCHAR(2) PRIMARY KEY,
  r_bezeichnung VARCHAR(25),
  r_l_landeswahlkreis INT
) ENGINE = InnoDB;

LOAD DATA LOCAL INFILE 'data/regionalwahlkreise.csv'
  INTO TABLE r_regionalwahlkreise
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;

CREATE TABLE p_parteien (
  p_kurzbezeichnung VARCHAR(10) PRIMARY KEY,
  p_partei VARCHAR(120)
) ENGINE = InnoDB;

LOAD DATA LOCAL INFILE 'data/parteien.csv'
  INTO TABLE p_parteien
    FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;

CREATE TABLE li_liste (
  li_p_partei VARCHAR(10),
  li_position INT,
  li_nachname VARCHAR(30),
  li_vorname VARCHAR(30),
  li_titel VARCHAR(10),
  li_geburtsjahr INT,
  li_beruf VARCHAR(30),
  li_plz SMALLINT,
  li_ort VARCHAR(30),
  li_l_lpl INT,
  li_r_rpl VARCHAR(2),
  PRIMARY KEY (li_p_partei, li_position)
) ENGINE = InnoDB;

LOAD DATA LOCAL INFILE 'data/liste-spoe.csv'
  INTO TABLE li_liste
    FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'data/liste-oevp.csv'
  INTO TABLE li_liste
    FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'data/liste-fpoe.csv'
  INTO TABLE li_liste
    FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'data/liste-gruene.csv'
  INTO TABLE li_liste
    FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'data/liste-neos.csv'
  INTO TABLE li_liste
    FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'data/liste-weisse.csv'
  INTO TABLE li_liste
    FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'data/liste-floe.csv'
  INTO TABLE li_liste
    FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'data/liste-kpoe.csv'
  INTO TABLE li_liste
    FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'data/liste-pilz.csv'
  INTO TABLE li_liste
    FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'data/liste-gilt.csv'
  INTO TABLE li_liste
    FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'data/liste-slp.csv'
  INTO TABLE li_liste
    FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'data/liste-m.csv'
  INTO TABLE li_liste
    FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'data/liste-euaus.csv'
  INTO TABLE li_liste
    FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;

ALTER TABLE s_stimmbezirke
 ADD FOREIGN KEY (s_r_regionalwahlkreis)
   REFERENCES r_regionalwahlkreise (r_wahlkreisnummer)
   ON UPDATE RESTRICT
   ON DELETE RESTRICT,
 ADD FOREIGN KEY (s_l_landeswahlkreis)
   REFERENCES l_landeswahlkreise (l_wahlkreis)
   ON UPDATE RESTRICT
   ON DELETE RESTRICT;

ALTER TABLE r_regionalwahlkreise
  ADD FOREIGN KEY (r_l_landeswahlkreis)
    REFERENCES l_landeswahlkreise (l_wahlkreis)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE li_liste
 ADD FOREIGN KEY (li_p_partei)
   REFERENCES p_parteien (p_kurzbezeichnung)
   ON UPDATE RESTRICT
   ON DELETE RESTRICT,
 ADD FOREIGN KEY (li_l_lpl)
   REFERENCES l_landeswahlkreise (l_wahlkreis)
   ON UPDATE RESTRICT
   ON DELETE RESTRICT,
 ADD FOREIGN KEY (li_r_rpl)
   REFERENCES r_regionalwahlkreise (r_wahlkreisnummer)
   ON UPDATE RESTRICT
   ON DELETE RESTRICT;


-- example usage:
SELECT li_p_partei, li_position, li_nachname, li_vorname
  FROM li_liste where li_position < 10;

