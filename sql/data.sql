-- ----------------------------
-- DML - Creating the Data
-- ----------------------------

-- Inserting Hotel Chains ----------------------------

-- Inserting 5 hotel chains
INSERT INTO hotel_chain VALUES 
('NorthAmHotels','0'),
('UltraRes','0'),
('BestEastern','0'),
('ModernResorts','0'),
('Marrion','0');

-- Inserting managers (needed to create hotels) ----------------------------

INSERT INTO employee(employee_name,role,sin,address,chain_name)  VALUES 
('Jim Manage','manager','1268253','5 Alderney Dr',          'NorthAmHotels'),
('Joe Bos',  'manager', '1257835','10 82 Ave NW, Edmonton','UltraRes'),
('Susan Toc','manager', '12336','22 Salter St, Westminster', 'BestEastern'),
('Jim North','manager', '865586','50 9 Ave N, Golden',     'ModernResorts'),
('Kane Prem','manager', '79463143','37 smith Rd, Richmond', 'Marrion');


-- Inserting Hotels ----------------------------


-- Inserting 8 hotels for NorthAmHotels
INSERT INTO hotel VALUES 
('NorthAmHotels','Vista',      '1','73 Alderney Dr, Dartmouth',                   'VistaHelp@northAm.com','1','0'),
('NorthAmHotels','Oasis',      '2','5308 Boulevard Saint-Laurent, Montreal',     'OasisHelp@northAm.com','1','0'),
('NorthAmHotels','Solace',     '3','701 Niakwa Rd, St Boniface',       'SolaceHelp@northAm.com','1','0'),
('NorthAmHotels','Aria',       '4','10805 82 Ave NW, Edmonton',        'AriaHelp@northAm.com','1','0'),
('NorthAmHotels','Harmony',    '5','172 Dollard des Ormeaux, Gatineau','HarmonyHelp@northAm.com','1','0'),
('NorthAmHotels','Elysium',    '1','4500 Kingsway, Burnaby',           'ElysiumHelp@northAm.com','1','0'),
('NorthAmHotels','Tranquil',   '2','220 Salter St, Westminster',       'TranquilHelp@northAm.com','1','0'),
('NorthAmHotels','Serenity',   '3','13080 St Albert Trail, St Albert', 'SerenityHelp@northAm.com','1','0');

-- Inserting 8 hotels for UltraRes
INSERT INTO hotel VALUES 
('UltraRes','Haven',       '1','6185 Fraser St, Vancouver',        'HavenTrips@ultrares.com','2','0'),
('UltraRes','Zen',         '2','3388 Bd Taschereau, Greensfield',  'ZenTrips@ultrares.com','2','0'),
('UltraRes','Refine',      '3','2323 Arbot Rd, Nanaimo',           'RefineTrips@ultrares.com','2','0'),
('UltraRes','Relaxation Inn','4','132 Josephine St, North Huron',  'RelaxationTrips@ultrares.com','2','0'),
('UltraRes','Luxuria',     '5','739 Lake Bonavista Dr SE, Calgary','LuxuriaTrips@ultrares.com','2','0'),
('UltraRes','Frugality',   '1','501 9 Ave N, Golden',              'FrugalityTrips@ultrares.com','2','0'),
('UltraRes','Value',       '2','13580 102 Ave, Surey',             'ValueTrips@ultrares.com','2','0'),
('UltraRes','QuickTrip',   '3','022 Government St, Victoria',     'QuickTripTrips@ultrares.com','2','0');

-- Inserting 8 hotels for BestEastern
INSERT INTO hotel VALUES 
('BestEastern','Premier',   '1','2860 Cruickshank St, Abbotsford',     'PremierEast@BestEastern.com','3','0'),
('BestEastern','UltraEast', '2','1250 St Denis Rue, Laval',            'UltraEast@BestEastern.com','3','0'),
('BestEastern','Opulence',  '3','3779 smith Rd, Richmond',             'OpulenceEast@BestEastern.com','3','0'),
('BestEastern','The Manor', '4','308 Dundas St W, Whitby',             'TheManorEast@BestEastern.com','3','0'),
('BestEastern','Hideaway',  '5','131 Madawaska Chemin, Grand Falls',   'HideawayEast@BestEastern.com','3','0'),
('BestEastern','Prestige',  '1','301 Wellington St, Ottawa',           'PrestigeEast@BestEastern.com','3','0'),
('BestEastern','Lodge',     '2','1750 Erbs Rd, Agatha',                'LodgeEast@BestEastern.com','3','0'),
('BestEastern','Chateau',   '3','3599 Commercial St, Vancouver',       'ChateauEast@BestEastern.com','3','0');

