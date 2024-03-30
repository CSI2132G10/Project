-- ----------------------------
-- DDL - Creating the Database
-- ----------------------------

CREATE TABLE hotel_chain (
  chain_name varchar(45) PRIMARY KEY,
  num_hotels int NOT NULL CONSTRAINT positive_hotel_count CHECK (num_hotels>=0)
);

CREATE TABLE employee (
  employee_id            SERIAL PRIMARY KEY,
  employee_name varchar(45) NOT NULL,
  role          varchar(45) NOT NULL,
  sin           int         NOT NULL,
  address       varchar(45) NOT NULL,
  chain_name    varchar(45) NOT NULL REFERENCES hotel_chain(chain_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE hotel (
  chain_name  varchar(45) NOT NULL,
  hotel_name  varchar(45) NOT NULL,
  rating      int         NOT NULL CONSTRAINT positive_rating CHECK (rating>=0) CONSTRAINT valid_rating CHECK (rating<=5),
  address     varchar(45) NOT NULL,
  email       varchar(45) NOT NULL,
  manager     int         NOT NULL REFERENCES employee(employee_id),
  num_rooms   int NOT NULL CONSTRAINT positive_room_count CHECK (num_rooms>=0),
  FOREIGN KEY(chain_name) REFERENCES hotel_chain(chain_name) ON DELETE CASCADE ON UPDATE CASCADE,
  PRIMARY KEY(chain_name,hotel_name)
);

CREATE TABLE room (
  chain_name  varchar(45) NOT NULL,
  hotel_name  varchar(45) NOT NULL,
  room_number int         NOT NULL,
  price       numeric     NOT NULL CONSTRAINT positive_price CHECK(price>=0),
  capacity    int         NOT NULL CONSTRAINT positive_capacity CHECK(capacity>=0),
  FOREIGN KEY(chain_name,hotel_name) REFERENCES hotel (chain_name,hotel_name) ON DELETE CASCADE ON UPDATE CASCADE,
  PRIMARY KEY(chain_name,hotel_name,room_number)
);

CREATE TABLE customer (
  account_number               SERIAL PRIMARY KEY,
  customer_name       varchar(45) NOT NULL,
  address             varchar(45) NOT NULL,
  id                  int         NOT NULL,
  date_of_registration date NOT NULL
);

CREATE TABLE booking_renting (
  chain_name      varchar(45) NOT NULL,
  hotel_name      varchar(45) NOT NULL,
  room_number     int NOT NULL,
  account_number  int NOT NULL,
  -- If bookings are only allowed in the future, then add this checks:
  -- CHECK(booking_start>=NOW())
  booking_start   timestamp UNIQUE,
  booking_end     timestamp UNIQUE CONSTRAINT end_after_start CHECK(booking_end>=booking_start),
  is_renting      boolean NOT NULL,
  -- is_archived is only used in some models... not used in copy-to-new-table model so it has been commented out
  -- is_archived     boolean NOT NULL,
  FOREIGN KEY(chain_name,hotel_name,room_number) REFERENCES room(chain_name,hotel_name,room_number) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(account_number) REFERENCES customer(account_number) ON DELETE CASCADE ON UPDATE CASCADE,
  PRIMARY KEY(chain_name,hotel_name,room_number,account_number,booking_start,booking_end)
);

CREATE TABLE booking_renting_archive (
  chain_name      varchar(45),
  hotel_name      varchar(45),
  room_number     int,
  account_number  int,
  booking_start   timestamp UNIQUE,
  booking_end     timestamp UNIQUE CONSTRAINT end_after_start CHECK(booking_end>=booking_start),
  is_renting      boolean NOT NULL,
  -- is_archived is only used in some models... not used in copy-to-new-table model so it has been commented out
  -- is_archived     boolean NOT NULL,
  PRIMARY KEY(chain_name,hotel_name,room_number,account_number,booking_start,booking_end)
);

CREATE TABLE chain_address (
  chain_name      varchar(45) REFERENCES hotel_chain(chain_name) ON DELETE CASCADE ON UPDATE CASCADE,
  office_address  varchar(45),
  PRIMARY KEY(chain_name,office_address)
);

CREATE TABLE hotel_phone_numbers (
  chain_name    varchar(45) NOT NULL,
  hotel_name    varchar(45) NOT NULL,
  phone_number  int NOT NULL,
  FOREIGN KEY(chain_name,hotel_name) REFERENCES hotel(chain_name,hotel_name) ON DELETE CASCADE ON UPDATE CASCADE,
  PRIMARY KEY(chain_name,hotel_name,phone_number)
);

CREATE TABLE room_additional (
  chain_name          varchar(45) NOT NULL,
  hotel_name          varchar(45) NOT NULL,
  room_number         int NOT NULL,
  additional_details  varchar(45) NOT NULL,
  FOREIGN KEY(chain_name,hotel_name,room_number) REFERENCES room(chain_name,hotel_name,room_number) ON DELETE CASCADE ON UPDATE CASCADE,
  PRIMARY KEY(chain_name,hotel_name,room_number,additional_details)
);

CREATE TABLE room_amenities (
  chain_name  varchar(45)  NOT NULL,
  hotel_name  varchar(45)  NOT NULL,
  room_number int          NOT NULL,
  amenity     varchar(45),
  FOREIGN KEY(chain_name,hotel_name,room_number) REFERENCES room(chain_name,hotel_name,room_number) ON DELETE CASCADE ON UPDATE CASCADE,
  PRIMARY KEY(chain_name,hotel_name,room_number,amenity)
);

CREATE TABLE works_at (
  employee_id int         PRIMARY KEY REFERENCES employee(employee_id) ON DELETE CASCADE ON UPDATE CASCADE,
  chain_name  varchar(45) NOT NULL,
  hotel_name  varchar(45) NOT NULL,
  FOREIGN KEY(chain_name,hotel_name) REFERENCES hotel (chain_name,hotel_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE checked_in_by (
  chain_name      varchar(45) NOT NULL ,
  hotel_name      varchar(45) NOT NULL,
  room_number     int NOT NULL,
  account_number  int NOT NULL,
  booking_start   timestamp NOT NULL,
  booking_end     timestamp NOT NULL,
  employee_id     int REFERENCES employee(employee_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(chain_name,hotel_name,room_number,account_number,booking_start,booking_end) REFERENCES booking_renting(chain_name,hotel_name,room_number,account_number,booking_start,booking_end) ON DELETE CASCADE ON UPDATE CASCADE,
  PRIMARY KEY(chain_name,hotel_name,room_number,account_number,booking_start,booking_end)
);

-- ----------------------------
-- Triggers and Functions
-- ----------------------------


-- Function for archiving bookings/rentings
CREATE OR REPLACE FUNCTION archive_process()
    RETURNS TRIGGER AS
    $$
    BEGIN
        -- is_archived attribute is only used in some models... not used in copy-to-new-table model so it has been removed for now
        INSERT INTO booking_renting_archive(chain_name,hotel_name,room_number,account_number,booking_start,booking_end,is_renting) -- ,is_archived)
        VALUES(OLD.chain_name,OLD.hotel_name,OLD.room_number,OLD.account_number,OLD.booking_start,OLD.booking_end,OLD.is_renting); -- ,OLD.is_archived);

        RETURN OLD;
    END
    $$
    LANGUAGE PLPGSQL;
-- Trigger to activate the archiving on delete
CREATE OR REPLACE TRIGGER archive_booking_renting
    BEFORE DELETE
    ON booking_renting
    FOR EACH ROW
    EXECUTE FUNCTION archive_process();


-- Function to update num_hotels of hotel_chain
CREATE OR REPLACE FUNCTION number_of_hotels()
    RETURNS TRIGGER AS
    $$
    BEGIN
      if TG_OP='INSERT' then
        UPDATE hotel_chain set num_hotels = num_hotels + 1 where chain_name = new.chain_name;
      end if;
      if TG_OP='DELETE' then
        UPDATE hotel_chain set num_hotels = num_hotels - 1 where chain_name = old.chain_name;
      end if;
      RETURN NEW;
    END;
    $$
    LANGUAGE PLPGSQL;
-- Trigger to update the hotel count whenever hotel table is updated
CREATE TRIGGER trigger_num_hotel_update
    AFTER INSERT OR DELETE
    ON hotel
    FOR EACH ROW
    EXECUTE FUNCTION number_of_hotels();

-- Function to throw error if hotel_chains have more than 0 hotels on insertion
CREATE OR REPLACE FUNCTION chain_0_hotel()
    RETURNS TRIGGER AS
    $$
    BEGIN
      if NEW.num_hotels>0 then
        RAISE EXCEPTION 'hotel chains must have 0 hotels on insertion';
      end if;
      RETURN NEW;
    END;
    $$
    LANGUAGE PLPGSQL;
-- Trigger to ensure hotel_chains start with 0 hotels
CREATE TRIGGER insert_hotel_chain
    AFTER INSERT
    on hotel_chain
    FOR EACH ROW
    EXECUTE FUNCTION chain_0_hotel();


-- Function to update num_rooms of hotel
CREATE OR REPLACE FUNCTION number_of_rooms()
    RETURNS TRIGGER AS
    $$
    BEGIN
      if TG_OP='INSERT' then
        UPDATE hotel set num_rooms = num_rooms + 1 where hotel_name = new.hotel_name AND chain_name = new.chain_name;
      end if;
      if TG_OP='DELETE' then
        UPDATE hotel set num_rooms = num_rooms - 1 where hotel_name = old.hotel_name AND chain_name = old.chain_name;
      end if;
      RETURN NEW;
    END;
    $$
    LANGUAGE PLPGSQL;
-- Trigger to update the hotel room count whenever room table is updated
CREATE TRIGGER trigger_num_hotel_update
    AFTER INSERT OR DELETE
    ON room
    FOR EACH ROW
    EXECUTE FUNCTION number_of_rooms();

-- Function to throw error if hotels have more than 0 rooms on insertion
CREATE OR REPLACE FUNCTION hotel_0_room()
    RETURNS TRIGGER AS
    $$
    BEGIN
      if NEW.num_rooms>0 then
        RAISE EXCEPTION 'hotels must have 0 rooms on insertion';
      end if;
      RETURN NEW;
    END;
    $$
    LANGUAGE PLPGSQL;
-- Trigger to ensure hotel start with 0 rooms
CREATE TRIGGER insert_hotel
    AFTER INSERT
    on hotel
    FOR EACH ROW
    EXECUTE FUNCTION hotel_0_room();

-- ----------------------------
-- Views
-- ----------------------------

-- View for number of available rooms per area
CREATE VIEW remaining_rooms_view as
SELECT 
    total.chain_name,
    total.hotel_name,
	  (total.total_rooms - COALESCE(booked.booked_rooms, 0)) as remaining_rooms
FROM
    (SELECT 
        b.chain_name, b.hotel_name, COUNT(*) 
        AS total_rooms
    FROM 
        room b
    GROUP BY 
        b.chain_name, b.hotel_name) 
        AS total
LEFT JOIN
    (SELECT 
        r.chain_name, r.hotel_name, COUNT(*) 
        AS booked_rooms
    FROM 
        room r
    JOIN 
        booking_renting br ON r.chain_name = br.chain_name 
        AND r.hotel_name = br.hotel_name 
        AND r.room_number = br.room_number 
    WHERE 
        br.booking_start < CURRENT_DATE 
        AND br.booking_end > CURRENT_DATE
    GROUP BY 
        r.chain_name,
        r.hotel_name) AS booked
ON 
    total.chain_name = booked.chain_name
    AND total.hotel_name = booked.hotel_name;

-- View for capacity of each hotel taken as an aggregation of each room's capacity
CREATE VIEW hotel_capacity_view AS
SELECT chain_name, hotel_name, sum(capacity) AS total_capacity FROM room 
GROUP BY chain_name, hotel_name;

-- Multi-column index on hotel name and chain for hotels
CREATE INDEX hotel_index ON hotel (chain_name, hotel_name);

-- Multi-column index on room number, hotel name, and chain
CREATE INDEX room_index on room (chain_name, hotel_name, room_number);

-- Single-column index on employee id
CREATE INDEX employee_index on employee USING hash (employee_id);