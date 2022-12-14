-- This file is to bootstrap a database for the CS3200 project. 

create database NUHire;

grant all privileges on NUHire.* to 'webapp'@'%';
flush privileges;

use NUHire;

-- TABLE CREATION

drop table if exists College;

create table College (
	CollegeID INT,
	Name VARCHAR(13),
	primary key (CollegeID)
);

drop table if exists Advisor;

create table Advisor (
	AdvisorID INT,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	Email VARCHAR(50),
	PhoneNumber VARCHAR(50),
	primary key (AdvisorID)
);

drop table if exists Company;

create table Company (
	TickerSymbol VARCHAR(4),
	Name VARCHAR(50),
	AdvisorID INT,
	primary key (TickerSymbol),
	foreign key (AdvisorID) references Advisor(AdvisorID)
);

drop table if exists Recruiter;

create table Recruiter (
	EmployeeID INT,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	Email VARCHAR(50),
	PhoneNumber VARCHAR(50),
	TickerSymbol VARCHAR(4),
	primary key (EmployeeID),
	foreign key (TickerSymbol) references Company(TickerSymbol)
);

drop table if exists Term;

create table Term (
	Season VARCHAR(6),
	constraint checkSeason check (Season in ('Fall', 'Spring')),
	Year VARCHAR(4),
	primary key (Season, Year)
);

drop table if exists PositionType;

create table PositionType (
	PositionID INT,
	Type VARCHAR(10),
	constraint checkType check (Type in ('Co-op', 'Internship', 'Full-time', 'Part-time')),
	primary key (PositionID)
);

drop table if exists CoopClass;

create table CoopClass (
	CRN INT,
	CollegeID INT,
	AdvisorID INT,
	primary key (CRN),
	foreign key (CollegeID) references College(CollegeID),
	foreign key (AdvisorID) references Advisor(AdvisorID)
);

drop table if exists Student;

create table Student (
	NUID INT,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	Email VARCHAR(50),
	PhoneNumber VARCHAR(50),
	GPA DECIMAL(3,2),
	Status VARCHAR(19),
	Grade DECIMAL(5,2),
	CollegeID INT,
	CRN INT,
	primary key (NUID),
	foreign key (CollegeID) references College(CollegeID),
	foreign key (CRN) references CoopClass(CRN)
);

drop table if exists Job;

create table Job (
	JobID INT,
	Title VARCHAR(50),
	HourlyWage DECIMAL(4,2),
	Address VARCHAR(50),
	City VARCHAR(50),
	State VARCHAR(50),
	Country VARCHAR(50),
	ZIPCode INT,
	EmployeeID INT,
	Season VARCHAR(6),
	Year VARCHAR(50),
	PositionID INT,
    primary key (JobID),
    foreign key (EmployeeID) references Recruiter(EmployeeID),
    foreign key (Season, Year) references Term(Season, Year),
    foreign key (PositionID) references PositionType(PositionID)
);

drop table if exists Reference;

create table Reference (
	ReferenceID INT,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	Email VARCHAR(50),
	PhoneNumber VARCHAR(50),
	NUID INT,
	primary key (ReferenceID),
	foreign key (NUID) references Student(NUID)
);

drop table if exists PreviousCoop;

create table PreviousCoop (
	Title VARCHAR(50),
	HourlyWage DECIMAL(4,2),
	NUID INT,
	TickerSymbol VARCHAR(50),
	primary key (NUID, TickerSymbol),
	foreign key (NUID) references Student(NUID),
	foreign key (TickerSymbol) references Company(TickerSymbol)
);

drop table if exists Application;

create table Application (
	CoverLetter VARCHAR(1000),
	Resume VARCHAR(1000),
	Transcript VARCHAR(1000),
	Status VARCHAR(9),
	NUID INT,
	JobID INT,
	primary key (NUID, JobID),
	foreign key (NUID) references Student(NUID),
	foreign key (JobID) references Job(JobID)
);


-- SAMPLE DATA INSERT STATEMENTS

-- College sample data
insert into College (CollegeID, Name) values (1, 'Khoury');
insert into College (CollegeID, Name) values (2, 'D''Amore-McKim');
insert into College (CollegeID, Name) values (3, 'Bouve');
insert into College (CollegeID, Name) values (4, 'CSSH');
insert into College (CollegeID, Name) values (5, 'COE');

-- Advisor sample data
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (1, 'Shellysheldon', 'Thornber', 'sthornber0@scribd.com', '451-865-3968');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (2, 'Theressa', 'Weymouth', 'tweymouth1@ovh.net', '128-858-6144');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (3, 'Chloette', 'Hambleton', 'chambleton2@com.com', '578-289-1450');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (4, 'Wendeline', 'Klima', 'wklima3@yahoo.com', '901-698-4569');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (5, 'Coreen', 'Nott', 'cnott4@over-blog.com', '550-371-1857');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (6, 'Piper', 'Van der Daal', 'pvanderdaal5@nature.com', '510-214-4845');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (7, 'Lorraine', 'Livingstone', 'llivingstone6@freewebs.com', '427-931-8180');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (8, 'Dottie', 'Gianasi', 'dgianasi7@elpais.com', '867-496-1860');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (9, 'Willetta', 'Yakov', 'wyakov8@youtube.com', '815-751-5421');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (10, 'Ardyce', 'Phripp', 'aphripp9@elpais.com', '542-619-1076');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (11, 'Blondell', 'Silly', 'bsillya@w3.org', '481-942-7031');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (12, 'Addy', 'Ellerington', 'aelleringtonb@addtoany.com', '885-996-9887');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (13, 'Ximenez', 'Francillo', 'xfrancilloc@bloglines.com', '216-948-1661');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (14, 'Austin', 'Gellert', 'agellertd@shop-pro.jp', '856-236-1035');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (15, 'Goldia', 'Von Der Empten', 'gvonderemptene@paypal.com', '960-874-0996');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (16, 'Gerardo', 'Poznanski', 'gpoznanskif@merriam-webster.com', '151-657-0868');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (17, 'Dasha', 'Feltoe', 'dfeltoeg@japanpost.jp', '549-259-7331');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (18, 'Hermine', 'Haswall', 'hhaswallh@soup.io', '517-151-6161');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (19, 'Curtis', 'Foggarty', 'cfoggartyi@barnesandnoble.com', '341-583-7650');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (20, 'Liza', 'Laytham', 'llaythamj@utexas.edu', '602-941-4625');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (21, 'Dill', 'Phizakarley', 'dphizakarleyk@yandex.ru', '148-767-0403');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (22, 'Silvain', 'Claige', 'sclaigel@usda.gov', '701-360-4794');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (23, 'Corine', 'Veck', 'cveckm@jugem.jp', '293-843-7941');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (24, 'Annamaria', 'Cottier', 'acottiern@geocities.com', '306-380-4430');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (25, 'Brok', 'Woodsford', 'bwoodsfordo@google.co.jp', '380-628-8220');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (26, 'Seamus', 'Goodbarr', 'sgoodbarrp@cyberchimps.com', '908-499-5920');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (27, 'Linell', 'Oldacre', 'loldacreq@facebook.com', '704-264-8012');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (28, 'Augustina', 'Laville', 'alaviller@xinhuanet.com', '660-723-7181');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (29, 'Denny', 'Adin', 'dadins@census.gov', '202-631-9004');
insert into Advisor (AdvisorID, FirstName, LastName, Email, PhoneNumber) values (30, 'Olwen', 'Sample', 'osamplet@businessinsider.com', '864-933-3445');

