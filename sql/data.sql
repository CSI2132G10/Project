-- ----------------------------
-- DML - Creating the Data
-- ----------------------------

-- Inserting Hotel Chains ----------------------------

-- Inserting 5 hotel chains
INSERT INTO hotel_chain VALUES 
('Hilton','0'),
('UltraRes','0'),
('BestWestern','0'),
('ModernResorts','0'),
('Marriott','0');

-- Inserting managers (needed to create hotels) ----------------------------

INSERT INTO employee(employee_name,role,sin,address,chain_name)  VALUES 
('Jim Manage','manager','1268253','5 Alderney Dr',          'Hilton'),
('Joe Bos',  'manager', '1257835','10 82 Ave NW, Edmonton','UltraRes'),
('Susan Toc','manager', '12336','22 Salter St, Westminster', 'BestWestern'),
('Jim North','manager', '865586','50 9 Ave N, Golden',     'ModernResorts'),
('Kane Prem','manager', '79463143','37 smith Rd, Richmond', 'Marriott');


-- Inserting Hotels ----------------------------


-- Inserting 8 hotels for Hilton
INSERT INTO hotel VALUES 
('Hilton','Vista',      '1','73 Alderney Dr, Dartmouth',                   'VistaHelp@hilton.com','1','0'),
('Hilton','Oasis',      '2','5308 Boulevard Saint-Laurent, Montreal',     'OasisHelp@hilton.com','1','0'),
('Hilton','Solace',     '3','701 Niakwa Rd, St Boniface',       'SolaceHelp@hilton.com','1','0'),
('Hilton','Aria',       '4','10805 82 Ave NW, Edmonton',        'AriaHelp@hilton.com','1','0'),
('Hilton','Harmony',    '5','172 Dollard des Ormeaux, Gatineau','HarmonyHelp@hilton.com','1','0'),
('Hilton','Elysium',    '1','4500 Kingsway, Burnaby',           'ElysiumHelp@hilton.com','1','0'),
('Hilton','Hilton Garden Inn',   '2','220 Salter St, Westminster',       'HiltonGardenInnHelp@hilton.com','1','0'),
('Hilton','Serenity',   '3','13080 St Albert Trail, St Albert', 'SerenityHelp@hilton.com','1','0');

-- Inserting 8 hotels for UltraRes
INSERT INTO hotel VALUES 
('UltraRes','Haven',       '1','6185 Fraser St, Vancouver',        'HavenTrips@ultrares.com','2','0'),
('UltraRes','Zen',         '2','3388 Bd Taschereau, Greensfield',  'ZenTrips@ultrares.com','2','0'),
('UltraRes','Refine',      '3','2323 Arbot Rd, Nanaimo',           'RefineTrips@ultrares.com','2','0'),
('UltraRes','Relaxation Inn','4','132 Josephine St, North Huron',  'RelaxationTrips@ultrares.com','2','0'),
('UltraRes','Luxuria',     '5','739 Lake Bonavista Dr SE, Calgary','LuxuriaTrips@ultrares.com','2','0'),
('UltraRes','Sofitel',   '1','501 9 Ave N, Golden',              'SofitelTrips@ultrares.com','2','0'),
('UltraRes','Value',       '2','13580 102 Ave, Surey',             'ValueTrips@ultrares.com','2','0'),
('UltraRes','Wyndham',   '3','022 Government St, Victoria',     'WyndhamTrips@ultrares.com','2','0');

