drop database if exists LSM;
create database LSM;
use LSM;

create table librarian(lib_id int,lib_name varchar(20));
insert into librarian values(3456345,"Sakunthala");

create table student(
stud_id int not null primary key,
stud_name varchar(20),
dept varchar(5),
batch varchar(10));

insert into student values(4653,"shaji","CSE","2017-2020");
insert into student values(4563,"sujithhra","IT","2019-2023");
insert into student values(3653,"meena","MECH","2018-2021");
insert into student values(5644,"kumar","EEE","2017-2020");
insert into student values(3356,"rajesh","ECE","2019-2023");
insert into student values(9576,"shivani","EEE","2016-2019");
insert into student values(7346,"sham","CSE","2017-2020");
insert into student values(4765,"dhivya","MECH","2018-2021");

create table books(
book_id int not null primary key,
title varchar(45),
edition int,
availablity int);

insert into books values(342,"Theory of computation",4,2);
insert into books values(548,"Vectors",2,6);
insert into books values(234,"artificial intelligence",2,4);
insert into books values(564,"fluid mechaincs",4,7);
insert into books values(645,"electromagentism",1,3);
insert into books values(745,"theory of relativity",8,4);
insert into books values(875,"gate-question papers",1,2);
insert into books values(625,"programming with JAVA",3,6);
insert into books values(123,"python programming book",2,3);
insert into books values(987,"theory of computation",2,1);


create table author(
author_name varchar(20),
book_id int,
constraint FK_book_id foreign key(book_id) references books(book_id));

insert into author values("e.v.santha",342);
insert into author values("george",548);
insert into author values("latha",234);
insert into author values("sankar",564);
insert into author values("srija",645);
insert into author values("arihant",745);
insert into author values("walter h white",875);
insert into author values("krishnasamy",625);
insert into author values("som",123);
insert into author values("paul",987);


create table fine_amount(
book_id int,
stud_id int,
amount float,
constraint FK_stud_id foreign key(stud_id) references student(stud_id));

insert into fine_amount values(342,4653,12.10);
insert into fine_amount values(548,4563,0.0);
insert into fine_amount values(234,3653,1.50);
insert into fine_amount values(564,5644,8.10);
insert into fine_amount values(987,7346,10.00);
insert into fine_amount values(875,9576,6.10);

create table faculty(
fac_id int not null primary key,
fac_name varchar(25),
fac_dept varchar(15));

insert into faculty values(123,"meera","datascience");
insert into faculty values(115,"preetha","civil");
insert into faculty values(165,"nandhini","aiml");
insert into faculty values(201,"jennifer","chemical");
insert into faculty values(756,"meenkashi","chemical");
insert into faculty values(352,"tharani","chemical");
insert into faculty values(456,"madhu","chemical");
insert into faculty values(242,"jaya","chemical");
insert into faculty values(657,"rithika","chemical");
insert into faculty values(453,"sandra","chemical");

create table books_issued(
title varchar(25),
book_id int,
mem_id int,
foreign key(book_id) references books(book_id));

insert into books_issued values("theory of computation",342,4653);
insert into books_issued values("python programming book",548,5644);
insert into books_issued values("vectors",564,3653);
insert into books_issued values("theory of computation",342,5644);
insert into books_issued values("electromagentism",645,3653);
insert into books_issued values("artificial intelligence",234,7346);
insert into books_issued values("programming with JAVA",625,4765);
insert into books_issued values("theory of computation",342,4654);


create table books_returned(
title varchar(25),
book_id int,
mem_id int,
foreign key(book_id) references books(book_id));

insert into books_returned values("python programming book",123,5644);
insert into books_returned values("vectors",564,3653);

select *from librarian;	
select *from student;
select *from fine_amount;				
select *from author;
select *from books;
select *from faculty;
select *from books_issued;
select *from books_returned;

create trigger books_taken
before update on books
FOR EACH ROW
INSERT INTO books_issued
SET action = 'update',
book_id = OLD.book_id,
title = OLD.title,
mem_id = NOW();

show triggers;

update books_issued set title='ALREADY ISSUED' where book_id= 548;

select *from books_issued;

#functions
#CREATE DEFINER=`root`@`localhost` FUNCTION `pending_amount`(stud_id int) RETURNS float
    #READS SQL DATA
#BEGIN
#DECLARE pending float;
#select (amount) from fine_amount where stud_id = fine_amount.stud_id into pending;
#return pending;    
#END
select `lsm`.`pending_amount`(4653);

#procedures
USE `lsm`;
DROP procedure IF EXISTS `book_count`;

DELIMITER $$
USE `lsm`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `book_count`(
IN title varchar(45),
OUT book_count int)
BEGIN
     select COUNT(*) from books_issued A where A.title = title into book_count;
END$$
DELIMITER ;
set @book_count=0;
CALL `lsm`.`book_count`("theory of computation",@book_count);
select @book_count;

delimiter $$
DROP PROCEDURE IF EXISTS proc_lib;
create procedure proc_lib()
begin
	declare v_lib_id int;
	declare v_lib_name varchar(20);
    declare v_finished integer default 0;
    declare l cursor for select lib_id,lib_name from librarian;
    declare continue handler for not found set v_finished=1;
    open l;
    get_lib: LOOP
       fetch l into v_lib_id,v_lib_name;
       if v_finished=1 then
          leave get_lib;
       end if;
       select concat(v_lib_id,v_lib_name);
	END LOOP get_lib;
    close l;
