use cpardee;

CREATE TABLE user_t (
        userID int AUTO_INCREMENT PRIMARY KEY,
	username varchar(30) NOT NULL,
        email varchar(30) NOT NULL,
	pwd varchar(30) NOT NULL
        );

CREATE TABLE tweet_t (
       	tweetID int AUTO_INCREMENT PRIMARY KEY,
	tweet varchar(140) NOT NULL,
	userID int NOT NULL,
	FOREIGN KEY (userID) references user_t(userID)
        );


/*mysqlimport --yob2013.txt'
  FIELDS TERMINATED BY ',' ENCLOSED BY '"'
  LINES TERMINATED BY '\r\n'
  IGNORE 1 LINES;*/



