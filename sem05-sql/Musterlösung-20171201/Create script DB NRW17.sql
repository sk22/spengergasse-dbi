# Achtung: 
# - bei den Spalten immer mit dem PK beginnen, FK am Ende
# - bei FK/PK mit Datentyp Varchar kann es Probleme geben, wenn in den Daten 
#   am Ende ein Leerzeichen steht. Übersieht man leicht.
# - wenn Datentyp nicht passt, wird abgeschnitten
# - windows verwendet zwei zeichen als Zeilende \r\n -> 
#   lines terminated by \r\n
# - character set/collate muss passen
# - engine=innodb für FK constraints
# - \ im Pfadnamen muss escaped werden \\

DROP DATABASE IF EXISTS nrw2017db_muster;
CREATE DATABASE nrw2017db_muster;
USE nrw2017db_muster;


# Parteien
CREATE TABLE p_parteien(
	p_kuerzel varchar(10) NOT NULL,
	p_langname varchar(200),
	PRIMARY KEY(p_kuerzel)
)engine=innodb, character set latin1 collate latin1_german2_ci;
    
LOAD DATA local INFILE 'NRW17-Data/p_parteien.csv'
INTO TABLE p_parteien
character set latin1
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\r\n'
(p_kuerzel, p_langname);

#Landeswahlkreise
CREATE TABLE lwk_landeswahlkreise(
	lwk_nummer Decimal(1) NOT NULL,
	lwk_name varchar(200) NOT NULL,
    PRIMARY KEY(lwk_nummer)
)engine=innodb, character set latin1 collate latin1_german2_ci;

LOAD DATA local INFILE 'NRW17-Data/lwk_landeswahlkreise.csv'
INTO TABLE lwk_landeswahlkreise
character set latin1
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\r\n';    

#Regionalwahlkreise
CREATE TABLE rwk_regionalwahlkreise(
    rwk_kuerzel varchar(2) NOT NULL,
    rwk_bezeichnung varchar(200),
    rwk_lwkreis decimal(1),
    PRIMARY KEY(rwk_kuerzel)
)engine=innodb, character set latin1 collate latin1_german2_ci;

LOAD DATA local INFILE 'NRW17-Data/rwk_regionalwahlkreise.csv'
INTO TABLE rwk_regionalwahlkreise
character set latin1
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\r\n';    

#Stimmbezirke
CREATE TABLE sb_stimmbezirke(
    sb_name varchar(200) NOT NULL,
    sb_rwk_regionalwahlkreis varchar(2) NOT NULL,
    sb_art varchar(200) NOT NULL,
    PRIMARY KEY(sb_name)
)engine=innodb, character set latin1 collate latin1_german2_ci;

LOAD DATA local INFILE 'NRW17-Data/sb_stimmbezirke.csv'
INTO TABLE sb_stimmbezirke
character set latin1
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\r\n';    

#Kandidaten
CREATE TABLE k_kandidaten(
    k_knr int auto_increment,
    k_laufnr int not null,
    k_nachname varchar(100) NOT NULL,
    k_vorname varchar(100) NOT NULL,
    k_titel varchar(50) NULL,
    k_geburtsjahr decimal(4) NOT NULL,
    k_beruf varchar(255) NOT NULL,
    k_plz decimal(10) NOT NULL,
    k_wohnort varchar(100) NOT NULL,
    k_lwk_landeswahlkreis decimal(1) NULL, 
    k_rwk_regionalwahlkreis varchar(2) NULL,
    k_p_partei varchar(10) NOT NULL,
    PRIMARY KEY(k_knr)
)engine=innodb, character set latin1 collate latin1_german2_ci;

LOAD DATA local INFILE 'NRW17-Data/k_kandidaten.csv'
INTO TABLE k_kandidaten
character set latin1
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\r\n'    
(k_laufnr,k_nachname, k_vorname,@vk_titel, k_geburtsjahr, k_beruf, k_plz, k_wohnort, @vk_lwk_landeswahlkreis,@vk_rwk_regionalwahlkreis, k_p_partei)
SET k_titel = nullif(@vk_titel,''),k_rwk_regionalwahlkreis = nullif(@vk_rwk_regionalwahlkreis,''),k_lwk_landeswahlkreis = nullif(@vk_lwk_landeswahlkreis,'');
    
#Foreign keys
ALTER TABLE rwk_regionalwahlkreise
ADD FOREIGN KEY(rwk_lwkreis ) REFERENCES lwk_landeswahlkreise(lwk_nummer);

ALTER TABLE sb_stimmbezirke
ADD foreign key(sb_rwk_regionalwahlkreis) REFERENCES rwk_regionalwahlkreise(rwk_kuerzel);

ALTER TABLE k_kandidaten
ADD FOREIGN KEY(k_lwk_landeswahlkreis) REFERENCES lwk_landeswahlkreise(lwk_nummer);
ALTER TABLE k_kandidaten
ADD FOREIGN KEY(k_rwk_regionalwahlkreis) REFERENCES rwk_regionalwahlkreise(rwk_kuerzel);
ALTER TABLE k_kandidaten
ADD FOREIGN KEY(k_p_partei) REFERENCES p_parteien(p_kuerzel);
