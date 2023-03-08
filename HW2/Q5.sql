-- This query was run with MySQL Workbench.
/*
Jonathan Sun
jsun9683@usc.edu
CSCI 585 HW2 Q5.sql
*/

/*
These two commands create the database and select
it so that it can be manipulated with queries.
This was added in Q1 earlier so if it may not need
to be run if these were used for Q1.
*/
-- CREATE DATABASE youtube;
-- USE youtube;

/*
The next two queries create and insert data into
the youtube_users table. It only holds the
necessary columns such as the USER_NAME and
USER_AGE.
*/
CREATE TABLE youtube_users (
	USER_ID int NOT NULL AUTO_INCREMENT,
	USER_NAME varchar(255) NOT NULL,
    USER_AGE int NOT NULL,
    PRIMARY KEY (USER_ID)
);

INSERT INTO youtube_users (USER_NAME, USER_AGE)
VALUES
	('Taylor Swift', 33),
    ('Harry Styles', 29),
    ('Ariana Grande', 29),
    ('Joan of Arc', 41),
    ('Ludwig van Beethoven', 37),
    ('Charles Darwin', 59);

/*
These next two queries create and insert data
into the video_creators table. Only necessary
data is added.
*/
CREATE TABLE video_creators (
    CHANNEL_ID int NOT NULL AUTO_INCREMENT,
    USER_ID int NOT NULL,
    PRIMARY KEY (CHANNEL_ID),
    FOREIGN KEY (USER_ID) REFERENCES youtube_users (USER_ID)
);

INSERT INTO video_creators (USER_ID)
VALUES
	(1),
    (4),
    (5),
    (1),
    (6);

/*
These next two queries create and insert data
into the youtube_channels table. The data
includes Taylor Swift having multiple channels
to test whether the main query can find the video
with the most views across multiple channels.
*/
CREATE TABLE youtube_channels (
	CHANNEL_ID int NOT NULL AUTO_INCREMENT,
    CHANNEL_NAME varchar(255) NOT NULL UNIQUE,
    USER_ID int NOT NULL,
    PRIMARY KEY (CHANNEL_ID),
    FOREIGN KEY (USER_ID) REFERENCES video_creators (USER_ID)
);

INSERT INTO youtube_channels (CHANNEL_NAME, CHANNEL_ID, USER_ID)
VALUES
	("Taylor Swift's 1st Channel", 1, 1),
    ("Taylor Swift's 2nd Channel", 4, 1),
    ("Joan of Arc's 1st Channel", 2, 4),
    ("Ludwig van Beethoven's 1st Channel", 3, 5),
    ("Charles Darwin's 1st Channel", 5, 6);

/*
The next two queries create and insert data
into the youtube_videos table.
*/
CREATE TABLE youtube_videos (
	VIDEO_URL varchar(255) NOT NULL,
	VIDEO_TITLE varchar(255) NOT NULL,
    CHANNEL_ID int NOT NULL,
    PRIMARY KEY (VIDEO_URL),
    FOREIGN KEY (CHANNEL_ID) REFERENCES youtube_channels (CHANNEL_ID)
);

INSERT INTO youtube_videos (VIDEO_URL, VIDEO_TITLE, CHANNEL_ID)
VALUES
	('www.youtube.com/ts1', 'TS 1', 1),
    ('www.youtube.com/ts2', 'TS 2', 1),
    ('www.youtube.com/ts2_1', 'TS2 1', 4),
    ('www.youtube.com/joa1', 'JOA 1', 2),
    ('www.youtube.com/lvb1', 'LVB 1', 3),
    ('www.youtube.com/cd1', 'CD 1', 5);

/*
The next two queries create and insert data
into the video_comments table. This table
will be responsible for linking the comment
to the user.
*/
CREATE TABLE video_comments (
	COMMENT_ID int NOT NULL AUTO_INCREMENT,
    VIDEO_URL varchar(255) NOT NULL,
    USER_ID int NOT NULL,
    PRIMARY KEY (COMMENT_ID, VIDEO_URL),
    FOREIGN KEY (VIDEO_URL) REFERENCES youtube_videos (VIDEO_URL),
    FOREIGN KEY (USER_ID) REFERENCES youtube_users (USER_ID)
);

INSERT INTO video_comments (VIDEO_URL, USER_ID)
VALUES
	('www.youtube.com/ts1', 2),
    ('www.youtube.com/ts1', 4),
    ('www.youtube.com/ts1', 5),
    ('www.youtube.com/ts1', 6),
    ('www.youtube.com/ts2', 2),
    ('www.youtube.com/ts2', 3),
    ('www.youtube.com/ts2', 4),
    ('www.youtube.com/ts2_1', 2),
    ('www.youtube.com/joa1', 1),
    ('www.youtube.com/lvb1', 1),
    ('www.youtube.com/cd1', 1);

/*
The next two queries create and insert data
into the video_statistics table. It holds
the number of views and comments on a video.
TS 1 and TS 2 have the same amount of views
and are the max values. JOA 1 has more views,
but this is to test that it will be filtered
out despite having more views.
*/
CREATE TABLE video_statistics (
	VIDEO_URL varchar(255) NOT NULL,
    VIEWS int NOT NULL DEFAULT 0,
    NUMBER_OF_COMMENTS int NOT NULL,
    PRIMARY KEY (VIDEO_URL),
    FOREIGN KEY (VIDEO_URL) REFERENCES youtube_videos (VIDEO_URL)
);

INSERT INTO video_statistics (VIDEO_URL, VIEWS, NUMBER_OF_COMMENTS)
VALUES
	('www.youtube.com/ts1', 2000000, 4),
    ('www.youtube.com/ts2', 2000000, 3),
    ('www.youtube.com/joa1', 20000001, 3);

/*
This is the main query for problem 5. It joins the
tables together in order to properly return the
correct values. The youtube_videos table is filtered
to only return videos that are from Taylor Swift.
It then groups the necessary columns with the video
statistics. The HAVING clause is used to filter out
the videos that are not the most viewed. It then
returns the video title, min age, and max age.
*/
SELECT youtube_videos.VIDEO_TITLE, MIN(youtube_users.USER_AGE) AS MIN_AGE, MAX(youtube_users.USER_AGE) AS MAX_AGE
FROM youtube_users
JOIN video_comments ON youtube_users.USER_ID = video_comments.USER_ID
JOIN youtube_videos ON video_comments.VIDEO_URL = youtube_videos.VIDEO_URL
JOIN video_statistics ON youtube_videos.VIDEO_URL = video_statistics.VIDEO_URL
WHERE youtube_videos.CHANNEL_ID IN (
    SELECT CHANNEL_ID 
    FROM youtube_channels 
    WHERE USER_ID IN (
        SELECT USER_ID 
        FROM youtube_users 
        WHERE USER_NAME = 'Taylor Swift'
    )
)
GROUP BY youtube_videos.VIDEO_TITLE, video_statistics.VIEWS
HAVING video_statistics.VIEWS = (
    SELECT MAX(VIEWS)
    FROM video_statistics
    WHERE VIDEO_URL IN (
        SELECT youtube_videos.VIDEO_URL
        FROM youtube_videos
        WHERE youtube_videos.CHANNEL_ID IN (
            SELECT CHANNEL_ID 
            FROM youtube_channels 
            WHERE USER_ID IN (
                SELECT USER_ID 
                FROM youtube_users 
                WHERE USER_NAME = 'Taylor Swift'
            )
        )
    )
);