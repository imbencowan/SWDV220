--Ben Cowan
--2018-10-24
--SWDV 220 Project 5

USE DiskInventory;
GO

	--Create Insert, Update, and Delete stored procedures for the artist table. 
		--Insert accepts all columns as input parameters except for identity fields. 
IF OBJECT_ID('spAddArtist') IS NOT NULL
	DROP PROC spAddArtist
GO
CREATE PROC spAddArtist
	@type int,
	@fName varchar(50) = NULL,
	@lName varchar(50) = NULL,
	@groupName varchar(50) = NULL
AS
	BEGIN TRY
		IF @type < 1 OR @type > 3
			THROW 50001, '@type was out of range. Enter a value of 1, 2, or 3.', 1;
		IF @fName IS NULL AND @lName IS NULL AND @groupName IS NULL
			THROW 50002, 'Missing argument. You must enter at least one name for the artist.', 1;
		INSERT INTO Artist
		VALUES (@type, @fName, @lName, @groupName)
	END TRY
	BEGIN CATCH
		PRINT 'Looks like some thing went wrong.'
		PRINT 'Row was not inserted.'
		PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER()) + ': ' + 
			CONVERT(varchar(1000), ERROR_MESSAGE());
	END CATCH;
GO
	

		--Update procedure accepts a primary key value and the artist’s names for update. 
IF OBJECT_ID('spUpdateArtist') IS NOT NULL
	DROP PROC spUpdateArtist
GO
CREATE PROC spUpdateArtist
	@id int,
	@fName varchar(50) = NULL,
	@lName varchar(50) = NULL,
	@groupName varchar(50) = NULL
AS
	BEGIN TRY
		IF NOT EXISTS (SELECT * FROM Artist WHERE artistID = @id)
			THROW 50001, 'The artist id you are attempting to update does not exist. 
				Please try again.', 1;
		IF @fName IS NULL AND @lName IS NULL AND @groupName IS NULL
			THROW 50001, 'The artist must have at least one name.', 1;
		UPDATE Artist
		SET fName = @fName,
			lName = @lName,
			groupName = @groupName
		WHERE artistID = @id
	END TRY
	BEGIN CATCH
		PRINT 'Looks like some thing went wrong.'
		PRINT 'The artist was not updated.'
		PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER()) + ': ' + 
			CONVERT(varchar(1000), ERROR_MESSAGE());
	END CATCH;
GO



		--Delete accepts a primary key value for delete.
IF OBJECT_ID('spDeleteArtist') IS NOT NULL
	DROP PROC spDeleteArtist
GO
CREATE PROC spDeleteArtist
	@id int
AS
	BEGIN TRY
		IF NOT EXISTS (SELECT * FROM Artist WHERE artistID = @id)
			THROW 50001, 'The artist id you are attempting to delete does not exist. 
				Please try again.', 1;
		DELETE Artist
		WHERE artistID = @id;
	END TRY
	BEGIN CATCH
		PRINT 'Looks like some thing went wrong.'
		PRINT 'The artist was not deleted.'
		PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER()) + ': ' + 
			CONVERT(varchar(1000), ERROR_MESSAGE());
	END CATCH;
GO


	--Create Insert, Update, and Delete stored procedures for the borrower table. 
		--Insert accepts all columns as input parameters except for identity fields. 
IF OBJECT_ID('spAddBorrower') IS NOT NULL
	DROP PROC spAddBorrower
GO
CREATE PROC spAddBorrower
	@fName varchar(50),
	@lName varchar(50),
	@email varchar(255),
	@phone varchar(12)
AS
	BEGIN TRY
		IF LEN(@phone) < 7
			THROW 50001, 'Phone number must contain at least 7 digits.', 1;
		IF CHARINDEX('@', @email) = 0 OR CHARINDEX('.', @email) = 0
			THROW 50001, 'Please enter a valid email address.', 1;
		INSERT INTO Borrower
		VALUES (@fName, @lName, @email, @phone);
	END TRY
	BEGIN CATCH
		PRINT 'Looks like some thing went wrong.'
		PRINT 'The row was not inserted.'
		PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER()) + ': ' + 
			CONVERT(varchar(1000), ERROR_MESSAGE());
	END CATCH;
GO


		--Update procedure accepts a primary key value and the borrower’s names for update. 
IF OBJECT_ID('spUpdateBorrower') IS NOT NULL
	DROP PROC spUpdateBorrower
GO
CREATE PROC spUpdateBorrower
		@id int,
		@fName varchar(50),
		@lName varchar(50)