-- Company sample data
insert into Company (TickerSymbol, Name, AdvisorID) values ('LND', 'Haley Inc', 9);
insert into Company (TickerSymbol, Name, AdvisorID) values ('HUY', 'Kozey Group', 13);
insert into Company (TickerSymbol, Name, AdvisorID) values ('NCL', 'Kozey, Bayer and Schultz', 23);
insert into Company (TickerSymbol, Name, AdvisorID) values ('GJR', 'Franecki-Nolan', 18);
insert into Company (TickerSymbol, Name, AdvisorID) values ('OUK', 'Ullrich-Cronin', 19);
insert into Company (TickerSymbol, Name, AdvisorID) values ('AAJ', 'Waters, Weimann and Stiedemann', 28);
insert into Company (TickerSymbol, Name, AdvisorID) values ('CHN', 'Stamm, Murray and Schiller', 14);
insert into Company (TickerSymbol, Name, AdvisorID) values ('CBM', 'Nitzsche Inc', 25);
insert into Company (TickerSymbol, Name, AdvisorID) values ('THF', 'Marks, Bogisich and Douglas', 29);
insert into Company (TickerSymbol, Name, AdvisorID) values ('MBH', 'McClure-Douglas', 17);
insert into Company (TickerSymbol, Name, AdvisorID) values ('GAL', 'Mann LLC', 21);
insert into Company (TickerSymbol, Name, AdvisorID) values ('KEZ', 'Yost, Schmidt and Reilly', 17);
insert into Company (TickerSymbol, Name, AdvisorID) values ('ANC', 'Stoltenberg and Sons', 6);
insert into Company (TickerSymbol, Name, AdvisorID) values ('YEY', 'Ruecker, Padberg and Osinski', 10);
insert into Company (TickerSymbol, Name, AdvisorID) values ('ABL', 'Batz and Sons', 10);
insert into Company (TickerSymbol, Name, AdvisorID) values ('SLN', 'O''Conner-Conn', 23);
insert into Company (TickerSymbol, Name, AdvisorID) values ('KUT', 'Boyer-Boyle', 21);
insert into Company (TickerSymbol, Name, AdvisorID) values ('PTJ', 'Halvorson, Friesen and Douglas', 29);
insert into Company (TickerSymbol, Name, AdvisorID) values ('BQA', 'Roberts-Rohan', 23);
insert into Company (TickerSymbol, Name, AdvisorID) values ('MHN', 'Blick LLC', 2);
insert into Company (TickerSymbol, Name, AdvisorID) values ('SCW', 'Lind, Kub and Mueller', 21);
insert into Company (TickerSymbol, Name, AdvisorID) values ('EED', 'Gusikowski-Bradtke', 12);
insert into Company (TickerSymbol, Name, AdvisorID) values ('CWS', 'Runolfsson-Lesch', 15);
insert into Company (TickerSymbol, Name, AdvisorID) values ('GLR', 'Kris, Ritchie and Runolfsson', 26);
insert into Company (TickerSymbol, Name, AdvisorID) values ('HEK', 'Kemmer LLC', 13);
insert into Company (TickerSymbol, Name, AdvisorID) values ('CMP', 'Kirlin Inc', 3);
insert into Company (TickerSymbol, Name, AdvisorID) values ('SBX', 'Stehr-Kautzer', 7);
insert into Company (TickerSymbol, Name, AdvisorID) values ('MGD', 'Ebert Group', 25);
insert into Company (TickerSymbol, Name, AdvisorID) values ('SIL', 'Hyatt LLC', 23);
insert into Company (TickerSymbol, Name, AdvisorID) values ('TNN', 'Heathcote, Hyatt and Jacobi', 2);
insert into Company (TickerSymbol, Name, AdvisorID) values ('JAM', 'Gottlieb and Sons', 11);
insert into Company (TickerSymbol, Name, AdvisorID) values ('LLU', 'Rodriguez, Haag and Hahn', 3);
insert into Company (TickerSymbol, Name, AdvisorID) values ('EBW', 'Emard Group', 4);
insert into Company (TickerSymbol, Name, AdvisorID) values ('CYM', 'Kirlin Inc', 2);
insert into Company (TickerSymbol, Name, AdvisorID) values ('HNI', 'Ortiz, Franecki and Greenholt', 1);
insert into Company (TickerSymbol, Name, AdvisorID) values ('WSM', 'Blick Group', 4);
insert into Company (TickerSymbol, Name, AdvisorID) values ('BKR', 'Okuneva, Wintheiser and Bechtelar', 26);
insert into Company (TickerSymbol, Name, AdvisorID) values ('KKR', 'Orn-Effertz', 25);
insert into Company (TickerSymbol, Name, AdvisorID) values ('VOI', 'Medhurst LLC', 12);
insert into Company (TickerSymbol, Name, AdvisorID) values ('YYL', 'Dickinson Group', 4);
insert into Company (TickerSymbol, Name, AdvisorID) values ('ULD', 'Walter Group', 3);
insert into Company (TickerSymbol, Name, AdvisorID) values ('YAH', 'Gottlieb-Leannon', 7);
insert into Company (TickerSymbol, Name, AdvisorID) values ('UME', 'Goldner Inc', 10);
insert into Company (TickerSymbol, Name, AdvisorID) values ('KRP', 'Prohaska, Mosciski and Wilderman', 18);
insert into Company (TickerSymbol, Name, AdvisorID) values ('KZC', 'Homenick, Mitchell and Weber', 27);
insert into Company (TickerSymbol, Name, AdvisorID) values ('BTA', 'Kertzmann, White and Koepp', 22);
insert into Company (TickerSymbol, Name, AdvisorID) values ('QOJ', 'Spinka-Wiegand', 27);
insert into Company (TickerSymbol, Name, AdvisorID) values ('AQP', 'Mraz-Farrell', 19);
insert into Company (TickerSymbol, Name, AdvisorID) values ('COK', 'Schaden Inc', 23);
insert into Company (TickerSymbol, Name, AdvisorID) values ('DCI', 'Zulauf, Bartell and Homenick', 29);
insert into Company (TickerSymbol, Name, AdvisorID) values ('NMG', 'Sauer, Barrows and O''Hara', 22);
insert into Company (TickerSymbol, Name, AdvisorID) values ('FMS', 'Tillman LLC', 12);
insert into Company (TickerSymbol, Name, AdvisorID) values ('CSO', 'Bauch-Rath', 20);
insert into Company (TickerSymbol, Name, AdvisorID) values ('UTE', 'Kuhn-Veum', 25);
insert into Company (TickerSymbol, Name, AdvisorID) values ('MHV', 'Schamberger-Hudson', 23);
insert into Company (TickerSymbol, Name, AdvisorID) values ('PKX', 'Fahey Inc', 11);
insert into Company (TickerSymbol, Name, AdvisorID) values ('KMG', 'Bogisich-Kuphal', 2);
insert into Company (TickerSymbol, Name, AdvisorID) values ('ISB', 'Lowe, Greenholt and Hartmann', 9);
insert into Company (TickerSymbol, Name, AdvisorID) values ('KTP', 'Rau Group', 13);
insert into Company (TickerSymbol, Name, AdvisorID) values ('YVV', 'Dickens, Ondricka and Schaden', 14);
insert into Company (TickerSymbol, Name, AdvisorID) values ('GEM', 'Pagac, Ziemann and Greenholt', 15);
insert into Company (TickerSymbol, Name, AdvisorID) values ('LEL', 'Zboncak, Volkman and Sporer', 12);
insert into Company (TickerSymbol, Name, AdvisorID) values ('UGB', 'Bins, Ernser and Purdy', 15);
insert into Company (TickerSymbol, Name, AdvisorID) values ('BIM', 'Roberts, Jakubowski and Grimes', 20);
insert into Company (TickerSymbol, Name, AdvisorID) values ('MCD', 'Gerhold LLC', 22);
insert into Company (TickerSymbol, Name, AdvisorID) values ('NCN', 'Bechtelar Group', 4);
insert into Company (TickerSymbol, Name, AdvisorID) values ('RGI', 'Zboncak, Volkman and Feest', 1);
insert into Company (TickerSymbol, Name, AdvisorID) values ('MAA', 'Lindgren-Marks', 5);
insert into Company (TickerSymbol, Name, AdvisorID) values ('TYS', 'Ryan, Waters and Renner', 26);
insert into Company (TickerSymbol, Name, AdvisorID) values ('SBK', 'Boyer Group', 16);
insert into Company (TickerSymbol, Name, AdvisorID) values ('ATS', 'Collier-Cummings', 22);
insert into Company (TickerSymbol, Name, AdvisorID) values ('JNX', 'Bosco Inc', 9);
insert into Company (TickerSymbol, Name, AdvisorID) values ('WON', 'Stoltenberg, Dicki and Steuber', 14);
insert into Company (TickerSymbol, Name, AdvisorID) values ('TSJ', 'Hermiston and Sons', 10);
insert into Company (TickerSymbol, Name, AdvisorID) values ('BXT', 'DuBuque LLC', 5);
insert into Company (TickerSymbol, Name, AdvisorID) values ('PEY', 'Lang, McLaughlin and Stroman', 12);
insert into Company (TickerSymbol, Name, AdvisorID) values ('YXK', 'Beer-Price', 13);
insert into Company (TickerSymbol, Name, AdvisorID) values ('GMA', 'Lind Group', 28);
insert into Company (TickerSymbol, Name, AdvisorID) values ('YGJ', 'Cummerata, Jaskolski and Bechtelar', 6);
insert into Company (TickerSymbol, Name, AdvisorID) values ('MEM', 'Sporer-Collins', 28);

-- Recruiter sample data
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (1, 'Pris', 'Heyward', 'pheyward0@businessweek.com', '960-105-5779', 'ULD');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (2, 'Armin', 'Seccombe', 'aseccombe1@issuu.com', '650-744-5309', 'KTP');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (3, 'Salvatore', 'Cradduck', 'scradduck2@businessweek.com', '273-815-8462', 'NMG');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (4, 'Eolanda', 'Kirwan', 'ekirwan3@chronoengine.com', '885-135-6600', 'GJR');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (5, 'Leroy', 'Brazenor', 'lbrazenor4@123-reg.co.uk', '680-253-9723', 'QOJ');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (6, 'Lacee', 'Yakovliv', 'lyakovliv5@abc.net.au', '593-719-6225', 'KEZ');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (7, 'Gil', 'Sowray', 'gsowray6@ed.gov', '734-991-2999', 'AAJ');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (8, 'Bette', 'Alwell', 'balwell7@ezinearticles.com', '983-716-2724', 'BQA');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (9, 'Merrel', 'Farbrace', 'mfarbrace8@dedecms.com', '233-921-7644', 'KTP');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (10, 'Pierrette', 'Wills', 'pwills9@hexun.com', '336-219-9354', 'SCW');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (11, 'Odelle', 'O''Sherrin', 'oosherrina@diigo.com', '108-189-3547', 'UTE');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (12, 'Elsworth', 'Cutill', 'ecutillb@ehow.com', '735-363-7825', 'AQP');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (13, 'Marcella', 'Stitfall', 'mstitfallc@cnbc.com', '784-525-6671', 'SLN');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (14, 'Britta', 'Arrigo', 'barrigod@upenn.edu', '598-131-7635', 'TNN');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (15, 'Ronny', 'Sykora', 'rsykorae@elegantthemes.com', '574-533-2805', 'MHN');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (16, 'Becca', 'Dillaway', 'bdillawayf@bandcamp.com', '416-539-4653', 'JAM');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (17, 'Sinclare', 'Hoult', 'shoultg@goodreads.com', '532-646-9426', 'BXT');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (18, 'Delcina', 'O''Hear', 'dohearh@booking.com', '850-118-0661', 'KRP');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (19, 'Brandon', 'Trynor', 'btrynori@vinaora.com', '815-488-9967', 'ANC');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (20, 'Barrie', 'Inchley', 'binchleyj@twitpic.com', '276-990-2691', 'CBM');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (21, 'Edward', 'Danielczyk', 'edanielczykk@comcast.net', '802-636-9494', 'ABL');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (22, 'Jessie', 'Dixsee', 'jdixseel@so-net.ne.jp', '420-384-7934', 'ABL');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (23, 'Franklyn', 'Delacourt', 'fdelacourtm@dot.gov', '858-945-0635', 'CSO');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (24, 'Silvester', 'Presser', 'spressern@fotki.com', '399-831-9020', 'NMG');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (25, 'Wilma', 'Shewen', 'wsheweno@de.vu', '592-449-1245', 'BQA');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (26, 'Berta', 'Nenci', 'bnencip@icio.us', '193-460-7710', 'KKR');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (27, 'Eldon', 'Etches', 'eetchesq@gov.uk', '759-747-6760', 'GLR');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (28, 'Israel', 'Alelsandrovich', 'ialelsandrovichr@oracle.com', '488-452-4281', 'COK');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (29, 'Hershel', 'Gillbee', 'hgillbees@over-blog.com', '466-976-4963', 'PEY');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (30, 'Tatum', 'Binne', 'tbinnet@unicef.org', '159-888-2938', 'BQA');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (31, 'Normie', 'Pinchbeck', 'npinchbecku@themeforest.net', '805-733-4870', 'YAH');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (32, 'Forbes', 'Limprecht', 'flimprechtv@csmonitor.com', '558-834-4950', 'YAH');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (33, 'Jemie', 'Dagger', 'jdaggerw@themeforest.net', '731-940-8243', 'YAH');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (34, 'Brandais', 'Thornton-Dewhirst', 'bthorntondewhirstx@sfgate.com', '635-325-3409', 'GJR');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (35, 'Leola', 'Castleton', 'lcastletony@ebay.co.uk', '742-681-7157', 'YXK');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (36, 'Emmalyn', 'Yerlett', 'eyerlettz@hhs.gov', '617-377-9320', 'PTJ');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (37, 'Dukie', 'Bucknall', 'dbucknall10@newsvine.com', '505-821-4398', 'BXT');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (38, 'Isa', 'Lohmeyer', 'ilohmeyer11@timesonline.co.uk', '606-976-7045', 'LEL');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (39, 'Steward', 'Wetton', 'swetton12@1688.com', '707-873-1038', 'PKX');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (40, 'Dun', 'Jebb', 'djebb13@redcross.org', '213-654-0628', 'TSJ');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (41, 'Maximilien', 'Paddy', 'mpaddy14@so-net.ne.jp', '745-368-9638', 'YAH');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (42, 'Berk', 'Dumberrill', 'bdumberrill15@netlog.com', '104-711-0163', 'NCL');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (43, 'Berkie', 'Fetherstone', 'bfetherstone16@tinyurl.com', '859-302-8072', 'GMA');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (44, 'Wileen', 'McBayne', 'wmcbayne17@elegantthemes.com', '656-138-3090', 'HNI');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (45, 'Darby', 'Peaple', 'dpeaple18@ihg.com', '651-787-6388', 'GJR');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (46, 'Huey', 'Barlie', 'hbarlie19@disqus.com', '838-835-7225', 'GAL');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (47, 'Kipper', 'Lung', 'klung1a@china.com.cn', '924-981-6509', 'QOJ');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (48, 'Rogers', 'Filippi', 'rfilippi1b@hao123.com', '233-802-2934', 'PEY');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (49, 'Gwyn', 'Kearns', 'gkearns1c@livejournal.com', '582-218-4705', 'KEZ');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (50, 'Ray', 'Sykora', 'rsykora1d@fema.gov', '352-997-7987', 'WON');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (51, 'Kaleena', 'Merrywether', 'kmerrywether1e@java.com', '929-833-0520', 'UTE');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (52, 'Hersh', 'Martel', 'hmartel1f@discuz.net', '838-106-7562', 'LEL');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (53, 'Tawsha', 'Macbeth', 'tmacbeth1g@cbsnews.com', '737-756-4139', 'YAH');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (54, 'Rani', 'Cornall', 'rcornall1h@ifeng.com', '189-433-0278', 'HNI');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (55, 'Onida', 'Braben', 'obraben1i@vistaprint.com', '789-133-3464', 'HEK');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (56, 'Roselia', 'Hartless', 'rhartless1j@wunderground.com', '193-741-2706', 'KEZ');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (57, 'Ericka', 'Noods', 'enoods1k@jigsy.com', '274-625-5290', 'YXK');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (58, 'Colet', 'Lyven', 'clyven1l@ifeng.com', '587-270-8779', 'HEK');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (59, 'Huntley', 'Bridger', 'hbridger1m@example.com', '830-659-3874', 'KUT');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (60, 'Rodi', 'Kornas', 'rkornas1n@acquirethisname.com', '233-654-2308', 'UGB');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (61, 'Myrna', 'Torrese', 'mtorrese1o@gov.uk', '501-912-7466', 'EED');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (62, 'Bentley', 'Heistermann', 'bheistermann1p@prweb.com', '406-150-7542', 'YXK');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (63, 'Jameson', 'Emburey', 'jemburey1q@vkontakte.ru', '639-541-4165', 'TSJ');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (64, 'Jean', 'Capper', 'jcapper1r@typepad.com', '505-339-4396', 'LND');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (65, 'Eliot', 'Brakewell', 'ebrakewell1s@globo.com', '805-415-0369', 'MBH');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (66, 'Willey', 'Idell', 'widell1t@dropbox.com', '774-692-8233', 'AAJ');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (67, 'Vasili', 'Fenge', 'vfenge1u@symantec.com', '900-656-6322', 'CMP');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (68, 'Brent', 'State', 'bstate1v@prnewswire.com', '673-469-7334', 'YEY');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (69, 'Sanderson', 'Farland', 'sfarland1w@cnet.com', '334-968-4394', 'TSJ');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (70, 'Caesar', 'Broxton', 'cbroxton1x@newyorker.com', '616-918-5988', 'CBM');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (71, 'Dinnie', 'Dowry', 'ddowry1y@yelp.com', '824-944-2081', 'FMS');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (72, 'Ferguson', 'Dowle', 'fdowle1z@google.cn', '116-351-1106', 'NMG');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (73, 'Silvanus', 'Goble', 'sgoble20@reference.com', '603-424-8055', 'PKX');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (74, 'Shelli', 'Springham', 'sspringham21@wiley.com', '340-881-9453', 'DCI');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (75, 'Port', 'McPeake', 'pmcpeake22@google.fr', '735-401-6889', 'YEY');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (76, 'Filia', 'Joselin', 'fjoselin23@mtv.com', '404-125-2469', 'LND');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (77, 'Cassie', 'Trapp', 'ctrapp24@boston.com', '499-724-3214', 'PEY');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (78, 'Opalina', 'McAlpine', 'omcalpine25@wp.com', '662-414-9972', 'KKR');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (79, 'Tammi', 'Andover', 'tandover26@quantcast.com', '222-737-3091', 'SBK');
insert into Recruiter (EmployeeID, FirstName, LastName, Email, PhoneNumber, TickerSymbol) values (80, 'Mal', 'Broek', 'mbroek27@statcounter.com', '267-100-3462', 'GJR');

