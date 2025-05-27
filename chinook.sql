chinook.sql
-- act 1
SELECT FirstName, LastName
FROM Employee
ORDER BY LastName, FirstName;

-- act 2
SELECT Track.Name, Track.Milliseconds
FROM Track
JOIN Album ON Track.AlbumId = Album.AlbumId
WHERE Album.Title = 'Big Ones'
ORDER BY Track.Milliseconds DESC;

-- act 3
SELECT Genre.Name, COUNT(Track.TrackId) AS CantidadCanciones
FROM Genre
JOIN Track ON Genre.GenreId = Track.GenreId
GROUP BY Genre.GenreId
ORDER BY CantidadCanciones DESC;

-- act 4
SELECT Album.Title, COUNT(Track.TrackId) AS NumCanciones
FROM Album
JOIN Track ON Album.AlbumId = Track.AlbumId
GROUP BY Album.AlbumId
HAVING COUNT(Track.TrackId) >= 5;

-- act 5
SELECT Album.Title, SUM(Track.UnitPrice) AS PrecioTotal
FROM Album
JOIN Track ON Album.AlbumId = Track.AlbumId
GROUP BY Album.AlbumId
ORDER BY PrecioTotal ASC
LIMIT 10;

-- act 6
SELECT Track.Name AS Tema, Genre.Name AS Género, Album.Title AS Disco
FROM Track
JOIN Genre ON Track.GenreId = Genre.GenreId
JOIN Album ON Track.AlbumId = Album.AlbumId
WHERE Track.UnitPrice = 0.99;

