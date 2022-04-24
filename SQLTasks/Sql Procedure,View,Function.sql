CREATE DATABASE HOTEL

USE HOTEL

CREATE TABLE RoomTypes(
ID INT PRIMARY KEY IDENTITY,
TypeName NVARCHAR(100),
PricePerNight FLOAT,
MaxPerson INT
)

INSERT INTO RoomTypes VALUES('Single',100,1)
INSERT INTO RoomTypes VALUES('Double',180,2)
INSERT INTO RoomTypes VALUES('King',1000,7)

SELECT*FROM RoomTypes


CREATE TABLE Rooms(
ID INT PRIMARY KEY IDENTITY,
RoomTypeID INT REFERENCES RoomTypes(ID),
RoomNumber INT UNIQUE,
[Floor] INT ,
Status BIT DEFAULT 1
)

INSERT INTO Rooms VALUES(2,155,1,1)
INSERT INTO Rooms VALUES(1,255,2,1)
INSERT INTO Rooms VALUES(3,355,3,1)
SELECT*FROM Rooms

CREATE TABLE Customers(
ID INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(100) NOT NULL,
Surname NVARCHAR(100) NOT NULL ,
DateOfBirth DATE NOT NULL ,
Gender nvarchar (10),
Address NVARCHAR(100),
City NVARCHAR(100),
Country NVARCHAR(100),
Email NVARCHAR(100) NOT NULL ,
PhoneNum NVARCHAR(100) NOT NULL ,
PassportId NVARCHAR(100) NOT NULL
)


INSERT INTO Customers
VALUES('Gulchin','Taghizade','2001-09-30','Female','Shahin Samedov, 7A','Baku','Azerbaijan','gulcin.tagizade@gmail.com','+994775076266','C05698545')
INSERT INTO Customers
VALUES('Ilahe','Taghizade','2003-02-25','Female','Shahin Samedov, 7A','Baku','Azerbaijan','ilahe.tagizade@gmail.com','+994775076166','C06698545')
INSERT INTO Customers
VALUES('Reshad','Taghizade','1995-09-25','Male','Mosc dist, home 8D','Moscow','Russia','reshad.tagizade@gmail.com','+994705706266','C05698775')

SELECT * FRom Customers

CREATE TABLE Reservations(
ID INT PRIMARY KEY IDENTITY,
CustomerID INT REFERENCES Customers(id),
RoomID INT REFERENCES Rooms(ID),
ReservationDate Date,
DateIn Date,
DateOut Date,
DaysRange int
)

INSERT INTO Reservations 
VALUES(1,3,'2022-04-24','2022-06-18','2022-09-15',DATEDIFF(DAY,'2022-06-18','2022-09-15'))
INSERT INTO Reservations 
VALUES(2,1,'2022-04-24','2022-05-15','2022-05-29',DATEDIFF(DAY,'2022-05-15','2022-05-29'))
INSERT INTO Reservations 
VALUES(3,2,'2022-04-24','2022-07-05','2022-08-15',DATEDIFF(DAY,'2022-07-05','2022-08-15'))

SELECT*FROM Reservations

CREATE TABLE PaymentTypes(
ID INT PRIMARY KEY IDENTITY,
PaymentType NVARCHAR(20)
)

INSERT INTO PaymentTypes
VALUES ('BY CASH')
INSERT INTO PaymentTypes
VALUES ('BY CARD')

SELECT*FROM PaymentTypes

CREATE TABLE Payments(
ID INT PRIMARY KEY IDENTITY,
ReservationID INT REFERENCES Reservations(id),
CustomerID INT REFERENCES Customers(id),
PaymentTypeID INT REFERENCES PaymentTypes(id),
Amount FLOAT,
PaymentDate DATE
)


INSERT INTO Payments
VALUES (1,1,2,1000,'2022-04-24')
INSERT INTO Payments
VALUES (4,2,1,180,'2022-04-24')
INSERT INTO Payments
VALUES (5,3,1,100,'2022-04-24')

SELECT*FROM Payments

CREATE TABLE Spendings(
ID INT PRIMARY KEY IDENTITY,
NAME NVARCHAR(100),
CustomerID INT REFERENCES Customers(id),
Amount FLOAT
)

INSERT INTO Spendings VALUES ('FOOD',1,200)
INSERT INTO Spendings VALUES ('FOOD',2,150)
INSERT INTO Spendings VALUES ('AMUSEMENT',3,300)

SELECT*FROM Spendings


--Query'ler yazmaq(Function,Trigger) her birine oz isteyinize uygun sample yazmaq.
--VIEW
CREATE VIEW GetCustomersAllExpenses
AS
SELECT C.Name,SUM(S.Amount+p.Amount) 'All expenses' FROM Customers AS C
JOIN Spendings AS S
ON S.CustomerID=C.ID
JOIN Payments AS P
ON P.CustomerID=C.ID
GROUP BY C.Name

SELECT*FROM  GetCustomersAllExpenses

--PROCEDURE
CREATE PROCEDURE GetRoomTypeOfCustomer @custID int 
AS
SELECT C.Name,RT.TypeName 'Room Type' FROM Customers AS C
JOIN Reservations AS R
ON R.CustomerID=C.ID
JOIN Rooms 
ON Rooms.ID=r.RoomID
JOIN RoomTypes AS RT
ON RT.ID=Rooms.RoomTypeID
WHERE @custID=C.ID

EXEC GetRoomTypeOfCustomer @CUSTiD=3


--FUNCTION
CREATE FUNCTION GetMaxCustomerCount (@RoomType nvarchar(50))
RETURNS INT
AS
BEGIN
	DECLARE @MaxPerson int
	SELECT @MaxPerson=RT.MaxPerson  FROM RoomTypes AS RT
	WHERE @RoomType=RT.TypeName
	RETURN @MaxPerson
END


SELECT [DBO].[GetMaxCustomerCount]('King')



--TRIGGER
CREATE TRIGGER CustomerInsertTrigger
ON Customers
AFTER INSERT
AS
BEGIN
	SELECT * FROM Customers
END

INSERT INTO Customers
VALUES('Ramin','Mammadov','2002-02-25','Male','Shah Sevenler dist. ','Ganja','Azerbaijan','mammedov07@gmail.com','+994556547896','C05602345')

CREATE TRIGGER CustomerDeleteTrigger
ON Customers
AFTER DELETE
AS 
BEGIN
	SELECT COUNT(*) 'Count Of Customers'FROM Customers
END

DELETE FROM Customers
WHERE ID=5