-- Inserting 8 hotels for ModernResorts
INSERT INTO hotel VALUES 
('ModernResorts','Urban',     '1','44 Britannia Rd E, Mississauga',        'UrbanRes@ModernResorts.com','4','0'),
('ModernResorts','Contempor', '2','1897 Queen E, Toronto',                 'ContemporRes@ModernResorts.com','4','0'),
('ModernResorts','Slode',     '3','250H MacEwan Hall, Calgary',            'SlodeRes@ModernResorts.com','4','0'),
('ModernResorts','Tresid',    '4','2300 Yonge St, Toronto',                'TresidRes@ModernResorts.com','4','0'),
('ModernResorts','CutEdge',   '5','842 Québec 138, Cap-Sante',             'CutEdgeRes@ModernResorts.com','4','0'),
('ModernResorts','Corner',    '1','20811 Fraser Hwy, Langley',             'CornerRes@ModernResorts.com','4','0'),
('ModernResorts','Underhill', '2','A 275 Principale, Sauveur',             'UnderhillRes@ModernResorts.com','4','0'),
('ModernResorts','Overhill',  '3','4396 Boulevard Saint-Laurent, Montreal','OverhillRes@ModernResorts.com','4','0');

-- Inserting 8 hotels for Marrion
INSERT INTO hotel VALUES 
('Marrion','Grim',     '1','1173 Michener, Sarnia',             'GrimReports@Marrion.com','5','0'),
('Marrion','Crum',     '2','3430 Weston, New york',            'CrumReports@Marrion.com','5','0'),
('Marrion','Squal',    '3','6416 Main St, Vancouver',          'SqualReports@Marrion.com','5','0'),
('Marrion','Ding',     '4','18730 Fraser Hwy #204, Surrey',    'DingReports@Marrion.com','5','0'),
('Marrion','Tattao',   '5','48 Rue Dante, Montreal',           'TattaoReports@Marrion.com','5','0'),
('Marrion','Dill',     '1','411 Bayfield St B1, Barrie',       'DillReports@Marrion.com','5','0'),
('Marrion','Waterfoul','2','1900 E Trans Canada HWY, Kamloops','WaterfoulReports@Marrion.com','5','0'),
('Marrion','Sholly',   '3','5472 Spring Garden Rd, Halifax',   'ShollyReports@Marrion.com','5','0');


-- Inserting rooms ----------------------------

-- This code generates 5 rooms per hotel
-- The rooms have room numbers  100,200,300,400,500, 
-- The rooms have prices        199.99,299.99,399.99,499.99,599.99
-- The rooms have capacities    1,2,3,4,5

INSERT INTO room  
(
    SELECT * FROM
    (
    SELECT chain_name, hotel_name
    FROM hotel
    )
    CROSS JOIN
    (
    SELECT i, cast(i as numeric)+99.99, i/100
    FROM generate_series(100,500,100) AS t(i)
    )
);

--  Inserting customers ----------------------------


INSERT INTO customer VALUES 
(DEFAULT,'Joe K',       '1 Spring Garden Rd, Halifax',  '4896742', '1985-02-10'),
(DEFAULT,'John Burming','1 Michener, Sarnia',           '40927613', '1995-07-12');


--  Inserting employees ----------------------------

-- This code generates 2 employees for each hotel.
-- 1 Front desk agent, and 1 cleaner
-- They have generic data

with full_edata as (
        -- 1 This query generates the 80 employees
		SELECT employee_name, role, sin, address, chain_name, hotel_name
			FROM
			(
				SELECT chain_name, hotel_name, role, ROW_NUMBER() OVER (ORDER BY chain_name) AS rn
				FROM
				(
					SELECT chain_name, hotel_name
					FROM hotel
				)
				CROSS JOIN
				(
					SELECT * FROM
					(VALUES('Cleaner'),('Front Desk Agent')) AS Employees(role)
				)
			) AS t1
			FULL OUTER JOIN
			(
				SELECT employee_name,sin,address, ROW_NUMBER() OVER (ORDER BY employee_name) AS rn
				FROM
				(
				SELECT CONCAT('Jon Doe',i), i+12981361, CONCAT(i,' Employee Street, Bermuda')
				FROM generate_series(1,80) AS t(i)
				) AS eData(employee_name,sin,address)
			) AS t2
			ON t1.rn = t2.rn
        -- /1
	),
 etable as (
    -- this part adds them to the employee table
	INSERT into employee (employee_name, role, sin, address, chain_name)
	SELECT employee_name, role, sin, address, chain_name FROM full_edata
	returning *
)
-- this part adds them to the works_at table
INSERT into works_at
select employee_id, etable.chain_name, hotel_name
from full_edata JOIN etable 
ON full_edata.employee_name=etable.employee_name AND full_edata.sin=etable.sin
;


