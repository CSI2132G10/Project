-- ----------------------------
-- Queries for Task
-- ----------------------------

-- Note: You do not need to run this on the local database for project setup
--       These queries are here by requirement of the project

-- Query that returns the total profit of a hotel by adding the price of every room and the bookings under it
-- The values 'Hilton' and 'Aria' can be replaced with any hotel in the DB to get that hotel's profit.
-- This is the sample query for one that uses aggregation, as the sum of price is being taken.
select sum(r.price) as profit from room r
JOIN 
        booking_renting br ON r.chain_name = br.chain_name 
        AND r.hotel_name = br.hotel_name 
        AND r.room_number = br.room_number
where r.chain_name = 'Hilton' and r.hotel_name = 'Aria';

-- Query that returns the room numbers which are not currently booked and their prices using a nested query.
-- The values 'Hilton' and 'Aria' can be replaced with any hotel in the DB.
-- This is the sample query for one that uses a nested query, as we find and exclude the booked rooms in a subquery.
select * from room r
where r.chain_name = 'Hilton' and r.hotel_name = 'Aria'
and r.room_number not in
(
	SELECT room_number FROM booking_renting br
    WHERE 
		br.chain_name = r.chain_name 
		and br.hotel_name = r.hotel_name
        and br.booking_start < CURRENT_DATE 
        AND br.booking_end > CURRENT_DATE
);




