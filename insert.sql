-- Добавляем жанры (не менее 3 жанров)
INSERT INTO genres ("name") 
VALUES ('Rock'), ('Pop'), ('Electronic');

-- Добавляем исполнителей (не менее 4 исполнителей)
INSERT INTO artists ("name") 
VALUES ('Linkin Park'), ('Lady Gaga'), ('Daft Punk'), ('Radiohead'), ('Баста');

-- Связываем исполнителей с жанрами
INSERT INTO artists_genres (artists_id, genres_id) 
VALUES (1, 1), (2, 2), (3, 3), (4, 1), (5, 2);

-- Добавляем альбомы (не менее 3 альбомов)
INSERT INTO albums ("name", release_year) 
VALUES 
('Meteora', 2003), 
('The Fame', 2008), 
('Discovery', 2001), 
('Future Nostalgia', 2020), 
('Баста 4', 2013);

-- Связываем исполнителей с альбомами 
INSERT INTO artists_albums (artists_id, albums_id) 
VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

-- Добавляем треки (не менее 6 треков)
INSERT INTO tracks ("name", duration, albums_id) 
VALUES 
('Numb', 187, 1), 
('Faint', 162, 1),
('Poker Face', 237, 2), 
('Paparazzi', 208, 2),
('One More Time', 320, 3), 
('Harder, Better, Faster, Stronger', 224, 3),
('Levitating', 203, 4), 
('Don''t Start Now', 183, 4),
('Мой стиль', 215, 5),
('My Universe', 228, 5),
('Believe in my soul', 190, 5);

-- Добавляем сборники (не менее 4 сборников)
INSERT INTO "collection" ("name", year_manufacture) 
VALUES 
('Best of 2000s', 2010), 
('Electronic Giants', 2015), 
('Rock Anthems', 2012), 
('Dance Hits', 2018),
('Global Hits 2020', 2020);

-- Связываем сборники с треками
INSERT INTO track_collection (tracks_id, collection_id) 
VALUES 
(1, 1), (2, 1), (3, 1), (4, 1),
(5, 2), (6, 2), (11, 2), 
(1, 3), (2, 3), 
(3, 4), (4, 4), 
(7, 4), (8, 4), (9, 4), 
(7, 5), (8, 5), (9, 5), (10, 5), (11, 5);

-- Связываем трек с жанрами
INSERT INTO track_genres (tracks_id, genres_id)
VALUES 
(1, 1), 
(2, 1), 
(3, 2), 
(4, 2), 
(5, 3), 
(6, 3), 
(7, 2), 
(8, 2), 
(9, 2), 
(10, 2),
(11, 2);

-------------------------------------------
---------------- Задание 2 ----------------
-------------------------------------------

-- Название и продолжительность самого длительного трека.
SELECT "name", duration 
FROM tracks
WHERE duration = (SELECT MAX(duration) FROM tracks);

-- Название треков, продолжительность которых не менее 3,5 минут.
SELECT "name"
FROM tracks
WHERE duration >= 210;

-- Названия сборников, вышедших в период с 2018 по 2020 год включительно.
SELECT "name"
FROM "collection"
WHERE year_manufacture BETWEEN 2018 AND 2020;

-- Исполнители, чьё имя состоит из одного слова.
SELECT "name"
FROM artists
WHERE "name" NOT LIKE '% %';

-- Название треков, которые содержат слово «мой» или «my».
SELECT "name"
FROM tracks
WHERE "name" ~* '\m(мой|my)\M';

-------------------------------------------
---------------- Задание 3 ----------------
-------------------------------------------

-- Количество исполнителей в каждом жанре.
SELECT g."name", COUNT(ag.artists_id) AS artists_count
FROM genres g
LEFT JOIN artists_genres ag ON g.genres_id = ag.genres_id
GROUP BY g."name";

-- Количество треков, вошедших в альбомы 2019–2020 годов.
SELECT COUNT(t.tracks_id) AS track_count
FROM tracks t
JOIN albums a ON t.albums_id = a.albums_id
WHERE a.release_year BETWEEN 2019 AND 2020;

-- Средняя продолжительность треков по каждому альбому.
SELECT a."name", ROUND(AVG(t.duration), 1) AS average_duration
FROM albums a
JOIN tracks t ON a.albums_id = t.albums_id
GROUP BY a."name";

-- Все исполнители, которые не выпустили альбомы в 2020 году.
SELECT "name"
FROM artists
WHERE "name" NOT IN (
    SELECT ar."name"
    FROM artists ar
    JOIN artists_albums aa ON ar.artists_id = aa.artists_id
    JOIN albums al ON aa.albums_id = al.albums_id
    WHERE al.release_year = 2020
);

-- Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).
SELECT DISTINCT c."name"
FROM "collection" c
JOIN track_collection tc ON c.collection_id = tc.collection_id
JOIN tracks t ON tc.tracks_id = t.tracks_id
JOIN albums a ON t.albums_id = a.albums_id
JOIN artists_albums aa ON a.albums_id = aa.albums_id
JOIN artists art ON aa.artists_id = art.artists_id
WHERE art."name" = 'Linkin Park';
