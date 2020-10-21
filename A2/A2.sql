/* Create table and inport data for Q1 */
drop table if exists bank2001;
create table bank2001(id varchar(30), date varchar(30), asset numeric(15,2), liability numeric(15,2));
copy bank2001 from 'C:\Users\DELL\Desktop\FE513\A2\banks_al_2001.csv' delimiter ',' csv;
/* However, I actually import data manually because of the "permission denied" issue. */
select * from bank2001;

/* 1-2 */
SELECT count(*) FROM bank2001 where (asset - liability) > 0.1 * asset and date like '3/31/2001%';
/* 1-3 */
SELECT round(avg(liability), 2) FROM bank2001 where asset > (SELECT avg(asset) FROM bank2001) and date like '3/31/2001%';
/* 1-4 */
SELECT id FROM bank2001 where asset = (select max(asset) from bank2001 where 
									   asset < (select max(asset) from bank2001 where 
												date like '6/30/2001%') and 
									   date like '6/30/2001%') and date like '6/30/2001%';
/* 1-5 */
SELECT count(*) FROM bank2001 group by date order by date ASC;

/* Create table and inport data for Q2 */
drop table if exists bank2002_sec;
create table bank2002_sec(id varchar(30), date varchar(30), security numeric(15,2));
copy bank2002_sec from 'C:\Users\DELL\Desktop\FE513\A2\banks_sec_2002.csv' delimiter ',' csv;
drop table if exists bank2002_al;
create table bank2002_al(id varchar(30), date varchar(30), asset numeric(15,2), liability numeric(15,2));
copy bank2002_al from 'C:\Users\DELL\Desktop\FE513\A2\banks_al_2002.csv' delimiter ',' csv;
/* However, I actually import data manually because of the "permission denied" issue. */

/* 2-1 */
drop table if exists table1;
create table table1(a integer, b integer, c integer);
drop table if exists table2;
create table table2(d integer, e integer);
drop table if exists table3;
create table table3(d integer, e integer, f integer);
insert into table1 values (1,1,1), (2,2,2), (3,3,3), (1,1,1),(NULL,1,1);
insert into table2 values (1,2), (3,2), (1,2), (NULL,2);
insert into table3 values (1,2,3), (1,1,1) ,(0,3,2),(2,2,2),(1,1,1),(NULL,1,1);

SELECT * FROM table1 INTERSECT SELECT * FROM table2;
SELECT * FROM table1 INTERSECT SELECT * FROM table3;
SELECT * FROM table1 a inner JOIN table2 b ON a.a = b.d; 

/* 2-2 */
delete from bank2002_sec where ctid not in (select min(ctid) from bank2002_sec group by id, date);

/* 2-3 */
/* The importing data step have already done */
SELECT * FROM bank2002_sec;
SELECT * FROM bank2002_al;
select count(*) from bank2002_sec s, bank2002_al a where 
s.id = a.id and s.date = a.date and security > 0.2 * asset and a.date like '3/31/2002%'; 

/* 2-4 */
select count(*) from bank2001 a, bank2002_al b where a.id = b.id and 
a.liability > 0.9 * a.asset and a.date like '12/31/2001%' and 
b.liability < 0.9 * b.asset and b.date like '3/31/2002%' ; 

/* 2-5 */
select asset, security from bank2002_sec s, bank2002_al a where 
s.id = a.id and s.date = a.date and 
security > (SELECT avg(security) FROM bank2002_sec) and 
a.date like '3/31/2002%'; 

copy (select asset, security from bank2002_sec s, bank2002_al a where s.id = a.id and 
	  s.date = a.date and security > (SELECT avg(security) FROM bank2002_sec) and 
	  a.date like '3/31/2002%') 
to 'C:\Users\DELL\Desktop\FE513\A2\result.csv' delimiter ',' csv header;

/* 2-6 I choose the 2 tables related to year 2002 */
drop table if exists banks_al;
create table banks_al(id_al varchar(30), date_al varchar(30), asset numeric(15,2), 
					  liability numeric(15,2), id_sec varchar(30), date_sec varchar(30), security integer);
