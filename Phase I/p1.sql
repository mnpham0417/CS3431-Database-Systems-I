--drop table Process;
drop table WineLabelForm;
drop table WineCompRep;
drop table SuperAgent;
drop table GovernmentAgent;
drop table Account;
drop table Wine;
drop sequence superAgent_sq;
drop sequence wineCompRep_sq;
drop sequence wine_sq;
drop sequence wineLabelForm_sq;

create table Account(
    loginName varchar2(25),
    password varchar2(25),
    constraint account_PK primary key (loginName)
);

INSERT into Account values ('Hurping', 'Ohs0ohchee');
INSERT into Account values ('Cone1990', 'kiel9oalaiG');
INSERT into Account values ('Witers', 'Si5ubaiGoh2');
INSERT into Account values ('Racke1985', 'ooka1AhKe4k');
INSERT into Account values ('Facepow', 'Eet7aiM8ru');
INSERT into Account values ('Faids1990', 'oonubahP8xi');
INSERT into Account values ('Hicent1983', 'zae8Dae6Eimoh');
INSERT into Account values ('Throlould', 'un3Ahdie');
INSERT into Account values ('Riont1946', 'naMaedei3');
INSERT into Account values ('Speakne', 'AZahchei9th');
INSERT into Account values ('Sicinsions', 'jei2waiGhee');
INSERT into Account values ('Goor1994', 'zaiveebu4Ch');
INSERT into Account values ('Forrounce1955', 'Coh9shei');
INSERT into Account values ('Pithenclacke1939', 'Ovut3ThaiChiw');
INSERT into Account values ('Olown1949', 'iTahGae9');
INSERT into Account values ('Cusufattion', 'Ahph2woo');
INSERT into Account values ('Martur', 'Quot2Goh');
INSERT into Account values ('Lontageman', 'auRiez5fae');
INSERT into Account values ('Whold1984', 'eeV4thae1ae');
INSERT into Account values ('Bels1991', 'ooz9Ioxeiqu');

create table governmentAgent(
    emailAddr varchar2(50),
    phone number(15),
    name varchar2(25),
    loginName varchar2(25),
    constraint governmentAgent_PK primary key (emailAddr),
    constraint loginName_FK foreign key (loginName) references Account(loginName)
);

INSERT into governmentAgent VALUES ('JeffreyJMoody@rhyta.com', 6185569815, 'Jeffrey J. Moody', 'Hurping');
INSERT into governmentAgent VALUES ('AngelaSEllis@rhyta.com', 6185569815, 'Angela S. Ellis', 'Cone1990');
INSERT into governmentAgent VALUES ('JohnDJames@teleworm.us', 6185569815, 'John D. James', 'Witers');
INSERT into governmentAgent VALUES ('MelanieMRios@jourrapide.com', 6185569815, 'Melanie M. Rios', 'Racke1985');
INSERT into governmentAgent VALUES ('MichealMMiller@armyspy.com', 6185569815, 'Micheal M. Miller', 'Facepow');
INSERT into governmentAgent VALUES ('DavidEPalmer@armyspy.com', 6185569815, 'David E. Palmer', 'Faids1990');
INSERT into governmentAgent VALUES ('KarenWRunyon@dayrep.com', 6185569815, 'Karen W. Runyon', 'Hicent1983');
INSERT into governmentAgent VALUES ('EricCFite@teleworm.us', 6185569815, 'Eric C. Fite', 'Throlould');
INSERT into governmentAgent VALUES ('EllenSDavis@teleworm.us', 6185569815, 'Ellen S. Davis', 'Riont1946');
INSERT into governmentAgent VALUES ('MarieBFeuerstein@dayrep.com', 6185569815, 'Marie B. Feuerstein', 'Speakne');

create table superAgent(
    emailAddr varchar2(50),
    ttbID number,
    constraint superAgent primary key (emailAddr, ttbID),
    constraint ttbid_uq unique (ttbid),
    -- is a relationship
    CONSTRAINT superAgent_pk foreign KEY (emailAddr) REFERENCES governmentAgent(emailAddr) on DELETE CASCADE
);

create SEQUENCE superAgent_sq
    start with 100
    increment by 1;
insert into superAgent VALUES ('JeffreyJMoody@rhyta.com', superAgent_sq.nextval);
insert into superAgent VALUES ('AngelaSEllis@rhyta.com', superAgent_sq.nextval);
insert into superAgent VALUES ('JohnDJames@teleworm.us', superAgent_sq.nextval);
insert into superAgent VALUES ('MelanieMRios@jourrapide.com', superAgent_sq.nextval);
insert into superAgent VALUES ('MichealMMiller@armyspy.com', superAgent_sq.nextval);
insert into superAgent VALUES ('DavidEPalmer@armyspy.com', superAgent_sq.nextval);
insert into superAgent VALUES ('KarenWRunyon@dayrep.com', superAgent_sq.nextval);
insert into superAgent VALUES ('EricCFite@teleworm.us', superAgent_sq.nextval);
insert into superAgent VALUES ('EllenSDavis@teleworm.us', superAgent_sq.nextval);
insert into superAgent VALUES ('MarieBFeuerstein@dayrep.com', superAgent_sq.nextval);

