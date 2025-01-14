/*LIBRARY MANAGEMENT SYSTEM*/

CREATE DATABASE IF NOT EXISTS library;
USE library;
CREATE TABLE IF NOT EXISTS books(
id INT PRIMARY KEY,
title VARCHAR(40),
author VARCHAR(50),
publisher VARCHAR(40),
publish_year INT ,
available_copies INT );

CREATE TABLE IF NOT EXISTS members(
id INT PRIMARY KEY,
name VARCHAR(40),
email VARCHAR(50),
address VARCHAR(50),
phone_no VARCHAR(20));

CREATE TABLE IssueStatus(
issue_id INT PRIMARY KEY,
issue_mem INT ,
issue_book INT,
issue_date DATE,
FOREIGN KEY (issue_mem) REFERENCES members(id),
FOREIGN KEY (issue_book) REFERENCES books(id));


CREATE TABLE ReturnStatus(
return_id INT PRIMARY KEY,
return_mem INT,
return_book INT,
return_date DATE,
FOREIGN KEY (return_mem) REFERENCES members(id),
FOREIGN KEY (return_book) REFERENCES books(id));

SELECT * 
FROM members;
INSERT INTO books(id,title,author,publisher,publish_year,available_copies)
VALUES (1011,"Making India Awesome","Chetan Bhagat","Rupa Publications",2015,10),
(1012,"Naked Triangle","Balvant Gargi","‎Vikas Publishing House",1979,8),
(1013,"A River Sutra ","Geeta Mehta","Random House of Toronto",1993,5),
(1014,"Bhagavad Gita  ","S.RadhaKrishan","‎Macmillan Publishers",1968,30),
(1015," Introduction to Python Programming","Eric Matthes","‎No Starch Press",1990,40),
(1016,"java","Herbert Schildt","McGraw-Hill Education",2017,45),
(1017,"c++","Herbert Schildt","‎McGraw-Hill Education",2015,48),
(1018,"C#","Herbert Schildt","McGraw-Hill Education",2014,35),
(1019,"Getting Started with SQL","Thomas Nield","O'Reilly Media",2016,13),
(1020,"Principia Mathematica", " Isaac Newton","‎Cambridge University Press",1962,100);
SELECT * 
FROM books;
  
  INSERT INTO members(id,name,email,address,phone_no)
  VALUES(101,"urva","urvashinagpal064@gmail.com","470/6 khail bazar" ,9729680091),
  (102,"neil","neilnitin64@gmail.com","477/6 model town " ,8956712551),
  (103,"mukesh","mukesh4@gmail.com","HN8798 tehsil camp" ,9789584645),
  (104,"casey","casey@gmail.com","7867 insar market" ,9729680097),
  (105,"bob","thisisbob@gmail.com","4536T TDI" ,9729459891),
  (106,"adam","adamsid@gmail.com","1111 sarae" ,9729156591),
  (107,"merrie","merrieeee@gmail.com","HM1234 TP" ,9722458791),
  (108,"babeha","heybabeha@gmail.com","456/99 ansal" ,9722546891),
  (109,"anu","anu1234@gmail.com","TO123 eldico" ,9729684587),
  (110,"sherlyn","sherlyn234@gmail.com","563/9 namaste chowk" ,9729680087);
SELECT * 
FROM members;
  
INSERT INTO IssueStatus(issue_id,issue_mem,issue_book,issue_date)
VALUES(001,103,1012,"2024-04-12"),
(002,105,1015,"2024-04-12"),
(003,106,1014,"2024-05-28"),
(004,109,1012,"2024-03-10"),
(005,101,1011,"2024-06-20"),
(006,110,1020,"2024-05-15");
SELECT * 
FROM IssueStatus;

INSERT INTO ReturnStatus(return_id,return_mem,return_book,return_date)
VALUES(001,103,1012,"2024-04-22"),
(002,105,1015,"2024-04-22"),
(003,106,1014,"2024-06-08"),
(004,109,1012,"2024-03-20"),
(005,101,1011,"2024-06-30"),
(006,110,1020,"2024-05-25");
SELECT * 
FROM ReturnStatus;

/*queries*/
#1 display the total count of books in each catagory:
SELECT publisher,COUNT(title)
FROM books
GROUP BY publisher;

#2 display the return status according to ascending order in dates:
SELECT *
FROM ReturnStatus
ORDER BY return_date ASC;

#3 add column in books:
ALTER TABLE books
ADD COLUMN catagory VARCHAR(40);
SELECT *
FROM books;

#4 delete any column in books:
ALTER TABLE books
DROP COLUMN catagory;

#5 change the datatype of any column in members:
ALTER TABLE members
MODIFY name CHAR(10);

SELECT *
FROM members;

#6 return common record of both members and issuestatus id :
SELECT id
FROM members
INNER JOIN IssueStatus
ON members.id=IssueStatus.issue_mem;

#7 return all records from return status and matched records of members:
SELECT id
FROM ReturnStatus
LEFT JOIN members
ON ReturnStatus.return_mem=members.id;

#8 return all records of issue status and return status:
SELECT *
FROM IssueStatus AS a 
LEFT JOIN
ReturnStatus AS b
ON a.issue_id=b.return_id
UNION
SELECT *
FROM IssueStatus AS a 
RIGHT JOIN
ReturnStatus AS b
ON a.issue_id=b.return_id;

#9  update the phone_no of urva in members:
SET SQL_SAFE_UPDATES=0;
UPDATE members
SET phone_no=9729680131
WHERE phone_no=9729680091;

SELECT *
FROM members;

#10 create a virtual table only of name and id in members:
CREATE VIEW view1 AS
SELECT id,name
FROM members;

SELECT *
FROM view1;