-- Inserting Bookings ----------------------------

INSERT INTO booking_renting VALUES ('NorthAmHotels','Vista','500', '1','2014-10-19 10:23:54','2014-10-19 12:23:54','false');
INSERT INTO booking_renting VALUES ('Marrion','Squal','103', '2','2024-03-21 10:23:54','2024-05-25 12:23:54','true');
INSERT INTO booking_renting VALUES ('Hilton','Newport','226', '3','2024-03-21 10:23:54','2024-05-25 12:23:54','true');
INSERT INTO booking_renting VALUES ('Marriott','Atlantic','307', '2','2024-03-21 10:23:54','2024-05-25 12:23:54','false');
INSERT INTO booking_renting VALUES ('Hinton','Central','811', '4','2024-03-21 10:23:54','2024-05-25 12:23:54','false');
INSERT INTO booking_renting VALUES ('Wyndham','Suites','319', '1','2024-03-21 10:23:54','2024-05-25 12:23:54','true');
-- Since the entry above has 'true' for renting, we make Marrion Squal's Front Desk Agent check the customer in
INSERT INTO checked_in_by VALUES
('Marrion','Squal','500', '2','2024-03-21 10:23:54','2024-05-25 12:23:54',
	(SELECT employee_id FROM employee
	WHERE role='Front Desk Agent' AND employee_id IN
	(SELECT employee_id FROM works_at WHERE chain_name='Marrion' AND hotel_name='Squal'))
),
('Hilton','Newport','226', '3','2024-03-21 10:23:54','2024-05-25 12:23:54',
	(SELECT employee_id FROM employee
	WHERE role='Front Desk Agent' AND employee_id IN
	(SELECT employee_id FROM works_at WHERE chain_name='Hilton' AND hotel_name='Newport'))
),
('Wyndham','Suites','319', '1','2024-03-21 10:23:54','2024-05-25 12:23:54',
	(SELECT employee_id FROM employee
	WHERE role='Front Desk Agent' AND employee_id IN
	(SELECT employee_id FROM works_at WHERE chain_name='Wyndham' AND hotel_name='Suites'))
);

-- Inserting Room Features ---------------------

INSERT INTO room_additional VALUES ("Marriott","Atlantic","307","Seaside View");
INSERT INTO room_additional VALUES ("Marriott", "Marriott Marquis", "123", "Seaside View, Single Bed, Balcony");
INSERT INTO room_additional VALUES ("Hilton", "Hilton Garden Inn", "225", "City View, Double Bed");
INSERT INTO room_additional VALUES ("Hyatt", "Hyatt Regency", "301", "Mountain View, King Bed");
INSERT INTO room_additional VALUES ("InterContinental", "InterContinental San Francisco", "112", "City View, Single Bed");
INSERT INTO room_additional VALUES ("Radisson", "Radisson Blu Aqua Hotel", "209", "Lake View, Queen Bed, Mini Bar");
INSERT INTO room_additional VALUES ("Accor", "Sofitel New York", "305", "City View, King Bed, Balcony");
INSERT INTO room_additional VALUES ("Wyndham", "Wyndham Grand Orlando Resort", "127", "Pool View, Double Bed, Balcony");
INSERT INTO room_additional VALUES ("Choice Hotels", "Cambria Hotel New Orleans", "229", "City View, Single Bed");
INSERT INTO room_additional VALUES ("Best Western", "Best Western Plus Music Row", "303", "City View, King Bed");
INSERT INTO room_additional VALUES ("Four Seasons", "Four Seasons Hotel Miami", "115", "Ocean View, Queen Bed, Mini Bar");


