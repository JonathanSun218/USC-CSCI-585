-- This query was run with MySQL Workbench.
/*
Jonathan Sun
jsun9683@usc.edu
CSCI 585 HW2 Q4.sql
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
The next two queries create the table for the
Youtube videos as well as inserting data into it.
This is the main table that will bridge the
informational video table with the comments table.
*/
CREATE TABLE youtube_videos (
	VIDEO_URL varchar(255) NOT NULL,
    VIDEO_TITLE varchar(255) NOT NULL,
    PRIMARY KEY (VIDEO_URL)
);

INSERT INTO youtube_videos (VIDEO_URL, VIDEO_TITLE)
VALUES
	('www.youtube.com/vid1', 'Vid1'),
    ('www.youtube.com/vid2', 'Vid2'),
    ('www.youtube.com/vid3', 'Vid3'),
    ('www.youtube.com/vid4', 'Vid4'),
    ('www.youtube.com/vid5', 'Vid5'),
    ('www.youtube.com/vid6', 'Vid6'),
    ('www.youtube.com/vid7', 'Vid7'),
    ('www.youtube.com/vid8', 'Vid8'),
    ('www.youtube.com/vid9', 'Vid9'),
    ('www.youtube.com/vid10', 'Vid10'),
    ('www.youtube.com/vid11', 'Vid11'),
    ('www.youtube.com/vid12', 'Vid12'),
    ('www.youtube.com/vid13', 'Vid13');

/*
The next two queries create the table for the
informational videos as well as adding the
keywords for each Youtube video.
*/
CREATE TABLE informational_videos (
	VIDEO_URL varchar(255) NOT NULL,
    VIDEO_KEYWORDS varchar(255) NOT NULL,
    PRIMARY KEY (VIDEO_URL, VIDEO_KEYWORDS),
    FOREIGN KEY (VIDEO_URL) REFERENCES youtube_videos (VIDEO_URL)
);

INSERT INTO informational_videos (VIDEO_URL, VIDEO_KEYWORDS)
VALUES
	('www.youtube.com/vid1', 'Food'),
    ('www.youtube.com/vid1', 'Health'),
    ('www.youtube.com/vid4', 'Food'),
    ('www.youtube.com/vid7', 'Food'),
    ('www.youtube.com/vid10', 'Food'),
    ('www.youtube.com/vid2', 'Finance'),
    ('www.youtube.com/vid5', 'Finance'),
    ('www.youtube.com/vid8', 'Finance'),
    ('www.youtube.com/vid11', 'Education'),
    ('www.youtube.com/vid12', 'Education'),
    ('www.youtube.com/vid13', 'Education');
/*
These next two queries create the comments table
and inserts a sentiment score for each comment
corresponding to the VIDEO_URL.
*/
CREATE TABLE video_comments (
	COMMENT_ID int NOT NULL AUTO_INCREMENT,
    VIDEO_URL varchar(255) NOT NULL,
    COMMENT_SENTIMENT int NOT NULL DEFAULT 0,
    PRIMARY KEY (COMMENT_ID, VIDEO_URL),
    FOREIGN KEY (VIDEO_URL) REFERENCES youtube_videos (VIDEO_URL)
);

INSERT INTO video_comments (VIDEO_URL, COMMENT_SENTIMENT)
VALUES
	('www.youtube.com/vid1', 5),
    ('www.youtube.com/vid2', 3),
    ('www.youtube.com/vid3', 8),
    ('www.youtube.com/vid4', 6),
    ('www.youtube.com/vid5', 10),
    ('www.youtube.com/vid6', 1),
    ('www.youtube.com/vid7', 7),
    ('www.youtube.com/vid8', 2),
    ('www.youtube.com/vid9', 9),
    ('www.youtube.com/vid10', 10);

/*
This is the main query for problem 4. It
first joins the informational_videos table with
the video_comments table through VIDEO_URL.
It then grabs each unique keyword and returns its
average sentiment value in reverse order, from
highest to lowest.
*/
SELECT VIDEO_KEYWORDS, IFNULL(AVG(COMMENT_SENTIMENT), 0) AS AVG_SENTIMENT
FROM informational_videos
LEFT JOIN video_comments ON informational_videos.VIDEO_URL = video_comments.VIDEO_URL
GROUP BY VIDEO_KEYWORDS
ORDER BY AVG_SENTIMENT DESC;