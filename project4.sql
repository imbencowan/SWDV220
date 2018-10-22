--Ben Cowan 2018-10-22
--Project 4

	--select the database
USE DiskInventory;
GO

	--3
	--Show the disks in your database and any associated Individual artists only. 
		--Sort by Artist Last Name, First Name & Disk Name.
SELECT fName, lName, diskName, releaseDate
FROM Artist
	JOIN DiskHasArtist
		ON Artist.artistID = DiskHasArtist.artistID
	JOIN Disk
		ON DiskHasArtist.diskID = Disk.diskID
--WHERE groupName IS NULL
ORDER BY lName, fName, diskName;
GO




	--4
	--Create a view called View_Individual_Artist that shows the artists’ names and not group names. 
		--Include the artist id in the view definition but do not display the id in your output.
IF OBJECT_ID('ViewIndividualArtist', 'V') IS NOT NULL
DROP VIEW ViewIndividualArtist;
GO

CREATE VIEW ViewIndividualArtist AS
SELECT fName, lName, artistID
FROM Artist
WHERE groupName IS NULL;
GO

SELECT fName, lName
FROM ViewIndividualArtist;




	--5
	--Show the disks in your database and any associated Group artists only. 
		--Use the View_Individual_Artist view. Sort by Group Name & Disk Name.
SELECT diskName, groupName, releaseDate
FROM Disk
	JOIN DiskHasArtist
		ON Disk.diskID = DiskHasArtist.diskID
	JOIN Artist
		ON DiskHasArtist.artistID = Artist.artistID
WHERE NOT EXISTS (SELECT * FROM ViewIndividualArtist WHERE Artist.artistID = ViewIndividualArtist.artistID)
ORDER BY groupName, diskName




	--6
	--Show which disks have been borrowed and who borrowed them. 
		--Sort by Borrower’s Last Name, (***then First Name, then Disk Name, then Borrowed Date).
SELECT fName, lName, diskName, borrowDate
FROM Borrower
	JOIN BorrowInstance
		ON Borrower.borrowerID = BorrowInstance.borrowerID
	JOIN Disk
		ON BorrowInstance.diskID = Disk.diskID
ORDER BY lName, fName, diskName, borrowDate;




	--7
	--In disk_id order, show the number of times each disk has been borrowed.
SELECT Disk.diskID, diskName, COUNT(borrowInstanceID) AS TimesBorrowed
FROM Disk
	LEFT JOIN BorrowInstance
		ON Disk.diskID = BorrowInstance.diskID
GROUP BY Disk.diskID, diskName
ORDER BY Disk.diskID;




	--8
	--Show the disks outstanding or on-loan and who has each disk. Sort by disk name.
SELECT diskName, borrowDate, returnDate, fName, lName
FROM Disk
	JOIN BorrowInstance
		ON Disk.diskID = BorrowInstance.diskID
	JOIN Borrower
		ON Borrower.borrowerID = BorrowInstance.borrowerID
WHERE returnDate IS NULL
ORDER BY diskName;