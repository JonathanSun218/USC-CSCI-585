-- This query was run with MySQL Workbench.
/*
Jonathan Sun
jsun9683@usc.edu
CSCI 585 HW2 Q6.sql
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
The next two queries create and insert data
into the youtube_users table. It holds the
USER_ID, USER_NAME, and ADDRESS, which are
the only necessary information for this problem.
Countries other than the USA were also added
to test the main query.
*/
CREATE TABLE youtube_users (
	USER_ID int NOT NULL AUTO_INCREMENT,
    USER_NAME varchar(255) NOT NULL,
    ADDRESS varchar(255) NOT NULL,
    PRIMARY KEY (USER_ID)
);

INSERT INTO youtube_users (USER_NAME, ADDRESS)
VALUES
	('User1', '1 Street, USC, CA USA'),
    ('User2', '2 Street, USC, CA USA'),
    ('User3', '3 Street, USC, CA USA'),
    ('User4', '4 Street, USC, CA USA'),
    ('User5', '5 Street, NOT USC, XX Japan'),
    ('User6', '6 Street, USC, CA USA'),
    ('User7', '7 Street, USC, CA USA'),
    ('User8', '8 Street, USC, CA USA'),
    ('User9', '9 Street, USC, CA USA'),
    ('User10', '10 Street, USC, CA USA'),
    ('User11', '11 Street, USC, CA USA'),
    ('User12', '12 Street, USC, CA USA'),
    ('User13', '13 Street, USC, CA USA'),
    ('User14', '14 Street, USC, CA USA'),
    ('User15', '15 Street, USC, CA USA'),
    ('User16', '16 Street, USC, CA USA'),
    ('User17', '17 Street, USC, CA USA'),
    ('User18', '18 Street, USC, CA USA'),
    ('User19', '19 Street, USC, CA USA'),
    ('User20', '20 Street, USC, CA USA');

/*
The next two queries create and insert data
into the video_creators table. It only holds
the information necessary for this problem.
SUBSCRIPTION_COUNT was renamed to
TOTAL_SUBSCRIPTIONS from the sample (E)ER
diagram because the subscription count should
be specific to the channel rather than the
user.
*/
CREATE TABLE video_creators (
	USER_ID int NOT NULL,
    TOTAL_SUBSCRIPTIONS int NOT NULL,
    PRIMARY KEY (USER_ID),
    FOREIGN KEY (USER_ID) REFERENCES youtube_users (USER_ID)
);

INSERT INTO video_creators (USER_ID, TOTAL_SUBSCRIPTIONS)
VALUES
	(1, 2384),
    (2, 85368),
    (3, 4576),
    (4, 9284),
    (5, 152),
    (6, 456),
    (7, 924689),
    (8, 12),
    (9, 42768827),
    (10, 84378),
    (11, 16361),
    (12, 51361),
    (13, 6124),
    (14, 311617),
    (15, 316),
    (16, 8262),
    (17, 0),
    (18, 13512),
    (19, 8195739),
    (20, 71632);

/*
The next two queries create and insert data
into the youtube_channels table. A new entity
was added to this table from the sample (E)ER
diagram to correctly return what is needed for
this problem. The SUBSCRIPTION_COUNT is moved
to this table so that each channel can have
its own number of subscriptions.
*/
CREATE TABLE youtube_channels (
	CHANNEL_NAME varchar(255) NOT NULL,
    OWNER_USER_ID int NOT NULL,
    SUBSCRIPTION_COUNT int NOT NULL DEFAULT 0,
    PRIMARY KEY (CHANNEL_NAME),
    FOREIGN KEY (OWNER_USER_ID) REFERENCES video_creators (USER_ID)
);

INSERT INTO youtube_channels (CHANNEL_NAME, OWNER_USER_ID, SUBSCRIPTION_COUNT)
VALUES
	("User 1's Channel 1", 1, 2264),
    ("User 1's Channel 2", 1, 120),
    ("User 2's Channel 1", 2, 85368),
    ("User 3's Channel 1", 3, 4376),
    ("User 3's Channel 2", 3, 200),
    ("User 4's Channel 1", 4, 9284),
    ("User 5's Channel 1", 5, 152),
    ("User 6's Channel 1", 6, 456),
    ("User 7's Channel 1", 7, 924689),
    ("User 8's Channel 1", 8, 12),
    ("User 9's Channel 1", 9, 42768827),
    ("User 10's Channel 1", 10, 84378),
    ("User 11's Channel 1", 11, 16361),
    ("User 12's Channel 1", 12, 51361),
    ("User 13's Channel 1", 13, 6124),
    ("User 14's Channel 1", 14, 311617),
    ("User 15's Channel 1", 15, 316),
    ("User 16's Channel 1", 16, 8262),
    ("User 17's Channel 1", 17, 0),
    ("User 18's Channel 1", 18, 13512),
    ("User 19's Channel 1", 19, 8195739),
    ("User 20's Channel 1", 20, 71632);

