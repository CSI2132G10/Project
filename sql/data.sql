-- ----------------------------
-- DML - Creating the Data
-- ----------------------------

-- NOTE THAT THIS IS STILL UNFINISHED!!!

-- Inserting 5 hotel chains
INSERT INTO hotel_chain VALUES ('NorthAmHotels','0');
INSERT INTO hotel_chain VALUES ('UltraRes','0');
INSERT INTO hotel_chain VALUES ('BestEastern','0');
INSERT INTO hotel_chain VALUES ('ModernResorts','0');
INSERT INTO hotel_chain VALUES ('Marrion','0');

-- Inserting a manager (needed to create hotels)
INSERT INTO employee VALUES ('1','jim','manager','123','homaddress','NorthAmHotels');

-- Inserting 8 hotels for NorthAmHotels
INSERT INTO hotel VALUES ('NorthAmHotels','Vista',      '1','73 Alderney Dr',               'email1','1');
INSERT INTO hotel VALUES ('NorthAmHotels','Oasis',      '2','5308 Boulevard Saint-Laurent', 'email1','1');
INSERT INTO hotel VALUES ('NorthAmHotels','Solace',     '3','701 Niakwa Rd, St Boniface',   'email1','1');
INSERT INTO hotel VALUES ('NorthAmHotels','Aria',       '4','10805 82 Ave NW, Edmonton',    'email1','1');
INSERT INTO hotel VALUES ('NorthAmHotels','Harmony',    '5','172 Dollard des Ormeaux, Gatineau','email1','1');
INSERT INTO hotel VALUES ('NorthAmHotels','Elysium',    '1','4500 Kingsway, Burnaby',       'email1','1');
INSERT INTO hotel VALUES ('NorthAmHotels','Tranquil',   '2','220 Salter St, Westminster',   'email1','1');
INSERT INTO hotel VALUES ('NorthAmHotels','Serenity',   '3','13080 St Albert Trail, St Albert','email1','1');

-- Inserting 8 hotels for UltraRes
-- TO BE COMPLETED AT A LATER DATE




INSERT INTO room VALUES ('NorthAmHotels','Vista','500','1000','3');
INSERT INTO customer VALUES ('1','customjoe','house address','6','1985-02-10');
INSERT INTO booking_renting VALUES ('NorthAmHotels','Vista','500','1','2004-10-19 10:23:54','2004-10-19 12:23:54','false');
