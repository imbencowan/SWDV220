USE DiskInventory;
GO



SELECT Disk.diskID, DiskType.description, diskName, groupName, GenreType.description, releaseDate 
FROM Disk
	JOIN DiskHasArtist
		ON Disk.DiskID = DiskHasArtist.diskID
	JOIN Artist
		ON DiskHasArtist.artistID = Artist.artistID
	JOIN DiskType
		ON Disk.diskTypeID = DiskType.diskTypeID
	JOIN GenreType
		ON Disk.genreID = GenreType.genreTypeID
ORDER BY Disk.diskID
