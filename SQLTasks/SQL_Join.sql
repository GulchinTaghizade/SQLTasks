﻿CREATE DATABASE MARKET

USE MARKET

CREATE TABLE ISCI(
ID INT PRIMARY KEY IDENTITY,
SAA NVARCHAR(100),
VEZIFEID INT REFERENCES VEZIFE(ID),
MAAS INT
)

INSERT INTO ISCI VALUES('ARIF',3,1500),
						('MALIK',2,1000),
						('ZAUR',1,700)


CREATE TABLE VEZIFE(
ID INT PRIMARY KEY IDENTITY,
AD NVARCHAR(100)
)

INSERT INTO VEZIFE 
VALUES('KASSIR'),
 	  ('SATICI'),
	  ('ADMINISTRATOR')

CREATE TABLE FILIAL(
ID INT PRIMARY KEY IDENTITY,
AD NVARCHAR(100)
)

INSERT INTO FILIAL 
VALUES('YASAMAL'),
	  ('NESIMI'),
	  ('XETAI')

CREATE TABLE MEHSUL(
ID INT PRIMARY KEY IDENTITY,
AD NVARCHAR(100),
ALISQIYMETI FLOAT,
SATISQIYMETI FLOAT
)

INSERT INTO MEHSUL 
VALUES ('MEYVE',50,70),
	   ('TEREVEZ',30,40),
	   ('SUD',20,30)

CREATE TABLE SATIS(
ID INT PRIMARY KEY IDENTITY,
MEHSULID INT REFERENCES MEHSUL(ID),
ISCIID INT REFERENCES ISCI(ID),
FILIALID INT REFERENCES FILIAL(ID),
SATISTARIXI DATE
)

INSERT INTO SATIS 
VALUES (3,1,2,'2022-04-20'),
	   (2,3,1,'2022-03-14'),
	   (1,2,3,'2022-01-22'),
	   (1,2,1,'2022-01-13')


--1) Satış cədvəlində işçilərin , satılan məhsulların, satışın olduğu filialın, məhsulun alış və satış qiyməti yazılsın.
SELECT I.SAA,M.AD 'MEHSUL ADI',F.AD 'FILIAL ADI',M.ALISQIYMETI,M.SATISQIYMETI FROM SATIS AS S  
JOIN ISCI AS I
ON I.ID=S.ISCIID
JOIN MEHSUL AS M
ON M.ID=S.MEHSULID
JOIN FILIAL AS F
ON F.ID=S.FILIALID

--2) Bütün satışların cəmini tap.
SELECT SUM(SATISQIYMETI) FROM SATIS AS S
JOIN MEHSUL AS M
ON M.ID=S.MEHSULID

--3) Cari ayda məhsul satışından gələn yekun məbləği tap
SELECT SUM(SATISQIYMETI) FROM SATIS AS S
JOIN MEHSUL AS M
ON M.ID=S.MEHSULID
WHERE MONTH(S.SATISTARIXI)=MONTH(GETDATE())


--4) Hər işçinin satdığı məhsul sayını tap
SELECT COUNT(*) FROM SATIS GROUP BY ISCIID

--5) Bu gün üzrə ən çox məhsul satılan filialı tap.
SELECT MAX(FILIALCOUNT) 'FILIAL ID'
FROM (SELECT COUNT(*)  FROM SATIS 
WHERE DAY(SATISTARIXI)=DAY(GETDATE())
GROUP BY FILIALID) AS FILIALCOUNT

--6) Cari ayda ən çox satılan məhsulu tap.

SELECT MAX(MEHSULCOUNT) 'MEHSUL ID'
FROM (SELECT COUNT(*)  FROM SATIS 
WHERE MONTH(SATISTARIXI)=MONTH(GETDATE())
GROUP BY MEHSULID) AS MEHSULCOUNT