AS
	BEGIN TRY
		IF NOT EXISTS (SELECT * FROM Borrower WHERE borrowerID = @id)
			THROW 50001, 'The borrower id you are attempting to update does not exist. 
				Please try again.', 1;
		UPDATE Borrower
		SET fName = @fName,
			lName = @lName
		WHERE borrowerID = @id;
	END TRY
	BEGIN CATCH
		PRINT 'Looks like some thing went wrong.'
		PRINT 'The row was not updated.'
		PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER()) + ': ' + 
			CONVERT(varchar(1000), ERROR_MESSAGE());
	END CATCH;
GO


		--Delete accepts a primary key value for delete.
IF OBJECT_ID('spDeleteBorrower') IS NOT NULL
	DROP PROC spDeleteBorrower
GO
CREATE PROC spDeleteBorrower
	@id int
AS
	BEGIN TRY
		IF NOT EXISTS (SELECT * FROM Borrower WHERE borrowerID = @id)
			THROW 50001, 'The borrower id you are attempting to delete does not exist. 
				Please try again.', 1;
		DELETE Borrower
		WHERE borrowerID = @id;
	END TRY
	BEGIN CATCH
		PRINT 'Looks like some thing went wrong.'
		PRINT 'The borrower was not deleted.'
		PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER()) + ': ' + 
			CONVERT(varchar(1000), ERROR_MESSAGE());
	END CATCH;
GO


	--Create Insert, Update, and Delete stored procedures for the disk table. 
		--Insert accepts all columns as input parameters except for identity fields. 
IF OBJECT_ID('spAddDisk') IS NOT NULL
	DROP PROC spAddDisk
GO
CREATE PROC spAddDisk
	@diskTypeID int,
	@genreID int,
	@diskName varchar(100),
	@releaseDate date,
	@borrowStatus char(1)
AS
	BEGIN TRY
		IF @diskTypeID < 1 OR @diskTypeID > 2
			THROW 50001, '@diskTypeID was out of range. 
				The value must 1 for an album or 2 for a movie.', 1;
		IF @genreID < 1 OR @genreID > 9
			THROW 50001, '@genreID was out of range. The value must be in the range 1 through 9.', 1;

		INSERT INTO Disk
		VALUES (@diskTypeID, @genreID, @diskName, @releaseDate, @borrowStatus)
	END TRY
	BEGIN CATCH
		PRINT 'Looks like some thing went wrong.'
		PRINT 'Row was not inserted.'
		PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER()) + ': ' + 
			CONVERT(varchar(1000), ERROR_MESSAGE());
	END CATCH;;
GO


		--Update procedure accepts a primary key value and the disk information for update. 
IF OBJECT_ID('spUpdateDisk') IS NOT NULL
	DROP PROC spUpdateDisk
GO
CREATE PROC spUpdateDisk
	@id int,
	@diskTypeID int,
	@genreID int,
	@diskName varchar(100),
	@releaseDate date,
	@borrowStatus char(1)
AS
	BEGIN TRY
		IF @diskTypeID < 1 OR @diskTypeID > 2
			THROW 50001, '@diskTypeID was out of range. 
				The value must 1 for an album or 2 for a movie.', 1;
		IF @genreID < 1 OR @genreID > 9
			THROW 50001, '@genreID was out of range. The value must be in the range 1 through 9.', 1;
		IF NOT EXISTS (SELECT * FROM Disk WHERE diskID = @id)
			THROW 50001, 'The disk id you are attempting to update does not exist. 
				Please try again.', 1;
		UPDATE Disk
		SET diskTypeID = @diskTypeID,
			genreID = @genreID,
			diskName = @diskName,
			releaseDate = @releaseDate,
			borrowStatus = @borrowStatus
		WHERE diskID = @id;
	END TRY
	BEGIN CATCH
		PRINT 'Looks like some thing went wrong.'
		PRINT 'The row was not updated.'
		PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER()) + ': ' + 
			CONVERT(varchar(1000), ERROR_MESSAGE());
	END CATCH;
GO


		--Delete accepts a primary key value for delete.
IF OBJECT_ID('spDeleteDisk') IS NOT NULL
	DROP PROC spDeleteDisk
GO
CREATE PROC spDeleteDisk
	@id int
AS
	BEGIN TRY
		IF NOT EXISTS (SELECT * FROM Disk WHERE diskID = @id)
			THROW 50001, 'The disk id you are attempting to delete does not exist. 
				Please try again.', 1;
		DELETE Disk
		WHERE diskID = @id;
	END TRY
	BEGIN CATCH
		PRINT 'Looks like some thing went wrong.'
		PRINT 'The disk was not deleted.'
		PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER()) + ': ' + 
			CONVERT(varchar(1000), ERROR_MESSAGE());
	END CATCH;
