
USE Company;

-- Employee table
CREATE TABLE Employee (
    SSN INT PRIMARY KEY IDENTITY(1,1),
    Fname NVARCHAR(20) NOT NULL,
    Lname NVARCHAR(20) NOT NULL,
    Gender NVARCHAR(6) CHECK (Gender IN ('male', 'female')),
    DateBirth DATE
);

-- Department table
CREATE TABLE Department (
    DepNum INT PRIMARY KEY,
    Hiring_date DATE NOT NULL,
    SSN INT, 
    FOREIGN KEY (SSN) REFERENCES Employee(SSN)
);

-- Location table
CREATE TABLE Location (
    DepNum int,
	location nvarchar(100),
	Foreign key (DepNum) references Department(DepNum),
	primary key (DepNum, location)
);

--Project table
CREATE TABLE Project
(
	Pname nvarchar(50) not null,
	Pnumber int primary key identity(1,1),
	location nvarchar(100) not null,
	city nvarchar(100) not null,
	DepNum int,
	foreign key (DepNum) references Department(DepNum)
);

--Works table
create table Works
(
	SSN int,
	Pnumber int,
	Hours int not null,
	foreign key (SSN) references Employee(SSN),
	foreign key (Pnumber) references Project(Pnumber),
	primary key (SSN, Pnumber)
);

--Dependent table
create table Dependent
(
	SSN int,
	Dependent_name int primary key identity(1,1),
	gender bit default 0,
	Birth_date date,
	foreign key (SSN) references Employee(SSN)
);

alter table Employee
	add DepNum int foreign key references Department(DepNum)


DECLARE @SSN INT;
DECLARE @Pnumber INT;

--Insert into Employee and capture the SSN
INSERT INTO Employee(Fname, Lname, DateBirth, Gender)
VALUES ('Raiya', 'Alhabsi', '1999-08-18', 'Female');

-- Get the auto-generated SSN
SET @SSN = SCOPE_IDENTITY();

--Insert into Department using the captured SSN
INSERT INTO Department(DepNum, Hiring_date, SSN)
VALUES (101, '2020-01-15', @SSN);

--Insert into Location
INSERT INTO Location(DepNum, location)
VALUES (101, 'Muscat HQ');

-- Get Raiya's SSN from Employee table (since we've already inserted her)
SELECT @SSN = SSN FROM Employee WHERE Fname = 'Raiya' AND Lname = 'Alhabsi';

-- Insert into Project and capture Pnumber
INSERT INTO Project(Pname, location, city, DepNum)
VALUES ('ERP Implementation', 'Muscat HQ', 'Muscat', 101);

SET @Pnumber = SCOPE_IDENTITY();  -- Get generated Pnumber

--Insert into Works using SSN and Pnumber
INSERT INTO Works(SSN, Pnumber, Hours)
VALUES (@SSN, @Pnumber, 40);

-- Insert into Dependent 
INSERT INTO Dependent(SSN, gender, Birth_date)
VALUES (@SSN, 0, '2015-06-01');  -- 0 = Female