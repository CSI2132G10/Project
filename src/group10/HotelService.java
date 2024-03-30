package group10;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class HotelService {

    /**
     * Method to get all Hotel from database
     *
     * @return list of all Hotel found in database
     * @throws Exception when trying to connect to database
     */
    public List<Hotel> getHotels() throws Exception {

        // sql query
        String sql = "SELECT * FROM hotel";
        // connection object
        ConnectionDB db = new ConnectionDB();

        // data structure to keep all Hotels retrieved from database
        List<Hotel> hotels = new ArrayList<Hotel>();

        // try connect to database, catch any exceptions
        try (Connection con = db.getConnection()) {
            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // get the results from executing the query
            ResultSet rs = stmt.executeQuery();

            // iterate through the result set
            while (rs.next()) {
                // create new Hotel object
                Hotel newHotel = new Hotel(
                    rs.getString("chain_name"),
                    rs.getString("hotel_name"),
                    rs.getInt("rating"),
                    rs.getString("address"),
                    rs.getString("email"),
                    rs.getInt("manager"),
                    rs.getInt("num_rooms")
                );

                // append Hotel in Hotels list
                hotels.add(newHotel);
            }

            // close result set
            rs.close();
            // close statement
            stmt.close();
            con.close();
            db.close();

            // return result
            return hotels;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

    public List<Hotel> findHotel(String chain_name, String hotel_name) throws Exception {
        Connection con = null;

        // sql query
        String sql = "SELECT * FROM hotel WHERE chain_name=? AND hotel_name=?;";

        // database connection object
        ConnectionDB db = new ConnectionDB();

        List<Hotel> hotels = new ArrayList<Hotel>();

        // try connect to database, catch any exceptions
        try {

            con = db.getConnection();

            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // set every ? of statement
            stmt.setString(1, chain_name);
            stmt.setString(2, hotel_name);

            // execute the query
            ResultSet rs = stmt.executeQuery();

            // iterate through the result set
            while (rs.next()) {
                // create new Room object
                Hotel newHotel = new Hotel(
                    rs.getString("chain_name"),
                    rs.getString("hotel_name"),
                    rs.getInt("rating"),
                    rs.getString("address"),
                    rs.getString("email"),
                    rs.getInt("manager"),
                    rs.getInt("num_rooms")
                );

                // append Room in Rooms list
                hotels.add(newHotel);
            }

            // close result set
            rs.close();
            // close statement
            stmt.close();
            con.close();
            db.close();

            return hotels;

        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }

    }

    public String createHotel(Hotel newHotel) throws Exception {
        String message = "";
        Connection con = null;

        // connection object
        ConnectionDB db = new ConnectionDB();

        // sql query
        String insertHotelQuery = "INSERT INTO hotel VALUES (?, ?, ?, ?, ?, ?, ?);";

        // try connect to database, catch any exceptions
        try {
            con = db.getConnection(); //get Connection

            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(insertHotelQuery);

            // set every ? of statement
            stmt.setString(1, newHotel.getChainName());
            stmt.setString(2, newHotel.getHotelName());
            stmt.setInt(3, newHotel.getRating());
            stmt.setString(4, newHotel.getAddress());
            stmt.setString(5, newHotel.getEmail());
            stmt.setInt(6, newHotel.getManager());
            stmt.setInt(7, newHotel.getNumRooms());

            // execute the query
            int output = stmt.executeUpdate();
            System.out.println(output);

            // close the statement
            stmt.close();
            // close the connection
            db.close();
        } catch (Exception e) {
            message = "Error while inserting hotel: " + e.getMessage();
        } finally {
            if (con != null) // if connection is still open, then close.
                con.close();
            if (message.equals("")) message = "Hotel successfully inserted!";

        }

        // return respective message
        return message;
    }

    //Update hotel is not allowed to update the num_rooms attribute
    public String updateHotel(Hotel editHotel) throws Exception {
        Connection con = null;
        String message = "";

        // sql query
        String sql = "UPDATE hotel SET rating=?, address=?, email=?, manager=? WHERE chain_name=? AND hotel_name=?;";

        // connection object
        ConnectionDB db = new ConnectionDB();

        // try connect to database, catch any exceptions
        try {
            // get connection
            con = db.getConnection();

            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // set every ? of statement
            stmt.setString(5, editHotel.getChainName());
            stmt.setString(6, editHotel.getHotelName());
            stmt.setInt(1, editHotel.getRating());
            stmt.setString(2, editHotel.getAddress());
            stmt.setString(3, editHotel.getEmail());
            stmt.setInt(4, editHotel.getManager());


            // execute the query
            int matchedRows = stmt.executeUpdate();
            // If no rows are matched, mention this in the message
            if (matchedRows<1) {
                message = "Logic Error: No rows matched (therefore update was successful)";
            }

            // close the statement
            stmt.close();

        } catch (Exception e) {
            message = "Error while updating Hotel: " + e.getMessage();

        } finally {
            if (con != null) con.close();
            if (message.equals("")) message = "Hotel successfully updated!";
        }

        // return respective message
        return message;
    }


    public String deleteHotel(String chain_name, String hotel_name) throws Exception {
        Connection con = null;
        String message = "";

        // sql query
        String sql = "DELETE FROM hotel WHERE chain_name=? AND hotel_name=?;";

        // database connection object
        ConnectionDB db = new ConnectionDB();

        // try connect to database, catch any exceptions
        try {
            con = db.getConnection();

            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // set every ? of statement
            stmt.setString(1, chain_name);
            stmt.setString(2, hotel_name);

            // execute the query
            int matchedRows = stmt.executeUpdate();
            // If no rows are matched, mention this in the message
            if (matchedRows<1) {
                message = "Logic Error: No rows matched (therefore update was successful)";
            }

            // close the statement
            stmt.close();

        } catch (Exception e) {
            message = "Error while delete Hotel: " + e.getMessage();
        } finally {
            if (con != null) con.close();
            if (message.equals("")) message = "Hotel successfully deleted!";
        }

        return message;
    }


}

