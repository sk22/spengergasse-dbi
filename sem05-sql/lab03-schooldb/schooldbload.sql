#------------------------------------------------------

drop database if exists 20171006schooldbload;

create database 20171006schooldbload;

use 20171006schooldbload;


#---------------------------------------------------

# Tabelle Gegenstande
create table s_subjects
  ( s_id varchar(5) not null,
    s_text varchar(20) default null,
    primary key (s_id)
) engine=InnoDB;

load data local infile 'C:\\Users\\Leo\\Desktop\\Subjects.txt' 
into table s_subjects fields terminated by ';' enclosed by '"' lines terminated by '\n';