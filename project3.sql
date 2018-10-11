--Ben Cowan 2018-10-11 
--Project 3

--i fixed issues in project 2  and reran it rather than coding fixes in a separate project

/**************************************
Using your disk_inventory database, write the SQL statements to be executed against it. Save the SQL code for each query into ONE SQL document. Post that text Document in BB. No joins are required this week.

a. Document each SQL statement – what it is supposed to do.

b. If structure changes are needed to the tables from previous projects, include the code at the beginning of your script & document it/them.

c. Disk table:
1. Insert at least 20 rows of data into the table
2. Update only 1 row using a where clause

d. Borrower table:
1. Insert at least 20 rows of data into the table
2. Delete only 1 row using a where clause

e. Artist table:
1. Insert at least 20 rows of data into the table

f. DiskHasBorrower table:
1. Insert at least 20 rows of data into the table
2. Insert at least 2 different disks
3. Insert at least 2 different borrowers
4. At least 1 disk has been borrowed by the same borrower 2 different times
5. At least 1 disk in the disk table does not have a related row here
6. At least 1 disk must have at least 2 different rows here
7. At least 1 borrower in the borrower table does not have a related row here
8. At least 1 borrower must have at least 2 different rows here

g. DiskHasArtist table:
1. Insert at least 20 rows of data into the table
2. At least 1 disk must have at least 2 different artist rows here
3. At least 1 artist must have at least 2 different disk rows here
4. Correct variation of disk & artist data similar to DiskHasBorrower

h. Create a query to list the disks that are on loan and have not been returned.
Sample Output:
Borrower_id Disk_id Borrowed_date Return_date
9 2 2012-04-02 00:00:00.000 NULL
9 4 2012-04-02 00:00:00.000 NULL
****************************************/

	--use the correct database
USE DiskInventory;
GO

	--fill dependent taables first
		--start with DiskType
INSERT INTO DiskType
VALUES
	('album'),
	('movie')
;

	--then ArtistType
INSERT INTO ArtistType
VALUES
	('musical artist'),
	('director'),
	('comedian')
;

	--then GenreType
INSERT INTO GenreType
VALUES
	('rock'),
	('alternative'),
	('electronic'),
	('country'),
	('hip hop'),
	('action'),
	('drama'),
	('comedy'),
	('romance')
;

	--now we can fill artists. first we'll do ones that only have a group name. music groups.
INSERT INTO Artist (artistType, groupName)
VALUES
	(1, 'Cloud Nothings'),
	(1, 'Mr. Gnome'),
	(1, 'Yeah Yeah Yeahs'),
	(1, 'Los Campesinos!'),
	(1, 'Wolf Parade'),
	(1, 'Modest Mouse'),
	(1, 'Sleigh Bells'),
	(1, 'Japandroids'),
	(1, 'The Joy Formidable'),
	(1, 'Weatherbox'),
	(1, 'The Appleseed Cast'),
	(1, 'Murder By Death'),
	(1, 'Hanni El Khatib'),
	(1, 'Pretty Lights'),
	(1, 'Arcade Fire'),
	(1, 'Big Country'),
	(1, 'Thao With The Get Down Stay Down'),
	(1, 'Hot Water Music'),
	(1, 'Millencolin'),
	(1, 'The Naked & Famous'),
	(1, 'Wavves')
;
	--we'll add an artists with first and last name. at least one for dvds
INSERT INTO Artist (artistType, fName, lName)
VALUES
	(1, 'Parov', 'Stelar'),
	(2, 'John', 'Nolan')
;

	--now that we have DiskType, GenreType, and Artist, we can fill Disk
INSERT INTO Disk
VALUES
	(1, 1, 'Attack On Memory', '2012-01-24', DEFAULT),
	(1, 1, 'Madness In Miniature', '2011-10-25', DEFAULT),
	(1, 1, 'Here And Nowhere Else', '2014-04-01', DEFAULT),
	(1, 1, 'Is Is', '2007-07-24', DEFAULT),
	(1, 2, 'No Blues', '2013-10-29', DEFAULT),
	(1, 2, 'Apologies to the Queen Mary', '2005-09-27', DEFAULT),
	(1, 1, 'Strangers to Ourselves', '2015-03-17', DEFAULT),
	(1, 3, 'Treats', '2010-05-24', DEFAULT),
	(1, 1, 'Celebration Rock', '2012-05-29', DEFAULT),
	(1, 1, 'A Balloon Called Moaning', '2008-12-17', DEFAULT),
	(1, 1, 'The Big Roar', '2011-01-24', DEFAULT),
	(1, 1, 'American Art', '2007-05-08', DEFAULT),
	(1, 1, 'The Heart of a Dark Star', '2014-11-18', DEFAULT),
	(1, 2, 'Illumination Ritual', '2013-04-23', DEFAULT),
	(1, 1, 'Fever to Tell', '2003-04-29', DEFAULT),
	(1, 1, 'This is a Long Drive for Someone with Nothing to Think About', '1996-04-26', DEFAULT),
	(1, 1, 'The Moon and Antarctica', '2000-06-13', DEFAULT),
	(1, 2, 'Bitter Drink, Bitter Moon', '2012-09-25', DEFAULT),
	(1, 1, 'Will the Guns Come Out', '2011-09-23', DEFAULT),
	(1, 2, 'Reflektor', '2013-10-28', DEFAULT),
	(1, 1, 'No Life For Me', '2015-06-28', DEFAULT),
	(2, 6, 'Interstellar i guess well update this', '2014-10-26', DEFAULT)
