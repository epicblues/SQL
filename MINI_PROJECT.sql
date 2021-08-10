CREATE TABLE PHONE_BOOK (
    id NUMBER(10) PRIMARY KEY,
    name VARCHAR2(10),
    hp VARCHAR2(20),
    tel VARCHAR2(20)
);

CREATE SEQUENCE seq_phone_book;
    
drop Sequence seq_phone_book;

    
SELECT * FROM USER_SEQUENCES;

SELECT * FROM phone_book;

INSERT INTO phone_book values(seq_phone_book.nextval, '김민성','010-2406-5216','02-6242-5216');
commit;

select seq_phone_book.nextval from dual;
select seq_phone_book.currval from dual;