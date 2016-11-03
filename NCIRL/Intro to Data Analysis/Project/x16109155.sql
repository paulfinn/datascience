Drop database x16109155;
CREATE DATABASE x16109155;
use x16109155;



-- Create Tables --
CREATE TABLE `Account`
(
  `Account_Id` Int NOT NULL,
  `Transaction_Type` Varchar(10),
  `Transaction_Amount` Decimal(18,4),
  `Transaction_DateTime` Datetime,
  `Member_Id` Int NOT NULL
)
;

ALTER TABLE `Account` ADD  PRIMARY KEY (`Account_Id`,`Member_Id`)
;

-- Table Genre

CREATE TABLE `Genre`
(
  `Genre_Id` Int NOT NULL,
  `Genre` Varchar(30) NOT NULL
)
;

ALTER TABLE `Genre` ADD  PRIMARY KEY (`Genre_Id`)
;


-- Table Genre_Title

CREATE TABLE `Genre_Title`
(
  `Genre_Id` Int NOT NULL,
  `Title_Id` Int NOT NULL
)
;


-- Table Member

CREATE TABLE `Member`
(
  `Member_Id` Int NOT NULL,
  `Member_First_Name` Varchar(50),
  `Member_Address` Varchar(100),
  `Account_Balance_Limit` Decimal(18,4),
  `Member_DOB` Date,
  `Member_Last_Name` Varchar(50),
  `Member_Account_Status` Varchar(10),
  `Member_Email_Address` Varchar(100)
)
;

ALTER TABLE `Member` ADD  PRIMARY KEY (`Member_Id`)
;


-- Table Member_Audit

CREATE TABLE `Member_Audit`
(
  `Member_Audit_Id` Int NOT NULL,
  `Member_Update_Datetime` Bigint,
  `Member_Id` Int,
  `Member_First_Name` Varchar(50),
  `Member_Address` Varchar(100),
  `Account_Balance_Limit` Decimal(18,4),
  `Member_DOB` Date,
  `Member_Last_Name` Varchar(50),
  `Member_Account_Status` Varchar(10),
  `Member_Email_Address` Varchar(100)
)
;

ALTER TABLE `Member_Audit` ADD  PRIMARY KEY (`Member_Audit_Id`)
;


-- Table Platform

CREATE TABLE `Platform`
(
  `Platform_Id` Int NOT NULL,
  `Platform_Name` Varchar(50),
  `Platform_Manufacturer` Varchar(50)
)
;

ALTER TABLE `Platform` ADD  PRIMARY KEY (`Platform_Id`)
;



-- Table Platform_Title

CREATE TABLE `Platform_Title`
(
  `Platform_Id` Int NOT NULL,
  `Title_Id` Int NOT NULL
)
;


-- Table Publisher

CREATE TABLE `Publisher`
(
  `Publisher_Id` Int NOT NULL,
  `Publisher_Name` Varchar(50)
)
;

ALTER TABLE `Publisher` ADD  PRIMARY KEY (`Publisher_Id`)
;


-- Table Rental

CREATE TABLE `Rental`
(
  `Rental_id` Int NOT NULL,
  `Rental_Datetime` Datetime NOT NULL,
  `Expected_Return_Date` Date NOT NULL,
  `Actual_Return_Date` Date,
  `Rental_Fee` Decimal(18,4) NOT NULL,
  `Daily_Late_Return_Charge` Decimal(18,4),
  `Member_Id` Int NOT NULL,
  `Stock_Item_id` Int NOT NULL
)
;

CREATE INDEX `IX_Member - Rental` ON `Rental` (`Member_Id`)
;

CREATE INDEX `IX_Stock_Item - Rental` ON `Rental` (`Stock_Item_id`)
;

ALTER TABLE `Rental` ADD  PRIMARY KEY (`Rental_id`)
;


-- Table Rental_Rules

CREATE TABLE `Rental_Rules`
(
  `Rental_Rule_Id` Int NOT NULL,
  `Rule_Type` Varchar(20) NOT NULL,
  `Active_YN` Varchar(1) NOT NULL,
  `Rental_Rule_Logic` Varchar(500) NOT NULL
)
;

ALTER TABLE `Rental_Rules` ADD  PRIMARY KEY (`Rental_Rule_Id`)
;


-- Table Reservation

CREATE TABLE `Reservation`
(
  `Reservation_Id` Int NOT NULL,
  `Reservation_Datetime` Datetime,
  `Stock_Item_id` Int NOT NULL
)
;

CREATE INDEX `IX_Stock_Item - Reservation` ON `Reservation` (`Stock_Item_id`)
;

ALTER TABLE `Reservation` ADD  PRIMARY KEY (`Reservation_Id`)
;


-- Table Stock_Item

CREATE TABLE `Stock_Item`
(
  `Stock_Item_id` Int NOT NULL,
  `Item_Stock_No` Varchar(10),
  `In_Stock` Int NOT NULL,
  `Item_Reserved_YN` Varchar(1) NOT NULL,
  `Shelf_Location` Varchar(10) NOT NULL,
  `Title_Id` Int NOT NULL
)
;

CREATE INDEX `IX_Title - Stock_Item` ON `Stock_Item` (`Title_Id`)
;

ALTER TABLE `Stock_Item` ADD  PRIMARY KEY (`Stock_Item_id`)
;


-- Table Supplier

CREATE TABLE `Supplier`
(
  `Supplier_Id` Int NOT NULL,
  `Supplier_Name` Varchar(50),
  `Supplier_Address` Varchar(100)
)
;

ALTER TABLE `Supplier` ADD  PRIMARY KEY (`Supplier_Id`)
;


-- Table Title

CREATE TABLE `Title`
(
  `Title_Id` Int NOT NULL,
  `Game_Name` Varchar(100) NOT NULL,
  `Title_Age_Rating` Varchar(30),
  `Release_Year` Varchar(4),
  `Publisher_Id` Int NOT NULL
)
;

CREATE INDEX `IX_Publisher - Title` ON `Title` (`Publisher_Id`)
;

ALTER TABLE `Title` ADD  PRIMARY KEY (`Title_Id`)
;

-- Create relationships section ------------------------------------------------- 