Insert into banks_al SELECT * FROM bank2002_al a LEFT JOIN bank2002_sec b ON A.ctid = B.ctid;
SELECT * FROM banks_al;
ALTER TABLE banks_al ADD PRIMARY KEY (id_al, date_al);

/* Create table and inport data for Q3 */
drop table if exists Movie;
create table Movie(mID varchar(30), title varchar(100), year integer, director varchar(50));
copy Movie from 'C:\Users\DELL\Desktop\FE513\A2\Movie.csv' delimiter ',' csv;
drop table if exists Reviewer;
create table Reviewer(rID varchar(30), name varchar(30));
copy Reviewer from 'C:\Users\DELL\Desktop\FE513\A2\Reviewer.csv' delimiter ',' csv;
drop table if exists Rating;
create table Rating(rID varchar(30), mID varchar(30), stars integer, ratingDate varchar(30));
copy Rating from 'C:\Users\DELL\Desktop\FE513\A2\Rating.csv' delimiter ',' csv;
/* However, I actually inport data manually because of the "permission denied" issue. */
SELECT * FROM Movie;
SELECT * FROM Reviewer;
SELECT * FROM Rating;

/* 3-1 */
select title from Movie where director like 'Steven Spielberg%';

/* 3-2 */
select distinct year from Movie where mID in (select mID from Rating where stars between 4 and 5) order by year;

/* 3-3 */
select title, stars from Movie a, (select mID, max(stars) as stars from Rating group by mid) b 
where a.mid = b.mid order by title;

/* 3-4 */
select name from reviewer where rid in (select rid from rating where ratingdate is null);

/* 3-5 */
/* data prepare, I don't need the "movie" one here */
drop table if exists Reviewer_test;
create table Reviewer_test(rID integer, name varchar(30));
drop table if exists Rating_test;
create table Rating_test(rID integer, mID integer, stars integer, ratingDate varchar(30));
insert into Reviewer_test values (001,'man1'),(002,'man2'), (003,'man3');
insert into Rating_test values (001,1111,5,'a'),(002,1111,5,'b'),(001,2222,5,'c');

/* Do as required in test tables */
SELECT DISTINCT Rv1.name, Rv2.name
from Rating_test r1, Rating_test r2, Reviewer_test rv1, Reviewer_test rv2
where r1.mID = r2.mID and r1.rID = rv1.rID and r2.rID = rv2.rID and rv1.name < rv2.name
order by rv1.name, rv2.name;

/* Do as required in tables for Q3 */
SELECT DISTINCT Rv1.name, Rv2.name
from Rating r1, Rating r2, Reviewer rv1, Reviewer rv2
where r1.mID = r2.mID and r1.rID = rv1.rID and r2.rID = rv2.rID and rv1.name < rv2.name
order by rv1.name, rv2.name;

/* 3-6 */
select title, spread from Movie a, (select mID, max(stars)-min(stars) as spread 
									from Rating group by mid) b where a.mid = b.mid order by spread, title;

/* 3-7 */
select title, average from Movie a, (select mID, round(avg(stars), 2) as average 
									 from Rating group by mid) b where a.mid = b.mid order by average DESC, title;

/* 3-8 */
insert into rating(mID) select distinct mID from Movie;
UPDATE rating SET rID = '0000' WHERE stars is null; 
UPDATE rating SET stars = 5 WHERE rID = '0000'; 
insert into reviewer values ('0000', 'James Cameron');
select * from rating;
select * from reviewer;

/* 3-9 */
select mid, round(avg(stars), 2) as average_stars from rating where mid in (select mid from movie 
																			where year < 1980) group by mid;
select mid, round(avg(stars), 2) as average_stars from rating where mid not in (select mid from movie 
																				where year < 1980) group by mid;

select round(avg(before.average_stars) - avg(after.average_stars), 6) as difference from 
(select avg(stars) as average_stars from rating where mid in 
 (select mid from movie where year < 1980) group by mid) before, 
 (select mid, avg(stars) as average_stars from rating where mid not in 
  (select mid from movie where year < 1980) group by mid) after; 
/* The first 2 queries show average stars for each movie before and after 1980 respectively */
/* The third query show differences in average stars between movie released before and after 1980 */
