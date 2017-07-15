-- Login Y/N
-- set up all future queries to refer to a specific user (by username)\

use cpardee;
select * from user_t where username = 'absrdst' or email = 'absrdst@hotmail.com' and pwd = 'absrdsm';

-- Insert New User Y/N
-- allow someone to input required credentials to make a user (username, email, password)\

insert into user_t (username, email, pwd) values ('taylorswift', 'tswift@hotmail.com', 'shakeitoff!');

-- Follow Y/N
-- follow someone

insert into stalker_t (follower, following) values (1, 11);

-- Following Y/N
-- the number of people following the user

select count(*) from stalker_t where following = 1;

-- Total Tweets Y/N
-- total tweets made by the user

select count(*) from tweet_t where userID = 2;

-- Tweet Listing Y/N
-- The Tweet listing if for the Tweets of the Users YOU are following.

select a.* from tweet_t a inner join (select * from stalker_t where follower = 1) b on a.userID = b.following;

-- Tweets IDs for a given hashtag Y/N
-- find all tweets IDS that have a given hashtag in them (from hash_tweet_rel)

select tweetID from hash_tweet_rel where hashID = 1;

-- HashID for a given hashtag Y/N
-- output a number from a hashtag name

select hashID from hashtag_t where hashtag = 'ebola';

