

CREATE DATABASE TASK
USE TASK

CREATE TABLE VEZIFE(
ID INT PRIMARY KEY IDENTITY,
VEZIFE NVARCHAR(50)
)

CREATE TABLE ISCI(
ID INT PRIMARY KEY IDENTITY,
MKOD INT REFERENCES MEHSUL(ID),
SAA NVARCHAR(200),
VEZIFEID INT REFERENCES VEZIFE(ID),
MAAS INT
)

CREATE TABLE FILIAL(
ID INT PRIMARY KEY IDENTITY,
FILIAL NVARCHAR(50)
)

CREATE TABLE MEHSUL(
ID INT PRIMARY KEY IDENTITY,
AD NVARCHAR(50),
ALISQIYMETI FLOAT,
SATISQIYMETI FLOAT
)

CREATE TABLE SATIS(
ID INT PRIMARY KEY IDENTITY,
MEHSULID INT REFERENCES MEHSUL(ID),
ISCIID INT REFERENCES ISCI(ID),
ENDIRIM FLOAT,
SATISTARIXI DATE
)


SELECT COUNT(*) FROM ISCI

SELECT *FROM ISCI ORDER BY(MAAS) DESC

SELECT*FROM MEHSUL ORDER BY (SATISQIYMETI) DESC

SELECT*FROM SATIS ORDER BY (SATISTARIXI)

CREATE TABLE ISCIVEZIFE(
ID INT PRIMARY KEY IDENTITY,
ISCIID INT REFERENCES ISCI(ID),
VEZIFEID INT REFERENCES VEZIFE(ID)
)

INSERT INTO VEZIFE VALUES('BACKEND DEVELOPER')
INSERT INTO VEZIFE VALUES('FRONTEND DEVELOPER')
INSERT INTO VEZIFE VALUES('FULL DEVELOPER')
SELECT*FROM VEZIFE
SELECT*FROM SATIS



INSERT INTO ISCI VALUES(10,'TAGHIZADE GULCHIN NAIL',1,1500)
INSERT INTO ISCI VALUES(100,'TAGHIZADE ILAHE NAIL',2,1000)
INSERT INTO ISCI VALUES(120,'TAGHIZADE NAGI NAIL',3,2500)

SELECT*FROM ISCI








 




