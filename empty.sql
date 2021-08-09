select * from user_objects;
select * from user_constraints;
select * from user_tables;
select * from user_objects;
select * from all_users;
delete from emp123;
select * from user_tablespaces;
select * from user_tablespaces;
select * from user_tables;
select * from all_users;
select * from user_constraints where table_name = 'EMPLOYEES';

select * from user_users;
select * from user_tab_columns;
INSERT INTO emp123 (select * from hr.employees);
select * from emp123;
ALTER TABLE emp123 drop (email,phone_number);

desc emp123;
select * from user_constraints where table_name = 'EMP123';
ALTER TABLE emp123 add constraint emp_pk PRIMARY KEY (employee_id);

ALTER TABLE emp123 drop constraint emp_pk;

ALTER TABLE emp123 add constraint SYS_C009528;

ALTER TABLE emp123 add (kmsbabo nvarchar2(20) DEFAULT 'babo' not null);

select * from emp123;

desc emp123;

select * from user_constraints where constraint_type = 'P';

select * from user_primary_keys;

select * from user_objects;

select * from book;
desc book;

CREATE TABLE KMSGOD (
    k_id number(20) not null,
    k_game char(5),
    k_name NVARCHAR2(20) default '바보' not null,
    upload_date date default sysdate,
    k_contents clob default '기본_내용입니다' not null,
    constraint KMS_PK PRIMARY KEY(k_id),
    constraint KMS_UNI UNIQUE(k_name)
);

desc kmsgod;

INSERT INTO KMSGOD (k_id, k_game) values (12341, 'abra');
select * from kmsgod;

rename kmsgod to kmsbabo;

select * from tabs;

desc book;
desc author;
select * from user_constraints where table_name = 'BOOK';

alter table book drop constraint FK_AUTHOR_ID;
desc author;
alter table book drop constraint fk_author_id;
                        
select * from book;
desc book;
INSERT INTO book values(1, 'hahaha',default , 1);
INSERT INTO book values(2, 'hahoho',default , 2);
INSERT INTO book values(3, USER, default ,2);
UPDATE book set author_id = 2 where author_id is null;
select * from book;
select rowid from book;
commit;

select * from book;
alter table book add primary key(author_id);
select * from author;

select * from author, book where book.author_id = author.author_id;

desc hr.employees;

select * from author;

delete from author where author_id = 1;
select * from book;

alter table book drop primary key;

select * from emp123;

alter table emp123 drop column kmsbabo;

INSERT INTO emp123 (
    select employee_id, first_name, last_name, hire_date, job_id, salary, commission_pct, manager_id, department_id 
    from hr.employees where salary = 6000
);
select * from user_tab_columns;

select * from emp123 where salary = 6000;

CREATE TABLE emp_kms as SELECT * from hr.employees;

select * from emp_kms;
grant create view to C##kmsbabo;
CREATE VIEW kms_view as SELECT * from emp_kms where salary between 10000 and 15000;

select first_name, salary, email || '@hanmail.net', replace(phone_number,'.','-') from kms_view;

SELECT * from USER_INDEXES;
CREATE INDEX kms_index on emp_kms(EMPLOYEE_ID);
select * from emp_kms;
ALTER TABLE emp_kms add constraint kms_unique unique(employee_id);

SELECT * FROM USER_CONSTRAINTS;

CREATE SEQUENCE kms_seq 
    START WITH 3
    INCREMENT BY 2
    MAXVALUE 30
    CACHE 20;

select kms_seq.nextval from dual;
select kms_seq.currval from dual;

SELECT * from USER_SEQUENCES;
SELECT * FROM user_objects;

SELECT * FROM emp_kms;

CREATE VIEW emp_mag (employee_id, employee_name, manager_name, department_id) 
as SELECT e.employee_id, e.first_name || ' ' || e.last_name fname, m.first_name, e.department_id
from emp_kms e, emp_kms m
where e.manager_id = m.employee_id;

SELECT * FROM emp_mag;



SELECT * FROM tabs;

SELECT * FROM author,book where book.author_id = author.author_id;