-- Term sample data
insert into Term (Season, Year) values ('Fall', 2020);
insert into Term (Season, Year) values ('Spring', 2020);
insert into Term (Season, Year) values ('Fall', 2021);
insert into Term (Season, Year) values ('Spring', 2021);
insert into Term (Season, Year) values ('Fall', 2022);
insert into Term (Season, Year) values ('Spring', 2022);
insert into Term (Season, Year) values ('Fall', 2023);
insert into Term (Season, Year) values ('Spring', 2023);

-- PositionType sample data
insert into PositionType (PositionID, Type) values (1, 'Co-op');
insert into PositionType (PositionID, Type) values (2, 'Full-time');
insert into PositionType (PositionID, Type) values (3, 'Part-time');
insert into PositionType (PositionID, Type) values (4, 'Internship');

-- CoopClass sample data
insert into CoopClass (CRN, CollegeID, AdvisorID) values (1, 3, 11);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (2, 3, 27);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (3, 4, 1);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (4, 2, 19);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (5, 4, 27);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (6, 2, 5);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (7, 1, 15);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (8, 2, 17);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (9, 3, 3);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (10, 2, 30);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (11, 3, 2);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (12, 4, 27);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (13, 5, 13);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (14, 3, 7);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (15, 2, 11);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (16, 5, 28);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (17, 5, 4);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (18, 5, 24);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (19, 5, 19);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (20, 4, 6);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (21, 3, 16);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (22, 4, 28);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (23, 1, 20);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (24, 5, 10);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (25, 1, 29);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (26, 4, 20);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (27, 2, 11);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (28, 1, 5);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (29, 1, 2);
insert into CoopClass (CRN, CollegeID, AdvisorID) values (30, 5, 9);

-- Student sample data
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (1, 'Eldon', 'Wormstone', 'ewormstone0@springer.com', '124-153-4437', 2.1, 'Not Searching', 16.46, 4, 1);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (2, 'Wendall', 'Bootyman', 'wbootyman1@google.pl', '713-690-3963', 1.39, 'Searching', 60.22, 4, 3);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (3, 'Manny', 'Robinett', 'mrobinett2@flickr.com', '318-206-4552', 0.78, 'Searching', 65.92, 2, 19);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (4, 'Vernon', 'Dudman', 'vdudman3@deviantart.com', '266-263-8960', 3.99, 'Not Searching', 6.89, 4, 18);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (5, 'Jacqueline', 'Doldon', 'jdoldon4@people.com.cn', '429-924-9351', 3.58, 'Not Searching', 60.66, 1, 10);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (6, 'Rip', 'Beckham', 'rbeckham5@mail.ru', '607-178-0196', 1.79, 'Searching', 97.34, 2, 30);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (7, 'Gray', 'Mityushkin', 'gmityushkin6@furl.net', '900-219-7009', 2.94, 'Searching', 75.63, 2, 17);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (8, 'Bastian', 'Prantoni', 'bprantoni7@stumbleupon.com', '308-310-2932', 1.47, 'Searching', 60.43, 1, 11);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (9, 'Addi', 'Kilgour', 'akilgour8@tmall.com', '159-529-5637', 0.1, 'Not Searching', 43.77, 3, 27);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (10, 'Estevan', 'Sollom', 'esollom9@deviantart.com', '491-575-1744', 3.01, 'Not Searching', 53.63, 1, 4);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (11, 'Maxy', 'Smithend', 'msmithenda@msu.edu', '621-697-9800', 2.2, 'Not Searching', 14.41, 5, 11);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (12, 'Muffin', 'Martignoni', 'mmartignonib@washington.edu', '423-867-5199', 1.58, 'Hired', 34.06, 2, 18);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (13, 'Felecia', 'Secret', 'fsecretc@1und1.de', '475-184-3919', 2.87, 'Not Searching', 20.64, 1, 2);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (14, 'Sophey', 'Badsworth', 'sbadsworthd@mayoclinic.com', '682-629-1367', 0.62, 'Hired', 66.4, 4, 6);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (15, 'Lara', 'Dunnan', 'ldunnane@globo.com', '499-641-6539', 3.67, 'Hired', 66.3, 1, 1);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (16, 'Jarvis', 'McGovern', 'jmcgovernf@ustream.tv', '792-426-4918', 0.91, 'Searching', 14.66, 1, 28);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (17, 'Clair', 'Coddrington', 'ccoddringtong@boston.com', '206-576-7541', 0.3, 'Hired', 60.45, 3, 23);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (18, 'Whitaker', 'Teresa', 'wteresah@sitemeter.com', '621-101-3027', 1.38, 'Hired', 88.56, 5, 2);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (19, 'Elnar', 'Edmand', 'eedmandi@google.nl', '831-554-4409', 2.73, 'Searching', 0.99, 1, 1);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (20, 'Florina', 'Honatsch', 'fhonatschj@yelp.com', '265-435-0936', 0.67, 'Hired', 60.6, 5, 9);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (21, 'Jennee', 'Padson', 'jpadsonk@joomla.org', '746-598-8721', 1.23, 'Not Searching', 3.71, 3, 21);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (22, 'Alvy', 'Cometson', 'acometsonl@unc.edu', '818-920-8818', 1.64, 'Not Searching', 27.34, 3, 21);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (23, 'Nonnah', 'Ridehalgh', 'nridehalghm@mysql.com', '501-760-2926', 3.81, 'Searching', 77.03, 3, 4);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (24, 'Aurlie', 'Lube', 'aluben@icq.com', '313-860-2993', 3.2, 'Hired', 21.86, 2, 5);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (25, 'Jobina', 'Bearham', 'jbearhamo@shinystat.com', '503-319-8667', 3.87, 'Hired', 93.42, 3, 28);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (26, 'Estevan', 'Wickersham', 'ewickershamp@baidu.com', '249-733-2743', 1.37, 'Searching', 7.11, 3, 21);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (27, 'Wes', 'Rainbow', 'wrainbowq@com.com', '732-561-9320', 1.34, 'Hired', 50.61, 3, 18);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (28, 'Tildi', 'Flagg', 'tflaggr@wix.com', '555-983-1637', 1.1, 'Not Searching', 4.02, 3, 25);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (29, 'Otha', 'Duckhouse', 'oduckhouses@yelp.com', '240-374-1844', 1.71, 'Not Searching', 69.85, 2, 20);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (30, 'Bartolemo', 'Kose', 'bkoset@de.vu', '347-338-0859', 2.87, 'Not Searching', 12.4, 2, 8);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (31, 'Berty', 'Lieber', 'blieberu@paypal.com', '355-464-5787', 0.33, 'Hired', 39.44, 2, 14);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (32, 'Byrom', 'Altimas', 'baltimasv@blogspot.com', '301-143-4425', 0.63, 'Searching', 43.61, 3, 14);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (33, 'Dame', 'Grevel', 'dgrevelw@fastcompany.com', '122-112-3672', 2.93, 'Searching', 25.58, 1, 4);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (34, 'Adriana', 'Rhead', 'arheadx@irs.gov', '185-807-8359', 0.97, 'Searching', 50.58, 1, 26);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (35, 'Amelie', 'McCreadie', 'amccreadiey@discuz.net', '809-317-2209', 2.11, 'Searching', 26.54, 1, 9);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (36, 'Manolo', 'Swanson', 'mswansonz@patch.com', '770-817-0952', 0.5, 'Searching', 70.42, 2, 13);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (37, 'Alena', 'Moorrud', 'amoorrud10@t-online.de', '927-994-9961', 0.89, 'Searching', 52.29, 1, 10);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (38, 'Amelita', 'Tuffell', 'atuffell11@sakura.ne.jp', '803-235-7288', 0.64, 'Not Searching', 68.07, 5, 15);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (39, 'Fabio', 'Jorry', 'fjorry12@nba.com', '334-742-9846', 0.04, 'Hired', 93.01, 1, 18);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (40, 'Trisha', 'Klulisek', 'tklulisek13@blogger.com', '448-633-0306', 0.43, 'Searching', 88.84, 5, 14);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (41, 'Betsey', 'Runacres', 'brunacres14@berkeley.edu', '292-401-4603', 1.69, 'Hired', 81.21, 1, 17);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (42, 'Theobald', 'Pencot', 'tpencot15@blogs.com', '402-731-4611', 1.17, 'Searching', 51.36, 2, 8);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (43, 'Rhodie', 'Kaming', 'rkaming16@smugmug.com', '561-707-1707', 3.57, 'Searching', 26.74, 1, 17);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (44, 'Kristi', 'Schutter', 'kschutter17@creativecommons.org', '810-283-8446', 1.45, 'Not Searching', 14.22, 3, 2);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (45, 'Flory', 'Sharper', 'fsharper18@dot.gov', '511-223-5164', 3.67, 'Hired', 22.23, 1, 27);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (46, 'Nealy', 'De Malchar', 'ndemalchar19@cdc.gov', '348-730-8796', 1.62, 'Hired', 84.93, 5, 12);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (47, 'Cissy', 'Renad', 'crenad1a@indiegogo.com', '949-528-6909', 2.11, 'Searching', 32.7, 1, 10);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (48, 'Conrade', 'Vallens', 'cvallens1b@google.co.jp', '329-464-6460', 0.88, 'Not Searching', 88.2, 2, 12);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (49, 'Gigi', 'Peascod', 'gpeascod1c@mit.edu', '728-831-8968', 3.67, 'Hired', 53.65, 5, 15);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (50, 'Arv', 'Hallows', 'ahallows1d@msu.edu', '767-875-4224', 2.26, 'Not Searching', 59.28, 5, 5);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (51, 'Liesa', 'Ashley', 'lashley1e@cnet.com', '784-513-9912', 2.6, 'Not Searching', 21.03, 3, 14);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (52, 'Alfi', 'Collymore', 'acollymore1f@ucoz.ru', '412-441-3258', 1.97, 'Hired', 74.78, 4, 19);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (53, 'Balduin', 'Landall', 'blandall1g@usgs.gov', '856-495-7571', 1.15, 'Hired', 3.23, 4, 20);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (54, 'Jorgan', 'Quickenden', 'jquickenden1h@samsung.com', '959-952-6801', 1.26, 'Searching', 3.75, 4, 1);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (55, 'Krystyna', 'Sullens', 'ksullens1i@discovery.com', '900-696-9301', 2.49, 'Searching', 74.93, 2, 6);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (56, 'Ruthe', 'Pesselt', 'rpesselt1j@cmu.edu', '968-254-0000', 1.71, 'Searching', 60.76, 3, 13);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (57, 'Sky', 'Baroch', 'sbaroch1k@skype.com', '461-288-2413', 1.49, 'Hired', 11.07, 1, 16);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (58, 'Brnaby', 'Torel', 'btorel1l@mapy.cz', '393-117-7604', 2.1, 'Searching', 33.95, 4, 22);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (59, 'Dorella', 'Spurdens', 'dspurdens1m@rediff.com', '844-750-2168', 1.12, 'Not Searching', 89.27, 3, 14);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (60, 'Clari', 'Playford', 'cplayford1n@jigsy.com', '829-609-7448', 0.89, 'Not Searching', 11.11, 3, 30);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (61, 'Alphonse', 'O''Feeney', 'aofeeney1o@furl.net', '657-653-0914', 3.75, 'Searching', 31.35, 3, 5);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (62, 'Adela', 'Gyngell', 'agyngell1p@reverbnation.com', '812-881-1554', 0.59, 'Hired', 91.24, 3, 5);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (63, 'Bink', 'Laffin', 'blaffin1q@biblegateway.com', '225-108-7356', 3.8, 'Searching', 70.8, 1, 6);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (64, 'Ingaberg', 'Benny', 'ibenny1r@paypal.com', '712-461-5822', 0.37, 'Not Searching', 91.42, 4, 15);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (65, 'Wylie', 'Geindre', 'wgeindre1s@sourceforge.net', '581-324-7874', 0.06, 'Hired', 17.51, 3, 4);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (66, 'Corrinne', 'Hoggan', 'choggan1t@dyndns.org', '121-541-0366', 1.44, 'Searching', 41.39, 1, 24);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (67, 'Quinton', 'Gullis', 'qgullis1u@state.tx.us', '948-219-2441', 3.53, 'Searching', 13.04, 3, 10);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (68, 'Jamill', 'Dutson', 'jdutson1v@etsy.com', '792-574-7899', 0.63, 'Not Searching', 9.0, 2, 26);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (69, 'Eberto', 'Burnie', 'eburnie1w@angelfire.com', '451-892-8493', 3.24, 'Not Searching', 61.05, 2, 1);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (70, 'Cicily', 'Passingham', 'cpassingham1x@webnode.com', '350-409-1477', 1.82, 'Not Searching', 19.4, 3, 9);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (71, 'Brannon', 'Audiss', 'baudiss1y@weebly.com', '590-765-2813', 0.56, 'Hired', 53.88, 1, 20);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (72, 'Yard', 'McGibbon', 'ymcgibbon1z@studiopress.com', '570-518-3982', 2.08, 'Hired', 64.09, 4, 17);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (73, 'Amanda', 'Swancott', 'aswancott20@cnn.com', '408-829-3014', 2.78, 'Hired', 81.77, 4, 8);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (74, 'Judd', 'Channon', 'jchannon21@drupal.org', '800-349-8152', 2.7, 'Hired', 30.69, 3, 17);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (75, 'Jennee', 'Fereday', 'jfereday22@java.com', '594-528-0242', 0.52, 'Not Searching', 95.38, 4, 20);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (76, 'Lizzie', 'Raiston', 'lraiston23@shop-pro.jp', '769-365-1347', 1.28, 'Hired', 99.57, 2, 29);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (77, 'Wendel', 'Driver', 'wdriver24@mysql.com', '915-358-8307', 0.52, 'Not Searching', 93.95, 1, 18);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (78, 'Sampson', 'Pering', 'spering25@shareasale.com', '227-986-0123', 2.43, 'Hired', 97.84, 4, 8);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (79, 'Levin', 'O''Glassane', 'loglassane26@twitter.com', '330-808-5066', 3.03, 'Searching', 65.75, 3, 16);
insert into Student (NUID, FirstName, LastName, Email, PhoneNumber, GPA, Status, Grade, CollegeID, CRN) values (80, 'Danyelle', 'Ottee', 'dottee27@dedecms.com', '733-205-9828', 0.03, 'Not Searching', 57.69, 2, 15);

