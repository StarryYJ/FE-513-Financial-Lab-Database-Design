Drop table if exists members;
Drop table if exists facilities;
Drop table if exists bookings;
CREATE TABLE members(memid integer NOT NULL,
					 surname character varying(200) NOT NULL,
					 firstname character varying(200) NOT NULL,
					 address character varying(300) NOT NULL,
					 zipcode integer NOT NULL,
					 telephone character varying(20) NOT NULL,
					 recommendedby integer,
					 joindate timestamp not null,
					 CONSTRAINT members_pk PRIMARY KEY (memid),
					 CONSTRAINT fk_members_recommendedby FOREIGN KEY (recommendedby)
					 REFERENCES members(memid) ON DELETE SET NULL);
					 
CREATE TABLE facilities(facid integer NOT NULL,
						name character varying(100) NOT NULL,
						membercost numeric NOT NULL,
						guestcost numeric NOT NULL,
						initialoutlay numeric NOT NULL,
						monthlymaintenance numeric NOT NULL,
						CONSTRAINT facilities_pk PRIMARY KEY (facid));

CREATE TABLE bookings(bookid integer NOT NULL,
					  facid integer NOT NULL,
					  memid integer NOT NULL,
					  starttime timestamp NOT NULL,
					  slots integer NOT NULL,
					  CONSTRAINT bookings_pk PRIMARY KEY (bookid),
					  CONSTRAINT fk_bookings_facid FOREIGN KEY (facid) REFERENCES facilities(facid),
					  CONSTRAINT fk_bookings_memid FOREIGN KEY (memid) REFERENCES members(memid));

/* 1 SQL - 1 done */
select name, monthlymaintenance, case when (monthlymaintenance > 100) then 'expensive' else 'cheap' end as label from facilities; 


/* 1 SQL - 2 */
select a.surname from (select distinct * from members limit 10) a order by a.surname;


/* 1 SQL - 3 done */
select m.surname, f.name from members m, bookings b, facilities f where m.memid = b.memid and b.facid = f.facid;


/* 1 SQL - 4 done*/
select distinct m.firstname, m.surname as lastname from members m, bookings b ,
(select memid, min(starttime) as starttime from bookings group by memid) c
where m.memid = b.memid and b.memid = c.memid and 
b.starttime = (select max(min1) from (select min(a.starttime) as min1 from bookings a group by memid) as max1)
and m.joindate = (select max(joindate) from members);


/* 1 SQL - 5 */
select starttime from members m, bookings b 
where m.memid = b.memid and m.surname like 'Farrell' and m.firstname like 'David';


/* 3 SQL - database */
drop table if exists orders;
drop table if exists supplier;
drop table if exists items;
drop table if exists employee;
drop table if exists department;

create table department(department_name text,
				   manager_name text, 
				   primary key(department_name));
				   
create table employee(employee_name text, 
					  salary numeric(15, 2), 
					  department_name text, 
					  foreign key(department_name) references department(department_name),
					  primary key(employee_name, department_name));

create table items(item_ID int primary key, 
				   department_name text, 
				   discription text, 
				   quantity int, 
				   foreign key(department_name) references department(department_name));
				   
create table supplier(supplier_name text, 
					  address text, 
					  item_ID int, 
					  price numeric(15, 2), 
					  foreign key(item_ID) references items(item_ID),
					  primary key (supplier_name, item_ID));
					  
create table orders(order_ID int, 
					item_ID int, 
					order_date date, 
					shipping_address text, 
					quantity int, 
					foreign key(item_ID) references items(item_ID),
					primary key(order_ID, item_ID))

select * from department;
select * from orders;
select * from supplier;
select * from employee;
select * from items;

create table abc(col1 int, col2 int);
insert into abc values(1,2),(1,3),(1,4),(2,2),(2,3);
select col1, min(col2) from abc group by col1;


