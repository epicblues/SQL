CREATE ROLE C##babo;
GRANT create session TO C##babo;
GRANT select any table to C##babo;
grant drop any table to C##babo;
grant delete on hr.employees to C##babo; 
grant connect, resource to C##babo;
select * from role_sys_privs;
select * from ROLE_TAB_PRIVs where role = 'C##BABO';

alter user C##kmsbabo
    default tablespace users
    quota unlimited on users;
    
select * from user_tablespace;
    

CREATE USER C##kmsbabo identified by default;
alter user C##kmsbabo identified by 1234;

grant c##babo to c##kmsbabo;

revoke c##babo from c##kmsbabo;

select * from DBA_USERS where USERname = 'C##KMSBABO';

SELECT * from USER_ROLE_PRIVS;

grant select on hr.employees to c##kmsbabo;
select * from dba_TABLESPACEs;
select * from role_sys_privs where role like '%conn%';

drop role C##babo;
revoke select on hr.employees from c##kmsbabo;