-- Job sample data
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (1, 'Help Desk Technician', 28.27, '975 Burning Wood Hill', 'Shangtang', null, 'China', 33397, 25, 'Spring', 2020, 1);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (2, 'Environmental Specialist', 38.61, '244 Debs Trail', 'Chingas', null, 'Peru', 78486, 16, 'Fall', 2022, 2);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (3, 'Marketing Manager', 24.51, '0333 Gateway Trail', 'Jaguariaíva', null, 'Brazil', 60307, 27, 'Spring', 2023, 3);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (4, 'Senior Sales Associate', 22.02, '17 Butternut Drive', 'Xinjiang', null, 'China', 37087, 64, 'Fall', 2023, 2);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (5, 'Quality Control Specialist', 48.61, '9333 Prentice Street', 'Molugan', null, 'Philippines', 74260, 16, 'Spring', 2022, 4);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (6, 'VP Accounting', 49.64, '38 Mockingbird Avenue', 'Wuyang', null, 'China', 75878, 65, 'Spring', 2020, 4);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (7, 'VP Product Management', 47.68, '6 Fulton Hill', 'Chapecó', null, 'Brazil', 35077, 8, 'Spring', 2023, 4);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (8, 'Research Associate', 16.06, '5 Oxford Center', 'Ternate', null, 'Philippines', 59135, 44, 'Spring', 2022, 3);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (9, 'Information Systems Manager', 26.8, '777 Valley Edge Place', 'Boise', 'ID', 'United States', 22998, 12, 'Spring', 2022, 4);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (10, 'Help Desk Operator', 47.28, '963 Steensland Trail', 'Santa Cruz', 'COA', 'Mexico', 90364, 44, 'Fall', 2021, 3);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (11, 'Compensation Analyst', 14.53, '440 Eggendart Center', 'Yangong', null, 'China', 11137, 34, 'Spring', 2022, 2);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (12, 'Sales Associate', 46.07, '619 Porter Circle', 'Ḩarastā', null, 'Syria', 93903, 46, 'Spring', 2023, 4);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (13, 'Speech Pathologist', 13.29, '0 Eagan Terrace', 'Buzet', null, 'Croatia', 91528, 51, 'Fall', 2022, 4);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (14, 'Engineer IV', 43.42, '00606 Butternut Road', 'Adolfo Lopez Mateos', 'MEX', 'Mexico', 21319, 7, 'Fall', 2022, 4);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (15, 'Analyst Programmer', 23.28, '5 Myrtle Road', 'Cavan', null, 'Ireland', 39369, 27, 'Fall', 2021, 3);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (16, 'Editor', 41.15, '9867 Norway Maple Lane', 'Unawatuna', null, 'Sri Lanka', 73456, 50, 'Fall', 2021, 2);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (17, 'Quality Control Specialist', 3.64, '3013 Eggendart Court', 'Souto', '13', 'Portugal', 79027, 31, 'Fall', 2021, 1);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (18, 'Senior Quality Engineer', 27.75, '926 Bobwhite Avenue', 'Anzihao', null, 'China', 89230, 19, 'Spring', 2023, 1);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (19, 'Associate Professor', 41.42, '0 Oakridge Place', 'Kanugrahan', null, 'Indonesia', 63820, 42, 'Spring', 2023, 1);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (20, 'Analog Circuit Design manager', 10.13, '68 Jana Parkway', 'Bukhovo', null, 'Bulgaria', 30524, 40, 'Fall', 2021, 2);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (21, 'Sales Associate', 4.98, '1229 Wayridge Terrace', 'Lypova Dolyna', null, 'Ukraine', 63784, 18, 'Fall', 2023, 3);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (22, 'Engineer IV', 31.59, '274 Novick Court', 'Šibenik', null, 'Croatia', 27733, 16, 'Fall', 2021, 1);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (23, 'Account Executive', 22.0, '25576 Eagan Alley', 'Nioumamilima', null, 'Comoros', 61493, 44, 'Spring', 2021, 2);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (24, 'Pharmacist', 27.86, '1 Duke Terrace', 'Cristóbal', null, 'Dominican Republic', 61884, 69, 'Fall', 2021, 1);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (25, 'Programmer Analyst II', 42.05, '875 3rd Court', 'Ashikaga', null, 'Japan', 85152, 45, 'Spring', 2022, 3);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (26, 'Product Engineer', 49.13, '0231 Randy Pass', 'La’ershan', null, 'China', 19196, 15, 'Spring', 2020, 4);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (27, 'Desktop Support Technician', 44.0, '06 Kingsford Lane', 'Xianqiao', null, 'China', 68715, 34, 'Fall', 2022, 4);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (28, 'Nuclear Power Engineer', 42.81, '6730 Drewry Road', 'Kaduketug', null, 'Indonesia', 13144, 50, 'Fall', 2023, 4);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (29, 'Systems Administrator I', 10.92, '72 Ohio Point', 'Priozërsk', null, 'Russia', 96238, 2, 'Fall', 2022, 1);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (30, 'Safety Technician IV', 37.16, '4 Hermina Plaza', 'Bakersfield', 'CA', 'United States', 77675, 23, 'Spring', 2021, 3);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (31, 'Analog Circuit Design manager', 11.54, '9588 David Crossing', 'Dno', null, 'Russia', 60301, 33, 'Spring', 2022, 3);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (32, 'VP Quality Control', 1.92, '9772 Bay Hill', 'Namwala', null, 'Zambia', 20579, 10, 'Fall', 2021, 3);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (33, 'VP Quality Control', 11.69, '65905 Center Crossing', 'San Luis', 'CHP', 'Mexico', 55695, 4, 'Fall', 2022, 3);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (34, 'Geologist IV', 7.86, '123 Main Circle', 'Palecenan', null, 'Indonesia', 44878, 27, 'Fall', 2021, 1);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (35, 'VP Quality Control', 20.6, '7685 Commercial Court', 'Angochi', null, 'Aruba', 63854, 13, 'Fall', 2023, 2);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (36, 'Research Associate', 17.85, '21156 Mallard Place', 'Pniewy', null, 'Poland', 14309, 4, 'Fall', 2020, 1);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (37, 'Programmer Analyst II', 48.08, '5 Crescent Oaks Way', 'Malamig', null, 'Philippines', 54645, 37, 'Spring', 2023, 4);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (38, 'Recruiting Manager', 39.92, '54900 American Ash Road', 'Cileuya', null, 'Indonesia', 88423, 53, 'Spring', 2023, 1);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (39, 'Actuary', 35.2, '45968 Thompson Lane', 'Serov', null, 'Russia', 99486, 12, 'Spring', 2022, 3);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (40, 'Biostatistician IV', 0.45, '8664 Holmberg Junction', 'Michałów-Reginów', null, 'Poland', 91972, 2, 'Fall', 2021, 1);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (41, 'Software Test Engineer I', 3.06, '2685 Texas Plaza', 'Urazovo', null, 'Russia', 91809, 63, 'Fall', 2021, 2);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (42, 'Engineer I', 34.21, '64 Anthes Center', 'Itsandzéni', null, 'Comoros', 90014, 63, 'Fall', 2020, 3);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (43, 'Research Associate', 42.56, '758 Schmedeman Plaza', 'Pápa', 'VE', 'Hungary', 35888, 70, 'Spring', 2022, 3);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (44, 'Database Administrator I', 46.37, '743 Linden Junction', 'Borås', 'O', 'Sweden', 80219, 13, 'Spring', 2020, 2);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (45, 'Programmer Analyst I', 1.2, '21512 Sundown Park', 'Athens', null, 'Greece', 93026, 17, 'Fall', 2020, 2);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (46, 'VP Sales', 32.42, '289 Summit Park', 'Arboleda', null, 'Colombia', 32185, 52, 'Spring', 2023, 1);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (47, 'Assistant Manager', 32.85, '220 Crest Line Road', 'Šmartno pri Litiji', null, 'Slovenia', 44279, 49, 'Spring', 2022, 2);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (48, 'Assistant Professor', 40.27, '98 Loeprich Street', 'Grebenskaya', null, 'Russia', 53579, 33, 'Fall', 2020, 4);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (49, 'Editor', 11.39, '81152 Swallow Pass', 'Jiangnan', null, 'China', 34864, 62, 'Fall', 2022, 2);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (50, 'Quality Control Specialist', 8.54, '87587 Straubel Avenue', 'Ostojićevo', null, 'Serbia', 57613, 56, 'Fall', 2023, 2);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (51, 'Statistician IV', 40.22, '423 High Crossing Terrace', 'Nogent-sur-Marne', 'A8', 'France', 36789, 29, 'Fall', 2022, 2);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (52, 'Analog Circuit Design manager', 31.55, '82255 Hanover Drive', 'Cashel', null, 'Ireland', 46560, 5, 'Fall', 2023, 3);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (53, 'Environmental Tech', 14.31, '4 Mandrake Street', 'Kapasan', null, 'Indonesia', 23166, 80, 'Fall', 2022, 4);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (54, 'Nuclear Power Engineer', 43.42, '6667 Sunfield Terrace', 'Quţūr', null, 'Egypt', 43957, 5, 'Spring', 2022, 3);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (55, 'Biostatistician IV', 6.86, '60 Crest Line Point', 'Makiwalo', null, 'Philippines', 74256, 55, 'Spring', 2021, 1);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (56, 'Internal Auditor', 3.69, '713 Miller Drive', 'Mistřice', null, 'Czech Republic', 45883, 10, 'Fall', 2022, 3);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (57, 'VP Sales', 36.9, '63350 Melvin Point', 'Rantauambacang', null, 'Indonesia', 59485, 20, 'Spring', 2021, 2);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (58, 'Editor', 37.41, '2 Hoard Park', 'Salwá', null, 'Kuwait', 10826, 32, 'Fall', 2022, 4);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (59, 'Occupational Therapist', 40.27, '3 High Crossing Avenue', 'Kilimatinde', null, 'Tanzania', 85490, 41, 'Fall', 2021, 2);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (60, 'Human Resources Manager', 41.7, '0289 Northland Plaza', 'Columbus', 'OH', 'United States', 18542, 55, 'Spring', 2022, 4);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (61, 'Editor', 4.15, '91 Lighthouse Bay Park', 'Huocheng', null, 'China', 56444, 2, 'Fall', 2022, 4);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (62, 'Teacher', 26.92, '44013 Rowland Road', 'Inriville', null, 'Argentina', 60279, 8, 'Spring', 2021, 3);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (63, 'Senior Editor', 5.0, '15422 Emmet Circle', 'Isiolo', null, 'Kenya', 78566, 55, 'Spring', 2021, 4);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (64, 'Data Coordiator', 6.02, '1 Clyde Gallagher Drive', 'Caimitillo', null, 'Panama', 92310, 49, 'Fall', 2023, 3);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (65, 'Administrative Officer', 40.31, '958 Prentice Terrace', 'Trelleborg', 'M', 'Sweden', 49064, 57, 'Fall', 2020, 2);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (66, 'Staff Accountant II', 41.74, '49 Melvin Road', 'Devnya', null, 'Bulgaria', 70473, 79, 'Spring', 2022, 4);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (67, 'Assistant Manager', 12.61, '9 Hovde Center', 'Yunxiang', null, 'China', 10799, 12, 'Spring', 2020, 3);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (68, 'Professor', 23.08, '31155 Lukken Parkway', 'Zlonice', null, 'Czech Republic', 90381, 14, 'Spring', 2021, 1);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (69, 'Financial Analyst', 16.66, '04112 Browning Center', 'Timbuktu', null, 'Mali', 20206, 14, 'Fall', 2020, 1);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (70, 'Research Assistant II', 4.75, '8142 Blue Bill Park Court', 'Ulme', '14', 'Portugal', 63798, 69, 'Fall', 2020, 4);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (71, 'Editor', 33.45, '4 Northfield Park', 'Pawitan', null, 'Indonesia', 95599, 45, 'Fall', 2020, 3);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (72, 'Human Resources Assistant III', 24.05, '12 8th Park', 'Laoshawan', null, 'China', 29888, 20, 'Spring', 2022, 1);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (73, 'Research Assistant II', 21.01, '57474 Westend Junction', 'Somita', null, 'Gambia', 56519, 60, 'Fall', 2022, 4);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (74, 'Senior Financial Analyst', 20.62, '54 Morning Lane', 'Santarém', '14', 'Portugal', 27123, 7, 'Spring', 2020, 1);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (75, 'Accountant III', 13.55, '68561 Chinook Lane', 'Messina', 'SC', 'Italy', 80221, 54, 'Fall', 2023, 4);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (76, 'Senior Financial Analyst', 15.16, '11580 Laurel Road', 'Fort Myers', 'FL', 'United States', 29940, 43, 'Fall', 2020, 2);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (77, 'GIS Technical Architect', 40.59, '1 Tennyson Parkway', 'Żychlin', null, 'Poland', 81701, 67, 'Spring', 2023, 3);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (78, 'Marketing Assistant', 2.18, '18 Moose Drive', 'Sevilla', 'AN', 'Spain', 82584, 52, 'Spring', 2021, 1);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (79, 'Tax Accountant', 1.83, '074 Westport Pass', 'Iecava', null, 'Latvia', 24672, 42, 'Fall', 2020, 4);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (80, 'Senior Developer', 37.59, '82 Lukken Avenue', 'Fairview', 'AB', 'Canada', 74677, 7, 'Spring', 2023, 1);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (81, 'Senior Financial Analyst', 30.68, '5675 Springview Court', 'Sharïngol', null, 'Mongolia', 43097, 72, 'Spring', 2022, 2);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (82, 'Human Resources Assistant IV', 23.54, '63 Leroy Street', 'Dashiren', null, 'China', 97059, 70, 'Fall', 2021, 3);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (83, 'Marketing Assistant', 28.48, '83340 Chinook Junction', 'Nansan', null, 'China', 32389, 39, 'Fall', 2020, 2);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (84, 'Information Systems Manager', 29.24, '4800 Valley Edge Junction', 'Cordova', null, 'Philippines', 82548, 60, 'Fall', 2023, 3);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (85, 'Automation Specialist I', 45.73, '8948 Roxbury Point', 'Hepo', null, 'China', 46028, 47, 'Fall', 2022, 4);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (86, 'Recruiting Manager', 1.98, '32680 Hanson Park', 'Leluo', null, 'China', 37602, 55, 'Fall', 2023, 2);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (87, 'Senior Developer', 26.8, '4511 Annamark Crossing', 'Itauguá', null, 'Paraguay', 33181, 38, 'Fall', 2021, 1);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (88, 'Statistician I', 19.29, '5427 Dakota Junction', 'Huangben', null, 'China', 57310, 67, 'Spring', 2022, 1);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (89, 'Cost Accountant', 2.59, '21280 Susan Lane', 'Luleå', 'BD', 'Sweden', 40089, 44, 'Fall', 2021, 2);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (90, 'Librarian', 32.66, '8 Stephen Hill', 'La Concepcion', 'VER', 'Mexico', 93159, 59, 'Fall', 2020, 1);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (91, 'Business Systems Development Analyst', 17.62, '90800 Truax Alley', 'Užice', null, 'Serbia', 22708, 10, 'Fall', 2023, 3);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (92, 'Administrative Assistant III', 45.44, '0 Victoria Avenue', 'Ivot', null, 'Russia', 80473, 16, 'Fall', 2022, 1);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (93, 'Social Worker', 11.27, '3 Petterle Junction', 'Arnhem', '03', 'Netherlands', 92232, 48, 'Spring', 2023, 2);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (94, 'Electrical Engineer', 2.79, '89938 Roxbury Pass', 'Canto', '01', 'Portugal', 57189, 69, 'Spring', 2023, 3);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (95, 'Associate Professor', 45.88, '3141 Blaine Street', 'Dailekh', null, 'Nepal', 37667, 47, 'Fall', 2020, 2);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (96, 'Product Engineer', 7.65, '44564 Bay Point', 'Yao', null, 'Japan', 45769, 32, 'Spring', 2023, 2);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (97, 'Community Outreach Specialist', 24.59, '5 Moulton Crossing', 'Oli', null, 'Indonesia', 91292, 26, 'Spring', 2020, 1);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (98, 'Systems Administrator IV', 35.34, '6677 Dapin Hill', 'Néa Ionía', null, 'Greece', 21698, 56, 'Fall', 2020, 4);
insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, EmployeeID, Season, Year, PositionID) values (99, 'Speech Pathologist', 21.72, '225 East Road', 'Hradec Králové', null, 'Czech Republic', 61530, 77, 'Fall', 2021, 1);

