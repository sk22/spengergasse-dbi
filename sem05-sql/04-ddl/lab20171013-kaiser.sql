DROP DATABASE IF EXISTS 20171013Kaiser;
CREATE DATABASE 20171013Kaiser DEFAULT CHARACTER SET utf8;
USE 20171013Kaiser;

-- CREATE TABLES

CREATE TABLE a_abbb (
  a_a1 INT PRIMARY KEY,
  a_a2 VARCHAR(20),
  a_a3 INT,
  a_b_a4 INT NOT NULL,
  a_a5 DATE
) ENGINE = InnoDB;

CREATE TABLE b_bccc (
  b_b1 INT PRIMARY KEY AUTO_INCREMENT,
  b_b2 VARCHAR(20),
  b_a_b3 INT NOT NULL
) ENGINE = InnoDB;

CREATE TABLE c_cddd (
  c_c1 VARCHAR(20) PRIMARY KEY,
  c_c2 INT,
  c_c3 VARCHAR(20),
  c_b_c4 INT NOT NULL
) ENGINE = InnoDB;

CREATE TABLE d_deee (
  d_a_d1 INT NOT NULL,
  d_c_d2 VARCHAR(20) NOT NULL,
  d_d3 DATE NOT NULL,
  d_d4 VARCHAR(20),
  PRIMARY KEY (d_a_d1, d_c_d2, d_d3)
) ENGINE = InnoDB;

-- INSERT DATA

INSERT INTO a_abbb (a_a1, a_a2, a_a3, a_b_a4, a_a5) VALUES
  (11, "a12", 11, 2, "2001-02-22"),
  (22, "a22", 22, 1, "2001-02-23");

INSERT INTO b_bccc (b_b1, b_b2, b_a_b3) VALUES
  (1, "b12", 22),
  (2, "b22", 11);

INSERT INTO c_cddd (c_c1, c_c2, c_c3, c_b_c4) VALUES
  ("alpha", 11, "a", 2),
  ("beta", 22, "b", 1);

INSERT INTO d_deee (d_a_d1, d_c_d2, d_d3, d_d4) VALUES
  (11, "beta", "2001-02-24", "abc"),
  (22, "alpha", "2001-02-25", "bcd");

-- ADD FOREIGN KEYS

ALTER TABLE a_abbb
  ADD FOREIGN KEY (a_b_a4) REFERENCES b_bccc (b_b1);

ALTER TABLE b_bccc
  ADD FOREIGN KEY (b_a_b3) REFERENCES a_abbb (a_a1);

ALTER TABLE c_cddd
  ADD FOREIGN KEY (c_b_c4) REFERENCES b_bccc (b_b1);

ALTER TABLE d_deee
  ADD FOREIGN KEY (d_a_d1) REFERENCES a_abbb (a_a1),
  ADD FOREIGN KEY (d_c_d2) REFERENCES c_cddd (c_c1);
