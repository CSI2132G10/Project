-- ----------------------------
-- DDL
-- ----------------------------

CREATE TABLE hotel_chain (
  chain_name varchar(45) PRIMARY KEY,
  num_hotels int NOT NULL
);

CREATE TABLE employee (
  employee_id int PRIMARY KEY,
  employee_name varchar(45) NOT NULL,
  role varchar(45) NOT NULL,
  sin int NOT NULL,
  address varchar(45) NOT NULL,
  chain_name varchar(45) NOT NULL REFERENCES hotel_chain(chain_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE hotel (
  chain_name varchar(45) UNIQUE REFERENCES hotel_chain(chain_name) ON DELETE CASCADE ON UPDATE CASCADE,
  hotel_name varchar(45) UNIQUE,
  rating int NOT NULL,
  address varchar(45) NOT NULL,
  email varchar(45) NOT NULL,
  manager int NOT NULL REFERENCES employee(employee_id),
  PRIMARY KEY(chain_name,hotel_name)
);

CREATE TABLE room (
  chain_name varchar(45) UNIQUE REFERENCES hotel(chain_name) ON DELETE CASCADE ON UPDATE CASCADE,
  hotel_name varchar(45) UNIQUE REFERENCES hotel(hotel_name) ON DELETE CASCADE ON UPDATE CASCADE,
  room_number int UNIQUE,
  price int NOT NULL,
  capacity varchar(45) NOT NULL,
  PRIMARY KEY(chain_name,hotel_name,room_number)
);

CREATE TABLE customer (
  account_number int PRIMARY KEY,
  customer_name varchar(45) NOT NULL,
  address varchar(45) NOT NULL,
  id int NOT NULL,
  --this should be a datetime instead of varchar
  date_of_registration varchar(45) NOT NULL
);

CREATE TABLE booking_renting (
  chain_name varchar(45) UNIQUE REFERENCES room(chain_name) ON DELETE CASCADE ON UPDATE CASCADE,
  hotel_name varchar(45) UNIQUE REFERENCES room(hotel_name) ON DELETE CASCADE ON UPDATE CASCADE,
  room_number int UNIQUE REFERENCES room(room_number) ON DELETE CASCADE ON UPDATE CASCADE,
  account_number int UNIQUE REFERENCES customer(account_number) ON DELETE CASCADE ON UPDATE CASCADE,
  -- Booking dates could be a set of 2 datetimes instead of a string
  booking_dates varchar(45) UNIQUE,
  is_renting boolean NOT NULL,
  is_archived boolean NOT NULL,
  PRIMARY KEY(chain_name,hotel_name,room_number,account_number,booking_dates)
);

CREATE TABLE booking_renting_archive (
  chain_name varchar(45),
  hotel_name varchar(45),
  room_number int,
  account_number int,
  -- Booking dates could be a set of 2 datetimes instead of a string
  booking_dates varchar(45),
  is_renting boolean NOT NULL,
  is_archived boolean NOT NULL,
  PRIMARY KEY(chain_name,hotel_name,room_number,account_number,booking_dates)
);

CREATE TABLE chain_address (
  chain_name varchar(45) REFERENCES hotel_chain(chain_name) ON DELETE CASCADE ON UPDATE CASCADE,
  office_address varchar(45),
  PRIMARY KEY(chain_name,office_address)
);

CREATE TABLE hotel_phone_numbers (
  chain_name varchar(45) REFERENCES hotel(chain_name) ON DELETE CASCADE ON UPDATE CASCADE,
  hotel_name varchar(45)REFERENCES hotel(hotel_name) ON DELETE CASCADE ON UPDATE CASCADE,
  phone_number int,
  PRIMARY KEY(chain_name,hotel_name,phone_number)
);

CREATE TABLE room_additional (
  chain_name varchar(45)REFERENCES room(chain_name) ON DELETE CASCADE ON UPDATE CASCADE,
  hotel_name varchar(45) REFERENCES room(hotel_name) ON DELETE CASCADE ON UPDATE CASCADE,
  room_number int REFERENCES room(room_number) ON DELETE CASCADE ON UPDATE CASCADE,
  additional_details varchar(45),
  PRIMARY KEY(chain_name,hotel_name,room_number,additional_details)
);

CREATE TABLE room_amenities (
  chain_name varchar(45)REFERENCES room(chain_name) ON DELETE CASCADE ON UPDATE CASCADE,
  hotel_name varchar(45) REFERENCES room(hotel_name) ON DELETE CASCADE ON UPDATE CASCADE,
  room_number int REFERENCES room(room_number) ON DELETE CASCADE ON UPDATE CASCADE,
  amenity varchar(45),
  PRIMARY KEY(chain_name,hotel_name,room_number,amenity)
);

CREATE TABLE works_at (
  employee_id int PRIMARY KEY REFERENCES employee(employee_id) ON DELETE CASCADE ON UPDATE CASCADE,
  chain_name varchar(45) NOT NULL REFERENCES room(hotel_name) ON DELETE CASCADE ON UPDATE CASCADE,
  hotel_name varchar(45) NOT NULL REFERENCES hotel(hotel_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE checked_in_by (
  chain_name varchar(45) REFERENCES booking_renting(chain_name) ON DELETE CASCADE ON UPDATE CASCADE,
  hotel_name varchar(45) REFERENCES booking_renting(hotel_name) ON DELETE CASCADE ON UPDATE CASCADE,
  room_number int REFERENCES booking_renting(room_number) ON DELETE CASCADE ON UPDATE CASCADE,
  account_number int REFERENCES booking_renting(account_number) ON DELETE CASCADE ON UPDATE CASCADE,
  -- Booking dates could be a set of 2 datetimes instead of a string
  booking_dates varchar(45) REFERENCES booking_renting(booking_dates) ON DELETE CASCADE ON UPDATE CASCADE,
  employee_id int NOT NULL REFERENCES employee(employee_id) ON DELETE CASCADE ON UPDATE CASCADE,
  PRIMARY KEY(chain_name,hotel_name,room_number,account_number,booking_dates)
);



CREATE OR REPLACE FUNCTION archive_process()
    RETURNS TRIGGER
    AS
    $$
    BEGIN
        INSERT INTO booking_renting_archive(chain_name,hotel_name,room_number,account_number,booking_dates,is_renting,is_archived)
        VALUES(OLD.chain_name,OLD.hotel_name,OLD.room_number,OLD.account_number,OLD.booking_dates,OLD.is_renting,OLD.is_archived);

        RETURN OLD;
    END
    $$
    LANGUAGE PLPGSQL;

CREATE OR REPLACE TRIGGER archive_booking_renting
    BEFORE DELETE
    ON booking_renting
    FOR EACH ROW
    EXECUTE FUNCTION archive_process();



-- ----------------------------
-- DML
-- ----------------------------

INSERT INTO hotel_chain VALUES ('hotels+','3');
INSERT INTO employee VALUES ('1','jim','manager','123','homaddress','hotels+');
INSERT INTO hotel VALUES ('hotels+','hotel1','1','add1','email1','1');
INSERT INTO room VALUES ('hotels+','hotel1','500','1000','3');
INSERT INTO customer VALUES ('1','customjoe','house address','6','1985-02-10');
INSERT INTO booking_renting VALUES ('hotels+','hotel1','500','1','DateSet1','false','false');