INSERT INTO room_amenities VALUES ("Marrion","Squal","103","Kitchen, Doubles");
INSERT INTO room_amenities VALUES ("Marriott", "Marriott Marquis", "123", "TV, Air Conditioner, Free Wifi");
INSERT INTO room_amenities VALUES ("Hilton", "Hilton Garden Inn", "225", "TV, Air Conditioner, Large Fridge"); 
INSERT INTO room_amenities VALUES ("Hyatt", "Hyatt Regency", "301", "Free Wifi, Large Fridge, TV");
INSERT INTO room_amenities VALUES ("InterContinental", "InterContinental San Francisco", "112", "Air Conditioner, Free Wifi, TV");
INSERT INTO room_amenities VALUES ("Radisson", "Radisson Blu Aqua Hotel", "209", "Large Fridge, TV, Air Conditioner");
INSERT INTO room_amenities VALUES ("Accor", "Sofitel New York", "305", "TV, Free Wifi, Large Fridge");
INSERT INTO room_amenities VALUES ("Wyndham", "Wyndham Grand Orlando Resort", "127", "Air Conditioner, Large Fridge, Free Wifi");
INSERT INTO room_amenities VALUES ("Choice Hotels", "Cambria Hotel New Orleans", "229", "TV, Air Conditioner, Free Wifi");
INSERT INTO room_amenities VALUES ("Best Western", "Best Western Plus Music Row", "303", "Large Fridge, Free Wifi, TV");
INSERT INTO room_amenities VALUES ("Four Seasons", "Four Seasons Hotel Miami", "115", "Air Conditioner, TV, Free Wifi");

-- Inserting Hotel Room Numbers ------------------

INSERT INTO hotel_phone_numbers VALUES ("Hilton","Newport","+1(905)-470-8500");
INSERT INTO hotel_phone_numbers VALUES ("Marriott", "Marriott Marquis", "(123) 456-7890");
INSERT INTO hotel_phone_numbers VALUES ("Hilton", "Hilton Garden Inn", "(234) 567-8901");
INSERT INTO hotel_phone_numbers VALUES ("Hyatt", "Hyatt Regency", "(345) 678-9012");
INSERT INTO hotel_phone_numbers VALUES ("InterContinental", "InterContinental San Francisco", "(456) 789-0123");
INSERT INTO hotel_phone_numbers VALUES ("Radisson", "Radisson Blu Aqua Hotel", "(567) 890-1234");
INSERT INTO hotel_phone_numbers VALUES ("Accor", "Sofitel New York", "(678) 901-2345");
INSERT INTO hotel_phone_numbers VALUES ("Wyndham", "Wyndham Grand Orlando Resort", "(789) 012-3456");
INSERT INTO hotel_phone_numbers VALUES ("Choice Hotels", "Cambria Hotel New Orleans", "(890) 123-4567");
INSERT INTO hotel_phone_numbers VALUES ("Best Western", "Best Western Plus Music Row", "(901) 234-5678");
INSERT INTO hotel_phone_numbers VALUES ("Four Seasons", "Four Seasons Hotel Miami", "(012) 345-6789");


-- Inserting Chain Addresses ------------------

INSERT INTO chain_address VALUES ("Hilton","8500_WardenAvenueMarkham_ONCA_L6G1A5");
INSERT INTO chain_address VALUES ("Marriott", "10400 Fernwood Rd, Bethesda, MD 20817, USA");
INSERT INTO chain_address VALUES ("Hilton", "7930 Jones Branch Dr, McLean, VA 22102, USA");
INSERT INTO chain_address VALUES ("Hyatt", "150 N Riverside Plaza, Chicago, IL 60606, USA");
INSERT INTO chain_address VALUES ("InterContinental", "3 Ravinia Dr #100, Atlanta, GA 30346, USA");
INSERT INTO chain_address VALUES ("Radisson", "701 Carlson Pkwy, Minnetonka, MN 55305, USA");
INSERT INTO chain_address VALUES ("Accor", "82 Rue Henri Farman, 92130 Issy-les-Moulineaux, France");
INSERT INTO chain_address VALUES ("Wyndham", "22 Sylvan Way, Parsippany, NJ 07054, USA");
INSERT INTO chain_address VALUES ("Choice Hotels", "1 Choice Hotels Cir # 400, Rockville, MD 20850, USA");
INSERT INTO chain_address VALUES ("Best Western", "6201 N 24th Pkwy, Phoenix, AZ 85016, USA");
INSERT INTO chain_address VALUES ("Four Seasons", "1165 Leslie St, North York, ON M3C 2K8, Canada");