-- Reference sample data
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (1, 'Felicia', 'Zylbermann', 'fzylbermann0@cdc.gov', '854-620-0831', 9);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (2, 'Sheffie', 'Theuff', 'stheuff1@smh.com.au', '699-887-6370', 50);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (3, 'Teddie', 'Spriggs', 'tspriggs2@arizona.edu', '444-516-0914', 59);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (4, 'Jorie', 'Brooksbank', 'jbrooksbank3@go.com', '479-471-5063', 80);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (5, 'Gnni', 'Coole', 'gcoole4@nydailynews.com', '957-766-4557', 22);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (6, 'Vanessa', 'Callington', 'vcallington5@webeden.co.uk', '864-524-7051', 78);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (7, 'Pacorro', 'Jearum', 'pjearum6@photobucket.com', '129-602-6477', 71);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (8, 'Layla', 'Crowdy', 'lcrowdy7@google.com.au', '213-931-6526', 8);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (9, 'Bertrando', 'Branchett', 'bbranchett8@live.com', '183-143-4712', 34);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (10, 'Gery', 'Cackett', 'gcackett9@bloglines.com', '319-843-0851', 46);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (11, 'Shelden', 'Shew', 'sshewa@statcounter.com', '754-825-9816', 6);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (12, 'Sherman', 'Burgise', 'sburgiseb@weibo.com', '310-412-4997', 56);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (13, 'Shirleen', 'Shellard', 'sshellardc@wordpress.org', '536-801-8276', 47);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (14, 'Liv', 'Azemar', 'lazemard@photobucket.com', '611-561-5630', 53);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (15, 'Melita', 'Edis', 'medise@liveinternet.ru', '326-125-9428', 53);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (16, 'Sauncho', 'Izat', 'sizatf@seesaa.net', '420-944-5130', 75);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (17, 'Isador', 'Wilsone', 'iwilsoneg@nationalgeographic.com', '682-487-3445', 63);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (18, 'Lela', 'Walford', 'lwalfordh@blogger.com', '684-364-7127', 5);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (19, 'Clemens', 'Ibbs', 'cibbsi@domainmarket.com', '198-666-2746', 48);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (20, 'Webster', 'Calcraft', 'wcalcraftj@tinyurl.com', '532-471-1198', 4);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (21, 'Darnell', 'Dibner', 'ddibnerk@cbsnews.com', '245-117-4571', 79);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (22, 'Henrie', 'Marrows', 'hmarrowsl@deviantart.com', '561-189-1798', 6);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (23, 'Obadiah', 'Hanaby', 'ohanabym@seesaa.net', '444-180-0188', 36);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (24, 'Johnny', 'Kopfer', 'jkopfern@narod.ru', '304-135-3721', 42);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (25, 'Vita', 'Whenman', 'vwhenmano@behance.net', '359-733-3925', 48);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (26, 'Al', 'Trayhorn', 'atrayhornp@columbia.edu', '931-893-4378', 49);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (27, 'Alethea', 'Mochar', 'amocharq@harvard.edu', '486-376-6406', 34);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (28, 'Stillmann', 'Levitt', 'slevittr@example.com', '345-800-1580', 3);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (29, 'Brenden', 'Righy', 'brighys@virginia.edu', '629-576-6795', 64);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (30, 'Alley', 'Tustin', 'atustint@apple.com', '550-873-7503', 26);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (31, 'Cross', 'MacCallion', 'cmaccallionu@cyberchimps.com', '326-750-6036', 61);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (32, 'Woodie', 'Ramshaw', 'wramshawv@dmoz.org', '348-144-8818', 40);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (33, 'Moyna', 'Vesco', 'mvescow@google.nl', '924-530-5901', 38);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (34, 'Pris', 'Dollard', 'pdollardx@tamu.edu', '421-169-2081', 31);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (35, 'Cullen', 'Pain', 'cpainy@behance.net', '860-328-0215', 2);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (36, 'Mechelle', 'Crenshaw', 'mcrenshawz@imdb.com', '974-882-4033', 57);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (37, 'Lynda', 'Brahm', 'lbrahm10@slideshare.net', '793-514-1551', 38);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (38, 'Madelene', 'Alabastar', 'malabastar11@canalblog.com', '106-547-4927', 62);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (39, 'Beverly', 'Worgen', 'bworgen12@studiopress.com', '421-221-7717', 49);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (40, 'Dwayne', 'Jammet', 'djammet13@spiegel.de', '208-176-8358', 75);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (41, 'Pincus', 'Layburn', 'playburn14@chron.com', '460-291-1533', 2);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (42, 'Frasier', 'Castletine', 'fcastletine15@mysql.com', '427-784-9170', 72);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (43, 'Pamella', 'Lorence', 'plorence16@buzzfeed.com', '684-794-0936', 59);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (44, 'Goran', 'Boatright', 'gboatright17@com.com', '422-152-8509', 24);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (45, 'Yolanda', 'Eudall', 'yeudall18@ebay.com', '539-949-7116', 2);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (46, 'Osmond', 'Thurber', 'othurber19@msn.com', '137-680-9631', 75);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (47, 'Selma', 'Hovey', 'shovey1a@jimdo.com', '998-594-2121', 61);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (48, 'Zack', 'Abson', 'zabson1b@mozilla.org', '746-620-0444', 48);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (49, 'Ebony', 'Wildbore', 'ewildbore1c@quantcast.com', '104-767-2805', 32);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (50, 'Berton', 'O'' Mahony', 'bomahony1d@bravesites.com', '163-788-8971', 36);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (51, 'Damian', 'Carlin', 'dcarlin1e@ibm.com', '496-662-9048', 75);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (52, 'Elvin', 'Exrol', 'eexrol1f@posterous.com', '504-566-0506', 44);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (53, 'Wat', 'Crallan', 'wcrallan1g@chicagotribune.com', '194-212-3282', 19);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (54, 'Wren', 'Rubinsky', 'wrubinsky1h@wikispaces.com', '970-417-5047', 13);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (55, 'Laurella', 'Burcher', 'lburcher1i@admin.ch', '302-261-9377', 54);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (56, 'Rurik', 'Willimot', 'rwillimot1j@jiathis.com', '287-233-9551', 1);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (57, 'Horten', 'Jaffra', 'hjaffra1k@symantec.com', '886-351-4056', 36);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (58, 'Arly', 'Stoffel', 'astoffel1l@vk.com', '835-189-2212', 32);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (59, 'Melba', 'Harte', 'mharte1m@istockphoto.com', '542-596-3558', 14);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (60, 'Walliw', 'Crocumbe', 'wcrocumbe1n@nymag.com', '131-388-1717', 34);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (61, 'Merle', 'Hackleton', 'mhackleton1o@ebay.co.uk', '885-691-6770', 79);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (62, 'Kelby', 'Loch', 'kloch1p@latimes.com', '914-903-3870', 51);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (63, 'Anjela', 'Erwin', 'aerwin1q@xing.com', '596-214-0908', 25);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (64, 'Schuyler', 'Benedyktowicz', 'sbenedyktowicz1r@marketwatch.com', '630-838-1474', 42);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (65, 'Bert', 'Northover', 'bnorthover1s@nytimes.com', '390-591-1564', 20);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (66, 'Marsiella', 'Murrow', 'mmurrow1t@google.cn', '738-932-9606', 48);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (67, 'Arley', 'Seathwright', 'aseathwright1u@bigcartel.com', '173-217-2249', 79);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (68, 'Denni', 'Antushev', 'dantushev1v@google.ca', '356-260-5445', 30);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (69, 'Jorie', 'Filmer', 'jfilmer1w@cargocollective.com', '475-358-1923', 6);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (70, 'Howard', 'Drennan', 'hdrennan1x@digg.com', '942-320-2522', 80);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (71, 'Essie', 'Skarr', 'eskarr1y@forbes.com', '395-581-8275', 22);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (72, 'Goraud', 'Klais', 'gklais1z@shutterfly.com', '338-924-9430', 3);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (73, 'Natala', 'Cabell', 'ncabell20@jalbum.net', '822-667-8798', 15);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (74, 'Aaron', 'Denyukin', 'adenyukin21@privacy.gov.au', '172-843-0697', 33);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (75, 'Jenda', 'Collingridge', 'jcollingridge22@hugedomains.com', '691-852-0271', 57);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (76, 'Katerina', 'Twaite', 'ktwaite23@privacy.gov.au', '969-212-3090', 70);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (77, 'Sigismond', 'Coffee', 'scoffee24@cbc.ca', '286-423-3051', 56);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (78, 'Gardiner', 'Caffin', 'gcaffin25@auda.org.au', '324-453-2492', 45);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (79, 'Adiana', 'Scroxton', 'ascroxton26@google.co.uk', '996-243-3822', 71);
insert into Reference (ReferenceID, FirstName, LastName, Email, PhoneNumber, NUID) values (80, 'Anthony', 'Gundrey', 'agundrey27@abc.net.au', '138-986-4822', 37);

