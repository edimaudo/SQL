CREATE TABLE staff (
st_ID int NOT NULL,
st_FName varchar(60) NOT NULL, 
st_LName varchar(60) NOT NULL, 
st_AddrLine1 varchar(30) NOT NULL, 
st_AddrLine2 varchar(30) NOT NULL, 
st_City varchar(25) NOT NULL, 
st_Postcode varchar(7) NOT NULL, 
st_Email varchar(30),
st_Telephone varchar(11), 
PRIMARY KEY (st_ID)
);

CREATE TABLE location ( 
l_ID int NOT NULL,
l_Name varchar(40) NOT NULL, 
l_AddrLine1 varchar(30) NOT NULL, 
l_AddrLine2 varchar(30) NOT NULL, 
l_City varchar(25) NOT NULL, 
l_Postcode varchar(7) NOT NULL, 
PRIMARY KEY (l_ID)
);

CREATE TABLE product ( 
p_ID int NOT NULL,
p_Name varchar(30) NOT NULL, 
p_Team varchar(20) NOT NULL, 
p_Year int NOT NULL,
p_Version varchar(10) NOT NULL, 
p_Desc varchar(90) NOT NULL, 
p_Player varchar(25),
p_Brand varchar(15),
p_UnitPrice DECIMAL(3,2) NOT NULL, 
PRIMARY KEY (p_ID)
);

CREATE TABLE time_t (
t_ID int NOT NULL,
t_Day varchar(11) NOT NULL, 
t_Week int NOT NULL,
t_Month varchar(14) NOT NULL, 
t_Year int NOT NULL,
t_Hour int NOT NULL,
t_Min int NOT NULL,
t_Second int NOT NULL, 
t_Quarter varchar(2) NOT NULL, 
PRIMARY KEY (t_ID)
);

CREATE TABLE payment ( 
pm_ID int NOT NULL,
pm_Type varchar(10), 
PRIMARY KEY (pm_ID)
);

CREATE TABLE sales (
s_ID int NOT NULL PRIMARY KEY,
s_t_ID int NOT NULL //time key
s_l_ID int NOT NULL //location key
s_p_ID int NOT NULL //product key
s_st_ID int NOT NULL //staff key
s_Total DECIMAL(5,2) NOT NULL,
s_pm_ID int NOT NULL,
PRIMARY KEY (s_ID),
CONSTRAINT time_fk FOREIGN KEY (s_t_ID) REFERENCES time_t(t_ID),
CONSTRAINT location_fk FOREIGN KEY (s_l_ID) REFERENCES location(l_ID),
CONSTRAINT product_fk CONSTRAINT time_fk FOREIGN KEY (s_p_ID) REFERENCES product(p_ID), 
CONSTRAINT staff_fk FOREIGN KEY (s_st_ID) REFERENCES staff(st_ID),
CONSTRAINT payment_fk FOREIGN KEY (s_pm_ID) REFERENCES payment(pm_ID)
 );


 //data
 //LOCATION
INSERT INTO location (l_Name,l_AddrLine1,l_AddrLine2,l_City,l_Postcode)
VALUES ('El Classico Hackney', '4, Kingsland High St', 'Hackney', 'London', 'E8 1DJ');
INSERT INTO location (l_Name,l_AddrLine1,l_AddrLine2,l_City,l_Postcode)
VALUES ('El Classico Covent Garden', '11, Tavistock St', 'Covent Garden', 'London', 'WC2 8PT');
INSERT INTO location (l_Name,l_AddrLine1,l_AddrLine2,l_City,l_Postcode)
VALUES ('El Classico Hammersmith', '92, Goldhawk Rd', 'Hammersmith', 'London', 'W12 8HH');
INSERT INTO location (l_Name,l_AddrLine1,l_AddrLine2,l_City,l_Postcode) VALUES ('El Classico Enfield', '8, Church St', 'Enfield', 'London', 'EN2 6AA');
INSERT INTO location (l_Name,l_AddrLine1,l_AddrLine2,l_City,l_Postcode)
VALUES ('El Classico Greenwich', '22, Trafalgar Road', 'Greenwich', 'London', 'SE9 9UW');


//PAYMENT
INSERT INTO payment (pm_Type) VALUES ('Cash'); INSERT INTO payment (pm_Type) VALUES ('Card'); INSERT INTO payment (pm_Type) VALUES ('Voucher');

//STAFF
INSERT INTO staff (st_FName, st_LName,st_AddrLine1,st_AddrLine2,st_City,st_Postcode,st_Email,st_Telephone)
VALUES ('Thierry', 'Henry', '154, St. Thomas Road', 'Highbury', 'London', 'N4 2QP', 'kinghenry@gmail.com','07864364532');