;

	--here's a required UPDATE
UPDATE Disk
SET diskName = 'Interstellar'
WHERE diskName = 'Interstellar i guess well update this';

	--now with disks and artists we can fill DiskHasArtist
INSERT INTO DiskHasArtist
VALUES
	(1, 1),
	(2, 2),
	(3, 1),
	(4, 3),
	(5, 4),
	(6, 5),
	(7, 6),
	(8, 7),
	(9, 8),
	(10, 9),
	(11, 9),
	(12, 10),
	(13, 2),
	(14, 11),
	(15, 3),
	(16, 6),
	(17, 6),
	(18, 12),
	(19, 13),
	(20, 15),
	(21, 1),
	(21, 21),
	(22, 23)
;

	--now fill borrowers
INSERT INTO Borrower
VALUES
	('James', 'Smith', 'james@smith.com', '2083457734'),
	('Mary', 'Brown', 'mary@brown.com', '2089993456'),
	('John', 'Campbell', 'john@campbell.com', '2089215468'),
	('Patricia', 'Rowell', 'patricia@rowell.com', '2085438892'),
	('Robert', 'Planter', 'robert@planter.com', '2085526938'),
	('Jennifer', 'Garnier', 'jennifer@garnier.com', '2085547839'),
	('Michael', 'Smith', 'michael@smith.com', '2089925437'),
	('Linda', 'Gulia', 'linda@gulia.com', '9078856425'),
	('William', 'Bower', 'william@bower.com', '3602288425'),
	('Elizabeth', 'Queen', 'elizabeth@queen.com', '9075428859'),
	('David', 'Argyle', 'david@argyle.com', '2087725439'),
	('Barbara', 'Bismuth', 'barbara@bismuth.com', '3602245889'),
	('Richard', 'King', 'richard@king.com', '3605548992'),
	('Susan', 'Summers', 'susan@summers.com', '9078899621'),
	('Joseph', 'Hammer', 'joseph@hammer.com', '2085528973'),
	('Jessica', 'Bible', 'jessica@bible.com', '2089425583'),
	('Thomas', 'Doubtfire', 'thomas@doubtfire.com', '2083425569'),
	('Sarah', 'Summers', 'sarah@summers.com', '3366098825'),
	('Charles', 'Thomas', 'charles@thomas.com', '2083458889'),
	('Margaret', 'Thatchhead', 'margaret@thatchhead.com', '9075028945'),
	('Delete', 'Deletehead', 'delete@deletehead.com', '9075542121')
;

	--here we'll do a mandatory delete
DELETE Borrower
WHERE fName = 'Delete';

	--finally we can fill the BorrowInstance records
INSERT INTO BorrowInstance
VALUES
	(1, 5, '2018-10-11', '2018-10-18', NULL),
	(1, 5, '2018-07-09', '2018-07-16', '2018-07-15'),
	(1, 7, '2018-07-09', '2018-07-16', '2018-07-15'),
	(2, 8, '2018-07-09', '2018-07-16', '2018-07-15'),
	(3, 9, '2018-07-09', '2018-07-16', '2018-07-15'),
	(4, 11, '2018-07-09', '2018-07-16', '2018-07-15'),
	(5, 8, '2018-10-11', '2018-10-18', NULL),
	(6, 8, '2018-10-11', '2018-10-18', NULL),
	(11, 17, '2018-01-10', '2018-01-17', '2018-01-17'),
	(11, 19, '2018-01-10', '2018-01-17', '2018-01-17'),
	(11, 5, '2018-01-10', '2018-01-17', '2018-01-17'),
	(10, 6, '2018-01-10', '2018-01-17', '2018-01-17'),
	(5, 4, '2018-01-10', '2018-01-17', '2018-01-17'),
	(2, 3, '2018-02-03', '2018-02-10', '2018-02-05'),
	(4, 2, '2018-02-03', '2018-02-10', '2018-02-05'),
	(2, 18, '2018-02-03', '2018-02-10', '2018-02-05'),
	(2, 17, '2018-02-03', '2018-02-10', '2018-02-05'),
	(3, 8, '2018-02-03', '2018-02-10', '2018-02-05'),
	(3, 11, '2018-02-03', '2018-02-10', '2018-02-05'),
	(3, 4, '2018-03-03', '2018-03-10', '2018-03-10'),
	(6, 9, '2018-03-03', '2018-03-10', '2018-03-10'),
	(7, 8, '2018-03-03', '2018-03-10', '2018-03-10')
;



SELECT *
FROM BorrowInstance
WHERE returnDate IS NULL;