-- Inserting 8 hotels for BestWestern
INSERT INTO hotel VALUES 
('BestWestern','Cambria',   '1','2860 Cruickshank St, Abbotsford',     'CambriaEast@BestWestern.com','3','0'),
('BestWestern','Best Western Plus Music Row', '2','1250 St Denis Rue, Laval','BestWesternPlusMusicRow@BestWestern.com','3','0'),
('BestWestern','Opulence',  '3','3779 smith Rd, Richmond',             'OpulenceEast@BestWestern.com','3','0'),
('BestWestern','The Manor', '4','308 Dundas St W, Whitby',             'TheManorEast@BestWestern.com','3','0'),
('BestWestern','Hideaway',  '5','131 Madawaska Chemin, Grand Falls',   'HideawayEast@BestWestern.com','3','0'),
('BestWestern','Prestige',  '1','301 Wellington St, Ottawa',           'PrestigeEast@BestWestern.com','3','0'),
('BestWestern','Lodge',     '2','1750 Erbs Rd, Agatha',                'LodgeEast@BestWestern.com','3','0'),
('BestWestern','Chateau',   '3','3599 Commercial St, Vancouver',       'ChateauEast@BestWestern.com','3','0');

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

-- Inserting 8 hotels for Marriott
INSERT INTO hotel VALUES 
('Marriott','Grim',     '1','1173 Michener, Sarnia',             'GrimReports@Marriott.com','5','0'),
('Marriott','Marriott Marquis',     '2','3430 Weston, New york', 'MarriottMarquisReports@Marriott.com','5','0'),
('Marriott','Squal',    '3','6416 Main St, Vancouver',          'SqualReports@Marriott.com','5','0'),
('Marriott','Ding',     '4','18730 Fraser Hwy #204, Surrey',    'DingReports@Marriott.com','5','0'),
('Marriott','Tattao',   '5','48 Rue Dante, Montreal',           'TattaoReports@Marriott.com','5','0'),
('Marriott','Dill',     '1','411 Bayfield St B1, Barrie',       'DillReports@Marriott.com','5','0'),
('Marriott','Waterfoul','2','1900 E Trans Canada HWY, Kamloops','WaterfoulReports@Marriott.com','5','0'),
('Marriott','Sholly',   '3','5472 Spring Garden Rd, Halifax',   'ShollyReports@Marriott.com','5','0');


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
(DEFAULT,'John Burming','1 Michener, Sarnia',           '40927613', '1995-07-12'),
(DEFAULT,'Saul Summers','30 Michener, Sarnia',           '462464642', '1997-07-12'),
(DEFAULT,'Ariel Hendricks','50 Michener, Sarnia',           '73472347', '1995-02-12');



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

INSERT INTO booking_renting VALUES ('Hilton','Vista','500', '1','2014-10-19 10:23:54','2014-10-19 12:23:54','false');
INSERT INTO booking_renting VALUES ('Marriott','Squal','100', '2','2024-03-21 10:23:54','2024-05-25 12:23:54','true');
INSERT INTO booking_renting VALUES ('Hilton','Aria','200', '3','2024-03-21 10:23:54','2024-05-25 12:23:54','true');
INSERT INTO booking_renting VALUES ('Marriott','Marriott Marquis','300', '2','2024-03-21 10:23:54','2024-05-25 12:23:54','false');
INSERT INTO booking_renting VALUES ('Hilton','Solace','500', '4','2024-03-21 10:23:54','2024-05-25 12:23:54','false');
INSERT INTO booking_renting VALUES ('UltraRes','Refine','300', '1','2024-03-21 10:23:54','2024-05-25 12:23:54','true');
-- Since the entry above has 'true' for renting, we make Marriott Squal's Front Desk Agent check the customer in
INSERT INTO checked_in_by VALUES
('Marriott','Squal','100', '2','2024-03-21 10:23:54','2024-05-25 12:23:54',
	(SELECT employee_id FROM employee
	WHERE role='Front Desk Agent' AND employee_id IN
	(SELECT employee_id FROM works_at WHERE chain_name='Marriott' AND hotel_name='Squal'))
),
('Hilton','Aria','200', '3','2024-03-21 10:23:54','2024-05-25 12:23:54',
	(SELECT employee_id FROM employee
	WHERE role='Front Desk Agent' AND employee_id IN
	(SELECT employee_id FROM works_at WHERE chain_name='Hilton' AND hotel_name='Aria'))
),
('UltraRes','Refine','300', '1','2024-03-21 10:23:54','2024-05-25 12:23:54',
	(SELECT employee_id FROM employee
	WHERE role='Front Desk Agent' AND employee_id IN
	(SELECT employee_id FROM works_at WHERE chain_name='UltraRes' AND hotel_name='Refine'))
);


