CSCI 585 HW1
Jonathan Sun
jsun9683@usc.edu

Assumptions:
	We assume that video consumers can have 0 subscriptions.
	We assume that channels can have 0 subscribers.
	We assume that video creators must have one channel at the very least.
	We assume that channels can have 0 videos uploaded.
	We assume that videos can have 0 sponsors.
	We assume taht videos must have statistics.
	We assume that videos can have 0 comments.
	We assume that there has to be one comment to have more comments.

Diagram Explanation:
	We start at the User entity. It branches into two subtypes: Video Consumer and Video Creator.
	They are denoted by "o" and two lines to indicate that the users can be both video consumers and video creators.
	There will only be two subtypes under User, so the two lines mean that the branching is complete.

	The Subscription entity is a bridge entity because video consumers can have multiple subscriptions of channels
	and channels can have multiple subscribers. This M:N relationship is broken down into two 1:M relationships.
	The relationship between Video Consumer and Subscription is strong because both have the USER_ID key.
	The relationship between Subscription and Channel is also strong because both have the CHANNEL_ID key.

	Video Creators have at least one channel, and their relationship is weak because they do not share the same primary key.

	A channel can have at least 0 videos, and their relationship is weak because they do not share the same primary key.

	The Video entity branches into two subtypes: Informational Video and Entertainment Video.
	They are denoted by "d" and one line to indicate that the videos can only be one or the other and cannot overlap.
	There can be other types of videos under Video, so the single line means that the branching is incomplete and that more can be added.
	Each video can have multiple sponsors or no sponsors, and they have a weak relationship.
	Each video must have statistics, so they have a weak 1:1 relationship.
	Each video can also have multiple comments, and they have a weak relationship.

	The Comments entity can be recursive because each comment can have replies.
	Therefore, the Comments entity also has a unary relationship.
	There has to be one main comment for there to be more comments (replies).