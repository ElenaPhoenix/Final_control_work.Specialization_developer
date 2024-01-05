DROP DATABASE IF EXISTS `Mans_friends`;
CREATE DATABASE Mans_friends;

USE Mans_friends;
CREATE TABLE Ani_cl
	(Id INT AUTO_INCREMENT PRIMARY KEY, 
	Class_name VARCHAR(20));
INSERT INTO Ani_cl (Class_name)
VALUES ('Pack_animals'),
('Pets');  

CREATE TABLE Pack_animals
	(Id INT AUTO_INCREMENT PRIMARY KEY,
    Genus_name VARCHAR (20),
    Class_id INT,
    FOREIGN KEY (Class_id) REFERENCES Ani_cl (Id) ON DELETE CASCADE ON UPDATE CASCADE);
INSERT INTO Pack_animals (Genus_name, Class_id)
VALUES ('Horses', 1),
('Donkeys', 1),  
('Camels', 1); 
    
CREATE TABLE Pets
	(Id INT AUTO_INCREMENT PRIMARY KEY,
    Genus_name VARCHAR (20),
    Class_id INT,
    FOREIGN KEY (Class_id) REFERENCES Ani_cl (Id) ON DELETE CASCADE ON UPDATE CASCADE);
INSERT INTO Pets (Genus_name, Class_id)
VALUES ('Cats', 2),
('Dogs', 2),  
('Hamsters', 2); 

CREATE TABLE Cats 
	(Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(20), 
    Birthday DATE,
    Commands VARCHAR(50),
    Genus_id int,
    Foreign KEY (Genus_id) REFERENCES Pets (Id) ON DELETE CASCADE ON UPDATE CASCADE);
INSERT INTO Cats (Name, Birthday, Commands, Genus_id)
VALUES ('Murka', '2011-01-01', 'purrrr', 1),
('Fluffy', '2016-01-01', "jump", 1); 

CREATE TABLE Dogs
	(Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(20), 
    Birthday DATE,
    Commands VARCHAR(50),
    Genus_id int,
    Foreign KEY (Genus_id) REFERENCES Pets (Id) ON DELETE CASCADE ON UPDATE CASCADE);
INSERT INTO Dogs (Name, Birthday, Commands, Genus_id)
VALUES ('Duke', '2020-01-01', 'seat, bring a stick, run', 2),
('Toby', '2021-06-12', "lie, bark, run", 2); 

CREATE TABLE Hamsters 
	(Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(20), 
    Birthday DATE,
    Commands VARCHAR(50),
    Genus_id int,
    Foreign KEY (Genus_id) REFERENCES Pets (Id) ON DELETE CASCADE ON UPDATE CASCADE);
INSERT INTO Hamsters (Name, Birthday, Commands, Genus_id)
VALUES ('Nibbles', '2020-10-12', '"spin the wheel, squeak, lie', 3),
('Colene', '2021-03-12', "build a nest, squeak, lie", 3);  

CREATE TABLE Horses 
	(Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(20), 
    Birthday DATE,
    Commands VARCHAR(50),
    Genus_id int,
    Foreign KEY (Genus_id) REFERENCES Pack_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE);
INSERT INTO Horses (Name, Birthday, Commands, Genus_id)
VALUES ('Diana', '2020-01-12', 'ride, kick, bite', 1),
('Boy', '2017-03-12', "voice, ride, kick", 1);

CREATE TABLE Donkeys 
	(Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(20), 
    Birthday DATE,
    Commands VARCHAR(50),
    Genus_id int,
    Foreign KEY (Genus_id) REFERENCES Pack_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE);
INSERT INTO Donkeys (Name, Birthday, Commands, Genus_id)
VALUES ('Jeannette', '2019-04-10', 'run, kick, voice', 2),
('Tobias', '2020-03-12', 'run, kick, voice', 2);

CREATE TABLE Camels 
	(Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(20), 
    Birthday DATE,
    Commands VARCHAR(50),
    Genus_id int,
    Foreign KEY (Genus_id) REFERENCES Pack_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE);
INSERT INTO Camels (Name, Birthday, Commands, Genus_id)
VALUES ('Abeba', '2022-04-10', 'spit, lie down, get up', 3),
('Zulu', '2019-03-12', 'spit, lie down, get up', 3);

SET SQL_SAFE_UPDATES = 0;
DELETE FROM Camels;

SELECT Name, Birthday, Commands FROM Horses
UNION SELECT  Name, Birthday, Commands FROM Donkeys;

CREATE TEMPORARY TABLE N_Animals AS 
SELECT *, 'Horses' as genus FROM Horses
UNION SELECT *, 'Donkeys' AS genus FROM Donkeys
UNION SELECT *, 'Dogs' AS genus FROM Dogs
UNION SELECT *, 'Cats' AS genus FROM Cats
UNION SELECT *, 'Hamsters' AS genus FROM Hamsters;

CREATE TABLE Young_animals AS
SELECT Name, Birthday, Commands, genus, TIMESTAMPDIFF(MONTH, Birthday, CURDATE()) AS Age_in_month
FROM N_Animals WHERE Birthday BETWEEN ADDDATE(curdate(), INTERVAL -3 YEAR) AND ADDDATE(CURDATE(), INTERVAL -1 YEAR);
 
SELECT * FROM Young_animals;

SELECT h.Name, h.Birthday, h.Commands, pa.Genus_name, ya.Age_in_month 
FROM Horses h
LEFT JOIN Young_animals ya ON ya.Name = h.Name
LEFT JOIN Pack_animals pa ON pa.Id = h.Genus_id
UNION 
SELECT d.Name, d.Birthday, d.Commands, pa.Genus_name, ya.Age_in_month 
FROM Donkeys d 
LEFT JOIN Young_animals ya ON ya.Name = d.Name
LEFT JOIN Pack_animals pa ON pa.Id = d.Genus_id
UNION
SELECT c.Name, c.Birthday, c.Commands, p.Genus_name, ya.Age_in_month 
FROM Cats c
LEFT JOIN Young_animals ya ON ya.Name = c.Name
LEFT JOIN Pets p ON p.Id = c.Genus_id
UNION
SELECT d.Name, d.Birthday, d.Commands, p.Genus_name, ya.Age_in_month 
FROM Dogs d
LEFT JOIN Young_animals ya ON ya.Name = d.Name
LEFT JOIN Pets p ON p.Id = d.Genus_id
UNION
SELECT hm.Name, hm.Birthday, hm.Commands, p.Genus_name, ya.Age_in_month 
FROM Hamsters hm
LEFT JOIN Young_animals ya ON ya.Name = hm.Name
LEFT JOIN Pets p ON p.Id = hm.Genus_id;