-- Inserting Room Features ---------------------

INSERT INTO room_additional VALUES ('Marriott','Marriott Marquis','300','Seaside View');
INSERT INTO room_additional VALUES ('Marriott', 'Waterfoul', '100', 'Seaside View');
INSERT INTO room_additional VALUES ('Marriott', 'Waterfoul', '100', 'Single Bed');
INSERT INTO room_additional VALUES ('Marriott', 'Waterfoul', '100', 'Balcony');
INSERT INTO room_additional VALUES ('Hilton', 'Vista', '200', 'City View');
INSERT INTO room_additional VALUES ('Hilton', 'Vista', '200', 'Double Bed');
INSERT INTO room_additional VALUES ('ModernResorts', 'Corner', '300', 'King Bed');
INSERT INTO room_additional VALUES ('ModernResorts', 'Corner', '300', 'Mountain View');
INSERT INTO room_additional VALUES ('ModernResorts', 'Tresid', '100', 'City View');
INSERT INTO room_additional VALUES ('ModernResorts', 'Tresid', '100', 'Single Bed');
INSERT INTO room_additional VALUES ('UltraRes', 'Haven', '200', 'Mini Bar');
INSERT INTO room_additional VALUES ('UltraRes', 'Haven', '200', 'Queen Bed');
INSERT INTO room_additional VALUES ('UltraRes', 'Haven', '200', 'Lake View');
INSERT INTO room_additional VALUES ('UltraRes', 'Sofitel', '300', 'King Bed');
INSERT INTO room_additional VALUES ('UltraRes', 'Sofitel', '300', 'Balcony');
INSERT INTO room_additional VALUES ('UltraRes', 'Wyndham', '100', 'Balcony');
INSERT INTO room_additional VALUES ('UltraRes', 'Wyndham', '100', 'Double Bed');
INSERT INTO room_additional VALUES ('UltraRes', 'Wyndham', '100', 'Pool View');
INSERT INTO room_additional VALUES ('BestWestern', 'Chateau', '200', 'Single Bed');
INSERT INTO room_additional VALUES ('BestWestern', 'Chateau', '200', 'City View');
INSERT INTO room_additional VALUES ('BestWestern', 'Best Western Plus Music Row', '300', 'King Bed');
INSERT INTO room_additional VALUES ('BestWestern', 'Best Western Plus Music Row', '300', 'City View');
INSERT INTO room_additional VALUES ('BestWestern', 'Lodge', '100', 'Ocean View');


INSERT INTO room_amenities VALUES ('Marriott','Waterfoul','100','Kitchen');
INSERT INTO room_amenities VALUES ('Marriott', 'Marriott Marquis', '100', 'Free Wifi');
INSERT INTO room_amenities VALUES ('Marriott', 'Marriott Marquis', '100', 'TV');
INSERT INTO room_amenities VALUES ('Marriott', 'Marriott Marquis', '100', 'Air Conditioner');
INSERT INTO room_amenities VALUES ('Hilton', 'Vista', '200', 'TV'); 
INSERT INTO room_amenities VALUES ('Hilton', 'Vista', '200', 'Large Fridge'); 
INSERT INTO room_amenities VALUES ('Hilton', 'Vista', '200', 'Air Conditioner'); 
INSERT INTO room_amenities VALUES ('ModernResorts', 'Corner', '300', 'TV');
INSERT INTO room_amenities VALUES ('ModernResorts', 'Corner', '300', 'Free Wifi');
INSERT INTO room_amenities VALUES ('ModernResorts', 'Corner', '300', 'Large Fridge');
INSERT INTO room_amenities VALUES ('ModernResorts', 'Tresid', '100', 'Free Wifi');
INSERT INTO room_amenities VALUES ('ModernResorts', 'Tresid', '100', 'TV');
INSERT INTO room_amenities VALUES ('UltraRes', 'Haven', '200', 'Large Fridge');
INSERT INTO room_amenities VALUES ('UltraRes', 'Haven', '200', 'Air Conditioner');
INSERT INTO room_amenities VALUES ('UltraRes', 'Sofitel', '300', 'Large Fridge');
INSERT INTO room_amenities VALUES ('UltraRes', 'Sofitel', '300', 'TV');
INSERT INTO room_amenities VALUES ('UltraRes', 'Wyndham', '100', 'Air Conditioner');
INSERT INTO room_amenities VALUES ('UltraRes', 'Wyndham', '100', 'Free Wifi');
INSERT INTO room_amenities VALUES ('BestWestern', 'Chateau', '200', 'Free Wifi');
INSERT INTO room_amenities VALUES ('BestWestern', 'Chateau', '200', 'TV');
INSERT INTO room_amenities VALUES ('BestWestern', 'Best Western Plus Music Row', '300', 'Free Wifi');
INSERT INTO room_amenities VALUES ('BestWestern', 'Best Western Plus Music Row', '300', ' TV');
INSERT INTO room_amenities VALUES ('BestWestern', 'Lodge', '100', 'Air Conditioner');
INSERT INTO room_amenities VALUES ('BestWestern', 'Lodge', '100', 'TV');