INSERT INTO staff (st_FName, st_LName,st_AddrLine1,st_AddrLine2,st_City,st_Postcode,st_Email,st_Telephone)
VALUES ('Dennis', 'Bergkamp', '65, Gillespie Road', 'Highbury', 'London', 'N5 1HL', 'bergkamp@gmail.com','07936483748');


INSERT INTO staff (st_FName, st_LName,st_AddrLine1,st_AddrLine2,st_City,st_Postcode,st_Email,st_Telephone)
VALUES ('Paolo', 'Maldini', '1, Allen Street', 'Kensington', 'London', 'W8 6UX', 'p.maldini@gmail.com','07473647369');


INSERT INTO staff (st_FName, st_LName,st_AddrLine1,st_AddrLine2,st_City,st_Postcode,st_Email,st_Telephone)
VALUES ('Alessandro', 'Nesta', '184, Kensington High Street', 'Kensington', 'London', 'W8 6SH', 'alexnesta@gmail.com','07293850946');
INSERT INTO staff (st_FName, st_LName,st_AddrLine1,st_AddrLine2,st_City,st_Postcode,st_Email,st_Telephone)
VALUES ('Xavi', 'Hernandez', '220, City Road', 'Shoreditch', 'London', 'EC1 2NR', 'xavi4@gmail.com','07385983844');
INSERT INTO staff (st_FName, st_LName,st_AddrLine1,st_AddrLine2,st_City,st_Postcode,st_Email,st_Telephone)
VALUES ('Carles', 'Puyol', '56, City Road', 'Shoreditch', 'London', 'EC1 1BD', 'c.puyol@gmail.com','07904111242');
INSERT INTO staff (st_FName, st_LName,st_AddrLine1,st_AddrLine2,st_City,st_Postcode,st_Email,st_Telephone)
VALUES ('Oliver', 'Kahn', '235, Regent Street', 'Mayfair', 'London', 'W1B 2EL', 'oliverkahn@gmail.com','07748392835');
INSERT INTO staff (st_FName, st_LName,st_AddrLine1,st_AddrLine2,st_City,st_Postcode,st_Email,st_Telephone)
VALUES ('Mark', 'van Bommel', '318, Oxford Street', 'Mayfair', 'London', 'W1C 1HF', 'vanbommel@gmail.com','07819374937');
INSERT INTO staff (st_FName, st_LName,st_AddrLine1,st_AddrLine2,st_City,st_Postcode,st_Email,st_Telephone)
VALUES ('Zinedine', 'Zidane', '11, Queensway', 'Hyde Park', 'London', 'W2 3RR', 'zizou@gmail.com','07856473999');
INSERT INTO staff (st_FName, st_LName,st_AddrLine1,st_AddrLine2,st_City,st_Postcode,st_Email,st_Telephone)
VALUES ('Claude', 'Makelele', '33, Sussex Street', 'Hyde Park', 'London', 'W2 2TH', 'makelele@gmail.com','07748930284');

//PRODUCT
INSERT INTO `product` (`p_ID`, `p_Name`, `p_Team`, `p_Year`, `p_Version`, `p_Desc`, `p_Player`, `p_Brand`, `p_UnitPrice`)
VALUES (1,'Barcelona 10/11','FC Barcelona',2010,'Home','Worn by the Barcelona team that won every title in the 2010/11 season','','Nike',200.00),
(2,'Zidane - UEFA CL Final 2002','Real Madrid CF',2002,'Home','Worn by Zinedine Zidane in the 2002 Champions League Final against Bayer Leverkusen','ZIDANE','Adidas',250.00),
(3,'Ronaldo - World Cup 2002','Brazil',2002,'Home','Worn by Ronaldo during the 2002 World Cup Finals','RONALDO','NIKE',250.00),
(4,'Arsenal 2003/04','Arsenal FC',2004,'Home','Worn by the Arsenal team in 2004 who went unbeaten in the league','','NIKE',200.00),
(5,'Ronaldinho - UEFA CL R16 2005','FC Barcelona',2005,'Away','Worn by Ronaldinho in match against Chelsea at Stamford Bridge','RONALDINHO','NIKE',250.00),
(6,'Manchester United - 1998/99','Manchester United FC',1999,'Home','Worn by Manchester United team that won the treble in 1999','','NIKE',200.00),
(10,'Wayne Rooney -UEFA CL Grp 2004','Manchester United FC',2004,'Home','Worn by Rooney on his debut for Man United vs. Fenerbahce','ROONEY','NIKE',250.00),
(11,'Chelsea 2004/05','Chelsea FC',2005,'Home','Worn by Chelsea that won first league title in 50 years',NULL,'UMBRO',200.00),
(17,'A. Iniesta - UEFA CL SF 2009','FC Barcelona',2009,'Away','Worn by Iniesta who scored last minute winner at Chelsea','INIESTA','NIKE',250.00),
(18,'Roberto Carlos - TDF 1997','Brazil',1997,'Home','Worn by Roberto Carlos who scored an amazing free kick vs France','R. CARLOS','NIKE',250.00),
(19,'S. Tshabalala World Cup 2010','South Africa',2010,'Home','Worn by Tshabalala who scored an amazing goal for South Africa','TSHABALALA','ADIDAS',250.00),
(20,'Liverpool 2004/05','Liverpool FC',2005,'Home','Worn by Liverpool team who made historic CL comeback vs Milan',NULL,'REEBOK',200.00),
(21,'Porto 2003/04','FC Porto',2004,'Home','Worn by Porto team who eliminated Man United at Old Trafford',NULL,'NIKE',200.00),
(22,'Zidane - World Cup 1998','France',1998,'Home','Worn by Zidane who scored two goals to beat Brazil in the final','ZIDANE','ADIDAS',250.00),
(23,'Michael Owen - World Cup 1998','England',1998,'Home','Worn by a young Owen who scored a great goal vs Argentina','OWEN','UMBRO',250.00); 
(23,'Michael Owen - World Cup 1998','England',1998,'Home','Worn by a young Owen who scored a great goal vs Argentina','OWEN','UMBRO',250.00);


