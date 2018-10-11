--Ben Cowan, Project 2, SWDV 220, 2018-10-05

/**********************
fixed foreign keys that needed to be NOT NULL
added DiskHasArtist table
increased diskName from varchar(50) to varchar(100)
added a DEFAULT value for borrowStatus in Disk
**********************/

	--start in master to create the new database
USE master;
GO

	--drop the database if it already exists. this way we can run changes easily, or recreate if some thing goes wrong.
IF DB_ID('DiskInventory') IS NOT NULL DROP DATABASE DiskInventory;
CREATE DATABASE DiskInventory;
GO

	--now use the new 'diskInventory' database
USE DiskInventory;

	--now we create the tables. first the foreign key tables so they can be referenced later
	--artist type, as in musician, actor, comedian, etc
CREATE TABLE ArtistType (
	artistTypeID		INT				PRIMARY KEY		IDENTITY,
	description			VARCHAR(200)	NOT NULL
);

	--the actual artist. they may have an individual name, or a group name
CREATE TABLE Artist (
	artistID			INT				PRIMARY KEY		IDENTITY,
	artistType			INT				NOT NULL		REFERENCES ArtistType (artistTypeID),
		--names here accept nulls, as any artist may not have each name
	fName				VARCHAR(50)		DEFAULT NULL,
	lName				VARCHAR(50)		DEFAULT NULL,
	groupName			VARCHAR(50)		DEFAULT NULL
);

	--disk type, ie dvd, cd, some thing else
CREATE TABLE DiskType (
	diskTypeID			INT				PRIMARY KEY		IDENTITY,
	description			VARCHAR(200)	NOT NULL
);

	--genre
CREATE TABLE GenreType (
	genreTypeID			INT				PRIMARY KEY		IDENTITY,
	description			VARCHAR(200)	NOT NULL
);

	--the actual disk. references previous tables.
CREATE TABLE Disk (
	diskID				INT				PRIMARY KEY		IDENTITY,
	diskTypeID			INT				NOT NULL		REFERENCES DiskType (diskTypeID),
	genreID				INT				NOT NULL		REFERENCES GenreType (genreTypeID),
		--this one can be null, untitled albums have been released
	diskName			VARCHAR(100),
	releaseDate			DATE			NOT NULL,
	borrowStatus		CHAR			NOT NULL		DEFAULT 0
);

	--with Disk and Artist we can create DiskHasArtist
CREATE TABLE DiskHasArtist (
	diskHasArtistID		INT				PRIMARY KEY		IDENTITY,
	diskID				INT				NOT NULL		REFERENCES Disk (diskID),
	artistID			INT				NOT NULL		REFERENCES Artist (artistID)
);

	--a borrower, and their info
CREATE TABLE Borrower (
	borrowerID			INT				PRIMARY KEY		IDENTITY,
		--name is required. email and phone too.
	fName				VARCHAR(50)		NOT NULL,
	lName				VARCHAR(50)		NOT NULL,
	email				VARCHAR(255)	NOT NULL,
	phone				VARCHAR(12)		NOT NULL
);

	--a table to record each instance that a disk is borrowed.
CREATE TABLE BorrowInstance (
	borrowInstanceID	INT				PRIMARY KEY		IDENTITY,
	borrowerID			INT				NOT NULL		REFERENCES Borrower (borrowerID),
	diskID				INT				NOT NULL		REFERENCES Disk (diskID),
	borrowDate			DATE			NOT NULL,		--the date it was borrowed
	dueDate				DATE			NOT NULL,		--the date it is due back
	returnDate			DATE			NULL		--the date it was actually returned
);