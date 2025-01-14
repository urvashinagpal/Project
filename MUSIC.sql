/*music recommendation system*/

CREATE DATABASE music;
USE music;

CREATE TABLE users(
user_id INT PRIMARY KEY,
name VARCHAR(50),
email VARCHAR(50) UNIQUE,
password VARCHAR(40));

CREATE TABLE songs(
song_id INT PRIMARY KEY,
title VARCHAR(50),
song_type VARCHAR(40),
artist_id INT,
FOREIGN KEY (artist_id) REFERENCES artist(artist_id),
release_year INT,
popularity INT);


CREATE TABLE artist(
artist_id INT PRIMARY KEY,
name VARCHAR(50),
country VARCHAR(50));

CREATE TABLE userlike(
like_id INT PRIMARY KEY,
user_id INT,
song_id INT,
liked INT,
FOREIGN KEY(user_id)REFERENCES users(user_id),
FOREIGN KEY(song_id)REFERENCES songs(song_id));

INSERT INTO users(user_id,name,email,password)
VALUES(101,"urva","Urvaa@gmail.com",1234),
(102,"aashna","aashu12@gmail.com",8797),
(103,"ravi","raviiii@gmail.com","ravi5"),
(104,"mukul","itsmukul@gmail.com",9876),
(105,"casey","caseycasey@gmail.com","casey67"),
(106,"riva","riva5647@gmail.com",876554),
(107,"vyamika","vyamiiii@gmail.com","vyaa132"),
(108,"adam","thisisadam@gmail.com",9856470),
(109,"bob","bob876@gmail.com","bobaaaa345"),
(110,"merrie","merrie09@gmail.com",0987);

INSERT INTO songs(song_id,title,song_type,artist_id,release_year,popularity)
VALUES(1,"ve kamleya","traditional",0001,2023,110),
(2,"o maahi","romantic",0003,2023,80),
(3,"aakhon mein teri","soul",0006,2007,100),
(4,"naina","sad",0004,2016,70),
(5,"tera yaar hoon mein","soul",0003,2018,89),
(6,"sanam re","romantic",0005,2015,101),
(7,"papa meri jaan","soul",0007,2023,110),
(8,"meri maa","soul",0006,2013,99),
(9,"badri ki dulhania","dance",0008,2017,69),
(10,"apne","soul",0007,2007,100),
(11,"talking to the moon","rock",0002,2010,112),
(12,"love story","romantic",0010,2008,110),
(13,"ice cream","hip hop",0012,2020,90),
(14,"dilbaro","sad",0011,2018,78),
(15,"baby","rock",0009,2010,90);

INSERT INTO artist(artist_id,name,country)
VALUES(0001,"shreya ghoshal","india"),
(0002,"bruno mars","america"),
(0003,"arijit singh","india"),
(0004,"pritam","india"),
(0005,"armaan malik","india"),
(0006,"Krishnakumar Kunnath","india"),
(0007,"sonu nigam","india"),
(0008,"neha kakkar","india"),
(0009,"justin bieber","canada"),
(0010,"taylor swift","america"),
(0011,"harshdeep kaur","india"),
(0012,"selena gomez","america");


drop table songs;
drop table userlike;
drop table artist;

INSERT INTO userlike(like_id,user_id,song_id,liked)
VALUES(01,104,5,2),
(02,104,6,3),
(03,102,1,1),
(04,106,8,5),
(05,101,12,2),
(06,104,9,3),
(07,107,11,6),
(08,108,7,1),
(09,105,4,1),
(10,108,2,3),
(11,109,8,2),
(12,110,11,0),
(13,103,6,2),
(14,105,9,1);

/*queries*/

#1 popular  songs recommendation
SELECT *
FROM songs
ORDER BY popularity DESC;

#2 songs according to there type:
SELECT song_type, COUNT(title)
FROM songs
GROUP BY song_type;

#3 songs similar to user liked songs:
/*example for user mukul user_id=104:*/
SELECT songs.*
FROM songs
JOIN userlike
ON songs.song_id=userlike.song_id
WHERE userlike.user_id IN(
     SELECT user_id
     FROM userlike
     WHERE song_id IN(
               SELECT song_id
               FROM userlike
               WHERE user_id=104 AND liked=2)
     AND user_id<>102
     )
    GROUP BY userlike.song_id
    ORDER BY COUNT(*) DESC
    LIMIT 5;
    
    #4 show all the liked of  any user:
    SELECT songs.*
    FROM songs
    JOIN userlike
    ON songs.song_id=userlike.song_id
    WHERE userlike.user_id IN(
			SELECT user_id
            FROM userlike
            WHERE song_id IN(
                    SELECT song_id
                    FROM userlike
                    WHERE user_id=105 AND liked=5)
                    
                   AND user_id<>105
                    )
    GROUP BY songs.song_id
    ORDER BY COUNT(*) DESC;
    
     
     


