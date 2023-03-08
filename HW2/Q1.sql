-- This query was run with MySQL Workbench.
/*
Jonathan Sun
jsun9683@usc.edu
CSCI 585 HW2 Q1.sql
*/

/*
These two commands create the database and select
it so that it can be manipulated with queries.
*/
-- CREATE DATABASE youtube;
-- USE youtube;

/*
The next two queries create the table for the
Youtube videos and insert necessary data into
it. I do want to note that I only added columns
that were necessary for this problem and not 
the other columns that were not used.
*/
CREATE TABLE youtube_videos (
	VIDEO_ID int NOT NULL AUTO_INCREMENT,
    VIDEO_TITLE varchar(255) NOT NULL,
    PRIMARY KEY (VIDEO_ID)
);

INSERT INTO youtube_videos (VIDEO_TITLE)
VALUES
	('Video1'),
    ('Video2'),
    ('Video3'),
    ('Video4'),
    ('Video5'),
    ('Video6'),
    ('Video7'),
    ('Video8'),
    ('Video9'),
    ('Video10');

/*
The next two queries create the table for the
Youtube sponsors and insert necessary data into
it. I do want to note that I only added columns
that were necessary for this problem and not 
the other columns that were not used.
*/
CREATE TABLE youtube_sponsors (
	SPONSOR_ID int NOT NULL AUTO_INCREMENT,
    VIDEO_ID int NOT NULL,
    SPONSOR_NAME varchar(255),
    SPONSOR_PHONE varchar(255),
    SPONSOR_AMOUNT int,
    PRIMARY KEY (SPONSOR_ID, VIDEO_ID),
    FOREIGN KEY (VIDEO_ID) REFERENCES youtube_videos (VIDEO_ID)
);

INSERT INTO youtube_sponsors (SPONSOR_ID, VIDEO_ID, SPONSOR_NAME, SPONSOR_PHONE, SPONSOR_AMOUNT)
VALUES
	(1, 1, 'NordVPN', NULL, 10000),
	(2, 2, 'Epic Games', '(693) 305-7553', 1000),
    (1, 3, 'NordVPN', NULL, 1000),
    (3, 5, 'Squarespace', '(878) 562-9739', 1000),
    (4, 6, 'Raid Shadow Legends', '(266) 577-0412', 1000),
    (3, 7, 'Squarespace', '(878) 562-9739', 1000),
    (1, 9, 'NordVPN', NULL, 1000),
    (3, 1, 'Squarespace', '(878) 562-9739', 11000),
    (1, 10, 'NordVPN', NULL, 1000);

/*
This is the main query for problem 1. It first
joins the two tables through the VIDEO_ID column.
It then sums up the SPONSOR_AMOUNT column and groups
them by SPONSOR_NAME and SPONSOR_PHONE. After that,
it will take the maximum value that was summed up
and return the sponsor name, sponsor phone number,
and the total sponsored amount. This will also
return multiple sponsors if they have the same max
SPONSOR_AMOUNT. Please look at the next query.
*/
SELECT SPONSOR_NAME, SPONSOR_PHONE, SUM(SPONSOR_AMOUNT) AS SPONSOR_TOTAL
FROM youtube_videos
JOIN youtube_sponsors ON youtube_videos.VIDEO_ID = youtube_sponsors.VIDEO_ID
GROUP BY SPONSOR_NAME, SPONSOR_PHONE
HAVING SPONSOR_TOTAL = (
  SELECT MAX(SPONSOR_TOTAL)
  FROM (
    SELECT SUM(SPONSOR_AMOUNT) AS SPONSOR_TOTAL
    FROM youtube_videos
    JOIN youtube_sponsors ON youtube_videos.VIDEO_ID = youtube_sponsors.VIDEO_ID
    GROUP BY SPONSOR_NAME, SPONSOR_PHONE
  ) AS subquery
);