create table wineCompRep(
    repID number, 
    phone number(15),
    name varchar2(25),
    loginName varchar2(25),
    companyName varchar2(25),
    emailAddr varchar2(50),
    constraint wineCompRep_PK primary key (repID), 
    constraint wineCompRep_FK foreign key (loginName) references Account(loginName)
);

create SEQUENCE wineCompRep_sq
    start with 100
    increment by 1;
insert into wineCompRep VALUES (wineCompRep_sq.nextval, 6306202654, 'Lewis J. Hammond', 'Sicinsions', 'Hughes Hatcher', 'LewisJHammond@dayrep.com');
insert into wineCompRep VALUES (wineCompRep_sq.nextval, 2065256358, 'Terri S. Green', 'Goor1994', 'Buena Vista Garden', 'TerriSGreen@teleworm.us');
insert into wineCompRep VALUES (wineCompRep_sq.nextval, 8476074194, 'David P. Yanez', 'Forrounce1955', 'Plan Smart Partner', 'DavidPYanez@teleworm.us');
insert into wineCompRep VALUES (wineCompRep_sq.nextval, 3183363046, 'James A. Phillips', 'Pithenclacke1939', 'Schweggmanns', 'JamesAPhillips@rhyta.com');
insert into wineCompRep VALUES (wineCompRep_sq.nextval, 7012315678, 'Steven L. Sadler', 'Olown1949', 'Williams Bros.', 'LStevenLSadler@jourrapide.com');
insert into wineCompRep VALUES (wineCompRep_sq.nextval, 4022487618, 'Matthew C. Clark', 'Cusufattion', 'Maxiserve', 'MatthewCClark@teleworm.us');
insert into wineCompRep VALUES (wineCompRep_sq.nextval, 4786219440, 'Dorothy F. Thompson', 'Martur', 'Hughes Hatcher', 'LewisJHammond@dayrep.com');
insert into wineCompRep VALUES (wineCompRep_sq.nextval, 9013659009, 'Robert S. Scotti', 'Lontageman', 'Modern Realty', 'RobertSScotti@dayrep.com');
insert into wineCompRep VALUES (wineCompRep_sq.nextval, 7656522230, 'Alma R. Johnson', 'Whold1984', 'Luther Concepts', 'AlmaRJohnson@teleworm.us');
insert into wineCompRep VALUES (wineCompRep_sq.nextval, 6306202654, 'Juanita L. Elliott', 'Bels1991', 'Flagg Bros. Wines', 'JuanitaLElliott@jourrapide.com');

create table wine(
    wineID number,
    appelation varchar2(25),
    bottleName varchar2(25),
    alcoholPercentage number(4,2),
    class varchar2(25),
    brandName varchar2(25),
    netContent number(5,1),
    constraint wine_PK primary key (wineID)
);

create SEQUENCE wine_sq
    start with 100
    increment by 1;
insert into wine VALUES (wine_sq.nextval, 'Le Chambertin', 'Domaine Leroy Chambert', 13.5, 'Red - Savory and Classic', 'Domaine Leroy', 750);
insert into wine VALUES (wine_sq.nextval, 'Le Musigny', 'Domaine Musigny 1990', 12, 'Red - Savory and Classic', 'Domaine G. Roumier', 750);
insert into wine VALUES (wine_sq.nextval, 'Rioja', '2010 Remelluri de Remell', 13, 'Red - Savory and Classic', 'Remelluri Winery', 1500);
insert into wine VALUES (wine_sq.nextval, 'Napa Valley', '2014 Cabernet Sauvi', 14, 'Red - Bold and Structured', 'Honig Vineyard and Winery', 750);
insert into wine VALUES (wine_sq.nextval, 'Alexander Valley ', '2015 Alexander Chardonnay', 15, 'White - Buttery', 'Stonestreet Winery', 750);
insert into wine VALUES (wine_sq.nextval, 'Russian River Valley', '2015 Russian Noir', 13.9, 'Red - Savory and Classic', 'Gary Farrell Wines', 750);
insert into wine VALUES (wine_sq.nextval, 'Edna Valley', '2014 Stephen Pinot Noir', 13.7, 'Red - Light and Perfumed', 'Stephen Ross Wine Cellars', 750);
insert into wine VALUES (wine_sq.nextval, 'Ballard Canyon', '2015 Grown Syrah', 13.4, 'Red - Rich and Intense', 'Stolpman Vineyards', 750);
insert into wine VALUES (wine_sq.nextval, 'IGP Cotes Catalanes', '2013 Orin D Grenache', 14.1, 'Red - Rich and Intense', 'Department 66', 750);
insert into wine VALUES (wine_sq.nextval, 'Sauternes', '2014 Chateau Doisy', 14, 'Dessert - Lush', 'Chateau Doisy-Vedrines', 750);
insert into wine VALUES (wine_sq.nextval, 'Rioja Alta ', '2012 Bodegas Mug Reserva', 13.2, 'Red - Savory and Classic', 'Bodegas Muga', 750);