-- PreviousCoop sample data
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Systems Administrator II', 15.2, 80, 'CWS');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Cost Accountant', 47.2, 49, 'OUK');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Legal Assistant', 24.79, 38, 'CWS');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Administrative Officer', 6.89, 12, 'KEZ');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Structural Analysis Engineer', 10.15, 71, 'BKR');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Associate Professor', 17.3, 62, 'TNN');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Data Coordiator', 27.7, 55, 'MHV');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Sales Representative', 10.22, 6, 'MHV');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Chemical Engineer', 26.11, 16, 'PKX');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Senior Sales Associate', 35.28, 79, 'OUK');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('VP Marketing', 16.93, 20, 'MCD');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Paralegal', 33.92, 23, 'ABL');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Financial Advisor', 5.77, 41, 'JNX');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Software Test Engineer I', 15.23, 53, 'GAL');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Assistant Media Planner', 37.94, 27, 'GAL');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Director of Sales', 48.77, 64, 'EED');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Graphic Designer', 23.28, 80, 'WSM');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Budget/Accounting Analyst III', 18.65, 10, 'CYM');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Technical Writer', 31.63, 54, 'COK');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Registered Nurse', 24.93, 32, 'YEY');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Geological Engineer', 9.38, 56, 'UME');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Human Resources Assistant III', 45.41, 6, 'GEM');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Business Systems Development Analyst', 33.18, 46, 'KRP');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Sales Associate', 48.86, 27, 'CWS');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Operator', 44.2, 69, 'SIL');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Accounting Assistant IV', 15.16, 27, 'GEM');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Senior Financial Analyst', 22.88, 64, 'GLR');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Software Engineer I', 39.31, 6, 'RGI');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Geologist I', 45.7, 32, 'YGJ');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Web Developer II', 16.51, 52, 'ISB');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Quality Engineer', 44.15, 63, 'MAA');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Actuary', 26.41, 70, 'CMP');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Quality Engineer', 7.52, 63, 'LND');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Associate Professor', 33.85, 2, 'NMG');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Occupational Therapist', 32.9, 9, 'YAH');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Structural Analysis Engineer', 43.06, 11, 'MBH');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Research Nurse', 14.24, 17, 'BQA');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Budget/Accounting Analyst III', 12.36, 10, 'AAJ');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Software Test Engineer I', 9.87, 73, 'YGJ');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('VP Accounting', 38.23, 49, 'SCW');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Environmental Tech', 46.51, 39, 'GAL');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Systems Administrator II', 13.04, 9, 'BIM');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Librarian', 44.53, 78, 'YGJ');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Associate Professor', 33.83, 42, 'JAM');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Senior Editor', 36.32, 15, 'BTA');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Pharmacist', 30.69, 68, 'UTE');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Chemical Engineer', 39.41, 76, 'YVV');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Health Coach III', 26.73, 2, 'WON');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Editor', 18.54, 59, 'YYL');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Staff Scientist', 42.66, 31, 'KEZ');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Senior Editor', 7.83, 63, 'YGJ');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Dental Hygienist', 22.05, 66, 'DCI');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Research Assistant IV', 24.33, 41, 'SLN');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Biostatistician IV', 49.8, 72, 'KUT');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Software Engineer III', 46.87, 18, 'ISB');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Graphic Designer', 36.5, 73, 'ISB');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('VP Marketing', 19.5, 40, 'ISB');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Programmer Analyst II', 4.12, 69, 'ANC');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Systems Administrator I', 41.44, 22, 'GMA');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Account Executive', 3.31, 65, 'BQA');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Geological Engineer', 38.64, 26, 'JAM');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Data Coordiator', 19.42, 45, 'BXT');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Technical Writer', 1.85, 76, 'EED');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Help Desk Operator', 5.48, 6, 'MHN');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Programmer Analyst III', 1.43, 4, 'BTA');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Automation Specialist I', 9.46, 57, 'BKR');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Engineer IV', 35.23, 26, 'SCW');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Structural Analysis Engineer', 11.46, 60, 'RGI');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Pharmacist', 46.45, 24, 'TYS');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Computer Systems Analyst III', 24.3, 14, 'CBM');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Senior Sales Associate', 36.22, 1, 'EED');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Budget/Accounting Analyst I', 44.13, 36, 'TNN');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Software Engineer II', 1.13, 4, 'KZC');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Research Nurse', 7.1, 80, 'AAJ');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Teacher', 36.94, 67, 'KMG');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('VP Product Management', 32.1, 59, 'JNX');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Human Resources Manager', 48.97, 24, 'GMA');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Software Test Engineer III', 45.28, 33, 'CYM');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Research Assistant I', 12.28, 37, 'ATS');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Cost Accountant', 7.05, 41, 'CMP');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Structural Engineer', 20.52, 21, 'LLU');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Operator', 32.93, 75, 'MHV');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Human Resources Manager', 12.96, 71, 'PTJ');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Environmental Specialist', 48.77, 47, 'SBX');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Electrical Engineer', 36.2, 76, 'CWS');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Safety Technician I', 14.17, 78, 'LEL');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Actuary', 6.32, 49, 'LEL');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Engineer I', 11.87, 39, 'SCW');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Legal Assistant', 49.96, 78, 'ULD');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Safety Technician I', 22.82, 33, 'MHN');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Physical Therapy Assistant', 2.6, 57, 'NCL');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Media Manager III', 20.81, 43, 'GMA');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Account Coordinator', 30.05, 64, 'PKX');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Software Consultant', 44.05, 19, 'HNI');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Web Developer II', 12.76, 7, 'BKR');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Payment Adjustment Coordinator', 28.26, 79, 'ATS');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Web Designer I', 44.98, 74, 'CBM');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Marketing Manager', 12.86, 17, 'EED');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Office Assistant I', 7.34, 62, 'GJR');
insert into PreviousCoop (Title, HourlyWage, NUID, TickerSymbol) values ('Civil Engineer', 47.11, 75, 'LND');