end $$   
delimiter ;

call proc_lib();
  

delimiter $$
DROP PROCEDURE IF EXISTS proc_student;
create procedure proc_student()
begin
	declare v_stud_id int;
	declare v_stud_name varchar(20);
    declare v_dept varchar(5);
    declare v_batch varchar(10);
    declare v_finished integer default 0;
    declare c1 cursor for select stud_id,stud_name,dept,batch from student;
    declare continue handler for not found set v_finished=1;
    open c1;
    get_student: LOOP
       fetch c1 into v_stud_id,v_stud_name,v_dept,v_batch;
       if v_finished=1 then
          leave get_student;
       end if;
       select concat(v_stud_id,v_stud_name,v_dept,v_batch);
	END LOOP get_student;
    close c1;
end $$   
delimiter ;
call proc_student();


delimiter $$
DROP PROCEDURE IF EXISTS proc_bks;
create procedure proc_bks()
begin
	declare v_book_id int;
	declare v_title varchar(45);
    declare v_edition int;
    declare v_availablity int;
    declare v_finished integer default 0;
    declare c2 cursor for select book_id,title,edition,availablity from books;
    declare continue handler for not found set v_finished=1;
    open c2;
    get_bks: LOOP
       fetch c2 into v_book_id,v_title,v_edition,v_availablity;
       if v_finished=1 then
          leave get_bks;
       end if;
       select concat(v_book_id,v_title,v_edition,v_availablity);
	END LOOP get_bks;
    close c2;
end $$   
delimiter ;

call proc_bks();

  
delimiter $$
DROP PROCEDURE IF EXISTS proc_auth;
create procedure proc_auth()
begin
	declare v_author_name varchar(20);
	declare v_book_id int;
    declare v_finished integer default 0;
    declare c3 cursor for select author_name,book_id from author;
    declare continue handler for not found set v_finished=1;
    open c3;
    get_auth: LOOP
       fetch c3 into v_author_name,v_book_id;
       if v_finished=1 then
          leave get_auth;
       end if;
       select concat(v_author_name,v_book_id);
	END LOOP get_auth;
    close c3;
end $$   
delimiter ;

call proc_auth();

  
delimiter $$
DROP PROCEDURE IF EXISTS proc_fine;
create procedure proc_fine()
begin
	declare v_book_id int;
	declare v_stud_id int;
    declare v_amount float;
    declare v_finished integer default 0;
    declare c4 cursor for select book_id,stud_id,amount from fine_amount;
    declare continue handler for not found set v_finished=1;
    open c4;
    get_fine: LOOP
       fetch c4 into v_book_id,v_stud_id,v_amount;
       if v_finished=1 then
          leave get_fine;
       end if;
       select concat(v_book_id,v_stud_id,v_amount);
	END LOOP get_fine;
    close c4;
end $$   
delimiter ;

call proc_fine();

    
delimiter $$
DROP PROCEDURE IF EXISTS proc_fac;
create procedure proc_fac()
begin
	declare v_fac_id int;
	declare v_fac_name varchar(25);
    declare v_fac_dept varchar(15);
    declare v_finished integer default 0;
    declare c5 cursor for select fac_id,fac_name,fac_dept from faculty;
    declare continue handler for not found set v_finished=1;
    open c5;
    get_fac: LOOP
       fetch c5 into v_fac_id,v_fac_name,v_fac_dept;
       if v_finished=1 then
          leave get_fac;
       end if;
       select concat(v_fac_id,v_fac_name,v_fac_dept);
	END LOOP get_fac;
    close c5;
end $$   
delimiter ;

call proc_fac();

    
delimiter $$
DROP PROCEDURE IF EXISTS proc_issued;
create procedure proc_issued()
begin
	declare v_title varchar(25);
	declare v_book_id int;
    declare v_mem_id int;
    declare v_finished integer default 0;
    declare c6 cursor for select title,book_id,mem_id from books_issued;
    declare continue handler for not found set v_finished=1;
    open c6;
    get_issued: LOOP
       fetch c6 into v_title,v_book_id,v_mem_id;
       if v_finished=1 then
          leave get_issued;
       end if;
       select concat(v_title,v_book_id,v_mem_id);
	END LOOP get_issued;
    close c6;
end $$   
delimiter ;

call proc_issued();
  
  
delimiter $$
DROP PROCEDURE IF EXISTS proc_returned;
create procedure proc_returned()
begin
	declare v_title varchar(25);
	declare v_book_id int;
    declare v_mem_id int;
    declare v_finished integer default 0;
    declare c7 cursor for select title,book_id,mem_id from books_returned;
    declare continue handler for not found set v_finished=1;
    open c7;
    get_returned: LOOP
       fetch c7 into v_title,v_book_id,v_mem_id;
       if v_finished=1 then
          leave get_returned;
       end if;
       select concat(v_title,v_book_id,v_mem_id);
	END LOOP get_returned;
    close c7;
end $$   
delimiter ;

call proc_returned();
  
  