-- ----------------------------
-- DDL
-- ----------------------------

CREATE TABLE hotel_chain (
  chain_name varchar(45) PRIMARY KEY,
  num_hotels int NOT NULL CONSTRAINT positive_hotel_count CHECK (num_hotels>=0)
);

CREATE TABLE employee (
  employee_id   int         PRIMARY KEY,
  employee_name varchar(45) NOT NULL,
  role          varchar(45) NOT NULL,
  sin           int         NOT NULL,
  address       varchar(45) NOT NULL,
  chain_name    varchar(45) NOT NULL REFERENCES hotel_chain(chain_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE hotel (
  chain_name  varchar(45) UNIQUE REFERENCES hotel_chain(chain_name) ON DELETE CASCADE ON UPDATE CASCADE,
  hotel_name  varchar(45) UNIQUE,
  rating      int         NOT NULL CONSTRAINT positive_rating CHECK (rating>=0),
  address     varchar(45) NOT NULL,
  email       varchar(45) NOT NULL,
  manager     int         NOT NULL REFERENCES employee(employee_id),
  PRIMARY KEY(chain_name,hotel_name)
);

CREATE TABLE room (
  chain_name  varchar(45) UNIQUE REFERENCES hotel(chain_name) ON DELETE CASCADE ON UPDATE CASCADE,
  hotel_name  varchar(45) UNIQUE REFERENCES hotel(hotel_name) ON DELETE CASCADE ON UPDATE CASCADE,
  room_number int         UNIQUE,
  price       int         NOT NULL CONSTRAINT positive_price CHECK(price>=0),
  capacity    int         NOT NULL CONSTRAINT positive_capacity CHECK(capacity>=0),
  PRIMARY KEY(chain_name,hotel_name,room_number)
);

CREATE TABLE customer (
  account_number      int         PRIMARY KEY,
  customer_name       varchar(45) NOT NULL,
  address             varchar(45) NOT NULL,
  id                  int         NOT NULL,
  date_of_registration date NOT NULL
);

CREATE TABLE booking_renting (
  chain_name      varchar(45) UNIQUE REFERENCES room(chain_name) ON DELETE CASCADE ON UPDATE CASCADE,
  hotel_name      varchar(45) UNIQUE REFERENCES room(hotel_name) ON DELETE CASCADE ON UPDATE CASCADE,
  room_number     int UNIQUE REFERENCES room(room_number) ON DELETE CASCADE ON UPDATE CASCADE,
  account_number  int UNIQUE REFERENCES customer(account_number) ON DELETE CASCADE ON UPDATE CASCADE,
  -- If bookings are only allowed in the future, then add this checks:
  -- CHECK(booking_start>=NOW())
  booking_start   timestamp UNIQUE,
  booking_end     timestamp UNIQUE CONSTRAINT end_after_start CHECK(booking_end>=booking_start),
  is_renting      boolean NOT NULL,
  -- is_archived is only used in some models... not used in copy-to-new-table model
  is_archived     boolean NOT NULL,
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
  -- is_archived is only used in some models... not used in copy-to-new-table model
  is_archived     boolean NOT NULL,
  PRIMARY KEY(chain_name,hotel_name,room_number,account_number,booking_start,booking_end)
);

CREATE TABLE chain_address (
  chain_name      varchar(45) REFERENCES hotel_chain(chain_name) ON DELETE CASCADE ON UPDATE CASCADE,
  office_address  varchar(45),
  PRIMARY KEY(chain_name,office_address)
);

CREATE TABLE hotel_phone_numbers (
  chain_name    varchar(45) REFERENCES hotel(chain_name) ON DELETE CASCADE ON UPDATE CASCADE,
  hotel_name    varchar(45)REFERENCES hotel(hotel_name) ON DELETE CASCADE ON UPDATE CASCADE,
  phone_number  int,
  PRIMARY KEY(chain_name,hotel_name,phone_number)
);

CREATE TABLE room_additional (
  chain_name          varchar(45)REFERENCES room(chain_name) ON DELETE CASCADE ON UPDATE CASCADE,
  hotel_name          varchar(45) REFERENCES room(hotel_name) ON DELETE CASCADE ON UPDATE CASCADE,
  room_number         int REFERENCES room(room_number) ON DELETE CASCADE ON UPDATE CASCADE,
  additional_details  varchar(45),
  PRIMARY KEY(chain_name,hotel_name,room_number,additional_details)
);

CREATE TABLE room_amenities (
  chain_name  varchar(45) REFERENCES room(chain_name) ON DELETE CASCADE ON UPDATE CASCADE,
  hotel_name  varchar(45) REFERENCES room(hotel_name) ON DELETE CASCADE ON UPDATE CASCADE,
  room_number int         REFERENCES room(room_number) ON DELETE CASCADE ON UPDATE CASCADE,
  amenity     varchar(45),
  PRIMARY KEY(chain_name,hotel_name,room_number,amenity)
);

CREATE TABLE works_at (
  employee_id int         PRIMARY KEY REFERENCES employee(employee_id) ON DELETE CASCADE ON UPDATE CASCADE,
  chain_name  varchar(45) NOT NULL REFERENCES room(hotel_name) ON DELETE CASCADE ON UPDATE CASCADE,
  hotel_name  varchar(45) NOT NULL REFERENCES hotel(hotel_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE checked_in_by (
  chain_name      varchar(45) REFERENCES booking_renting(chain_name) ON DELETE CASCADE ON UPDATE CASCADE,
  hotel_name      varchar(45) REFERENCES booking_renting(hotel_name) ON DELETE CASCADE ON UPDATE CASCADE,
  room_number     int REFERENCES booking_renting(room_number) ON DELETE CASCADE ON UPDATE CASCADE,
  account_number  int REFERENCES booking_renting(account_number) ON DELETE CASCADE ON UPDATE CASCADE,
  -- Booking dates could be a set of 2 datetimes instead of a string
  booking_start   timestamp UNIQUE REFERENCES booking_renting(booking_start) ON DELETE CASCADE ON UPDATE CASCADE,
  booking_end     timestamp UNIQUE REFERENCES booking_renting(booking_end) ON DELETE CASCADE ON UPDATE CASCADE,
  employee_id     int REFERENCES employee(employee_id) ON DELETE CASCADE ON UPDATE CASCADE,
  PRIMARY KEY(chain_name,hotel_name,room_number,account_number,booking_start,booking_end)
);


-- Function for archiving bookings/rentings
CREATE OR REPLACE FUNCTION archive_process()
    RETURNS TRIGGER AS
    $$
    BEGIN
        INSERT INTO booking_renting_archive(chain_name,hotel_name,room_number,account_number,booking_dates,is_renting,is_archived)
        VALUES(OLD.chain_name,OLD.hotel_name,OLD.room_number,OLD.account_number,OLD.booking_dates,OLD.is_renting,OLD.is_archived);

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

-- IMPORTANT NOTE: You may want to comment this out. Depends on how you populate the data initially
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



-- ----------------------------
-- DML
-- ----------------------------

INSERT INTO hotel_chain VALUES ('hotels+','0');
INSERT INTO employee VALUES ('1','jim','manager','123','homaddress','hotels+');
INSERT INTO hotel VALUES ('hotels+','hotel1','1','add1','email1','1');
INSERT INTO room VALUES ('hotels+','hotel1','500','1000','3');
INSERT INTO customer VALUES ('1','customjoe','house address','6','1985-02-10');
INSERT INTO booking_renting VALUES ('hotels+','hotel1','500','1','2004-10-19 10:23:54','2004-10-19 12:23:54','false','false');
