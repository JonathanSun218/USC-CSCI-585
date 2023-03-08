-- This query was run with MySQL Workbench.
/*
Jonathan Sun
jsun9683@usc.edu
CSCI 585 HW2 Q2.sql
*/

/*
These two commands create the database and select
it so that it can be manipulated with queries.
This was added in Q1 earlier so if it may not need
to be run if these were used for Q1.
*/
CREATE DATABASE youtube;
USE youtube;

/*
The next two queries create and insert data
into the youtube_users table. Only the USER_ID
and USER_NAME are needed for this problem.
*/
CREATE TABLE youtube_users (
	USER_ID int NOT NULL AUTO_INCREMENT,
    USER_NAME varchar(255) NOT NULL,
    PRIMARY KEY (USER_ID)
);

INSERT INTO youtube_users (USER_ID, USER_NAME)
VALUES
	(1, "It's Marvel Entertainment 1"),
    (2, "It's Marvel Entertainment 2"),
    (3, "Random Marvel Channel"),
    (4, "Random Entertainment Channel");

/*
The next two queries create and insert data
into the video_creators table.
*/
CREATE TABLE video_creators (
	USER_ID int NOT NULL,
    PRIMARY KEY (USER_ID),
    FOREIGN KEY (USER_ID) REFERENCES youtube_users (USER_ID)
);

INSERT INTO video_creators (USER_ID)
VALUES
	(1),
    (2),
    (3),
    (4);

/*
The next two queries create and insert data
into the youtube_channels table.
*/
CREATE TABLE youtube_channels (
	CHANNEL_NAME varchar(255) NOT NULL,
    OWNER_USER_ID int NOT NULL,
    PRIMARY KEY (CHANNEL_NAME),
    FOREIGN KEY (OWNER_USER_ID) REFERENCES video_creators (USER_ID)
);

INSERT INTO youtube_channels (CHANNEL_NAME, OWNER_USER_ID)
VALUES
	("ME1's First Channel", 1),
    ("ME1's Second Channel", 1),
    ("ME1's Third Channel", 1),
    ("ME2's First Channel", 2),
    ("ME2's Second Channel", 2),
    ("RMC's First Channel", 3),
    ("REC's First Channel", 4);

/*
The next two queries create and insert data
into the youtube_videos table.
*/
CREATE TABLE youtube_videos (
	VIDEO_URL varchar(255) NOT NULL,
    VIDEO_TITLE varchar(255) NOT NULL,
    PRIMARY KEY (VIDEO_URL)
);

INSERT INTO youtube_videos (VIDEO_URL, VIDEO_TITLE)
VALUES
	('www.youtube.com/ME1-1_1', 'ME1 1_1'),
    ('www.youtube.com/ME1-1_2', 'ME1 1_2'),
    ('www.youtube.com/ME1-2_1', 'ME1 2_1'),
    ('www.youtube.com/ME1-3_1', 'ME1 3_1'),
    ('www.youtube.com/ME2-1_1', 'ME2 1_1'),
    ('www.youtube.com/ME2-2_1', 'ME2 2_1'),
    ('www.youtube.com/RMC1_1', 'RMC1 1'),
    ('www.youtube.com/REC1_1', 'REC1 1');

/*
The next two queries create and insert data
into the upload_request table. This table
combines the video_creators table with the
youtube_channels and youtube_videos tables.
*/
CREATE TABLE upload_request (
	UPLOADER_ID int NOT NULL,
    CHANNEL_NAME varchar(255) NOT NULL,
    VIDEO_URL varchar(255) NOT NULL,
    PRIMARY KEY (UPLOADER_ID, CHANNEL_NAME, VIDEO_URL),
    FOREIGN KEY (UPLOADER_ID) REFERENCES video_creators (USER_ID),
    FOREIGN KEY (CHANNEL_NAME) REFERENCES youtube_channels (CHANNEL_NAME),
    FOREIGN KEY (VIDEO_URL) REFERENCES youtube_videos (VIDEO_URL)
);

INSERT INTO upload_request (UPLOADER_ID, CHANNEL_NAME, VIDEO_URL)
VALUES
	(1, "ME1's First Channel", 'www.youtube.com/ME1-1_1'),
    (1, "ME1's First Channel", 'www.youtube.com/ME1-1_2'),
    (1, "ME1's Second Channel", 'www.youtube.com/ME1-2_1'),
    (1, "ME1's Third Channel", 'www.youtube.com/ME1-3_1'),
    (2, "ME2's First Channel", 'www.youtube.com/ME2-1_1'),
    (2, "ME2's Second Channel", 'www.youtube.com/ME2-2_1'),
	(3, "RMC's First Channel", 'www.youtube.com/RMC1_1'),
	(4, "REC's First Channel", 'www.youtube.com/REC1_1');

/*
The next two queries create and insert data
into the video_statistics table. The LIKES
and VIEWS default to 0 if a value is not
provided.
*/
CREATE TABLE video_statistics (
	VIDEO_URL varchar(255) NOT NULL,
    LIKES int NOT NULL DEFAULT 0,
    VIEWS int NOT NULL DEFAULT 0,
    PRIMARY KEY (VIDEO_URL),
    FOREIGN KEY (VIDEO_URL) REFERENCES youtube_videos (VIDEO_URL)
);

INSERT INTO video_statistics (VIDEO_URL, LIKES, VIEWS)
VALUES
	('www.youtube.com/ME1-1_1', 2536, 3164),
    ('www.youtube.com/ME1-1_2', 1612, 72161),
    ('www.youtube.com/ME1-2_1', 19276, 19276),
    ('www.youtube.com/ME1-3_1', 8766, 19851),
    ('www.youtube.com/ME2-1_1', 0, 10),
    ('www.youtube.com/ME2-2_1', 0, 0),
    ('www.youtube.com/RMC1_1', 315, 2367),
    ('www.youtube.com/REC1_1', 61361, 316136);

/*
This is the main query for problem 2. It
joins all the tables together and filters out
users that do not contain 'Marvel Entertainment'
in their name. It then returns the VIDEO_TITLE,
CHANNEL_NAME, and RATIO of LIKES to VIEWS.
The RATIO will return 0 if the VIEWS are 0. 
*/
SELECT VIDEO_TITLE, youtube_channels.CHANNEL_NAME, COALESCE(LIKES / VIEWS, 0) AS RATIO
FROM youtube_videos
JOIN upload_request ON youtube_videos.VIDEO_URL = upload_request.VIDEO_URL
JOIN youtube_channels ON upload_request.CHANNEL_NAME = youtube_channels.CHANNEL_NAME
JOIN video_creators ON youtube_channels.OWNER_USER_ID = video_creators.USER_ID
JOIN youtube_users ON video_creators.USER_ID = youtube_users.USER_ID
LEFT JOIN video_statistics ON youtube_videos.VIDEO_URL = video_statistics.VIDEO_URL
WHERE youtube_users.USER_NAME LIKE '%Marvel Entertainment%'
ORDER BY VIDEO_TITLE ASC;