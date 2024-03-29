-- ----------------------------
-- DML - Creating the Data
-- ----------------------------

-- NOTE THAT THIS IS STILL UNFINISHED!!!

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
('NorthAmHotels','Vista',      '1','73 Alderney Dr',                   'VistaHelp@northAm.com','1'),
('NorthAmHotels','Oasis',      '2','5308 Boulevard Saint-Laurent',     'OasisHelp@northAm.com','1'),
('NorthAmHotels','Solace',     '3','701 Niakwa Rd, St Boniface',       'SolaceHelp@northAm.com','1'),
('NorthAmHotels','Aria',       '4','10805 82 Ave NW, Edmonton',        'AriaHelp@northAm.com','1'),
('NorthAmHotels','Harmony',    '5','172 Dollard des Ormeaux, Gatineau','HarmonyHelp@northAm.com','1'),
('NorthAmHotels','Elysium',    '1','4500 Kingsway, Burnaby',           'ElysiumHelp@northAm.com','1'),
('NorthAmHotels','Tranquil',   '2','220 Salter St, Westminster',       'TranquilHelp@northAm.com','1'),
('NorthAmHotels','Serenity',   '3','13080 St Albert Trail, St Albert', 'SerenityHelp@northAm.com','1');

-- Inserting 8 hotels for UltraRes
INSERT INTO hotel VALUES 
('UltraRes','Haven',       '1','6185 Fraser St, Vancouver',        'HavenTrips@ultrares.com','2'),
('UltraRes','Zen',         '2','3388 Bd Taschereau, Greensfield',  'ZenTrips@ultrares.com','2'),
('UltraRes','Refine',      '3','2323 Arbot Rd, Nanaimo',           'RefineTrips@ultrares.com','2'),
('UltraRes','Relaxation Inn','4','132 Josephine St, North Huron',  'RelaxationTrips@ultrares.com','2'),
('UltraRes','Luxuria',     '5','739 Lake Bonavista Dr SE, Calgary','LuxuriaTrips@ultrares.com','2'),
('UltraRes','Frugality',   '1','501 9 Ave N, Golden',              'FrugalityTrips@ultrares.com','2'),
('UltraRes','Value',       '2','13580 102 Ave, Surey',             'ValueTrips@ultrares.com','2'),
('UltraRes','QuickTrip',   '3','022 Government St, Victoria',     'QuickTripTrips@ultrares.com','2');

-- Inserting 8 hotels for BestEastern
INSERT INTO hotel VALUES 
('BestEastern','Premier',   '1','2860 Cruickshank St, Abbotsford',     'PremierEast@BestEastern.com','3'),
('BestEastern','UltraEast', '2','1250 St Denis Rue, Laval',            'UltraEast@BestEastern.com','3'),
('BestEastern','Opulence',  '3','3779 smith Rd, Richmond',             'OpulenceEast@BestEastern.com','3'),
('BestEastern','The Manor', '4','308 Dundas St W, Whitby',             'TheManorEast@BestEastern.com','3'),
('BestEastern','Hideaway',  '5','131 Madawaska Chemin, Grand Falls',   'HideawayEast@BestEastern.com','3'),
('BestEastern','Prestige',  '1','301 Wellington St, Ottawa',           'PrestigeEast@BestEastern.com','3'),
('BestEastern','Lodge',     '2','1750 Erbs Rd, Agatha',                'LodgeEast@BestEastern.com','3'),
('BestEastern','Chateau',   '3','3599 Commercial St, Vancouver',       'ChateauEast@BestEastern.com','3');

-- Inserting 8 hotels for ModernResorts
INSERT INTO hotel VALUES 
('ModernResorts','Urban',     '1','44 Britannia Rd E, Mississauga',        'UrbanRes@ModernResorts.com','4'),
('ModernResorts','Contempor', '2','1897 Queen E, Toronto',                 'ContemporRes@ModernResorts.com','4'),
('ModernResorts','Slode',     '3','250H MacEwan Hall, Calgary',            'SlodeRes@ModernResorts.com','4'),
('ModernResorts','Tresid',    '4','2300 Yonge St, Toronto',                'TresidRes@ModernResorts.com','4'),
('ModernResorts','CutEdge',   '5','842 Québec 138, Cap-Sante',             'CutEdgeRes@ModernResorts.com','4'),
('ModernResorts','Corner',    '1','20811 Fraser Hwy, Langley',             'CornerRes@ModernResorts.com','4'),
('ModernResorts','Underhill', '2','A 275 Principale, Sauveur',             'UnderhillRes@ModernResorts.com','4'),
('ModernResorts','Overhill',  '3','4396 Boulevard Saint-Laurent, Montreal','OverhillRes@ModernResorts.com','4');

-- Inserting 8 hotels for Marrion
INSERT INTO hotel VALUES 
('Marrion','Grim',     '1','1173 Michener, Sarnia',             'GrimReports@Marrion.com','5'),
('Marrion','Crum',     '2','3430 Weston, New york',            'CrumReports@Marrion.com','5'),
('Marrion','Squal',    '3','6416 Main St, Vancouver',          'SqualReports@Marrion.com','5'),
('Marrion','Ding',     '4','18730 Fraser Hwy #204, Surrey',    'DingReports@Marrion.com','5'),
('Marrion','Tattao',   '5','48 Rue Dante, Montreal',           'TattaoReports@Marrion.com','5'),
('Marrion','Dill',     '1','411 Bayfield St B1, Barrie',       'DillReports@Marrion.com','5'),
('Marrion','Waterfoul','2','1900 E Trans Canada HWY, Kamloops','WaterfoulReports@Marrion.com','5'),
('Marrion','Sholly',   '3','5472 Spring Garden Rd, Halifax',   'ShollyReports@Marrion.com','5');


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
INSERT INTO booking_renting VALUES ('Marrion',      'Squal','500', '2','2024-03-21 10:23:54','2024-05-25 12:23:54','true');
-- Since the entry above has 'true' for renting, we make Marrion Squal's Front Desk Agent check the customer in
INSERT INTO checked_in_by VALUES
('Marrion','Squal','500', '2','2024-03-21 10:23:54','2024-05-25 12:23:54',
	(SELECT employee_id FROM employee
	WHERE role='Front Desk Agent' AND employee_id IN
	(SELECT employee_id FROM works_at WHERE chain_name='Marrion' AND hotel_name='Squal'))
)