DROP DATABASE IF EXISTS KlinikDB;
CREATE DATABASE KlinikDB DEFAULT CHARACTER SET utf8;
USE KlinikDB;

CREATE TABLE a_aerzte (
  a_arztnr DECIMAL(6, 0) NOT NULL PRIMARY KEY,
  a_name VARCHAR(20) NOT NULL,
  a_vorname VARCHAR(20),
  a_gebdatum DATE,
  a_geschlecht VARCHAR(1),
  a_f_fachgebiet INTEGER(8) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE fl_fachgebiete_leitung (
  fl_f_fachgebietsnr INTEGER(8) NOT NULL,
  fl_a_arztnr DECIMAL(6, 0) NOT NULL,
  fl_leiter_seit DATE,
  PRIMARY KEY (fl_f_fachgebietsnr, fl_a_arztnr, fl_leiter_seit)
) ENGINE = InnoDB;

CREATE TABLE f_fachgebiete (
  f_fachgebietsnr INTEGER(8) NOT NULL PRIMARY KEY,
  f_bezeichnung VARCHAR(25)
) ENGINE = InnoDB;


INSERT INTO a_aerzte VALUES
  (127369, "SCHMIDT", "KLAUS", "1968-12-17", "m", 44553022),
  (217499, "SAMMER", "MARTINA", "1972-01-25", "w", 56243640),
  (257521, "GEIER", "PAUL", "1963-04-18", "m", 12658400),
  (327566, "HEILER", "LUKAS", "1960-08-06", "m", 56243640),
  (117654, "BERNDT", "MARIA", "1971-03-05", "w", 56243640),
  (147698, "SCHMIDT", "MARIUS", "1972-02-11", "m", 62321233),
  (207782, "WALLA", "HERBERT", "1971-06-29", "m", 12658400),
  (317788, "KOLLER", "CLAUDIA", "1973-07-31", "w", 62321233),
  (156829, "PETRI", "WALTER", "1977-06-18", "m", 44553022),
  (436512, "BARI", "JOSEFA", "1976-04-24", "w", 44553022),
  (137839, "SCHMOLL", "TINA", "1972-09-17", "w", 12658400),
  (167844, "BERGER", "PETER", "1971-10-07", "m", 62321233),
  (297876, "SCHLAGER", "HANS", "1970-11-07", "m", 62321233);

INSERT INTO f_fachgebiete VALUES
  (12658400, "Hals-Nase-Ohren"),
  (56243640, "Unfallchirurgie"),
  (62321233, "Physikalische Medizin"),
  (44553022, "Innere Medizin");

INSERT INTO fl_fachgebiete_leitung VALUES
  (12658400, 257521, "2010-05-05"),
  (56243640, 327566, "1999-10-10"),
  (56243640, 117654, "2005-10-10"),
  (62321233, 147698, "2008-03-03"),
  (44553022, 436512, "2012-02-02");


ALTER TABLE a_aerzte
  ADD FOREIGN KEY (a_f_fachgebiet) REFERENCES f_fachgebiete (f_fachgebietsnr)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE fl_fachgebiete_leitung
  ADD FOREIGN KEY (fl_f_fachgebietsnr)
    REFERENCES f_fachgebiete (f_fachgebietsnr)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT,
  ADD FOREIGN KEY (fl_a_arztnr) REFERENCES a_aerzte (a_arztnr)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