//TIME
INSERT INTO `time_t` (`t_ID`, `t_Day`, `t_Week`, `t_Month`, `t_Year`, `t_Hour`, `t_Min`, `t_Second`, `t_Quarter`, `t_DayM`)
VALUES (1,'Monday',1,'January',2015,15,10,42,'Q1',1), (2,'Monday',1,'January',2015,16,23,15,'Q1',1), 
(3,'Monday',1,'January',2015,15,38,4,'Q1',1), 
(4,'Monday',1,'January',2015,17,20,57,'Q1',1), 
(5,'Monday',1,'January',2015,12,56,26,'Q1',1), 
(6,'Monday',1,'January',2015,10,8,8,'Q1',1), 
(7,'Monday',1,'January',2015,13,42,58,'Q1',1), 
(8,'Monday',1,'January',2015,10,13,40,'Q1',2), 
(9,'Monday',1,'January',2015,14,39,36,'Q1',2), 
(10,'Monday',1,'January',2015,17,46,33,'Q1',2), 
(11,'Tuesday',1,'January',2015,12,37,6,'Q1',2), 
(12,'Tuesday',1,'January',2015,11,2,28,'Q1',2), 
(13,'Tuesday',1,'January',2015,10,6,15,'Q1',2), 
(14,'Tuesday',2,'January',2015,15,14,22,'Q1',2), 
(15,'Tuesday',2,'January',2015,10,51,42,'Q1',3), 
(16,'Tuesday',2,'January',2015,11,43,35,'Q1',3), 
(17,'Tuesday',2,'January',2015,11,38,25,'Q1',3), 
(18,'Tuesday',2,'January',2015,15,35,58,'Q1',3), 
(19,'Tuesday',2,'January',2015,14,13,19,'Q1',3), 
(20,'Tuesday',2,'January',2015,17,29,15,'Q1',3), 
(21,'Wednesday',2,'January',2015,12,2,6,'Q1',3), 
(22,'Wednesday',2,'January',2015,12,6,49,'Q1',4), 
(23,'Wednesday',2,'January',2015,13,6,38,'Q1',4), 
(24,'Wednesday',2,'January',2015,17,29,0,'Q1',4), 
(25,'Wednesday',2,'January',2015,14,43,29,'Q1',4), 
(26,'Wednesday',2,'January',2015,11,18,6,'Q1',4);


//SALES
INSERT INTO `sales` (`s_ID`, `t_ID`, `l_ID`, `p_ID`, `st_ID`, `s_Total`, `pm_ID`) VALUES (1,1,2,23,8,200.00,1),
(2,2,1,18,2,250.00,2),
(3,3,5,19,8,250.00,2),
(4,4,3,18,5,200.00,2), 
(5,5,1,20,6,250.00,2), (6,6,1,22,5,200.00,1), 
(7,7,2,4,7,200.00,2), (8,8,1,5,7,200.00,1), (9,9,2,22,7,250.00,2), 
(10,10,1,11,3,250.00,1), (11,11,5,3,1,250.00,1), (12,12,2,20,1,200.00,1), 
(13,13,2,1,2,200.00,1), (14,14,2,2,9,200.00,2), (15,15,3,4,4,250.00,1), 
(16,16,3,4,1,200.00,2), (17,17,3,22,10,200.00,1), (18,18,3,18,4,200.00,1), 
(19,19,3,4,5,200.00,1), (20,20,5,19,6,250.00,1), (21,21,1,20,2,250.00,2), 
(22,22,1,2,9,250.00,1), (23,23,5,20,3,200.00,2), (24,24,4,17,4,200.00,1), 
(25,25,4,22,4,250.00,2), (26,26,1,23,10,200.00,1);