ALTER TABLE `Rental` ADD CONSTRAINT `Member - Rental` FOREIGN KEY (`Member_Id`) REFERENCES `Member` (`Member_Id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Stock_Item` ADD CONSTRAINT `Title - Stock_Item` FOREIGN KEY (`Title_Id`) REFERENCES `Title` (`Title_Id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Rental` ADD CONSTRAINT `Stock_Item - Rental` FOREIGN KEY (`Stock_Item_id`) REFERENCES `Stock_Item` (`Stock_Item_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Account` ADD CONSTRAINT `Member - Account` FOREIGN KEY (`Member_Id`) REFERENCES `Member` (`Member_Id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Title` ADD CONSTRAINT `Publisher - Title` FOREIGN KEY (`Publisher_Id`) REFERENCES `Publisher` (`Publisher_Id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Platform_Title` ADD CONSTRAINT `Platform - Title_Platform` FOREIGN KEY (`Platform_Id`) REFERENCES `Platform` (`Platform_Id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Platform_Title` ADD CONSTRAINT `Platform - Title_Title` FOREIGN KEY (`Title_Id`) REFERENCES `Title` (`Title_Id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Reservation` ADD CONSTRAINT `Stock_Item - Reservation` FOREIGN KEY (`Stock_Item_id`) REFERENCES `Stock_Item` (`Stock_Item_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Genre_Title` ADD CONSTRAINT `Relationship9_Genre` FOREIGN KEY (`Genre_Id`) REFERENCES `Genre` (`Genre_Id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Genre_Title` ADD CONSTRAINT `Relationship9_Title` FOREIGN KEY (`Title_Id`) REFERENCES `Title` (`Title_Id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

INSERT INTO PLATFORM (	Platform_Id, Platform_Manufacturer, Platform_Name	) Values (	1, 'Microsoft', 'Xbox One'	);
INSERT INTO PLATFORM (	Platform_Id, Platform_Manufacturer, Platform_Name	) Values (	2, 'Nintendo', 'Wii U'	);
INSERT INTO PLATFORM (	Platform_Id, Platform_Manufacturer, Platform_Name	) Values (	3, 'Sony', 'Playstation 4'	);
INSERT INTO PLATFORM (	Platform_Id, Platform_Manufacturer, Platform_Name	) Values (	4, 'Microsoft', 'Xbox 360'	);
INSERT INTO PLATFORM (	Platform_Id, Platform_Manufacturer, Platform_Name	) Values (	5, 'Sony', 'Playstation 3'	);

INSERT INTO GENRE (	Genre, Genre_Id	) Values (	'Action', 92001	);
INSERT INTO GENRE (	Genre, Genre_Id	) Values (	'Shooter', 92002	);
INSERT INTO GENRE (	Genre, Genre_Id	) Values (	'Unknown', 92003	);
INSERT INTO GENRE (	Genre, Genre_Id	) Values (	'Adventure', 92004	);
INSERT INTO GENRE (	Genre, Genre_Id	) Values (	'Puzzle', 92005	);
INSERT INTO GENRE (	Genre, Genre_Id	) Values (	'Sports', 92006	);
INSERT INTO GENRE (	Genre, Genre_Id	) Values (	'Role-Playing', 92007	);
INSERT INTO GENRE (	Genre, Genre_Id	) Values (	'Construction an...', 92008	);
INSERT INTO GENRE (	Genre, Genre_Id	) Values (	'Life Simulation', 92009	);
INSERT INTO GENRE (	Genre, Genre_Id	) Values (	'Racing', 92010	);
INSERT INTO GENRE (	Genre, Genre_Id	) Values (	'Music', 92011	);
INSERT INTO GENRE (	Genre, Genre_Id	) Values (	'Flight Simulato...', 92012	);
INSERT INTO GENRE (	Genre, Genre_Id	) Values (	'Platform', 92013	);
INSERT INTO GENRE (	Genre, Genre_Id	) Values (	'Horror', 92014	);
INSERT INTO GENRE (	Genre, Genre_Id	) Values (	'Strategy', 92015	);
INSERT INTO GENRE (	Genre, Genre_Id	) Values (	'Fighting', 92016	);
INSERT INTO GENRE (	Genre, Genre_Id	) Values (	'MMO', 92017	);
INSERT INTO GENRE (	Genre, Genre_Id	) Values (	'Stealth', 92018	);
INSERT INTO GENRE (	Genre, Genre_Id	) Values (	'Sandbox', 92019	);

INSERT INTO `x16109155`.`publisher`
(`Publisher_Id`,
`Publisher_Name`)
VALUES
(0,
'Unknown');


INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110001, '#IDARB', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110002, '007 Legends', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110003, '007: Quantum of Solace', '2008', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110004, '1001 Spikes', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110005, '1080° Snowboarding', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110006, '11 Eyes: CrossOver', '2009', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110007, '140', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110008, '1942: Joint Strike', '2008', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110009, '2006 FIFA World Cup', '2006', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110010, '2010 FIFA World Cup South Africa', '2010', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110011, '2014 FIFA World Cup Brazil', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110012, '2K Sports Combo Pack: MLB 2K12/NBA 2K12', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110013, '2nd Super Robot Wars Original Generation', '2012', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110014, '3 on 3 NHL Arcade', '2009', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110015, '3D Dot Game Heroes', '2010', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110016, '4-in-1 Action PACK', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110017, '50 Cent: Blood on the Sand', '2009', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110018, '7 Days to Die', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110019, 'A Kingdom for Keflings', '2009', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110020, 'A World of Keflings', '2010', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110021, 'A.R.E.S. Extinction Agenda EX', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110022, 'Aarus Awakening', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110023, 'Absolute Supercars', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110024, 'Abzu', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110025, 'AC/DC Live: Rock Band', '2008', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110026, 'AC/DC Live: Rock Band Track Pack', '2008', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110027, 'Accel World 02: Apex of Acceleration', '2013', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110028, 'Accel World Stage 01: Awakening of the Silver Wings', '2012', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110029, 'Acceleration of Suguri X Edition', '2011', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110030, 'Ace Combat 6: Fires of Liberation', '2007', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110031, 'Ace Combat Infinity', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110032, 'Ace Combat: Assault Horizon', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110033, 'Adams Venture Chronicles', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110034, 'Adams Venture: Origins', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110035, 'Adidas miCoach', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110036, 'Adrenalin Misfits', '2010', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110037, 'Adventure Time: Explore The Dungeon Because I Dont Know!', '2013', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110038, 'Adventure Time: Finn and Jake Investigations', '2015', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110039, 'Aegis of Earth: Protonovus Assault', '', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110040, 'Aegis Wing', '2007', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110041, 'AFL Live', '2011', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110042, 'Afrika', '2009', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110043, 'Afro Samurai', '2009', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110044, 'After Burner Climax', '2010', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110045, 'After Hours Athletes', '2011', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110046, 'Agarest: Generations Of War', '2009', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110047, 'Agatha Christies The ABC Murders', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110048, 'Age of Booty', '2008', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110049, 'Air Conflicts: Pacific Carriers', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110050, 'Air Conflicts: Secret Wars', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110051, 'Air Conflicts: Vietnam', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110052, 'Air Conflicts: Vietnam Ultimate Edition', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110053, 'AirMech Arena', '2014', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110054, 'Akai Katana', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110055, 'Akibas Trip 2', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110056, 'Akibas Trip: Undead & Undressed', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110057, 'Alan Wake', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110058, 'Alan Wake Limited Collectors Edition', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110059, 'Alan Wake: The Writer', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110060, 'Alan Wakes American Nightmare', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110061, 'Alekhines Gun', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110062, 'Alex Kidd in Miracle World', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110063, 'Alice: Madness Returns', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110064, 'Alice: Madness Returns', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110065, 'Alien Breed', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110066, 'Alien Breed 2: Assault', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110067, 'Alien Breed 3: Descent', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110068, 'Alien Breed: Impact', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110069, 'Alien Hominid HD', '2007', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110070, 'Alien Isolation: Nostromo Edition', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110071, 'Alien Rage', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110072, 'Alien: Isolation', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110073, 'Alien: Isolation Nostromo Edition', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110074, 'Alienation', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110075, 'Aliens vs. Predator', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110076, 'Aliens: Colonial Marines', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110077, 'All-Pro Football 2K8', '2007', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110078, 'Alone in the Dark', '2008', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110079, 'Alone in the Dark', '2008', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110080, 'Alone in the Dark: Inferno', '2008', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110081, 'Alpha Protocol', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110082, 'Altered Beast', '2011', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110083, 'Alvin and the Chipmunks: Chipwrecked', '2011', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110084, 'America’s Army: True Soldiers', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110085, 'American McGees Alice', '2011', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110086, 'Amiibo Tap: Nintendos Greatest Bits', '', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110087, 'Among the Sleep', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110088, 'Amped 3', '2005', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110089, 'Amplitude', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110090, 'Amy', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110091, 'Anarchy Reigns', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110092, 'Anarchy: Rush Hour', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110093, 'Angry Birds Star Wars', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110094, 'Angry Birds Trilogy', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110095, 'Angry Birds Trilogy', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110096, 'Anima: Gate of Memories', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110097, 'Animal Crossing: Amiibo Festival', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110098, 'Anomaly 2', '', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110099, 'Anomaly: Warzone Earth', '2012', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110100, 'Apache: Air Assault', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110101, 'Apocalypse: Desire Next', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110102, 'Apotheon', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110103, 'Aquanauts Holiday: Hidden Memories', '2008', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110104, 'AquaPazza: AquaPlus Dream Match', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110105, 'Aquatopia', '2007', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110106, 'Ar Nosurge: Ode to an Unborn Star', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110107, 'Ar Tonelico Qoga: Knell of Ar Ciel', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110108, 'Arcana Heart 3', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110109, 'Arcania: Gothic 4', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110110, 'Arcania: The Complete Tale', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110111, 'Arcania: The Complete Tale', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110112, 'Are You Smarter than a 5th Grader? Game Time', '2009', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110113, 'ARK: Survival Evolved', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110114, 'Ark: Survival of the Fittest', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110115, 'Armored Core 4', '2007', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110116, 'Armored Core for Answer', '2008', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110117, 'Armored Core V', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110118, 'Armored Core: For Answer', '2008', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110119, 'Armored Core: Verdict Day', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110120, 'Army of Two', '2008', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110121, 'Army of Two: The 40th Day', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110122, 'Army of Two: The Devils Cartel', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110123, 'Arslan: The Warriors of Legend', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110124, 'Ascend: New Gods', '2013', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110125, 'Ashes Cricket 2009', '2009', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110126, 'Assassins Creed', '2007', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110127, 'Assassins Creed 3 - Join or Die Edition', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110128, 'Assassins Creed Anthology', '2012', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110129, 'Assassins Creed Brotherhood and Revelations - Double Pack', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110130, 'Assassins Creed Chronicles', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110131, 'Assassins Creed Chronicles: China', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110132, 'Assassins Creed Chronicles: India', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110133, 'Assassins Creed Chronicles: Russia', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110134, 'Assassins Creed Double Pack', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110135, 'Assassins Creed Ezio Trilogy', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110136, 'Assassins Creed II', '2009', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110137, 'Assassins Creed III', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110138, 'Assassins Creed III: Liberation HD', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110139, 'Assassins Creed IV: Black Flag', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110140, 'Assassins Creed IV: Black Flag Skull Edition', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110141, 'Assassins Creed Revelations - Collectors Edition', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110142, 'Assassins Creed Rogue', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110143, 'Assassins Creed Syndicate', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110144, 'Assassins Creed Syndicate (Big Ben Edition)', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110145, 'Assassins Creed: Brotherhood', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110146, 'Assassins Creed: Freedom Cry', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110147, 'Assassins Creed: Heritage Collection', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110148, 'Assassins Creed: Revelations', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110149, 'Assassins Creed: Syndicate', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110150, 'Assassins Creed: The Americas Collection', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110151, 'Assassins Creed: Unity', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110152, 'Assault Heroes', '2006', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110153, 'Assault Heroes 2', '2008', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110154, 'Assault Suit Leynos', '2016', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110155, 'Assetto Corsa', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110156, 'Astro Tripper', '2009', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110157, 'Asuras Wrath', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110158, 'Atelier Ayesha: The Alchemist of Dusk', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110159, 'Atelier Escha & Logy: Alchemist of Dusk Sky', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110160, 'Atelier Meruru: The Apprentice of Arland', '2012', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110161, 'Atelier Rorona Plus: The Alchemist of Arland', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110162, 'Atelier Rorona: The Alchemist of Arland', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110163, 'Atelier Rorona: The Alchemist of Arland (Limited Edition)', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110164, 'Atelier Shallie: Alchemists of the Dusk Sea', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110165, 'Atelier Sophie: The Alchemist of the Mysterious Book', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110166, 'Atelier Totori: The Adventurer of Arland', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110167, 'Attack on Titan', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110168, 'Attouteki Yuugi: Mugen Souls Z', '2013', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110169, 'Autobahn Polizei', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110170, 'Avatar: The Last Airbender – The Burning Earth', '2007', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110171, 'Axiom Verge', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110172, 'Back to the Future: The Game', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110173, 'Back to the Future: The Game', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110174, 'Back to the Future: The Game - 30th Anniversary', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110175, 'Backbreaker', '2010', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110176, 'Backyard Football 10', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110177, 'Backyard Sports Football: Rookie Rush', '2010', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110178, 'Backyard Sports: Sandlot Sluggers', '2010', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110179, 'Baja: Edge of Control', '2008', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110180, 'Bakugan: Battle Brawlers', '2009', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110181, 'Bakugan: Defenders Of The Core', '2010', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110182, 'Balloon Fight', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110183, 'Band Hero', '2009', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110184, 'BandFuse: Rock Legends', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110185, 'Banjo-Kazooie', '2008', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110186, 'Banjo-Kazooie: Nuts & Bolts', '2008', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110187, 'Banjo-Tooie', '2009', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110188, 'Bastion', '', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110189, 'Bastion', '2011', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110190, 'Batman Arkham Knight: Special Edition Steelbook', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110191, 'Batman: Arkham Asylum', '2009', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110192, 'Batman: Arkham Asylum - Collectors Edition', '2009', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110193, 'Batman: Arkham Asylum - Game of the Year Edition', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110194, 'Batman: Arkham Asylum: Game of the Year Edition', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110195, 'Batman: Arkham City', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110196, 'Batman: Arkham City - Collectors Edition', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110197, 'Batman: Arkham City: Armored Edition', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110198, 'Batman: Arkham City: Game of the Year Edition', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110199, 'Batman: Arkham Knight', '2015', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110200, 'Batman: Arkham Origins', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110201, 'Batman: Arkham Origins Blackgate Deluxe Edition', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110202, 'Batman: Arkham Origins Collectors Edition', '2013', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110203, 'Batman: Arkham VR', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110204, 'Batman: Return To Arkham', '2017', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110205, 'Batman: The Telltale Series', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110206, 'Battle Fantasia', '2008', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110207, 'Battle Fantasia', '2009', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110208, 'Battle Islands', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110209, 'Battle Princess of Arcadias', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110210, 'Battle vs. Chess', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110211, 'Battle Worlds: Kronos', '2016', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110212, 'Battle: Los Angeles', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110213, 'Battleblock Theater', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110214, 'Battleborn', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110215, 'Battlefield 1', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110216, 'Battlefield 1943', '2009', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110217, 'Battlefield 2: Modern Combat', '2006', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110218, 'Battlefield 3', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110219, 'Battlefield 3 Premium Edition', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110220, 'Battlefield 3: Premium Edition', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110221, 'Battlefield 4', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110222, 'Battlefield Hardline', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110223, 'Battlefield Hardline', '', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110224, 'Battlefield: Bad Company', '2008', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110225, 'Battlefield: Bad Company 2', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110226, 'Battlefield: Bad Company 2 Ultimate Edition', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110227, 'Battleship', '2012', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110228, 'Battlestations: Midway', '2007', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110229, 'Battlestations: Pacific', '2009', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110230, 'Bayonetta', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110231, 'Bayonetta', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110232, 'Bayonetta 2', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110233, 'Bayonetta 2 - Special Edition', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110234, 'Beautiful Katamari', '2007', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110235, 'Bee Movie Game', '2007', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110236, 'Beijing 2008', '2008', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110237, 'Bejeweled 3', '2011', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110238, 'Bellator : MMA Onslaught', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110239, 'Ben 10: Galactic Racing', '2011', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110240, 'Ben 10: Omniverse', '2012', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110241, 'Ben 10: Ultimate Alien Cosmic Destruction', '2010', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110242, 'Beowulf: The Game', '2007', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110243, 'Best of PlayStation Network Vol. 1', '2013', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110244, 'Beyond Eyes', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110245, 'Beyond Good & Evil HD', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110246, 'Beyond the Future: Fix the Time Arrows', '2011', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110247, 'Beyond: Two Souls', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110248, 'Beyond: Two Souls', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110249, 'Beyond: Two Souls Special Edition', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110250, 'Big Bumpin', '2006', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110251, 'Big Game Hunter 2010', '2009', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110252, 'Big League Sports', '2011', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110253, 'Binary Domain', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110254, 'BioHazard 0: HD Remaster (JP)', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110255, 'Biohazard Revival Selection', '2008', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110256, 'Bionic Commando', '2009', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110257, 'Bionic Commando (2009)', '2009', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110258, 'Bionic Commando Rearmed 2', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110259, 'Bionic Commando: Rearmed', '2008', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110260, 'Bionic Commando: Rearmed 2', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110261, 'Bionicle Heroes', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110262, 'BioShock', '2007', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110263, 'BioShock', '2008', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110264, 'Bioshock 2', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110265, 'BioShock 2 Special Edition', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110266, 'Bioshock 2: Rapture Edition', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110267, 'BioShock Infinite', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110268, 'BioShock Infinite: Burial at Sea', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110269, 'Bioshock Infinite: The Complete Edition', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110270, 'Bioshock Infinite: Ultimate Songbird Edition', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110271, 'Bioshock: The Collection', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110272, 'Birds of Steel', '2012', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110273, 'BIT. TRIP Presents Runner 2: Future Legend of Rhythm Alien', '2013', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110274, 'BIT.TRIP Presents Runner 2: Future Legend of Rhythm Alien', '2013', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110275, 'Black College Football: The Xperience', '2009', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110276, 'Blacklight Retribution', '2013', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110277, 'Blacklight: Tango Down', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110278, 'BlackSite: Area 51', '2007', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110279, 'Blackwater', '2013', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110280, 'Blade & Soul', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110281, 'Blade Kitten', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110282, 'Blades of Time', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110283, 'Bladestorm The Hundred Years War', '2007', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110284, 'Bladestorm: Nightmare', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110285, 'Blast Off', '2009', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110286, 'BlazBlue: Calamity Trigger', '2009', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110287, 'BlazBlue: Chrono Phantasma', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110288, 'BlazBlue: Chrono Phantasma Extend', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110289, 'BlazBlue: Continuum Shift', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110290, 'Blazblue: Continuum Shift Extend', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110291, 'BlazeRush', '2014', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110292, 'Blazing Angels 2: Secret Missions of WWII', '2007', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110293, 'Blazing Angels: Squadrons of WWII', '2007', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110294, 'Bleach: Soul Resurreccion', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110295, 'Blitz: The League', '2005', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110296, 'Blitz: The League II', '2008', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110297, 'Blood Bowl', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110298, 'Blood Bowl 2', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110299, 'Blood Drive', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110300, 'Blood Knights', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110301, 'Bloodborne', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110302, 'Bloodborne Collectors Edition', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110303, 'Bloodborne Nightmare Edition', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110304, 'Bloodborne: The Old Hunters', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110305, 'Blue Dragon', '2007', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110306, 'Blue Toad Murder Files', '2010', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110307, 'Blur', '2010', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110308, 'Body and Brain Connection', '2011', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110309, 'Bodycount', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110310, 'Bolt', '2008', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110311, 'Bomberman Live', '2007', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110312, 'Bomberman Ultra', '2009', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110313, 'Bomberman: Act Zero', '2006', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110314, 'Boom Boom Rocket', '2007', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110315, 'Borderlands', '2009', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110316, 'Borderlands - Game of the Year Edition', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110317, 'Borderlands 2', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110318, 'Borderlands 2 Deluxe Vault Hunters Edition', '', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110319, 'Borderlands 2: Add-On Content Pack', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110320, 'Borderlands 2: Game of the Year', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110321, 'Borderlands Triple Pack', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110322, 'Borderlands: The Handsome Collection', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110323, 'Borderlands: The Pre-Sequel', '2014', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110324, 'Bound by Flame', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110325, 'Braid', '2008', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110326, 'Braid', '2009', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110327, 'Brain Challenge Deluxe', '2008', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110328, 'Brave: The Video Game', '2012', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110329, 'Brink', '2011', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110330, 'Broforce', '2016', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110331, 'Broken Age', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110332, 'Brothers in Arms: Hells Highway', '2008', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110333, 'Brothers: A Tale of Two Sons', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110334, 'Brothers: a Tale of Two Sons', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110335, 'Brunswick Pro Bowling', '', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110336, 'Brütal Legend', '2009', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110337, 'Bullet Soul Infinite Burst', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110338, 'Bullet Soul: Tama Tamashii', '2011', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110339, 'Bullet Witch', '2007', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110340, 'Bulletstorm', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110341, 'Bully: Scholarship Edition', '2008', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110342, 'Burn Zombie Burn!', '2009', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110343, 'Burnout Crash!', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110344, 'Burnout Paradise', '2008', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110345, 'Burnout Paradise: the Ultimate Box / Trivial Pursuit', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110346, 'Burnout Revenge', '2005', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110347, 'Buzz! Junior: Jungle Party', '2009', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110348, 'Buzz! Quem é o Génio Português', '2009', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110349, 'Buzz! Quiz TV', '2008', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110350, 'Buzz! Quiz TV Bundle', '2008', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110351, 'Buzz! Quiz World', '2009', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110352, 'Buzz! The Ultimate Music Quiz', '2010', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110353, 'Cabelas Adventure Camp', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110354, 'Cabelas Adventure Camp', '2011', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110355, 'Cabelas African Safari', '2006', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110356, 'Cabelas Alaskan Adventures', '2006', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110357, 'Cabelas Big Game Hunter', '2007', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110358, 'Cabelas Big Game Hunter 2010', '2009', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110359, 'Cabelas Big Game Hunter 2012', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110360, 'Cabelas Big Game Hunter: Hunting Party', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110361, 'Cabelas Dangerous Hunts 2009', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110362, 'Cabelas Dangerous Hunts 2011', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110363, 'Cabelas Dangerous Hunts 2013', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110364, 'Cabelas Hunting Expeditions', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110365, 'Cabelas North American Adventure', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110366, 'Cabelas Outdoor Adventures', '2009', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110367, 'Cabelas Survival: Shadows of Katmai', '2011', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110368, 'Cabelss Trophy Bucks', '2007', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110369, 'Caladrius', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110370, 'Caladrius Blaze', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110371, 'Call of Duty 2', '2005', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110372, 'Call of Duty 3', '2006', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110373, 'Call of Duty 4: Modern Warfare', '2007', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110374, 'Call of Duty Black Ops III Hardened Edition', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110375, 'Call of Duty Classic', '2009', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110376, 'Call of Duty Infinite Warfare', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110377, 'Call of Duty Modern Warfare 3 Hardened Edition', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110378, 'Call of Duty: Advanced Warfare', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110379, 'Call of Duty: Advanced Warfare Atlas Pro Edition', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110380, 'Call of Duty: Black Ops', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110381, 'Call of Duty: Black Ops II', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110382, 'Call of Duty: Black Ops III', '2015', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110383, 'Call of Duty: Black Ops III Juggernog Edition', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110384, 'Call of Duty: Ghosts', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110385, 'Call of Duty: Modern Warfare 2', '2009', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110386, 'Call of Duty: Modern Warfare 3', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110387, 'Call of Duty: World at War', '2008', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110388, 'Call of Juarez', '2007', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110389, 'Call of Juarez: Bound in Blood', '2009', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110390, 'Call of Juarez: Gunslinger', '2013', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110391, 'Call of Juarez: The Cartel', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110392, 'Capcom Digital Collection', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110393, 'Captain America: Super Soldier', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110394, 'Captain Morgane and the Golden Turtle', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110395, 'Captain Toad: Treasure Tracker', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110396, 'Carcassonne', '2007', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110397, 'Carmageddon: Max Damage', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110398, 'Carmageddon: Reincarnation', '2013', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110399, 'Carnival Games: Monkey See, Monkey Do', '2011', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110400, 'Carnival Island', '2011', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110401, 'Carrier Command: Gaea Mission', '2012', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110402, 'Cars', '2006', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110403, 'Cars 2', '2011', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110404, 'Cars: Mater-National Championship', '2007', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110405, 'Cars: Race O Rama', '2009', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110406, 'Cartoon Network: Punch Time Explosion XL', '2011', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110407, 'Castle Crashers', '2008', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110408, 'Castle Crashers', '2010', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110409, 'Castle of Illusion Remastered', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110410, 'Castlevania Lords of Shadow – Mirror of Fate HD', '2013', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110411, 'Castlevania: Harmony of Despair', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110412, 'Castlevania: Harmony of Despair', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110413, 'Castlevania: Lords of Shadow', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110414, 'Castlevania: Lords of Shadow 2', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110415, 'Castlevania: Lords of Shadow Collection', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110416, 'Castlevania: Lords of Shadow Collectors Edition', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110417, 'Castlevania: Lords of Shadow Limited Edition', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110418, 'Castlevania: Symphony of the Night', '2007', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110419, 'Catherine', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110420, 'Catherine', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110421, 'Champion Jockey: G1 Jockey & Gallop Racer', '2011', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110422, 'Chaos;Head Noah', '2009', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110423, 'Chaotic: Shadow Warriors', '2009', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110424, 'Chariot', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110425, 'Charlie Murder', '2013', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110426, 'Child of Eden', '2011', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110427, 'Child of Light', '2014', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110428, 'Chivalry: Medieval Warfare', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110429, 'Chromehounds', '2006', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110430, 'Chronicles of Riddick: Assault on Dark Athena', '2009', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110431, 'Citizens of Earth', '', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110432, 'Citizens of Earth', '2015', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110433, 'Clan of Champions', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110434, 'Clash of the Titans', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110435, 'Class of Heroes 2G', '2014', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110436, 'Classics HD: The Ratchet & Clank Trilogy', '2012', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110437, 'Clive Barkers Jericho', '2007', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110438, 'Closure', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110439, 'Cloudy With a Chance of Meatballs', '2009', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110440, 'Colin McRae: DiRT', '2007', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110441, 'Colin McRae: DiRT 2', '2009', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110442, 'Colin McRae: DiRT 2', '2008', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110443, 'College Hoops 2K7', '2006', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110444, 'College Hoops 2K8', '2007', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110445, 'Combat Wings: The Great Battles of WWII', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110446, 'Comet Crash', '2009', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110447, 'Comic Jumper', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110448, 'Comix Zone', '2011', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110449, 'Command & Conquer 3: Kanes Wrath', '2008', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110450, 'Command & Conquer 3: Tiberium Wars', '2007', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110451, 'Command & Conquer: Red Alert 3', '2008', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110452, 'Command & Conquer: Red Alert 3 Ultimate Edition', '2009', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110453, 'Conan', '2007', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110454, 'Condemned 2: Bloodshot', '2008', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110455, 'Condemned: Criminal Origins', '2006', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110456, 'Conflict: Denied Ops', '2008', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110457, 'Contra', '2006', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110458, 'Contrast', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110459, 'Costume Quest', '2010', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110460, 'Counter Strike: Global Offensive', '2012', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110461, 'CounterSpy', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110462, 'Counter-Strike: GO', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110463, 'Country Dance Kinect', '2012', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110464, 'Crackdown', '2007', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110465, 'Crackdown 2', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110466, 'Crackdown 3', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110467, 'Crash of the Titans', '2007', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110468, 'Crash Time 4: The Syndicate', '2012', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110469, 'Crash Time 5: Undercover', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110470, 'Crash: Mind Over Mutant', '2008', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110471, 'Crazy Machines Elements', '2011', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110472, 'Crazy Machines Elements', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110473, 'Crazy Taxi', '2010', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110474, 'Create', '2010', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110475, 'Crimson Alliance', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110476, 'Crimson Dragon', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110477, 'Critter Crunch', '2009', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110478, 'Cross Edge', '2009', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110479, 'Crysis', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110480, 'Crysis 2', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110481, 'Crysis 2: Limited Edition', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110482, 'Crysis 3', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110483, 'CSI: Deadly Intent', '2009', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110484, 'CSI: Fatal Conspiracy', '2010', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110485, 'CSI: Hard Evidence', '2007', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110486, 'Cuboid', '2009', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110487, 'Culdcept Saga', '2008', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110488, 'Cyberpunk 2077', '', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110489, 'D4: Dark Dreams Dont Die', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110490, 'Damage Inc.: Pacific Squadron WWII', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110491, 'Damnation', '2009', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110492, 'Dance Central', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110493, 'Dance Central 2', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110494, 'Dance Central 3', '2012', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110495, 'Dance Central Spotlight', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110496, 'Dance Dance Revolution', '2011', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110497, 'Dance Dance Revolution', '2010', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110498, 'Dance Dance Revolution Universe', '2007', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110499, 'Dance Dance Revolution Universe 2', '2007', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110500, 'Dance Magic', '2013', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110501, 'Dance on Broadway', '2011', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110502, 'Dance Paradise', '2011', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110503, 'Dance! Its Your Stage', '2010', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110504, 'Dance! Its Your Stage', '2011', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110505, 'DanceMasters', '2010', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110506, 'DanceStar Party', '2011', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110507, 'DanceStar: Party Hits', '2012', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110508, 'Dantes Inferno', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110509, 'Dark', '2013', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110510, 'Dark Messiah: Might and Magic Elements', '2008', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110511, 'Dark Sector', '2008', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110512, 'Dark Souls', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110513, 'Dark Souls II', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110514, 'Dark Souls II Webhallen Edition', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110515, 'Dark Souls II: Scholar of the First Sin', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110516, 'Dark Souls III', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110517, 'Dark Souls III Apocalypse Edition', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110518, 'Dark Souls III Collectors Edition', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110519, 'Dark Souls III Collectors Edition', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110520, 'Dark Souls: Collectors Edition', '2011', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110521, 'Dark Souls: Prepare to Die Edition', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110522, 'Dark Void', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110523, 'Darkest Dungeon', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110524, 'Darkest of Days', '2009', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110525, 'Darksiders', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110526, 'Darksiders - Collection', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110527, 'Darksiders 2: Deathinitive Edition', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110528, 'Darksiders II', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110529, 'Darksiders II: Deathinitive Edition', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110530, 'Darkstalkers Resurrection', '2013', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110531, 'DarkStar One: Broken Alliance', '2010', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110532, 'Dash of Destruction', '2008', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110533, 'Datura', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110534, 'Days Gone', '2017', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110535, 'Days of Thunder: Arcade', '2011', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110536, 'Days of Thunder: NASCAR Edition', '2011', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110537, 'DC Universe Online', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110538, 'de Blob 2', '2011', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110539, 'Dead Block', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110540, 'Dead Island', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110541, 'Dead Island - Double Pack', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110542, 'Dead Island: Definitive Collection', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110543, 'Dead Island: Game of the Year Edition', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110544, 'Dead Island: Riptide', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110545, 'Dead Nation', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110546, 'Dead Nation: Apocalypse Edition', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110547, 'Dead or Alive 4', '2005', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110548, 'Dead or Alive 5', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110549, 'Dead or Alive 5 Last Round', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110550, 'Dead or Alive 5 Ultimate', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110551, 'Dead or Alive 5: Last Round', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110552, 'Dead or Alive Xtreme 2', '2006', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110553, 'Dead Rising', '2006', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110554, 'Dead Rising 2', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110555, 'Dead Rising 2 - Zombrex Edition', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110556, 'Dead Rising 2: Case West', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110557, 'Dead Rising 2: Case Zero', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110558, 'Dead Rising 2: Off The Record', '2011', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110559, 'Dead Rising 3', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110560, 'Dead Space', '2008', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110561, 'Dead Space 2', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110562, 'Dead Space 2 (Collectors Edition)', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110563, 'Dead Space 2: Limited Edition', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110564, 'Dead Space 3', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110565, 'Dead Space Ignition', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110566, 'Dead Space: Extraction', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110567, 'Dead to Rights: Retribution', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110568, 'Deadburg', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110569, 'Deadfall Adventures', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110570, 'Deadliest Catch: Alaskan Storm', '2008', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110571, 'Deadliest Catch: Sea of Chaos', '2010', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110572, 'Deadliest Warrior: Ancient Combat', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110573, 'Deadliest Warrior: Legends', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110574, 'Deadlight', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110575, 'Deadlight Directors Cut', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110576, 'Deadly Premonition', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110577, 'Deadly Premonition: The Directors Cut', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110578, 'Deadpool', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110579, 'Deadpool', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110580, 'Deadstorm Pirates', '2010', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110581, 'Death Stranding', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110582, 'Death Tank', '2009', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110583, 'Death Track: Resurrection', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110584, 'Deathsmiles', '2007', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110585, 'Deathsmiles: Limited Edition', '2010', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110586, 'DeathSpank: Thongs of Virtue', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110587, 'DeathSpank: Thongs of Virtue', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110588, 'Deca Sports Freedom', '2010', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110589, 'Deception IV: Blood Ties', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110590, 'Deception IV: The Nightmare Princess', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110591, 'Deep Black', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110592, 'Def Jam Rapstar', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110593, 'Def Jam: Icon', '2007', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110594, 'Defense Grid 2', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110595, 'Defense Grid: The Awakening', '2009', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110596, 'Defiance', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110597, 'Defiance - Collectors Edition', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110598, 'Demons Souls', '2009', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110599, 'Demons Souls Black Phantom Edition', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110600, 'Demons Souls: Deluxe Edition', '2009', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110601, 'Dengeki Bunko: Fighting Climax', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110602, 'Desert Ashes', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110603, 'Destiny', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110604, 'Destiny: Ghost Edition', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110605, 'Destiny: House of Wolves', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110606, 'Destiny: The Dark Below', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110607, 'Destiny: The Taken King', '2015', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110608, 'Destroy All Humans! Path of the Furon', '2008', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110609, 'Destroy All Humans! Path Of The Furon', '2009', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110610, 'Deus Ex', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110611, 'Deus Ex Human Revolution Directors Cut', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110612, 'Deus Ex: Human Revolution', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110613, 'Deus Ex: Human Revolution - Augmented Edition', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110614, 'Deus Ex: Human Revolution Directors Cut', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110615, 'Deus Ex: Mankind Divided', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110616, 'Devil May Cry 4', '2008', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110617, 'Devil May Cry 4 Collectors Edition', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110618, 'Devil May Cry HD Collection', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110619, 'Devils Third', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110620, 'Dex', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110621, 'Diablo III', '', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110622, 'Diablo III', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110623, 'Diablo III Reaper of Souls: Ultimate Evil Edition', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110624, 'Diario: Rebirth Moon Legend', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110625, 'Digimon All-Star Rumble', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110626, 'Digimon Story: Cyber Sleuth', '2016', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110627, 'DiRT 3', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110628, 'Dirt 3: Complete Edition', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110629, 'Dirt Rally', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110630, 'Dirt Rally Legend Edition', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110631, 'Dirt: Showdown', '2012', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110632, 'Disgaea 3: Absence of Justice', '2008', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110633, 'Disgaea 4: A Promise Unforgotten', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110634, 'Disgaea 5: Alliance of Vengeance', '2015', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110635, 'Disgaea D2: A Brighter Darkness', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110636, 'Disgaea Dimension 2: A Brighter Darkness', '2013', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110637, 'Dishonored', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110638, 'Dishonored 2', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110639, 'Dishonored Definitive Edition', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110640, 'Dishonored Game of the Year', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110641, 'Dishonored: Game of the Year Edition', '2013', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110642, 'Dishonored: The Knife of Dunwall', '2013', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110643, 'Disney Epic Mickey 2: The Power of Two', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110644, 'Disney Infinity', '2013', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110645, 'Disney Infinity: 2.0 Edition', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110646, 'Disney Infinity 3.0 - Star Wars Starter Pack', '2015', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110647, 'Disney Infinity: 3.0 Edition', '2015', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110648, 'Disney Sing It', '2008', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110649, 'Disney Sing It: Family Hits', '2010', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110650, 'Disney Sing It: High School Musical 3: Senior Year', '2009', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110651, 'Disney Sing It: Party Hits', '2010', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110652, 'Disney Sing It: Pop Hits', '2009', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110653, 'Disney Universe', '2011', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110654, 'Divekick', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110655, 'Divinity II - The Dragon Knight Saga', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110656, 'Divinity II: Ego Draconis', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110657, 'Divinity Original Sin: Enhanced Edition', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110658, 'Divinity: Original Sin - Enhanced Edition', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110659, 'DJ Hero', '2009', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110660, 'DJ Hero 2', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110661, 'DmC Devil May Cry Definitive Edition', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110662, 'DmC: Devil May Cry', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110663, 'Doctor Who: The Eternity Clock', '2012', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110664, 'DoDonPachi Resurrection: Deluxe Edition', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110665, 'DoDonPachi Saidaioujou', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110666, 'Doki-Doki Universe', '2013', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110667, 'Don Bradman Cricket', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110668, 'Don King Presents: Prizefighter', '2008', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110669, 'Donkey Kong', '', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110670, 'Donkey Kong Country: Tropical Freeze', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110671, 'Dont Starve', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110672, 'Dont Starve Together', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110673, 'Doodle Jump', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110674, 'DOOM (2016)', '2016', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110675, 'Doom 3 BFG Edition', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110676, 'Doom: Collectors Edition', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110677, 'Doritos Crash Course', '2010', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110678, 'Doritos Crash Course 2', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110679, 'Double Fine Happy Action Theater', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110680, 'Dragon Age II', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110681, 'Dragon Age Inquisition: Deluxe Edition', '2014', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110682, 'Dragon Age: Inquisition', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110683, 'Dragon Age: Inquisition - Game of the Year Edition', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110684, 'Dragon Age: Origins', '2009', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110685, 'Dragon Age: Origins - Awakening', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110686, 'Dragon Age: Origins - Collectors Edition', '2009', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110687, 'Dragon Age: Origins - Ultimate Edition', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110688, 'Dragon Ball Xenoverse 2 Collectors Edition', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110689, 'Dragon Ball Z Budokai HD Collection', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110690, 'Dragon Ball Z for Kinect', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110691, 'Dragon Ball Z: Battle of Z', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110692, 'Dragon Ball Z: Burst Limit', '2008', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110693, 'Dragon Ball Z: Ultimate Tenkaichi', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110694, 'Dragon Ball: Raging Blast', '2009', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110695, 'Dragon Ball: Raging Blast 2', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110696, 'Dragon Ball: Xenoverse', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110697, 'Dragon Ball: Xenoverse 2', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110698, 'Dragon Fantasy: The Black Tome of Ice', '2016', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110699, 'Dragon Quest Heroes', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110700, 'Dragon Quest X', '2013', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110701, 'Dragons Crown', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110702, 'Dragons Dogma', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110703, 'Dragons Dogma: Dark Arisen', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110704, 'Drakengard 3', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110705, 'Dream C Club', '2009', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110706, 'Dreamcast Collection', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110707, 'DreamWorks Super Star Kartz', '2011', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110708, 'DriveClub', '2014', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110709, 'Driveclub VR', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110710, 'Driver: San Francisco', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110711, 'Droplitz', '2009', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110712, 'DuckTales Remastered', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110713, 'Duke Nukem 3D: 20th Anniversary World Tour', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110714, 'Duke Nukem 3D: Megaton Edition', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110715, 'Duke Nukem Forever', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110716, 'Duke Nukem Forever: Balls of Steel Edition', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110717, 'Dunamis 15', '2011', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110718, 'Dungeon Defenders', '2011', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110719, 'Dungeon Hunter: Alliance', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110720, 'Dungeon Siege III', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110721, 'Dungeon Siege III: Limited Edition', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110722, 'Dungeons & Dragons: Chronicles of Mystara', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110723, 'Dungeons & Dragons: Chronicles of Mystara.', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110724, 'DUST 514', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110725, 'Dust: An Elysian Tail', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110726, 'Dying Light', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110727, 'Dying Light: The Following', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110728, 'Dynasty Warriors 5: Empires', '2006', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110729, 'Dynasty Warriors 6', '2008', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110730, 'Dynasty Warriors 6: Empires', '2009', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110731, 'Dynasty Warriors 7', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110732, 'Dynasty Warriors 7: Empires', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110733, 'Dynasty Warriors 7: Xtreme Legends', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110734, 'Dynasty Warriors 8', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110735, 'Dynasty Warriors 8', '2013', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110736, 'Dynasty Warriors 8 Empires', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110737, 'Dynasty Warriors 8: Xtreme Legends - Complete Edition', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110738, 'Dynasty Warriors: Gundam', '2007', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110739, 'Dynasty Warriors: Gundam 2', '2009', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110740, 'Dynasty Warriors: Gundam 3', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110741, 'Dynasty Warriors: Gundam Reborn', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110742, 'Dynasty Warriors: Strikeforce', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110743, 'Dynasty Warriors: Strikeforce 2 HD Edition', '2012', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110744, 'E.X. Troopers', '2012', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110745, 'EA Sports Active 2', '2010', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110746, 'EA Sports Active 2.0', '2010', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110747, 'EA Sports MMA', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110748, 'EA Sports UFC', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110749, 'EA Sports UFC 2', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110750, 'Earth Defense Force 2017', '2007', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110751, 'Earth Defense Force 2025', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110752, 'Earth Defense Force 4.1: The Shadow of New Despair', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110753, 'Earth Defense Force Insect Armageddon', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110754, 'Eat Lead: The Return of Matt Hazard', '2009', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110755, 'echochrome', '2008', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110756, 'Echochrome ii', '2010', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110757, 'El Chavo Kart', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110758, 'El Shaddai: Ascension of the Metatron', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110759, 'Elder Scrolls V: Skyrim Collectors Edition', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110760, 'Elemental Monster', '2011', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110761, 'Elite: Dangerous', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110762, 'Emily Wants To Play', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110763, 'Enchanted Arms', '2006', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110764, 'Enchanted Arms', '2007', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110765, 'Enemy Front', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110766, 'Enemy Territory: Quake Wars', '2008', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110767, 'Enslaved: Odyssey to the West', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110768, 'Entwined', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110769, 'Eragon', '2006', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110770, 'Escape Dead Island', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110771, 'Escape Plan', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110772, 'Eschatos', '2011', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110773, 'Espgaluda 2', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110774, 'ESPN Sports Connection', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110775, 'Eternal Sonata', '2007', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110776, 'ETHER One', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110777, 'Eureka Seven AO: Jungfrau no Hanabanatachi', '2012', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110778, 'Ever17: Out of Infinity', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110779, 'Everybody Dance', '2011', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110780, 'Everybody Dance 2', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110781, 'Everybodys Golf: World Tour', '2008', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110782, 'Everybodys Gone to the Rapture', '2015', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110783, 'Everyday Shooter', '2007', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110784, 'Everyone Sing', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110785, 'Evolve', '2015', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110786, 'Eye Pet and Friends', '2011', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110787, 'EyeCreate', '2007', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110788, 'EyePet', '2010', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110789, 'F.E.A.R.', '2006', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110790, 'F.E.A.R.', '2007', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110791, 'F.E.A.R. 2: Project Origin', '2009', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110792, 'F.E.A.R. 3', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110793, 'F.E.A.R. Extraction Point', '2007', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110794, 'F.E.A.R. Files', '2007', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110795, 'F.E.A.R. Perseus Mandate', '2007', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110796, 'F1 2010', '2010', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110797, 'F1 2011', '2011', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110798, 'F1 2012', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110799, 'F1 2013', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110800, 'F1 2014', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110801, 'F1 2015', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110802, 'F1 2016', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110803, 'F1 Race Stars', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110804, 'Fable Anniversary', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110805, 'Fable Heroes', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110806, 'Fable II', '2008', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110807, 'Fable II (Limited Collectors Edition)', '2008', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110808, 'Fable II (Platinum Hits)', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110809, 'Fable II / Halo Wars', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110810, 'Fable III', '2011', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110811, 'Fable III: Limited Collectors Edition', '2010', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110812, 'Fable Legends', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110813, 'Fable: The Journey', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110814, 'FaceBreaker', '2008', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110815, 'Faery: Legends of Avalon', '2010', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110816, 'Faery: Legends of Avalon', '2011', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110817, 'Fairy Fencer F', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110818, 'Fairy Fencer F: Advent Dark Force', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110819, 'Fairytale Fights', '2009', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110820, 'Falling Skies', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110821, 'Fallout 3', '2008', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110822, 'Fallout 3 Collectors Edition', '2008', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110823, 'Fallout 3 Game Add-On Pack: Broken Steel and Point Lookout', '2009', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110824, 'Fallout 3 Game Add-On Pack: The Pitt and Operation: Anchorage', '2009', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110825, 'Fallout 3: Game of the Year Edition', '2009', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110826, 'Fallout 4', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110827, 'Fallout 4: Pip-Boy Edition', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110828, 'Fallout: New Vegas', '2010', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110829, 'Fallout: New Vegas Ultimate Edition', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110830, 'Family Guy: Back to the Multiverse', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110831, 'Family Party: 30 Great Games Obstacle Arcade', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110832, 'Fantasia: Music Evolved', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110833, 'Fantasia: Music Evolved', '', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110834, 'Fantastic Four: Rise of the Silver Surfer', '2007', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110835, 'Fantastic Pets', '2011', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110836, 'Far Cry 2', '2008', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110837, 'Far Cry 3', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110838, 'Far Cry 3 & Far Cry 4 - Double Pack', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110839, 'Far Cry 3: Blood Dragon', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110840, 'Far Cry 4', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110841, 'Far Cry 4', '', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110842, 'Far Cry 4 Kyrat Edition', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110843, 'Far Cry 4: Complete Edition', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110844, 'Far Cry 4: Limited Edition', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110845, 'Far Cry Classic', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110846, 'Far Cry Instincts: Predator', '2006', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110847, 'Far Cry Primal', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110848, 'Far Cry Primal', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110849, 'Far Cry Primal Collector', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110850, 'Far Cry Primal Collectors Edition', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110851, 'Farming Simulator', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110852, 'Farming Simulator 15', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110853, 'Fast & Furious: Showdown', '2013', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110854, 'Fast & Furious: Showdown', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110855, 'Fat Princess', '2009', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110856, 'Fatal Frame: Maiden of Black Water', '', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110857, 'Fatal Inertia', '2007', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110858, 'Fatal Inertia EX', '2008', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110859, 'Fate/Extella: The Umbral Star', '2017', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110860, 'Feeding Frenzy', '2006', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110861, 'Ferrari Challenge Deluxe', '2010', 'EC - Early Childhood',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110862, 'Ferrari Challenge Trofeo Pirelli', '2008', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110863, 'Fez', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110864, 'Fez', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110865, 'FIFA 06: Road to FIFA World Cup', '2005', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110866, 'FIFA 08', '2007', 'EC - Early Childhood',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110867, 'FIFA 09', '2008', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110868, 'FIFA 10', '2009', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110869, 'FIFA 12', '2011', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110870, 'FIFA 13', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110871, 'FIFA 14', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110872, 'FIFA 15', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110873, 'FIFA 16', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110874, 'FIFA 17', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110875, 'FIFA Soccer 08', '2007', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110876, 'FIFA Soccer 09', '2008', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110877, 'FIFA Soccer 10', '2009', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110878, 'FIFA Soccer 11', '2010', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110879, 'FIFA Soccer 12', '2011', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110880, 'FIFA Soccer 13', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110881, 'FIFA Street', '2012', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110882, 'FIFA Street 3', '2008', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110883, 'Fight Night Champion', '2011', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110884, 'Fight Night Round 3', '2006', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110885, 'Fight Night Round 4', '2009', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110886, 'Fighter Within', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110887, 'Fighters Uncaged', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110888, 'Final Fantasy Type-0 HD', '2015', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110889, 'Final Fantasy VII', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110890, 'Final Fantasy VII Remake', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110891, 'Final Fantasy X / X-2 HD Remaster', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110892, 'Final Fantasy X|X-2 HD Remaster Limited Edition', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110893, 'Final Fantasy XI Online', '2006', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110894, 'Final Fantasy XIII', '2010', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110895, 'Final Fantasy XIII-2', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110896, 'Final Fantasy XIII-2 Collectors Edition', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110897, 'Final Fantasy XIV Online: A Realm Reborn', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110898, 'Final Fantasy XIV Online: Heavensward', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110899, 'Final Fantasy XV', '', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110900, 'Firewatch', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110901, 'FLOCKERS', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110902, 'flOw', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110903, 'Flower', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110904, 'For Honor', '2017', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110905, 'Forza Horizon 2', '2014', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110906, 'Forza Horizon 2 Presents Fast & Furious', '2015', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110907, 'Forza Horizon 3', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110908, 'Forza Horizon 3: Ultimate', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110909, 'Forza Motorsport 5', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110910, 'Forza Motorsport 6', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110911, 'Frozen Free Fall: Snowball Fight', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110912, 'Funky Barn', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110913, 'Furi', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110914, 'Gal*Gun: Double Peace', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110915, 'Galak-Z: The Dimensional', '2015', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110916, 'Game & Wario', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110917, 'Game of Thrones: A Telltale Games Series', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110918, 'Game Party Champions', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110919, 'Gauntlet (2014)', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110920, 'Gears of War - Ultimate Edition and Rare Replay', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110921, 'Gears of War 4', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110922, 'Gears of War 4: Collectors Edition', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110923, 'Gears of War Ultimate Edition', '2015', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110924, 'Gems of War', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110925, 'Geometry Wars™ 3: Dimensions', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110926, 'Ghost of a Tale', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110927, 'Ghostbusters', '2016', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110928, 'Giana Sisters Twisted Dreams Directors Cut', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110929, 'Giana Sisters: Twisted Dreams - Directors Cut', '2014', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110930, 'Goat Simulator', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110931, 'God Eater 2 Rage Burst', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110932, 'God of War III Remastered', '', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110933, 'Godzilla', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110934, 'Gone Home', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110935, 'Grand Ages: Medieval Limited Special Edition', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110936, 'Grand Kingdom', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110937, 'Grand Theft Auto V', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110938, 'Gravity Rush Remastered', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110939, 'Grim Fandango Remastered', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110940, 'Grow Up', '2016', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110941, 'Guacamelee', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110942, 'Guilty Gear Xrd', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110943, 'Guitar Hero Live', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110944, 'Gundam Breaker 3', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110945, 'Halo 3: ODST', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110946, 'Halo 5: Guardians', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110947, 'Halo 5: Guardians Limited Collectors Edition', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110948, 'Halo 5: Guardians Limited Edition', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110949, 'Halo: Spartan Assault', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110950, 'Halo: The Master Chief Collection', '2014', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110951, 'Halo: The Master Chief Collection Limited Edition', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110952, 'Handball 16', '2015', 'EC - Early Childhood',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110953, 'Happy Wars', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110954, 'Hard Reset: Redux', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110955, 'Hasbro Family Fun Pack', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110956, 'Heavy Rain', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110957, 'Heavy Rain & Beyond: Two Souls Collection', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110958, 'Hellblade', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110959, 'Helldivers', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110960, 'Helldivers Super Earth Ultimate Edition', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110961, 'Hello Kitty Kruisers', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110962, 'Hitman Collectors Edition', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110963, 'Hohokum', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110964, 'Homefront: The Revolution', '', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110965, 'Horizon Zero Dawn', '2017', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110966, 'Hotline Miami', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110967, 'How to Survive', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110968, 'Hyrule Warriors', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110969, 'Infamous: First Light', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110970, 'Infamous: Second Son', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110971, 'Infamous: Second Son Limited Edition', '2014', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110972, 'Injustice Gods Among Us Ultimate Edition', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110973, 'Injustice: Gods Among Us', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110974, 'Jeopardy!', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110975, 'Joes Diner', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110976, 'JoJos Bizarre Adventure: Eyes of Heaven', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110977, 'Journey: Collectors Edition', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110978, 'J-Stars Victory Vs+', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110979, 'Just Cause 3', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110980, 'Just Cause 3 Collectors Edition', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110981, 'Just Dance 2014', '2013', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110982, 'Just Dance 2014', '', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110983, 'Just Dance 2015', '', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110984, 'Just Dance 2015', '2014', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110985, 'Just Dance 2016', '2015', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110986, 'Just Dance 4', '2012', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110987, 'Kalimba', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110988, 'Kholat', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110989, 'Kill Strain', '2016', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110990, 'Killer Instinct', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110991, 'Killzone: Shadow Fall', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110992, 'Kinect Sports Rivals', '2014', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110993, 'Kings Quest Chapter 1: A Knight to Remember', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110994, 'Kirby & the Rainbow Curse', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110995, 'Knack', '2013', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110996, 'Kung Fu Rabbit', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110997, 'Lara Croft and the Temple of Osiris', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110998, 'Laserlife', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	110999, 'Layers of Fear', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111000, 'Le Tour de France Season 2015', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111001, 'Legend of Kay Anniversary', '2015', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111002, 'LEGO Batman 2: DC Super Heroes', '2013', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111003, 'LEGO Batman 3: Beyond Gotham', '2014', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111004, 'Lego City Undercover', '2013', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111005, 'LEGO Dimensions Starter Pack', '2015', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111006, 'LEGO Jurassic World', '2015', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111007, 'LEGO Marvel Super Heroes', '2013', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111008, 'LEGO Marvels Avengers', '2016', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111009, 'Lego Star Wars: The Force Awakens', '2016', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111010, 'LEGO The Hobbit', '2014', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111011, 'Lego: Marvel Super Heroes', '2013', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111012, 'Lichdom: Battlemage', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111013, 'Life is Strange', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111014, 'Life is Strange - Limited Edition', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111015, 'Life Is Strange: Limited Edition', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111016, 'Little Big Planet 3', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111017, 'Little Inferno', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111018, 'LittleBigPlanet 3', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111019, 'Livelock', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111020, 'Lords of the Fallen', '2014', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111021, 'Lumo', '2016', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111022, 'Mad Max', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111023, 'Madden NFL 13', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111024, 'Madden NFL 15', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111025, 'Madden NFL 16', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111026, 'Madden NFL 17', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111027, 'Madden NFL 25', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111028, 'Madden NFL 25', '', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111029, 'Mafia III', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111030, 'Magic Duels: Origins', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111031, 'Magicka 2', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111032, 'Mario & Sonic at the Sochi 2014 Olympic Winter Games', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111033, 'Mario & Sonic Rio 2016 Olympics', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111034, 'Mario Kart 8', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111035, 'Mario Party 10', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111036, 'Mario Tennis: Ultra Smash', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111037, 'Mario vs. Donkey Kong: Tipping Stars', '', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111038, 'Marvel Avengers: Battle for Earth', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111039, 'Mass Effect 3', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111040, 'Massive Chalice', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111041, 'Max: The Curse of Brotherhood', '2013', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111042, 'Mega Man Legacy Collection', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111043, 'Megadimension Neptunia VII', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111044, 'Mercenary Kings', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111045, 'Metal Gear Solid V Ground Zeroes', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111046, 'Metal Gear Solid V: The Definitive Experience', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111047, 'Metal Gear Solid V: The Phantom Pain', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111048, 'Metal Gear Solid V: The Phantom Pain Collectors Edition', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111049, 'Metro Redux', '2014', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111050, 'Middle-Earth: Shadow of Mordor', '2014', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111051, 'Mighty No. 9', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111052, 'Mighty No. 9', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111053, 'Mighty Switch Force! Hyper Drive Edition', '2012', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111054, 'Minecraft', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111055, 'Minecraft: PlayStation 4 Edition', '2014', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111056, 'Minecraft: Story Mode', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111057, 'Minecraft: Xbox One Edition', '2014', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111058, 'Mini Mario & Friends: Amiibo Challenge', '', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111059, 'Mirrors Edge Catalyst', '2016', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111060, 'Mirrors Edge Catalyst Collectors Edition', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111061, 'Mitsurugi Kamui Hikae', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111062, 'MLB 15: The Show', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111063, 'MLB 16: The Show', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111064, 'Monopoly Family Fun Pack', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111065, 'Monster Hunter 3 Ultimate', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111066, 'Monster Hunter Frontier G', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111067, 'Mortal Kombat X', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111068, 'Mortal Kombat X Kollectors Edition', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111069, 'Mortal Kombat XL', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111070, 'MotoGP 14', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111071, 'MotoGP 15', '2015', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111072, 'Murdered: Soul Suspect', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111073, 'Mutant Mudds Deluxe', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111074, 'MXGP: The Official Motocross Videogame', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111075, 'Mystery Chronicle: One Way Heroics', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111076, 'Nano Assault Neo', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111077, 'Naruto Shippuden: Ultimate Ninja Storm 4', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111078, 'Naruto Shippuden: Ultimate Ninja Storm 4 Collectors Edition', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111079, 'Natural Doctrine', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111080, 'NBA 2K13', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111081, 'NBA 2K14', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111082, 'NBA 2K15', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111083, 'NBA 2K16', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111084, 'NBA 2k17', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111085, 'NBA Live 14', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111086, 'NBA Live 15', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111087, 'NBA Live 16', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111088, 'Need For Speed', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111089, 'Need for Speed Most Wanted', '2013', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111090, 'Need for Speed: Rivals', '2013', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111091, 'NERO: Nothing Ever Remains Obscure', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111092, 'NES Remix', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111093, 'NES Remix 2', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111094, 'NES Remix Pack', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111095, 'Never Alone Kisima Ingitchuna', '2014', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111096, 'Neverwinter', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111097, 'New Super Luigi U', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111098, 'New Super Mario Bros. U', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111099, 'New Super Mario Bros. U + New Super Luigi U', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111100, 'NHL 15', '2014', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111101, 'NHL 16', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111102, 'NieR: Automata', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111103, 'Nights of Azure', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111104, 'Ninja Gaiden 3: Razors Edge', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111105, 'Nintendo Land', '2012', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111106, 'Nitroplus Blasterz: Heroines Infinite Duel', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111107, 'No Mans Sky', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111108, 'Nobunagas Ambition: Sphere of Influence', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111109, 'Nuclear Throne', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111110, 'Octodad: Dadliest Catch', '2014', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111111, 'Oddworld: New n Tasty', '', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111112, 'Oddworld: New n Tasty', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111113, 'Odin Sphere Leifthrasir', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111114, 'Odin Sphere Leifthrasir Storybook Edition', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111115, 'OlliOlli2: Welcome to Olliwood', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111116, 'Omega Quintet', '2015', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111117, 'One Piece: Burning Blood', '2016', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111118, 'One Piece: Pirate Warriors 3', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111119, 'One Piece: Unlimited World Red', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111120, 'Onechanbara Z2: Chaos', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111121, 'Onigiri', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111122, 'Ori and the Blind Forest', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111123, 'Outlast', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111124, 'Overwatch', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111125, 'Oxenfree', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111126, 'P.T.', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111127, 'Pac-Man', '', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111128, 'Pac-Man 256', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111129, 'Pac-Man and the Ghostly Adventures', '2013', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111130, 'Paper Mario: Color Splash', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111131, 'Paragon', '2017', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111132, 'PayDay 2: Crimewave Edition', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111133, 'Peanuts Movie: Snoopys Grand Adventure', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111134, 'Peggle 2', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111135, 'Persona 5', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111136, 'PES 2015', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111137, 'Pier Solar and the Great Architects', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111138, 'Pikmin 3', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111139, 'Pinball FX 2', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111140, 'Pix the Cat', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111141, 'Pixel Slime U', '', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111142, 'PixelJunk Shooter Ultimate', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111143, 'PlanetSide 2', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111144, 'Plants vs Zombies: Garden Warfare 2', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111145, 'Plants vs Zombies: Garden Warfare 2', '', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111146, 'Plants vs. Zombies: Garden Warfare', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111147, 'Plants vs. Zombies: Garden Warfare', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111148, 'Pneuma: Breath of Life', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111149, 'Pokken Tournament', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111150, 'Powerstar Golf', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111151, 'Pro Evolution Soccer 2015', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111152, 'Pro Evolution Soccer 2016', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111153, 'Pro Evolution Soccer 2017', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111154, 'Project CARS', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111155, 'Project CARS', '2013', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111156, 'Project CARS', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111157, 'Project Spark', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111158, 'Project Zero: Maiden of Black Water', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111159, 'Pullblox World', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111160, 'Pure Chess', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111161, 'Pure Pool', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111162, 'Pushmo World', '', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111163, 'Pushmo: World', '', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111164, 'Puyo Puyo Tetris', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111165, 'Quantum Break', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111166, 'Quest of Dungeons', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111167, 'Quest of Dungeons', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111168, 'Rabbids Invasion', '2014', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111169, 'Rabbids Invasion: The Interactive TV Show', '2014', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111170, 'Rabbids Land', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111171, 'Race The Sun', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111172, 'Raiden V', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111173, 'Rainbow Moon', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111174, 'Rare Replay', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111175, 'Ratchet & Clank', '2016', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111176, 'Rayman Legends', '2014', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111177, 'Rayman Legends', '2013', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111178, 'ReCore', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111179, 'Republique', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111180, 'République - Contraband Edition', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111181, 'Resident Evil 4', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111182, 'Resident Evil 5', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111183, 'Resident Evil 6', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111184, 'Resident Evil HD Remaster', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111185, 'Resident Evil: Origins Collection', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111186, 'Resident Evil: Revelations', '2013', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111187, 'Resident Evil: Revelations 2', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111188, 'Resident Evil: Umbrella Corps', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111189, 'Resogun', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111190, 'Ride', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111191, 'Rime', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111192, 'Rise of the Guardians', '2012', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111193, 'Rise of the Tomb Raider', '2015', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111194, 'Rise of the Tomb Raider', '', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111195, 'Risen 3: Titan Lords - Enhanced Edition', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111196, 'Road Not Taken', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111197, 'Road Redemption', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111198, 'Rock Band 4', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111199, 'Rocket League', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111200, 'Rocket League', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111201, 'Rocket League Collectors Edition', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111202, 'Rocksmith', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111203, 'Rocksmith 2014 Edition', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111204, 'Rodea The Sky Soldier', '2015', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111205, 'Rogue Legacy', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111206, 'Rolie Polie Olie 2', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111207, 'Rolie Polie Olie Edge', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111208, 'Rolie,Polie,Olie Legends 2', '', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111209, 'Rolie,Polie,Olie Legends 2', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111210, 'Rollers of the Realm', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111211, 'Romance of the Three Kingdoms 13', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111212, 'Rory McIlroy PGA Tour', '', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111213, 'Rugby World Cup 2015', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111214, 'Runbow Deluxe Edition', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111215, 'Runner2: Future Legend of Rhythm Alien', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111216, 'Ryse: Son of Rome', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111217, 'Saint Seiya: Soldiers’ Soul', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111218, 'Saints Row IV: Re-Elected', '', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111219, 'Saints Row IV: Re-Elected', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111220, 'Saints Row: Gat Out of Hell', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111221, 'Salt and Sanctuary', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111222, 'Samurai Warriors 4', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111223, 'Samurai Warriors 4: Empires', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111224, 'Samurai Warriors 4-II', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111225, 'San Goku Shi 12', '2012', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111226, 'Scalebound', '2017', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111227, 'Scram Kitty and His Buddy on Rails', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111228, 'ScreamRide', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111229, 'Scribblenauts Unlimited', '2012', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111230, 'Scribblenauts Unmasked: A DC Comics Adventure', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111231, 'Sebastien Loeb Rally Evo', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111232, 'Secret Ponchos', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111233, 'Senran Kagura: Estival Versus', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111234, 'Shadow Complex Remastered', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111235, 'Shadow of Mordor: Game of the Year Edition', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111236, 'Shadow of the Beast', '', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111237, 'Shadow Warrior (2013)', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111238, 'Shantae: Riskys Revenge - Directors Cut', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111239, 'Sherlock Holmes: Crimes & Punishments', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111240, 'Sherlock Holmes: Crimes & Punishments', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111241, 'Sherlock Holmes: The Devils Daughter', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111242, 'Shovel Knight', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111243, 'Shovel Knight', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111244, 'SiNG Party', '2012', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111245, 'SingStar: Ultimate Party', '', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111246, 'Skulls of the Shogun: Bone-A-Fide Edition', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111247, 'Skylanders Giants', '2012', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111248, 'Skylanders SuperChargers', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111249, 'Skylanders SWAP Force', '2013', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111250, 'Skylanders Trap Team', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111251, 'Sleeping Dogs: Definitive Edition', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111252, 'SMITE', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111253, 'SMITE', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111254, 'Sniper Elite III', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111255, 'Sniper Elite V2', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111256, 'Snoopys Grand Adventure', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111257, 'SOMA', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111258, 'Song of the Deep', '2016', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111259, 'Sonic & All-Stars Racing Transformed', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111260, 'Sonic Boom: Rise of Lyric', '', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111261, 'Sonic Lost World', '2013', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111262, 'Sound Shapes', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111263, 'Space Engineers', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111264, 'Spelunky', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111265, 'Splatoon', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111266, 'Sportsfriends', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111267, 'Star Fox Guard', '2016', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111268, 'Star Fox Zero', '2015', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111269, 'Star Fox Zero and Star Fox Guard - First Print Edition', '2016', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111270, 'Star Ocean: Integrity and Faithlessness', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111271, 'STAR OCEAN: INTEGRITY AND FAITHLESSNESS LIMITED EDITION', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111272, 'Star Wars Battlefront', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111273, 'Star Wars Battlefront', '2015', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111274, 'STARWHAL', '', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111275, 'State of Decay: Year One Survival Edition', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111276, 'Stealth Inc. 2: A Game of Clones', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111277, 'SteamWorld Dig', '2014', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111278, 'Steins;Gate 0', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111279, 'Stick it to the Man!', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111280, 'Street Fighter V', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111281, 'Strider', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111282, 'Strike Suit Zero: Directors Cut', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111283, 'Sunset Overdrive', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111284, 'Super Mario 3D World', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111285, 'Super Mario Bros. 2: The Lost Levels', '', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111286, 'Super Mario Maker', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111287, 'Super Meat Boy', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111288, 'Super Mega Baseball', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111289, 'Super Mega Baseball: Extra Innings', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111290, 'Super Smash Bros. for Wii U', '2014', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111291, 'Super Time Force', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111292, 'SUPERHOT', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111293, 'Surgeon Simulator Anniversary Edition', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111294, 'Sword Art Online RE: Hollow Fragment', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111295, 'Sword Art Online: Hollow Realization', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111296, 'Sword Art Online: Lost Song', '2015', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111297, 'Tales from the Borderlands', '', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111298, 'Tales from the Borderlands', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111299, 'Tales of Zestiria', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111300, 'Tales of Zestiria Collectors Edition', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111301, 'Tank! Tank! Tank!', '2012', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111302, 'Tearaway Unfolded', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111303, 'Tearaway Unfolded Crafted Edition', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111304, 'Teenage Mutant Ninja Turtles: Mutants in Manhattan', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111305, 'Tekken 7', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111306, 'Tekken Tag Tournament 2: Wii U Edition', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111307, 'Terraria', '', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111308, 'Terraria', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111309, 'Teslagrad', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111310, 'Tetris Ultimate', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111311, 'The Amazing Spider-Man', '2013', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111312, 'The Amazing Spiderman 2', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111313, 'The Amazing Spider-Man 2', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111314, 'The Banner Saga 2', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111315, 'The Binding of Isaac: Rebirth', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111316, 'The Binding of Isaac: Rebirth', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111317, 'The Book of Unwritten Tales 2', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111318, 'The Cave', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111319, 'The Crew', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111320, 'The Crew: Wild Run', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111321, 'The Croods: Prehistoric Party!', '', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111322, 'The Deer God', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111323, 'The Elder Scrolls Online', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111324, 'The Elder Scrolls Online Tamriel Unlimited', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111325, 'The Elder Scrolls Online Tamriel Unlimited Imperial Edition', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111326, 'The Elder Scrolls V: Skyrim Special Edition', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111327, 'The Escapists', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111328, 'The Evil Within', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111329, 'The Evil Within - Limited Edition', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111330, 'The Evil Within Limited Edition', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111331, 'The Fall', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111332, 'The Four Kings Casino and Slots', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111333, 'The Golf Club', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111334, 'The Incredible Adventures of Van Helsing', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111335, 'The Jackbox Party Pack', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111336, 'The King of Fighters XIV', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111337, 'The Last Guardian', '', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111338, 'The Last of Us Remastered', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111339, 'The Legend of Zelda: Breath of the Wild', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111340, 'The Legend of Zelda: The Wind Waker HD', '2013', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111341, 'The Legend of Zelda: The Wind Waker HD Limited Edition', '2013', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111342, 'The Legend of Zelda: Twilight Princess HD', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111343, 'The Legend of Zelda: Twilight Princess HD - Limited Edition', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111344, 'The LEGO Movie Videogame', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111345, 'The Long Dark', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111346, 'The Order: 1886', '2015', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111347, 'The Peppercorn Family:Party', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111348, 'The Peppercorn Family:The Interactive TV Show', '2016', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111349, 'The Pinball Arcade', '2013', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111350, 'The Smurfs 2', '', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111351, 'The Swapper', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111352, 'The Talos Principle', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111353, 'The Talos Principle: Deluxe Edition', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111354, 'The Technomancer', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111355, 'The Tomorrow Children', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111356, 'The Unfinished Swan', '2014', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111357, 'The Vanishing of Ethan Carter', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111358, 'The Walking Dead: Michonne', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111359, 'The Walking Dead: Season 2', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111360, 'The Walking Dead: Season Two', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111361, 'The Walking Dead: Survival Instinct', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111362, 'The Walking Dead: The Complete First Season', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111363, 'The Witch and the Hundred Knight: Revival Edition', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111364, 'The Witcher 3 Game of the Year Edition', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111365, 'The Witcher 3: Hearts of Stone', '', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111366, 'The Witcher 3: Hearts of Stone', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111367, 'The Witcher 3: Wild Hunt', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111368, 'The Witcher 3: Wild Hunt Collectors Edition', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111369, 'The Witcher: Wild Hunt Collectors Edition', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111370, 'The Witness', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111371, 'The Wolf Among Us', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111372, 'The Wonderful 101', '2013', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111373, 'Thief', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111374, 'This War of Mine: The Little Ones', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111375, 'Threes', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111376, 'Titan Souls', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111377, 'Titanfall', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111378, 'Titanfall 2', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111379, 'TNT Racers - Nitro Machines Edition', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111380, 'Toki Tori 2', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111381, 'Toki Tori 2+', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111382, 'Tokyo Mirage Sessions #FE', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111383, 'Tom Clancys Ghost Recon: Wildlands', '', 'RP - Rating Pending',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111384, 'Tom Clancys Rainbow Six Siege', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111385, 'Tom Clancys Splinter Cell: Blacklist', '2013', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111386, 'Tom Clancys The Division', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111387, 'Tom Clancys: The Division', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111388, 'Tom Clancys: The Division Collectors Edition', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111389, 'Tomb Raider: Definitive Edition', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111390, 'Tony Hawks Pro Skater 5', '', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111391, 'Tony Hawks Pro Skater 5', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111392, 'Toren', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111393, 'Touhou Genso Rondo Bullet Bullet', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111394, 'Touhou Genso Rondo: Bullet Ballet', '2016', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111395, 'Toukiden: Kiwami', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111396, 'Tour de France 2015', '2015', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111397, 'Tour de France 2016', '2016', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111398, 'Tower of Guns', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111399, 'Tower of Guns Steelbook Limited Edition', '2015', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111400, 'TowerFall Ascension', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111401, 'Toy Odyssey: The Lost and The Found', '2016', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111402, 'Trackmania Turbo', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111403, 'Transformers Prime: The Game', '2012', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111404, 'Transformers: Devastation', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111405, 'Transformers: Rise of the Dark Spark', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111406, 'Transistor', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111407, 'Trials Fusion', '2014', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111408, 'Trine 2: Director’s Cut', '2012', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111409, 'Tropico 5', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111410, 'UEFA EURO 2016: Pro Evolution Soccer', '2016', 'EC - Early Childhood',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111411, 'Ultra Street Fighter IV', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111412, 'Uncharted 4: A Thiefs End', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111413, 'Uncharted 4: A Thiefs End Collectors Edition', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111414, 'Uncharted Waters Online', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111415, 'Uncharted: The Nathan Drake Collection', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111416, 'Unmechanical: Extended', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111417, 'Unravel', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111418, 'Unravel', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111419, 'Until Dawn', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111420, 'Until Dawn: Extended Edition', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111421, 'Until Dawn: Steelbook Edition', '2015', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111422, 'Valentino Rossi The Game', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111423, 'Valiant Hearts: The Great War', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111424, 'Valkyria Chronicles Remastered', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111425, 'Valkyria Chronicles Remastered (Europa Edition)', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111426, 'Velocity 2X', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111427, 'Verdun', '2016', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111428, 'Volgarr the Viking', '2014', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111429, 'Volume', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111430, 'War Thunder', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111431, 'Warframe', '2014', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111432, 'Warframe', '2013', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111433, 'Warriors Orochi 3: Hyper', '2012', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111434, 'Watch Dogs', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111435, 'We Happy Few', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111436, 'Wheel of Fortune', '2012', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111437, 'Wii Fit U', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111438, 'Wii Party U', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111439, 'Wii Sports Club', '2014', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111440, 'Wipeout 3', '2012', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111441, 'Wolfenstein: The New Order', '2014', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111442, 'Wolfenstein: The Old Blood', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111443, 'World of Tanks', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111444, 'Worms Battlegrounds', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111445, 'WRC 6', '2016', 'EC - Early Childhood',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111446, 'WWE 2K15', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111447, 'WWE 2K16', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111448, 'WWE 2K17', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111449, 'WWE 2K17 NXT Edition', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111450, 'XCOM 2', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111451, 'Xenoblade Chronicles X', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111452, 'Xenoblade Chronicles X - Limited Edition', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111453, 'Xenoblade Chronicles X Special Edition', '2015', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111454, 'Yoshis Woolly World', '2015', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111455, 'Your Shape: Fitness Evolved 2013', '2012', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111456, 'Yu-Gi-Oh! Legacy of the Duelist', '', '',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111457, 'Zelda Twilight Princess HD Special Edition Prices', '2016', 'T - Teen',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111458, 'ZEN Pinball 2', '2013', 'E10+ - Everyone 10+',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111459, 'Zenith', '2016', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111460, 'ZombiU', '2012', 'M - Mature',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111461, 'Zoo Tycoon', '2013', 'E - Everyone',0	);
INSERT INTO TITLE (	Title_Id, Game_Name, Release_Year, Title_Age_Rating, Publisher_Id	) VALUES (	111462, 'Zumba Fitness World Party', '2013', 'E - Everyone',0	);