-- Application sample data
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('cisco.com', 'github.io', 'dedecms.com', 'Rejected', 25, 2);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('imdb.com', 'free.fr', 'guardian.co.uk', 'Rejected', 43, 78);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('comcast.net', 'who.int', 'phpbb.com', 'Hired', 65, 64);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('wix.com', 'google.de', 'go.com', 'Interview', 29, 57);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('github.com', 'vk.com', 'bbc.co.uk', 'Rejected', 30, 7);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('adobe.com', 'mysql.com', 'mysql.com', 'Hired', 12, 50);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('about.com', 'people.com.cn', 'storify.com', 'Rejected', 21, 93);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('delicious.com', 'vinaora.com', 'cocolog-nifty.com', 'Interview', 11, 44);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('mail.ru', 'qq.com', 'rakuten.co.jp', 'Rejected', 26, 4);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('uiuc.edu', 'usnews.com', '123-reg.co.uk', 'Hired', 58, 5);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('hexun.com', 'nymag.com', 'ted.com', 'Interview', 27, 17);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('technorati.com', 'gizmodo.com', 'bigcartel.com', 'Hired', 46, 22);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('theguardian.com', 'java.com', 'fema.gov', 'Rejected', 31, 63);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('chronoengine.com', 'facebook.com', 'theglobeandmail.com', 'Interview', 68, 62);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('guardian.co.uk', 'wix.com', 'dailymotion.com', 'Hired', 67, 57);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('nbcnews.com', 'google.de', 'slate.com', 'Hired', 25, 81);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('webeden.co.uk', 'reverbnation.com', 'wix.com', 'Hired', 20, 75);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('sciencedirect.com', 'dion.ne.jp', 'webnode.com', 'Rejected', 53, 95);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('dropbox.com', 'slate.com', 'disqus.com', 'Interview', 22, 67);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('w3.org', 'nature.com', 'canalblog.com', 'Hired', 2, 90);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('lulu.com', 'go.com', 'walmart.com', 'Interview', 61, 89);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('archive.org', 'surveymonkey.com', 'prweb.com', 'Hired', 18, 46);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('wikimedia.org', 'state.tx.us', 'topsy.com', 'Rejected', 1, 31);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('joomla.org', 'businessinsider.com', 'bandcamp.com', 'Interview', 70, 21);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('tripod.com', 'state.gov', 'friendfeed.com', 'Interview', 42, 97);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('google.ru', 'webs.com', 'bbb.org', 'Interview', 19, 68);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('com.com', 'amazon.co.jp', 'meetup.com', 'Interview', 66, 64);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('clickbank.net', 'constantcontact.com', 'about.com', 'Interview', 45, 5);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('etsy.com', 'g.co', 'google.ca', 'Hired', 68, 75);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('netlog.com', 'xinhuanet.com', 'networkadvertising.org', 'Hired', 2, 60);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('unc.edu', 'twitpic.com', 'qq.com', 'Interview', 79, 35);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('squarespace.com', 'loc.gov', 'biblegateway.com', 'Interview', 76, 8);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('amazonaws.com', 'domainmarket.com', 'patch.com', 'Interview', 28, 71);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('reference.com', 'wikipedia.org', 'sourceforge.net', 'Hired', 53, 26);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('mediafire.com', 'cnet.com', 'ebay.com', 'Rejected', 23, 97);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('dropbox.com', 'globo.com', 'tripadvisor.com', 'Interview', 7, 25);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('yale.edu', 'i2i.jp', 'flickr.com', 'Hired', 14, 59);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('digg.com', 'feedburner.com', 'fc2.com', 'Rejected', 22, 4);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('boston.com', 'archive.org', 'altervista.org', 'Hired', 9, 73);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('qq.com', 'biglobe.ne.jp', 'nasa.gov', 'Hired', 14, 26);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('mapy.cz', 'hao123.com', 'google.de', 'Interview', 15, 99);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('engadget.com', 'indiatimes.com', 'java.com', 'Rejected', 1, 53);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('deliciousdays.com', 'thetimes.co.uk', 'instagram.com', 'Interview', 50, 48);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('smh.com.au', 'ifeng.com', 'vinaora.com', 'Hired', 4, 14);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('liveinternet.ru', 'illinois.edu', 'tmall.com', 'Rejected', 62, 52);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('google.es', 'cbslocal.com', 'guardian.co.uk', 'Hired', 51, 26);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('arizona.edu', 'weather.com', 'businessweek.com', 'Rejected', 69, 7);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('geocities.jp', 'canalblog.com', 'netscape.com', 'Rejected', 70, 92);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('histats.com', 'multiply.com', 'google.cn', 'Interview', 62, 7);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('amazon.de', 'webnode.com', 'delicious.com', 'Rejected', 78, 10);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('histats.com', 'pbs.org', 'admin.ch', 'Rejected', 61, 60);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('dailymail.co.uk', 'a8.net', 'mayoclinic.com', 'Rejected', 38, 25);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('a8.net', 'narod.ru', 'digg.com', 'Interview', 56, 58);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('surveymonkey.com', 'hhs.gov', 'flavors.me', 'Hired', 40, 36);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('mayoclinic.com', 'spotify.com', 'google.nl', 'Interview', 33, 22);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('bluehost.com', 'cnn.com', 'java.com', 'Rejected', 31, 87);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('sitemeter.com', 'archive.org', 'tinyurl.com', 'Rejected', 12, 29);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('mysql.com', 'dailymotion.com', 'hc360.com', 'Hired', 14, 56);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('ibm.com', 'economist.com', '51.la', 'Hired', 54, 18);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('so-net.ne.jp', 'sakura.ne.jp', 'prweb.com', 'Hired', 65, 13);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('java.com', 'weebly.com', 'com.com', 'Interview', 66, 61);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('vkontakte.ru', 'rakuten.co.jp', 'mac.com', 'Rejected', 45, 94);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('globo.com', 'squidoo.com', 'purevolume.com', 'Rejected', 47, 99);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('miitbeian.gov.cn', 'latimes.com', 'ucoz.ru', 'Rejected', 15, 28);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('umn.edu', 'earthlink.net', 'prweb.com', 'Interview', 7, 21);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('kickstarter.com', 'jigsy.com', '4shared.com', 'Interview', 16, 36);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('bloomberg.com', 'prnewswire.com', 'dot.gov', 'Rejected', 26, 80);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('time.com', 'nationalgeographic.com', 'guardian.co.uk', 'Interview', 73, 97);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('ezinearticles.com', 'jugem.jp', 'ning.com', 'Interview', 77, 13);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('illinois.edu', 'geocities.jp', 'usgs.gov', 'Rejected', 68, 23);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('slideshare.net', 'slideshare.net', 'dot.gov', 'Interview', 60, 14);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('zdnet.com', 'freewebs.com', 'psu.edu', 'Rejected', 72, 40);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('yelp.com', 'dell.com', 'webs.com', 'Hired', 77, 29);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('shareasale.com', 'hexun.com', 'ed.gov', 'Rejected', 58, 12);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('livejournal.com', 'sogou.com', 'storify.com', 'Hired', 33, 32);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('statcounter.com', 'deliciousdays.com', 'liveinternet.ru', 'Interview', 58, 35);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('hhs.gov', 'ebay.co.uk', 'upenn.edu', 'Hired', 65, 34);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('shutterfly.com', 'mediafire.com', 'google.cn', 'Interview', 22, 93);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('canalblog.com', 'plala.or.jp', 'princeton.edu', 'Rejected', 36, 77);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('timesonline.co.uk', 'ucoz.com', 'twitter.com', 'Rejected', 6, 71);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('yale.edu', 'dedecms.com', 'cargocollective.com', 'Rejected', 74, 81);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('geocities.jp', 'vkontakte.ru', 'archive.org', 'Rejected', 2, 50);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('miibeian.gov.cn', 'europa.eu', 'bbc.co.uk', 'Rejected', 75, 66);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('bing.com', 'nyu.edu', 'topsy.com', 'Rejected', 37, 21);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('dyndns.org', 'flickr.com', 'zdnet.com', 'Rejected', 23, 23);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('wikia.com', 'usda.gov', 'ihg.com', 'Interview', 12, 31);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('surveymonkey.com', 'friendfeed.com', 'google.pl', 'Hired', 59, 34);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('ucsd.edu', 'hubpages.com', 'utexas.edu', 'Hired', 74, 51);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('dyndns.org', 'yellowpages.com', 'geocities.jp', 'Interview', 36, 38);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('angelfire.com', 'jugem.jp', 'newsvine.com', 'Rejected', 74, 72);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('xing.com', 'cbslocal.com', 'e-recht24.de', 'Interview', 64, 95);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('wikimedia.org', 'ucoz.com', 'tripod.com', 'Interview', 6, 73);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('spiegel.de', 'sciencedirect.com', 'naver.com', 'Rejected', 23, 64);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('statcounter.com', 'cdc.gov', 'hud.gov', 'Hired', 25, 9);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('reverbnation.com', 'slashdot.org', 'merriam-webster.com', 'Hired', 47, 47);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('businessinsider.com', 'privacy.gov.au', 'bbc.co.uk', 'Hired', 77, 69);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('yale.edu', 'ocn.ne.jp', 'mtv.com', 'Hired', 18, 98);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('simplemachines.org', 'ask.com', 'umn.edu', 'Hired', 11, 57);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('buzzfeed.com', 'mail.ru', 'spotify.com', 'Rejected', 53, 76);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('biglobe.ne.jp', 'parallels.com', 'yale.edu', 'Rejected', 21, 46);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('webs.com', 'purevolume.com', 'tinypic.com', 'Hired', 61, 31);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('loc.gov', 'is.gd', 'blogs.com', 'Rejected', 79, 44);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('blog.com', 'usatoday.com', 'amazon.co.jp', 'Interview', 75, 3);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('deviantart.com', 'digg.com', 'vkontakte.ru', 'Rejected', 7, 74);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('marketwatch.com', 'thetimes.co.uk', 'mail.ru', 'Interview', 24, 85);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('disqus.com', 'phpbb.com', 'studiopress.com', 'Interview', 40, 17);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('cdbaby.com', 'apache.org', 'usnews.com', 'Interview', 29, 39);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('vkontakte.ru', 'addtoany.com', 'dmoz.org', 'Rejected', 13, 60);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('sun.com', 'google.es', 'scribd.com', 'Rejected', 78, 67);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('blog.com', 'unblog.fr', 'slate.com', 'Interview', 62, 46);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('princeton.edu', 'woothemes.com', '360.cn', 'Hired', 43, 79);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('gmpg.org', 'businessinsider.com', 'ca.gov', 'Rejected', 80, 79);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('scribd.com', 'ning.com', 'yellowpages.com', 'Rejected', 41, 85);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('seesaa.net', 'rediff.com', 'infoseek.co.jp', 'Rejected', 25, 95);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('alibaba.com', 'nationalgeographic.com', 'canalblog.com', 'Interview', 74, 69);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('netscape.com', 'wikimedia.org', 'patch.com', 'Hired', 41, 73);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('auda.org.au', 'networkadvertising.org', 'earthlink.net', 'Rejected', 34, 16);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('constantcontact.com', 'smh.com.au', 'google.it', 'Interview', 17, 55);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('webmd.com', 'mlb.com', 'storify.com', 'Hired', 65, 59);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('a8.net', 'altervista.org', 'infoseek.co.jp', 'Rejected', 8, 24);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('epa.gov', 'com.com', 't-online.de', 'Hired', 44, 54);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('statcounter.com', 'printfriendly.com', 'alibaba.com', 'Rejected', 43, 77);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('latimes.com', 'com.com', 'tumblr.com', 'Rejected', 40, 74);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('fema.gov', 'scientificamerican.com', 'purevolume.com', 'Interview', 10, 24);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('goodreads.com', 'ifeng.com', 'loc.gov', 'Interview', 37, 57);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('naver.com', 'gravatar.com', 'blinklist.com', 'Hired', 64, 53);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('sfgate.com', 'delicious.com', 'bbc.co.uk', 'Interview', 31, 2);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('army.mil', 'bizjournals.com', 'cargocollective.com', 'Hired', 55, 80);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('sciencedaily.com', 'cmu.edu', 'live.com', 'Interview', 3, 38);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('twitter.com', 'cdc.gov', 'auda.org.au', 'Interview', 7, 94);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('fc2.com', 'princeton.edu', 'spotify.com', 'Interview', 66, 33);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('narod.ru', 'wikimedia.org', 'blogs.com', 'Interview', 28, 70);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('drupal.org', 'quantcast.com', 'ifeng.com', 'Rejected', 78, 68);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('springer.com', 'bandcamp.com', 'umich.edu', 'Hired', 41, 27);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('cloudflare.com', 'merriam-webster.com', 'unc.edu', 'Hired', 46, 52);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('yale.edu', 'webnode.com', 'blogger.com', 'Rejected', 22, 85);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('seesaa.net', 'google.de', 'tamu.edu', 'Hired', 68, 21);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('icio.us', 'google.ru', 'gizmodo.com', 'Interview', 19, 11);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('smh.com.au', 'ezinearticles.com', 'paypal.com', 'Hired', 45, 84);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('mac.com', 'hexun.com', 'un.org', 'Interview', 64, 10);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('de.vu', 'php.net', 'boston.com', 'Interview', 61, 63);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('wp.com', 'instagram.com', 'netvibes.com', 'Hired', 19, 64);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('youku.com', 'noaa.gov', 'cafepress.com', 'Rejected', 65, 52);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('miibeian.gov.cn', 'blog.com', 'state.gov', 'Hired', 17, 82);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('rediff.com', 'hibu.com', 'freewebs.com', 'Rejected', 12, 48);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('dailymotion.com', 'sfgate.com', 'nydailynews.com', 'Hired', 68, 64);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('thetimes.co.uk', 'symantec.com', 'boston.com', 'Hired', 43, 46);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('ibm.com', 'cocolog-nifty.com', 'alibaba.com', 'Rejected', 38, 73);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('livejournal.com', 'purevolume.com', 'yahoo.com', 'Interview', 23, 28);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('hp.com', 'blog.com', 'thetimes.co.uk', 'Interview', 12, 82);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('shareasale.com', 'who.int', 'ow.ly', 'Rejected', 64, 32);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('examiner.com', 'marriott.com', 'sun.com', 'Rejected', 37, 69);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('sciencedirect.com', 'nytimes.com', 'java.com', 'Hired', 63, 39);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('t.co', 'ebay.co.uk', 'nba.com', 'Rejected', 69, 25);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('last.fm', 'ft.com', 'lulu.com', 'Hired', 50, 98);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('un.org', 'webs.com', 'studiopress.com', 'Hired', 74, 47);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('harvard.edu', 'livejournal.com', 'cnn.com', 'Interview', 73, 53);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('prnewswire.com', 'miitbeian.gov.cn', 'liveinternet.ru', 'Rejected', 28, 59);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('nytimes.com', 'yahoo.co.jp', 'surveymonkey.com', 'Hired', 54, 72);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('tumblr.com', 'statcounter.com', '1und1.de', 'Rejected', 32, 95);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('lulu.com', 'histats.com', 'hao123.com', 'Hired', 54, 94);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('symantec.com', 'dailymail.co.uk', 'google.ru', 'Rejected', 68, 63);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('jigsy.com', 'arstechnica.com', 'reddit.com', 'Hired', 20, 46);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('ovh.net', 'storify.com', 'cdbaby.com', 'Interview', 75, 26);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('goo.ne.jp', 'go.com', 'phpbb.com', 'Hired', 75, 32);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('dyndns.org', 'bing.com', 'about.com', 'Rejected', 41, 54);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('com.com', 'intel.com', 'clickbank.net', 'Rejected', 55, 85);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('hexun.com', 'tuttocitta.it', 'pagesperso-orange.fr', 'Interview', 33, 94);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('flickr.com', 'indiegogo.com', 'cargocollective.com', 'Interview', 5, 47);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('dion.ne.jp', 'opera.com', 'opera.com', 'Hired', 5, 13);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('addtoany.com', 'tuttocitta.it', 'earthlink.net', 'Rejected', 67, 4);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('hibu.com', 'gmpg.org', 'privacy.gov.au', 'Hired', 28, 19);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('merriam-webster.com', 'hexun.com', 'artisteer.com', 'Interview', 67, 46);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('spiegel.de', 'zimbio.com', '4shared.com', 'Rejected', 33, 3);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('dailymotion.com', 'narod.ru', 'dyndns.org', 'Rejected', 80, 27);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('bbc.co.uk', 'arizona.edu', 'phpbb.com', 'Hired', 3, 2);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('baidu.com', 'fc2.com', 'uiuc.edu', 'Hired', 62, 28);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('nasa.gov', 'booking.com', 'icio.us', 'Hired', 65, 89);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('twitter.com', 'goodreads.com', 'livejournal.com', 'Interview', 36, 90);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('nymag.com', 'blogtalkradio.com', 'epa.gov', 'Hired', 78, 12);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('technorati.com', 'tripadvisor.com', 'kickstarter.com', 'Interview', 10, 61);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('wisc.edu', 'amazon.co.uk', 'paginegialle.it', 'Rejected', 28, 31);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('wikispaces.com', 'indiegogo.com', 'gmpg.org', 'Rejected', 68, 96);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('prnewswire.com', 'flavors.me', 'multiply.com', 'Hired', 8, 77);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('yandex.ru', 'nhs.uk', 'cafepress.com', 'Hired', 39, 79);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('businesswire.com', 'photobucket.com', 'purevolume.com', 'Rejected', 32, 37);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('istockphoto.com', 'com.com', 'wix.com', 'Interview', 62, 37);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('discuz.net', 'stanford.edu', 'taobao.com', 'Rejected', 66, 91);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('odnoklassniki.ru', 'unicef.org', 'intel.com', 'Hired', 60, 79);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('rambler.ru', 'squarespace.com', 'gnu.org', 'Hired', 47, 45);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('friendfeed.com', 'imageshack.us', 'freewebs.com', 'Hired', 46, 43);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('comsenz.com', 'army.mil', 'go.com', 'Hired', 67, 36);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('fastcompany.com', 'rediff.com', 'domainmarket.com', 'Rejected', 76, 85);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('mozilla.org', 'ask.com', 'icq.com', 'Rejected', 38, 40);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('blogger.com', 'usa.gov', 'elpais.com', 'Hired', 10, 82);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('statcounter.com', 'utexas.edu', 'w3.org', 'Hired', 47, 63);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('sogou.com', 'disqus.com', 'e-recht24.de', 'Rejected', 2, 77);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('ocn.ne.jp', 'ucsd.edu', 'theglobeandmail.com', 'Rejected', 6, 84);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('livejournal.com', 'weebly.com', 'loc.gov', 'Interview', 77, 64);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('intel.com', 'ning.com', 'geocities.com', 'Rejected', 3, 99);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('hibu.com', 'google.com.hk', 'pagesperso-orange.fr', 'Interview', 66, 34);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('usatoday.com', 'dailymail.co.uk', 'statcounter.com', 'Hired', 42, 47);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('spotify.com', 'google.fr', 'wp.com', 'Hired', 4, 4);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('umn.edu', 'newsvine.com', 'state.tx.us', 'Hired', 67, 35);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('gov.uk', 'squarespace.com', 'unesco.org', 'Rejected', 69, 63);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('tumblr.com', 'timesonline.co.uk', 'pagesperso-orange.fr', 'Rejected', 61, 73);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('weebly.com', 'cbslocal.com', 'taobao.com', 'Interview', 73, 15);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('oaic.gov.au', 'simplemachines.org', 'seattletimes.com', 'Hired', 9, 90);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('toplist.cz', 'narod.ru', 'yellowbook.com', 'Interview', 79, 66);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('miitbeian.gov.cn', 'arizona.edu', 'statcounter.com', 'Hired', 46, 32);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('so-net.ne.jp', 'intel.com', 'pcworld.com', 'Rejected', 76, 74);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('wisc.edu', 'wufoo.com', 't-online.de', 'Rejected', 35, 44);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('themeforest.net', 'edublogs.org', 'dailymail.co.uk', 'Hired', 53, 54);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('amazon.co.uk', 'smugmug.com', 'ed.gov', 'Rejected', 13, 98);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('tumblr.com', 'sciencedaily.com', 'imdb.com', 'Interview', 45, 28);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('smugmug.com', 'pbs.org', 'cafepress.com', 'Hired', 28, 23);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('linkedin.com', 'flavors.me', 'clickbank.net', 'Hired', 79, 5);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('ca.gov', 'loc.gov', 'weebly.com', 'Hired', 65, 75);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('shareasale.com', 'histats.com', 'guardian.co.uk', 'Rejected', 70, 19);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('sitemeter.com', 'jiathis.com', 'utexas.edu', 'Interview', 35, 21);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('netvibes.com', 'bing.com', 'toplist.cz', 'Rejected', 46, 73);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('alibaba.com', 'meetup.com', 'free.fr', 'Hired', 9, 70);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('studiopress.com', 'toplist.cz', 'vk.com', 'Rejected', 50, 3);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('simplemachines.org', 'ning.com', 'cbc.ca', 'Hired', 45, 74);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('bbc.co.uk', 'ibm.com', 'toplist.cz', 'Interview', 46, 2);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('msu.edu', 'xing.com', 'yellowbook.com', 'Interview', 72, 75);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('diigo.com', 'newsvine.com', 'google.cn', 'Rejected', 44, 68);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('free.fr', 'lulu.com', 'nba.com', 'Interview', 48, 83);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('unicef.org', 'webmd.com', 'i2i.jp', 'Interview', 28, 10);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('adobe.com', 'plala.or.jp', 'gizmodo.com', 'Rejected', 43, 76);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('baidu.com', 'github.io', 'globo.com', 'Rejected', 14, 55);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('cdc.gov', 'cbc.ca', 'cdbaby.com', 'Hired', 56, 76);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('parallels.com', 'intel.com', 'toplist.cz', 'Hired', 74, 27);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('shinystat.com', 'hatena.ne.jp', 'photobucket.com', 'Hired', 66, 31);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('google.com.hk', 'jimdo.com', 'samsung.com', 'Interview', 66, 83);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('ovh.net', 'wordpress.org', 'xrea.com', 'Hired', 11, 27);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('tiny.cc', 'slideshare.net', 'ameblo.jp', 'Interview', 3, 95);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('theguardian.com', 'reuters.com', 'pbs.org', 'Rejected', 41, 17);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('vimeo.com', 'fc2.com', 'canalblog.com', 'Rejected', 37, 68);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('latimes.com', 'imdb.com', 'google.it', 'Hired', 17, 71);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('jiathis.com', 'vistaprint.com', 'dyndns.org', 'Rejected', 57, 64);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('amazon.co.uk', 'sakura.ne.jp', 'mac.com', 'Rejected', 58, 72);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('theguardian.com', 'w3.org', 'mashable.com', 'Interview', 54, 93);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('phpbb.com', 'ezinearticles.com', 'cmu.edu', 'Interview', 66, 5);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('artisteer.com', 'economist.com', 'hc360.com', 'Interview', 30, 59);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('washingtonpost.com', 'princeton.edu', 'blogtalkradio.com', 'Hired', 13, 10);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('msu.edu', 'homestead.com', 'pbs.org', 'Interview', 67, 33);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('unesco.org', 'about.com', 'ustream.tv', 'Interview', 10, 67);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('weebly.com', 'theglobeandmail.com', 'businesswire.com', 'Rejected', 8, 8);
insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) values ('ustream.tv', 'merriam-webster.com', 'wikimedia.org', 'Rejected', 66, 10);