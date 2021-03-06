

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
SATISTARIXI DATE,
FILIALID INT REFERENCES FILIAL(ID)
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

----------------------II seviyye---------------------------------

SELECT I.SAA,M.AD, M.ALISQIYMETI, M.SATISQIYMETI FROM SATIS AS S -------------1
JOIN MEHSUL as M
ON M.ID=S.MEHSULID
JOIN ISCI AS I
ON I.ID=S.ISCIID
JOIN FILIAL AS F
ON F.ID=S.FILIALID

SELECT SUM(M.SATISQIYMETI) FROM SATIS AS S-------------------2
JOIN MEHSUL AS M
ON S.MEHSULID=M.ID


SELECT SUM(SATISQIYMETI)  ------------------------3
FROM MEHSUL AS M
JOIN SATIS AS S
ON S.MEHSULID=M.ID
WHERE MONTH(S.SATISTARIXI) =MONTH(getdate()) 



SELECT SUM(SATISQIYMETI)-SUM(ALISQIYMETI)   ------------------------4
FROM MEHSUL AS M
JOIN SATIS AS S
ON S.MEHSULID=M.ID
WHERE MONTH(S.SATISTARIXI) =MONTH(getdate()) 


SELECT COUNT(*) FROM SATIS AS S  --------------------------5
WHERE MONTH(S.SATISTARIXI) =MONTH(getdate())
GROUP BY ISCIID


 
SELECT SUM(M.SATISQIYMETI) FROM SATIS AS S  --------------------------6
JOIN MEHSUL AS M
ON M.ID=S.MEHSULID
WHERE MONTH(S.SATISTARIXI) =MONTH(getdate())
GROUP BY ISCIID


SELECT SUM(M.SATISQIYMETI)-SUM(M.ALISQIYMETI) FROM SATIS AS S  --------------------------7
JOIN MEHSUL AS M
ON M.ID=S.MEHSULID
WHERE MONTH(S.SATISTARIXI) =MONTH(getdate())
GROUP BY ISCIID


SELECT SUM(M.SATISQIYMETI) FROM SATIS AS S     -------------------------8
JOIN MEHSUL AS M 
ON M.ID=S.MEHSULID
JOIN FILIAL AS F
ON F.ID=S.FILIALID
WHERE DAY(S.SATISTARIXI)=DAY(GETDATE())
GROUP BY FILIALID



SELECT COUNT(*) 'COUNT',M.AD FROM MEHSUL AS M          ------------------------9
JOIN SATIS AS S
ON S.MEHSULID=M.ID
WHERE MONTH(S.SATISTARIXI)=MONTH(GETDATE())
GROUP BY M.ID,M.AD



SELECT TOP 1 M.AD,COUNT(S.MEHSULID) 'COUNT' FROM SATIS AS S      ------------------------10
JOIN MEHSUL AS M
ON M.ID=S.MEHSULID
WHERE MONTH(S.SATISTARIXI)=MONTH(GETDATE())
GROUP BY M.AD



