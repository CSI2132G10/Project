package group10;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BookingService {

    /**
     * Method to get all bookings/rentings from database
     *
     * @return list of all bookings/rentings found in database
     * @throws Exception when trying to connect to database
     */
    public List<Booking> getBookingRenting() throws Exception {

        // sql query
        String sql = "SELECT * FROM booking_renting";
        // connection object
        ConnectionDB db = new ConnectionDB();

        // data structure to keep all Rooms retrieved from database
        List<Booking> bookings = new ArrayList<Booking>();

        // try connect to database, catch any exceptions
        try (Connection con = db.getConnection()) {
            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);
            // get the results from executing the query
            ResultSet rs = stmt.executeQuery();
            // iterate through the result set
            while (rs.next()) {
                // create new Room object
                Booking newBooking = new Booking(
                    rs.getString("chain_name"),
                    rs.getString("hotel_name"),
                    rs.getInt("room_number"),
                    rs.getInt("account_number"),
                    rs.getTimestamp("booking_start"),
                    rs.getTimestamp("booking_end"),
                    rs.getBoolean("is_renting")
                );

                // append Room in Rooms list
                bookings.add(newBooking);
            }

            // close result set
            rs.close();
            // close statement
            stmt.close();
            con.close();
            db.close();

            // return result
            return bookings;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

    public List<Booking> findBookingRentingByCustomer(int account_number, boolean is_renting) throws Exception {
        Connection con = null;

        // sql query
        String sql = "SELECT * FROM booking_renting WHERE account_number=? AND is_renting=;";
        // database connection object
        ConnectionDB db = new ConnectionDB();
        List<Booking> bookings = new ArrayList<Booking>();

        // try connect to database, catch any exceptions
        try {

            con = db.getConnection();

            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // set every ? of statement
            stmt.setInt(1, account_number);
            stmt.setBoolean(2, is_renting);

            // execute the query
            ResultSet rs = stmt.executeQuery();

            // iterate through the result set
            while (rs.next()) {
                // create new Room object
                Booking newBooking = new Booking(
                    rs.getString("chain_name"),
                    rs.getString("hotel_name"),
                    rs.getInt("room_number"),
                    rs.getInt("account_number"),
                    rs.getTimestamp("booking_start"),
                    rs.getTimestamp("booking_end"),
                    rs.getBoolean("is_renting")
                );

                // append Room in Rooms list
                bookings.add(newBooking);
            }

            // close the statement
            stmt.close();

            return bookings;

        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

    public String createCheckedInBy(Booking renting, int employee_id) throws Exception {
        String message = "";
        Connection con = null;
        // connection object
        ConnectionDB db = new ConnectionDB();
        // sql query
        String insertRoomQuery = "INSERT INTO checked_in_by VALUES (?, ?, ?, ?, ?, ?, ?);";

        // try connect to database, catch any exceptions
        try {
            con = db.getConnection(); //get Connection
            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(insertRoomQuery);
            // set every ? of statement
            stmt.setString(1, renting.getChainName());
            stmt.setString(2, renting.getHotelName());
            stmt.setInt(3, renting.getRoomNumber());
            stmt.setInt(4, renting.getAccountNumber());
            stmt.setTimestamp(5, renting.getBookingStart());
            stmt.setTimestamp(6, renting.getBookingEnd());
            stmt.setInt(7, employee_id);

            // execute the query
            int output = stmt.executeUpdate();
            System.out.println(output);
            // close the statement
            stmt.close();
            // close the connection
            db.close();
        } catch (Exception e) {
            message = "Error while inserting checked_in_by: " + e.getMessage();
        } finally {
            if (con != null) // if connection is still open, then close.
                con.close();
            if (message.equals("")) message = "checked_in_by successfully inserted!";
        }
        // return respective message
        return message;
    }

    public String createRenting(Booking newRenting, int employee_id) throws Exception {
        String message = "";
        Connection con = null;

        // connection object
        ConnectionDB db = new ConnectionDB();
        // sql query
        String insertRoomQuery = "INSERT INTO booking_renting VALUES (?, ?, ?, ?, ?, ?, ?);";

        // try connect to database, catch any exceptions
        try {
            con = db.getConnection(); //get Connection

            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(insertRoomQuery);

            // set every ? of statement
            stmt.setString(1, newRenting.getChainName());
            stmt.setString(2, newRenting.getHotelName());
            stmt.setInt(3, newRenting.getRoomNumber());
            stmt.setInt(4, newRenting.getAccountNumber());
            stmt.setTimestamp(5, newRenting.getBookingStart());
            stmt.setTimestamp(6, newRenting.getBookingEnd());
            stmt.setBoolean(7, newRenting.getIsRenting());

            // execute the query
            int output = stmt.executeUpdate();
            System.out.println(output);

            // close the statement
            stmt.close();
            // close the connection
            db.close();
        } catch (Exception e) {
            message = "Error while inserting renting: " + e.getMessage();
        } finally {
            if (con != null) // if connection is still open, then close.
                con.close();
            if (message.equals("")) message = "renting successfully inserted!";

        }

        String second_msg = createCheckedInBy(newRenting, employee_id);
        message = message+" | Creating renting leads to checked_in_by -> | "+second_msg;

        // return respective message
        return message;
    }

    public String convertBookingToRenting(Booking booking, int employee_id) throws Exception {
        Connection con = null;
        String message = "";

        // sql query
        String sql = "UPDATE booking_renting SET is_renting=? WHERE chain_name=? AND hotel_name=? AND room_number=? AND booking_start=? AND booking_end=? AND account_number=?;";

        // connection object
        ConnectionDB db = new ConnectionDB();

        // try connect to database, catch any exceptions
        try {
            // get connection
            con = db.getConnection();

            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // set every ? of statement
            stmt.setBoolean(1, true);
            stmt.setString(2, booking.getChainName());
            stmt.setString(3, booking.getHotelName());
            stmt.setInt(4, booking.getRoomNumber());
            stmt.setTimestamp(5, booking.getBookingStart());
            stmt.setTimestamp(6, booking.getBookingEnd());
            stmt.setInt(7, booking.getAccountNumber());

            // execute the query
            int matchedRows = stmt.executeUpdate();
            // If no rows are matched, mention this in the message
            if (matchedRows<1) {
                message = "Logic Error: No rows matched (therefore update was successful)";
            }

            // close the statement
            stmt.close();

        } catch (Exception e) {
            message = "Error while updating booking: " + e.getMessage();

        } finally {
            if (con != null) con.close();
            if (message.equals("")) message = "booking successfully updated!";
        }

        String second_msg = createCheckedInBy(booking, employee_id);
        message = message+" | Creating renting leads to checked_in_by -> | "+second_msg;

        // return respective message
        return message;
    }


    public String archiveBookingRenting(Booking oldBooking) throws Exception {
        Connection con = null;
        String message = "";

        // sql query
        String sql = "DELETE FROM booking_renting WHERE chain_name=? AND hotel_name=? AND room_number=? AND booking_start=? AND booking_end=? AND account_number=?;";

        // database connection object
        ConnectionDB db = new ConnectionDB();

        // try connect to database, catch any exceptions
        try {
            con = db.getConnection();

            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // set every ? of statement
            stmt.setString(1, oldBooking.getChainName());
            stmt.setString(2, oldBooking.getHotelName());
            stmt.setInt(3, oldBooking.getRoomNumber());
            stmt.setTimestamp(4, oldBooking.getBookingStart());
            stmt.setTimestamp(5, oldBooking.getBookingEnd());
            stmt.setInt(6, oldBooking.getAccountNumber());

            // execute the query
            int matchedRows = stmt.executeUpdate();
            // If no rows are matched, mention this in the message
            if (matchedRows<1) {
                message = "Logic Error: No rows matched (therefore delete was successful)";
            }

            // close the statement
            stmt.close();

        } catch (Exception e) {
            message = "Error while delete booking_renting: " + e.getMessage();
        } finally {
            if (con != null) con.close();
            if (message.equals("")) message = "Booking_renting successfully deleted!";
        }

        return message;
    }


}