/*
The next two queries create and insert data
into the upload_request table. Changes were
made from the sample (E)ER diagram for this.
The UPLOAD_DATE was made a primary key so
that a single UPLOADER_ID can have multiple
UPLOAD_DATE values. It was not possible if
the UPLOAD_DATE was not a primary key.
*/
CREATE TABLE upload_request (
	UPLOADER_ID int NOT NULL,
    CHANNEL_NAME varchar(255) NOT NULL,
    UPLOAD_DATE date NOT NULL,
    PRIMARY KEY (UPLOADER_ID, CHANNEL_NAME, UPLOAD_DATE),
    FOREIGN KEY (UPLOADER_ID) REFERENCES video_creators (USER_ID),
    FOREIGN KEY (CHANNEL_NAME) REFERENCES youtube_channels (CHANNEL_NAME)
);

INSERT INTO upload_request (UPLOADER_ID, CHANNEL_NAME, UPLOAD_DATE)
VALUES
	(1, "User 1's Channel 1", '2023-01-01'),
    (1, "User 1's Channel 1", '2023-01-10'),
    (1, "User 1's Channel 1", '2023-01-19'),
    (1, "User 1's Channel 1", '2023-01-25'),
    (1, "User 1's Channel 1", '2023-01-31'),
    (1, "User 1's Channel 2", '2023-01-01'),
    (1, "User 1's Channel 2", '2023-01-08'),
    (1, "User 1's Channel 2", '2023-01-15'),
    (1, "User 1's Channel 2", '2023-01-22'),
    (1, "User 1's Channel 2", '2023-01-29'),
    (3, "User 3's Channel 1", '2023-01-03'),
    (3, "User 3's Channel 1", '2023-01-10'),
    (3, "User 3's Channel 1", '2023-01-17'),
    (3, "User 3's Channel 1", '2023-01-24'),
    (3, "User 3's Channel 1", '2023-01-31'),
    (5, "User 5's Channel 1", '2023-01-03'),
    (5, "User 5's Channel 1", '2023-01-10'),
    (5, "User 5's Channel 1", '2023-01-17'),
    (5, "User 5's Channel 1", '2023-01-24'),
    (5, "User 5's Channel 1", '2023-01-31'),
    (18, "User 18's Channel 1", '2023-01-04'),
    (18, "User 18's Channel 1", '2023-01-11'),
    (18, "User 18's Channel 1", '2023-01-18'),
    (18, "User 18's Channel 1", '2023-01-25'),
	(18, "User 18's Channel 1", '2023-02-01'),
	(20, "User 20's Channel 1", '2023-01-01'),
    (20, "User 20's Channel 1", '2023-01-02'),
    (20, "User 20's Channel 1", '2023-01-03'),
    (20, "User 20's Channel 1", '2023-01-04'),
	(20, "User 20's Channel 1", '2023-01-05');

/*
This is the main query for problem 6. It joins
all of the tables together and filters the rows
based on the conditions where users are in the
USA and that they have uploaded once a week in
the month of January. It then displays the 
USER_NAME, CHANNEL_NAME, and the channel's
SUBSCRIPTION_COUNT.
*/
SELECT USER_NAME, youtube_channels.CHANNEL_NAME, SUBSCRIPTION_COUNT
FROM youtube_users
JOIN video_creators ON youtube_users.USER_ID = video_creators.USER_ID
JOIN youtube_channels ON video_creators.USER_ID = youtube_channels.OWNER_USER_ID
JOIN upload_request ON video_creators.USER_ID = upload_request.UPLOADER_ID AND youtube_channels.CHANNEL_NAME = upload_request.CHANNEL_NAME
WHERE youtube_users.ADDRESS LIKE '%USA%' AND UPLOAD_DATE BETWEEN '2023-01-01' AND '2023-01-31'
GROUP BY USER_NAME, CHANNEL_NAME, SUBSCRIPTION_COUNT
HAVING COUNT(DISTINCT WEEK(UPLOAD_DATE)) > 4;