CREATE TABLE IF NOT EXISTS artists
(
    artists_id SERIAL PRIMARY KEY,
    "name" VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS albums
(
    albums_id SERIAL PRIMARY KEY,
    "name" VARCHAR NOT NULL,
    release_year INTEGER NOT NULL CHECK (release_year >= 1900)
);

CREATE TABLE IF NOT EXISTS artists_albums
(
    artists_id INTEGER,
    albums_id INTEGER,
    CONSTRAINT fk_artists_id
        FOREIGN KEY (artists_id)
        REFERENCES artists(artists_id),
    CONSTRAINT fk_albums_id
        FOREIGN KEY (albums_id)
        REFERENCES albums(albums_id)
);

CREATE TABLE IF NOT EXISTS tracks
(
    tracks_id SERIAL PRIMARY KEY,
    "name" VARCHAR NOT NULL,
    duration INTEGER NOT NULL CHECK (duration > 0),
    albums_id INTEGER,
    CONSTRAINT fk_albums_id
        FOREIGN KEY (albums_id)
        REFERENCES albums(albums_id)
);

CREATE TABLE IF NOT EXISTS "collection"
(
    collection_id SERIAL PRIMARY KEY,
    "name" VARCHAR NOT NULL,
    year_manufacture INTEGER NOT NULL CHECK (year_manufacture > 1990),
    tracks_id INTEGER,
    CONSTRAINT fk_tracks_id
        FOREIGN KEY (tracks_id)
        REFERENCES tracks(tracks_id)    
);

CREATE TABLE IF NOT EXISTS genres
(
    genres_id SERIAL PRIMARY KEY,
    "name" VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS track_genres
(
    tracks_id INTEGER,
    genres_id INTEGER,
    CONSTRAINT fk_tracks_id
        FOREIGN KEY (tracks_id)
        REFERENCES tracks(tracks_id),
    CONSTRAINT fk_genres_id
        FOREIGN KEY (genres_id)
        REFERENCES genres(genres_id)
);

CREATE TABLE IF NOT EXISTS artists_genres
(
    artists_id INTEGER,
    genres_id INTEGER,
    CONSTRAINT fk_artists_id
        FOREIGN KEY (artists_id)
        REFERENCES artists(artists_id),
    CONSTRAINT fk_genres_id
        FOREIGN KEY (genres_id)
        REFERENCES genres(genres_id)
);
