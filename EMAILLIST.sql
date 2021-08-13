CREATE TABLE emaillist (
    no number PRIMARY KEY ,
    last_name varchar2(20) NOT NULL,
    first_name varchar2(20) NOT NULL,
    email VARCHAR2(128),
    createdAt DATE default SYSDATE
);

CREATE SEQUENCE seq_emaillist_pk
    START WITH 1
    INCREMENT BY 1;
    
INSERT INTO emaillist(no,last_name,first_name,email,createdAt)
VALUES (seq_emaillist_pk.nextval,'이','민성','lbueha@hanmail.net',DEFAULT);

SELECT * FROM emaillist;

COMMIT;
