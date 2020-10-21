/* Create table and inport data for Q2 */
drop table if exists Activity;
create table Activity(player_id int, device_id int, event_date date, games_played int, primary key(player_id, event_date));
select * from Activity;

/* Sub-question 1 */
select player_id, min(event_date) as first_login from Activity group by player_id;

/* Sub-question 2 */
select distinct b.player_id, device_id from Activity a, (select player_id, min(event_date) as first_login 
														 from Activity group by player_id) b
where a.player_id = b.player_id and event_date = first_login;

/* Sub-question 3 */
select b.player_id, b.event_date, sum(a.games_played) as games_played_so_far from Activity a, Activity b 
where a.player_id = b.player_id and a.event_date <= b.event_date group by b.player_id, b.event_date order by b.player_id, b.event_date;


/* Create table and inport data for Q3 */
drop table if exists Apartment;
create table Apartment(Apt_name text primary key, 
					   location text, 
					   open_year int, 
					   height int, 
					   last_renovation int);

drop table if exists Units;
create table Units(Apt_name text,
				   FOREIGN KEY (Apt_name) REFERENCES Apartment (Apt_name),
				   unit_num int, 
				   bedroom int, 
				   bathroom int, 
				   Separate_kitchen text, 
				   Separate_livingroom text, 
				   square_footage numeric(15,2),
				   primary key (Apt_name, unit_num));

drop table if exists Household_overallinfo;
create table Household_overallinfo(household_serial int primary key,
								   member_number int, 
								   header_name text);

drop table if exists Household_move;
create table Household_move(household_serial int,
							foreign key(household_serial) references Household_overallinfo(household_serial),
							movein_time date, 
							moveout_time date, 
							Apt_name text,
							unit_num int,
							foreign key(Apt_name, unit_num) references units(Apt_name, unit_num),
							primary key(household_serial, movein_time));

drop table if exists Household_info;
create table Household_info(household_serial int,
							foreign key (household_serial) references Household_overallinfo(household_serial),
							member_number int, 
							member_name text, 
							member_sex text, 
							member_birthday date, 
							head_or_not text,
							primary key(member_name, member_birthday));


/* create data as required */
INSERT INTO Apartment VALUES
('Apt 1', '1 Street', 2000, 15, 2013),
('Apt 2', '2 Street', 1980, 11, 2000),
('Apt 3', '3 Street', 2005, 10, 2013);
select * from Apartment;

INSERT INTO Units VALUES
('Apt 1', 1, 4, 2, 'Yes', 'Yes', 2000),
('Apt 1', 2, 4, 2, 'Yes', 'Yes', 2000),
('Apt 2', 1, 2, 2, 'No', 'No', 1000),
('Apt 2', 2, 2, 2, 'Yes', 'No', 900),
('Apt 3', 1, 3, 2, 'Yes', 'Yes', 1500),
('Apt 3', 2, 3, 2, 'No', 'Yes', 1400);
select * from Units;

insert into Household_overallinfo values
(1, 2, 'AA'),
(2, 3, 'AAA'),
(3, 4, 'AAAA');
select * from Household_overallinfo;

INSERT INTO Household_move VALUES
(1, '2014-01-02', '2016-01-01', 'Apt 1', 1),
(2, '2014-01-02', '2016-01-01', 'Apt 1', 1),
(3, '2015-01-02', '2016-01-01', 'Apt 2', 1),
(1, '2016-01-02', NULl, 'Apt 3', 2),
(2, '2016-01-02', '2018-01-01', 'Apt 2', 1),
(2, '2018-01-02', '2020-01-01', 'Apt 3', 1),
(3, '2016-01-02', '2018-01-01', 'Apt 1', 2);
select * from Household_move;

INSERT INTO Household_info VALUES
(1, 2, 'AA', 'Female', '1970-01-01', 'Yes'),
(1, 2, 'BB', 'Male', '1964-01-01', 'No'),
(2, 3, 'AAA', 'Female', '1996-01-01', 'Yes'),
(2, 3, 'BBB', 'Male', '1995-01-01', 'No'),
(2, 3, 'CCC', 'Male', '1994-01-01', 'No'),
(3, 4, 'AAAA', 'Female', '2001-01-01', 'Yes'),
(3, 4, 'BBBB', 'Male', '2002-01-01', 'No'),
(3, 4, 'CCCC', 'Male', '2003-01-01', 'No'),
(3, 4, 'DDDD', 'Male', '2000-01-01', 'No');
select * from Household_info;


/* Show how can I get required information */
/* 1. Information of developments */
select * from Apartment;

/* 2. Information of units */
select * from Units;

/* 3. Information of households in units */
select u.Apt_name, u.unit_num, m.household_serial, member_number, member_name, member_sex, member_birthday, head_or_not, movein_time, moveout_time
from Units u, Household_info i, Household_move m 
where i.household_serial = m.household_serial and m.Apt_name = u.Apt_name and m.unit_num = u.unit_num
order by u.Apt_name, u.unit_num;

/* 4. Information of households' movement */
select household_serial, Apt_name, unit_num from Household_move where moveout_time is null or moveout_time > now();





