--Ben Cowan, Project 2, SWDV 220, 2018-10-05

	--start in master to create the new database
USE master;
GO

	--drop the database if it already exists. this way we can run changes easily, or recreate if some thing goes wrong.
IF DB_ID('diskInventory') IS NOT NULL DROP DATABASE diskInventory;
CREATE DATABASE diskInventory;
GO

	--now use the new 'diskInventory' database
USE diskInventory;

	--now we create the tables. first the foreign key tables so they can be referenced later
	--artist type, as in musician, actor, comedian, etc
CREATE TABLE ArtistType (
	artistTypeID		INT				PRIMARY KEY		IDENTITY,
	description			VARCHAR(200)	NOT NULL
);

	--the actual artist. they may have an individual name, or a group name
CREATE TABLE Artist (
	artistID			INT				PRIMARY KEY		IDENTITY,
	artistType			INT				REFERENCES ArtistType (artistTypeID),
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
	diskTypeID			INT				REFERENCES DiskType (diskTypeID),
	artistID			INT				REFERENCES Artist (artistID),
	genreID				INT				REFERENCES GenreType (genreTypeID),
		--this one can be null, untitled albums have been released
	diskName			VARCHAR(50),
	releaseDate			DATE			NOT NULL,
	borrowStatus		CHAR			NOT NULL
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
	borrowerID			INT				REFERENCES Borrower (borrowerID),
	diskID				INT				REFERENCES Disk (diskID),
	borrowDate			DATE			NOT NULL,		--the date it was borrowed
	dueDate				DATE			NOT NULL,		--the date it is due back
	returnDate			DATE			NOT NULL,		--the date it was actually returned
);