-- Inserting Hotel Room Numbers ------------------

INSERT INTO hotel_phone_numbers VALUES ('Hilton','Vista','+1(905)-470-8500');
INSERT INTO hotel_phone_numbers VALUES ('Marriott', 'Marriott Marquis', '(123) 456-7890');
INSERT INTO hotel_phone_numbers VALUES ('Hilton', 'Hilton Garden Inn', '(234) 567-8901');
INSERT INTO hotel_phone_numbers VALUES ('ModernResorts', 'Corner', '(345) 678-9012');
INSERT INTO hotel_phone_numbers VALUES ('ModernResorts', 'Tresid', '(456) 789-0123');
INSERT INTO hotel_phone_numbers VALUES ('UltraRes', 'Haven', '(567) 890-1234');
INSERT INTO hotel_phone_numbers VALUES ('UltraRes', 'Sofitel', '(678) 901-2345');
INSERT INTO hotel_phone_numbers VALUES ('UltraRes', 'Wyndham', '(789) 012-3456');
INSERT INTO hotel_phone_numbers VALUES ('BestWestern', 'Chateau', '(890) 123-4567');
INSERT INTO hotel_phone_numbers VALUES ('BestWestern', 'Best Western Plus Music Row', '(901) 234-5678');
INSERT INTO hotel_phone_numbers VALUES ('BestWestern', 'Lodge', '(012) 345-6789');


-- Inserting Chain Addresses ------------------

INSERT INTO chain_address VALUES ('Hilton','8500_WardenAvenueMarkham_ONCA_L6G1A5');
INSERT INTO chain_address VALUES ('Marriott', '10400 Fernwood Rd, Bethesda, MD 20817, USA');
INSERT INTO chain_address VALUES ('Hilton', '7930 Jones Branch Dr, McLean, VA 22102, USA');
INSERT INTO chain_address VALUES ('ModernResorts', '150 N Riverside Plaza, Chicago, IL 60606, USA');
INSERT INTO chain_address VALUES ('ModernResorts', '3 Ravinia Dr #100, Atlanta, GA 30346, USA');
INSERT INTO chain_address VALUES ('UltraRes', '701 Carlson Pkwy, Minnetonka, MN 55305, USA');
INSERT INTO chain_address VALUES ('UltraRes', '82 Rue Henri Farman, 92130 oulineaux, France');
INSERT INTO chain_address VALUES ('UltraRes', '22 Sylvan Way, Parsippany, NJ 07054, USA');
INSERT INTO chain_address VALUES ('BestWestern', '1 Choice Hotels Cir # 400, Rockville, USA');
INSERT INTO chain_address VALUES ('BestWestern', '6201 N 24th Pkwy, Phoenix, AZ 85016, USA');
INSERT INTO chain_address VALUES ('BestWestern', '1165 Leslie St, North York, Canada');