GO


	--Script file includes all required ‘GO’ statements.

	--Stored procedures contain error processing (try-catch).

	--Script file includes all execute statements needed to invoke each stored procedure.
USE DiskInventory;
GO

	--add an artist
BEGIN TRY 
	EXEC spAddArtist '1', NULL, NULL, 'Pile'
	SELECT * FROM Artist ORDER BY artistID DESC;
END TRY
BEGIN CATCH
	PRINT 'Looks like some thing went wrong.'
	PRINT 'Make sure that you have the correct number of parameters, and that they are all the correct data type.'
	PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER()) + ': ' + 
		CONVERT(varchar(1000), ERROR_MESSAGE());
END CATCH;
GO

	--update that artist
BEGIN TRY
	EXEC spUpdateArtist @@IDENTITY, NULL, NULL, 'Slothrust'
	SELECT * FROM Artist ORDER BY artistID DESC;
END TRY
BEGIN CATCH
	PRINT 'Looks like some thing went wrong.'
	PRINT 'Make sure that you have the correct number of parameters, and that they are all the correct data type.'
	PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER()) + ': ' + 
		CONVERT(varchar(1000), ERROR_MESSAGE());
END CATCH;
GO

	--delete that artist
BEGIN TRY
	EXEC spDeleteArtist @@IDENTITY
	SELECT * FROM Artist ORDER BY artistID DESC;
END TRY
BEGIN CATCH
	PRINT 'Looks like some thing went wrong.'
	PRINT 'Make sure that you have the correct number of parameters, and that they are all the correct data type.'
	PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER()) + ': ' + 
		CONVERT(varchar(1000), ERROR_MESSAGE());
END CATCH;
GO


	--add a borrower
BEGIN TRY
	EXEC spAddBorrower 'Dick', 'Tracy', 'dick@tracy.net', '2089427734'
	SELECT * FROM Borrower ORDER BY borrowerID DESC;
END TRY
BEGIN CATCH
	PRINT 'Looks like some thing went wrong.'
	PRINT 'Make sure that you have the correct number of parameters, and that they are all the correct data type.'
	PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER()) + ': ' + 
		CONVERT(varchar(1000), ERROR_MESSAGE());
END CATCH;
GO

	--update that borrower
BEGIN TRY
	EXEC spUpdateBorrower @@IDENTITY, 'New', 'Sherriff'
	SELECT * FROM Borrower ORDER BY borrowerID DESC;
END TRY
BEGIN CATCH
	PRINT 'Looks like some thing went wrong.'
	PRINT 'Make sure that you have the correct number of parameters, and that they are all the correct data type.'
	PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER()) + ': ' + 
		CONVERT(varchar(1000), ERROR_MESSAGE());
END CATCH;
GO

	--delete that borrower
BEGIN TRY
	EXEC spDeleteBorrower @@IDENTITY
	SELECT * FROM Borrower ORDER BY borrowerID DESC;
END TRY
BEGIN CATCH
	PRINT 'Looks like some thing went wrong.'
	PRINT 'Make sure that you have the correct number of parameters, and that they are all the correct data type.'
	PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER()) + ': ' + 
		CONVERT(varchar(1000), ERROR_MESSAGE());
END CATCH;
GO


	--add a disk
BEGIN TRY
	EXEC spAddDisk '1', '1', 'Last Building Burning', '10-19-2018', '0'
	SELECT * FROM Disk ORDER BY diskID DESC;
END TRY
BEGIN CATCH
	PRINT 'Looks like some thing went wrong.'
	PRINT 'Make sure that you have the correct number of parameters, and that they are all the correct data type.'
	PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER()) + ': ' + 
		CONVERT(varchar(1000), ERROR_MESSAGE());
END CATCH;
GO

	--update that disk
BEGIN TRY
	EXEC spUpdateDisk @@IDENTITY, '1', '1', 'Fake Name', '10-10-2010', '0'
	SELECT * FROM Disk ORDER BY diskID DESC;
END TRY
BEGIN CATCH
	PRINT 'Looks like some thing went wrong.'
	PRINT 'Make sure that you have the correct number of parameters, and that they are all the correct data type.'
	PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER()) + ': ' + 
		CONVERT(varchar(1000), ERROR_MESSAGE());
END CATCH;
GO

	--delete that disk
BEGIN TRY
	EXEC spDeleteDisk @@IDENTITY
	SELECT * FROM Disk ORDER BY diskID DESC;
END TRY
BEGIN CATCH
	PRINT 'Looks like some thing went wrong.'
	PRINT 'Make sure that you have the correct number of parameters, and that they are all the correct data type.'
	PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER()) + ': ' + 
		CONVERT(varchar(1000), ERROR_MESSAGE());
END CATCH;
GO