create table wineLabelForm(
    formID number,
    status varchar2(25),
    dateRejected date,
    dateSubmitted date,
    vintage number(4), 
    dateApproved date,
    wineID number,
    constraint wineLabelForm_PK primary key (formID),
    constraint  wineID_FK foreign key (wineID) references wine(wineID)
);


CREATE SEQUENCE wineLabelForm_sq
    start with 100
    increment by 1;

insert into wineLabelForm VALUES (wineCompRep_sq.nextval, 'Good status', '17-APR-2007', '17-JAN-2007', 1951, '17-APR-2007', 100);
insert into wineLabelForm VALUES (wineCompRep_sq.nextval, 'Normal status', '17-APR-2012', '17-JAN-2007', 1952, '17-APR-2012', 101);
insert into wineLabelForm VALUES (wineCompRep_sq.nextval, 'Bad status', '17-APR-2013', '17-JAN-2007', 1953, '17-APR-2013', 102);
insert into wineLabelForm VALUES (wineCompRep_sq.nextval, 'Bad status', '17-APR-2010', '17-JAN-2007', 1954, '17-APR-2010',103);
insert into wineLabelForm VALUES (wineCompRep_sq.nextval, 'Normal status', '17-APR-2011', '17-JAN-2007', 1955, '17-APR-2011',104);
insert into wineLabelForm VALUES (wineCompRep_sq.nextval, 'Good status', '17-APR-2007', '17-JAN-2007', 1956, '17-APR-2007',105);
insert into wineLabelForm VALUES (wineCompRep_sq.nextval, 'Good status', '17-APR-2007', '17-JAN-2007', 1957, '17-APR-2007',106);
insert into wineLabelForm VALUES (wineCompRep_sq.nextval, 'Normal status', '17-APR-2007', '17-JAN-2007', 1958, '17-APR-2007', 107);
insert into wineLabelForm VALUES (wineCompRep_sq.nextval, 'Normal status', '17-APR-2007', '17-JAN-2007', 1959, '17-APR-2007',108);
insert into wineLabelForm VALUES (wineCompRep_sq.nextval, 'Bad status', '17-APR-2007', '17-JAN-2007', 1960, '17-APR-2007', 109);
insert into wineLabelForm VALUES (wineCompRep_sq.nextval, 'Good status', '17-APR-2007', '17-JAN-2007', 1961, '17-APR-2007', 109);
insert into wineLabelForm VALUES (wineCompRep_sq.nextval, 'Normal status', '17-APR-2007', '17-JAN-2007', 1962, '17-APR-2007',109);
insert into wineLabelForm VALUES (wineCompRep_sq.nextval, 'Good status', '17-APR-2007', '17-JAN-2007', 1963, '17-APR-2007',109);
insert into wineLabelForm VALUES (wineCompRep_sq.nextval, 'Bad status', '17-APR-2007', '17-JAN-2007', 1964, '17-APR-2007',109);
insert into wineLabelForm VALUES (wineCompRep_sq.nextval, 'Normal status', '17-APR-2007', '17-JAN-2007', 1965, '17-APR-2007',109);
insert into wineLabelForm VALUES (wineCompRep_sq.nextval, 'Bad status', '17-APR-2007', '17-JAN-2007', 1966, '17-APR-2007',107);
insert into wineLabelForm VALUES (wineCompRep_sq.nextval, 'Normal status', '17-APR-2007', '17-JAN-2007', 1967, '17-APR-2007',107);
insert into wineLabelForm VALUES (wineCompRep_sq.nextval, 'Bad status', '17-APR-2007', '17-JAN-2007', 1968, '17-APR-2007',107);
insert into wineLabelForm VALUES (wineCompRep_sq.nextval, 'Good status', '17-APR-2007', '17-JAN-2007', 1969, '17-APR-2007',108);
insert into wineLabelForm VALUES (wineCompRep_sq.nextval, 'Good status', '17-APR-2007', '17-JAN-2007', 1970, '17-APR-2007',101);

create table Process (
    "Date" date,
    "comment" varchar2(100),
    currentReviewerID number,
    formID number,
    constraint Process_PK primary key ("Date"),
    constraint ttbID_FK foreign key (currentReviewerID) references superAgent(ttbID),
    constraint form_ID foreign key (formID) references wineLabelForm(formID)
);

insert into Process values ('14-Jan-2015', 'I am so happy', 101, 102);
insert into Process values ('14-APR-2016', 'I am so unhappy', 101, 102);
insert into Process values ('12-May-2017', 'I am very happy', 105, 102);
insert into Process values ('17-APR-2017', "Good quality", 101, 105);
insert into Process values ('20-JUN-2018', "Average quality", 103, 102);
insert into Process values ('03-JUL-2015', "Bad quality", 104, 103);


select * from Account;
select * from governmentAgent;
select * from superAgent;
select * from wineCompRep;
select * from wine;

