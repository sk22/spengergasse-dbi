#------------------------------------------------------
drop database if exists tennisdb;
create database if not exists tennisdb;
use tennisdb;


#------------------------------------------------------
create table p_players(
	p_playerno 	smallint not null,
	p_name 		char(15) not null,
	p_initials	char(3) not null,
	p_year_of_birth smallint,
	p_sex		char(1) not null,
	p_year_joined	smallint not null,
	p_street	char(15) not null,
	p_houseno	char(4),
	p_postcode   	char(6),
	p_town		char(10),
	p_phoneno	char(10),
	p_leagueno	char(4),
	primary key (p_playerno))engine=InnoDB;

insert into p_players values(6,'Parmenter','R',1964,'M',1977,'Haseltine Lane','80','1234KK','Stratford','070-476537','8467');
insert into p_players values(44,'Baker','E',1963,'M',1980,'Lewsi Street','23','4444LJ','Inglewood','070-368753','1124');
insert into p_players values(83,'Hope','PK',1956,'M',1982,'Magdalene Road','16A','1812UP','Stratford','070-353548','1608');
insert into p_players values(2,'Everett','R',1948,'M',1975,'Stoney Road','43','3575NH','Stratford','070-237893','2411');
insert into p_players values(27,'Collins','DD',1964,'F',1983,'Long Drive','804','8457DK','Eltham','079-234857','2513');
insert into p_players values(104,'Moorman','D',1970,'F',1984,'Stout Street','65','9437AO','Eltham','079-987571','7060');
insert into p_players values(7,'Wise','GWS',1963,'M',1981,'Edgecomb Way','39','9758VB','Stratford','070-347689',null);
insert into p_players values(57,'Brown','M',1971,'M',1985,'Edgecomb Way','16','4377CB','Stratford','070-473458','6409');
insert into p_players values(39,'Bishop','D',1956,'M',1980,'Eaton Square','78','9629CD','Stratford','070-393435',null);
insert into p_players values(112,'Bailey','IP',1963,'F',1984,'Vixen Road','8','6392LK','Plymouth','010-548745','1319');
insert into p_players values(8,'Newcastle','B',1962,'F',1980,'Station Road','4','6584RO','Inglewood','070-458458','2983');
insert into p_players values(100,'Parmenter','P',1963,'M',1979,'Haseltine Lane','80','1234KK','Stratford','070-494593','6524');
insert into p_players values(28,'Collins','C',1963,'F',1983,'Old Main Road','10','1294QK','Midhurst','071-659599',null);
insert into p_players values(95,'Miller','P',1963,'M',1972,'High Street','33A','5746OP','Douglas','070-867564',null);



#------------------------------------------------------
create table t_teams(
	t_teamno	smallint not null,
	t_p_playerno	smallint not null,
	t_division	char(6) not null,
	primary key (t_teamno))engine=InnoDB;

insert into t_teams values(1,6,'first');
insert into t_teams values(2,27,'second');


#------------------------------------------------------
create table m_matches(
	m_matchno	smallint not null,
	m_t_teamno	smallint not null,
	m_p_playerno	smallint not null,
	m_won		smallint not null,
	m_lost		smallint not null,
	primary key(m_matchno))engine=InnoDB;

insert into m_matches values(1,1,6,3,1);
insert into m_matches values(2,1,6,2,3);
insert into m_matches values(3,1,6,3,0);
insert into m_matches values(4,1,44,3,2);
insert into m_matches values(5,1,83,0,3);
insert into m_matches values(6,1,2,1,3);
insert into m_matches values(7,1,57,3,0);
insert into m_matches values(8,1,8,0,3);
insert into m_matches values(9,2,27,3,2);
insert into m_matches values(10,2,104,3,2);
insert into m_matches values(11,2,112,2,3);
insert into m_matches values(12,2,112,1,3);
insert into m_matches values(13,2,8,0,3);


#------------------------------------------------------
create table pe_penalties(
	pe_paymentno	integer not null,
	pe_p_playerno	smallint not null,
	pe_pen_date	date not null default '1990-01-01',
	pe_amount	decimal(7,2) not null default 50.00,
	primary key(pe_paymentno))engine=InnoDB;

insert into pe_penalties values(1,6,'1980-12-08',100);
insert into pe_penalties values(2,44,'1981-05-05',75);
insert into pe_penalties values(3,27,'1983-09-10',100);
insert into pe_penalties values(4,104,'1984-12-08',50);
insert into pe_penalties values(5,44,'1980-12-08',25);
insert into pe_penalties values(6,8,'1980-12-08',25);
insert into pe_penalties values(7,44,'1982-12-30',30);
insert into pe_penalties values(8,27,'1984-11-12',75);

#------------------------------------------------------



# ---- ohne referential constraints -----------------------------------------------------
#alter table t_teams add foreign key (t_p_playerno) references p_players(p_playerno);		
#alter table m_matches add foreign key (m_t_teamno) references t_teams(t_teamno);
#alter table m_matches add foreign key (m_p_playerno) references p_players(p_playerno);
#alter table pe_penalties add foreign key (pe_p_playerno) references p_players(p_playerno);


# ---- mit referential constraints -----------------------------------------------------
alter table t_teams add foreign key (t_p_playerno) references p_players(p_playerno)
on delete cascade
on update cascade;
		
alter table m_matches add foreign key (m_t_teamno) references t_teams(t_teamno)
on delete cascade
on update cascade;

alter table m_matches add foreign key (m_p_playerno) references p_players(p_playerno)
on delete cascade
on update cascade;

alter table pe_penalties add foreign key (pe_p_playerno) references p_players(p_playerno)
on delete cascade
on update cascade;
