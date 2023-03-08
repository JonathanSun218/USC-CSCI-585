Jonathan Sun
CSCI 585 HW 2

Comments that describe each query is in the .sql files.

Please note that if a database needs to be created, please
uncomment the top two commands to do so.

I also want to point out that I only included data that was
necessary to each problem.

I apologize in advance if I did not provide enough data to
get my query across. I included enough data that should
test for the correct output as well as some edge cases that
were mentioned in Piazza and thought from me.


Q1.sql:

For Q1, I utilized the following tables:

youtube_videos,
youtube_sponsors.

I input the data to where phone numbers can be NULL values
and that the output should return multiple sponsors if some
are tied for the max amount of sponsored money.


Q2.sql:

For Q2, I utilized the following tables:

youtube_users,
video_creators,
youtube_channels,
youtube_videos,
upload_request,
video_statistics.

I input data where there is text on both ends of Marvel
Entertainment to test that the query is able to grab
the right users containing Marvel Entertainment. I also
added separate Marvel and Entertainment in other channels
to check that the user specifically had to have both
Marvel and Entertainment in the name.

As for channels, I gave some channels multiple channels
to check that all channels by Marvel Entertainment would
be printed.

For the ratios, I hard coded the likes and views, but made
sure to test for edge cases like if there were 0 likes or
0 views. 0 views would result in a divide by 0 error, so I
made sure that those cases would always return 0. As for the
case where a video would have 0 comments, the ratio would
default to 0 as well.

The first version query joins first joins the tables and then
filters the rows that do not contain Marvel Entertainment in
the username. It then calculates the ratio and returns the
video title, channel name, and ratio of likes to views. The
ratio is 
order arranges the video title in lexicographical order.

The second version query calculates the ratio differently from
the first version. It uses a case statement to check if there
are 0 views. If there are 0 views, then the ratio would be 0.
Otherwise, it would perform the division normally.

The third version query uses the COALESCE() function to determine
the ratio of likes to views. I use the NULLIF() function to check
if the views are 0. When the division is performed, the COALESCE()
function checks if it was NULL or not. If it was NULL, it changes
the ratio to 0. If not, it keeps the original division.


Q3.sql:

For Q3, I utilized the following tables:

youtube_users,
video_creators,
video_consumers,
youtube_channels,
subscriptions.

I created 150 users, 20 of which are video creators. For my
design, I made all users video consumers, so the table may
be redundant. I hard coded the video creators' subscription
count, but the total adds up as if it was not hard coded.
I gave video creators multiple channels. I only changed the
dates of the users that I would be working with. The rest all
have the same creation date. For subscriptions, I gave
qualifying video creators at least 100 paid subscribers. I
also gave some of them unpaid subscribers, causing some video
creators to not qualify for the greater than 100 paid subscriber
requirement. I also gave some users the incorrect creation date.
I also gave a user exactly 100 paid subscribers to test if that
user would get printed or not.

The main query first joins all necessary tables together. It
then filters the users who meet the creation date and lists
the paid subscribers with the WHERE clause. It then further
filters that table by checking who meets the 100 paid subscriber
requirement and only prints those out.


Q4.sql:

For Q4, I utilized the following tables:

youtube_videos,
informational_videos,
video_comments.

I added videos, giving them either one or more keywords. I did
not give all videos comments. That edge case is supposed to
return 0. I also gave some videos multiple keywords as well.
The main query first joins the necessary tables together and
groups them by keyword with the GROUP BY clause. It then
calculates the average sentiment. If the average turns
out to be NULL, the IFNULL() command will change it to 0.
The rows are then ordered by average sentiment score with the
highest being on top.


Q5.sql:

For Q5, I utilized the following tables:

youtube_users,
video_creators,
youtube_channels,
youtube_videos,
video_statistics,
video_comments.

I added 6 users. I gave Taylor Swift two channels and the rest
one channel. For my design, I just used the 6 users and had them
comment on each other's videos. I also gave some channels multiple
videos as well. I gave some videos the same amount of views. I
gave a video other than Taylor Swift's video the max views to test
if it would get filtered. Since there are two videos from Taylor
Swift that have the same max views, both are printed.

The main query joins the necessary tables together and filters
out the videos that do not belong to Taylor Swift with the
WHERE clause. The filtered results are grouped by video title and
views. The table is further filtered with the HAVING clause where
it creates a virtual table to determine which videos have the max
views. Once all that is done, it prints out the video title,
minimum age, and maximum age based on the table that filtered out
non-Taylor Swift videos.


Q6.sql:

For Q6, I utilized the following tables:

youtube_users,
video_creators,
youtube_channels,
upload_request.

I only changed the necessary data that would impact results. The
rest were left the same. In the youtube_channels table, I added
a SUBSCRIPTION_COUNT entity because the subscription count that
needed to printed should be per channel rather than per user.
For the upload dates, I added dates that pertained to January of
2023 specifically. I added data that included 4/5 weeks as well as
5/5 weeks but one week was a February date. These are all deemed
incorrect.

The main query joins all necessary tables together and filters out
users that are not in the USA and not uploading at least once a
week in January with the WHERE clause. It is grouped by username,
channel name, and subscription count. It is further filtered with
the HAVING clause to see if there are more than 4 uploads, 1 for
each week. The WEEK() function ensures that the one video per
week requirement is satisfied.