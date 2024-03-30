package group10;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoomService {

    /**
     * Method to get all rooms from database
     *
     * @return list of all chains found in database
     * @throws Exception when trying to connect to database
     */
    public List<Room> getRooms() throws Exception {

        // sql query
        String sql = "SELECT * FROM room";
        // connection object
        ConnectionDB db = new ConnectionDB();

        // data structure to keep all Rooms retrieved from database
        List<Room> rooms = new ArrayList<Room>();

        // try connect to database, catch any exceptions
        try (Connection con = db.getConnection()) {
            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // get the results from executing the query
            ResultSet rs = stmt.executeQuery();

            // iterate through the result set
            while (rs.next()) {
                // create new Room object
                Room newRoom = new Room(
                    rs.getString("chain_name"),
                    rs.getString("hotel_name"),
                    rs.getInt("room_number"),
                    rs.getFloat("price"),
                    rs.getInt("capacity")
                );

                // append Room in Rooms list
                rooms.add(newRoom);
            }

            // close result set
            rs.close();
            // close statement
            stmt.close();
            con.close();
            db.close();

            // return result
            return rooms;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

    public List<Room> findRoom(String chain_name, String hotel_name, int room_number) throws Exception {
        Connection con = null;

        // sql query
        String sql = "SELECT * FROM room WHERE chain_name=? AND hotel_name=? AND room_number=?;";

        // database connection object
        ConnectionDB db = new ConnectionDB();

        List<Room> rooms = new ArrayList<Room>();

        // try connect to database, catch any exceptions
        try {

            con = db.getConnection();

            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // set every ? of statement
            stmt.setString(1, chain_name);
            stmt.setString(2, hotel_name);
            stmt.setInt(3, room_number);

            // execute the query
            ResultSet rs = stmt.executeQuery();

            // iterate through the result set
            while (rs.next()) {
                // create new Room object
                Room newRoom = new Room(
                    rs.getString("chain_name"),
                    rs.getString("hotel_name"),
                    rs.getInt("room_number"),
                    rs.getFloat("price"),
                    rs.getInt("capacity")
                );

                // append Room in Rooms list
                rooms.add(newRoom);
            }

            // close result set
            rs.close();
            // close statement
            stmt.close();
            con.close();
            db.close();

            return rooms;

        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }

    }

    /**
     * @param chain_name Leave as "" to avoid searching using chain_name
     * @param rating Leave as -1 to avoid searching using hotel rating
     * @param num_of_rooms Leave as -1 to avoid searching using hotel num_of_rooms
     * @param price Leave as -1 to avoid searching using price
     * @param capacity Leave as -1 to avoid searching using capacity
     * @return
     * @throws Exception
     */
    public List<Room> complexRoomSearch(String chain_name, int rating, int num_of_rooms, float price, int capacity) throws Exception {
        Connection con = null;

        String sqlRoom = "SELECT * FROM room";
        boolean whereFlag = false;
        if (!chain_name.equals("")) {
            if (!whereFlag) {sqlRoom=sqlRoom+" WHERE chain_name=?"; whereFlag=true;}
            else {sqlRoom=sqlRoom+" AND chain_name=?";}
        }
        if (!(price==-1)) {
            if (!whereFlag) {sqlRoom=sqlRoom+" WHERE price<=?"; whereFlag=true;}
            else {sqlRoom=sqlRoom+" AND price=?";}
        }
        if (!(capacity==-1)) {
            if (!whereFlag) {sqlRoom=sqlRoom+" WHERE capacity=?"; whereFlag=true;}
            else {sqlRoom=sqlRoom+" AND capacity=?";}
        }

        String sqlHotel = "SELECT * FROM hotel";
        whereFlag = false;
        if (!(rating==-1)) {
            if (!whereFlag) {sqlHotel=sqlHotel+" WHERE rating=?"; whereFlag=true;}
            else {sqlHotel=sqlHotel+" AND rating=?";}
        }
        if (!(num_of_rooms==-1)) {
            if (!whereFlag) {sqlHotel=sqlHotel+" WHERE num_rooms=?"; whereFlag=true;}
            else {sqlHotel=sqlHotel+" AND num_rooms=?";}
        }

        String sql = "SELECT * FROM ("+sqlRoom+") AS room INNER JOIN ("+sqlHotel+") AS hotel ON room.hotel_name = hotel.hotel_name AND room.chain_name = hotel.chain_name;";


        // database connection object
        ConnectionDB db = new ConnectionDB();

        List<Room> rooms = new ArrayList<Room>();

        // try connect to database, catch any exceptions
        try {

            con = db.getConnection();

            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);

            int counter=1;
            if (!chain_name.equals("")) {
                stmt.setString(counter, chain_name);
                counter++;
            }
            if (!(price==-1)) {
                // No clue why, but this only works with bigdecimal
                stmt.setBigDecimal(counter, new BigDecimal(Float.toString(price)));
                counter++;
            }
            if (!(capacity==-1)) {
                stmt.setInt(counter, capacity);
                counter++;
            }    
            if (!(rating==-1)) {
                stmt.setInt(counter, rating);
                counter++;
            }
            if (!(num_of_rooms==-1)) {
                stmt.setInt(counter, num_of_rooms);
                counter++;
            }

            // execute the query
            ResultSet rs = stmt.executeQuery();
            
            // iterate through the result set
            while (rs.next()) {
                // create new Room object
                Room newRoom = new Room(
                    rs.getString("chain_name"),
                    rs.getString("hotel_name"),
                    rs.getInt("room_number"),
                    rs.getFloat("price"),
                    rs.getInt("capacity")
                );

                // append Room in Rooms list
                rooms.add(newRoom);
            }

            // close result set
            rs.close();
            // close statement
            stmt.close();
            con.close();
            db.close();
            
            return rooms;

        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }

    }


    public List<String> findRoomAmenities(String chain_name, String hotel_name, int room_number) throws Exception {
        Connection con = null;
        // sql query
        String sql = "SELECT * FROM room_amenities WHERE chain_name=? AND hotel_name=? AND room_number=?;";
        // database connection object
        ConnectionDB db = new ConnectionDB();
        List<String> amenities = new ArrayList<String>();
        // try connect to database, catch any exceptions
        try {
            con = db.getConnection();
            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);
            // set every ? of statement
            stmt.setString(1, chain_name);
            stmt.setString(2, hotel_name);
            stmt.setInt(3, room_number);
            // execute the query
            ResultSet rs = stmt.executeQuery();
            // iterate through the result set
            while (rs.next()) {
                String newAmenity = rs.getString("amenity");
                amenities.add(newAmenity);
            }
            /// close result set
            rs.close();
            // close statement
            stmt.close();
            con.close();
            db.close();

            return amenities;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

    public String createRoomAmenity(String chain_name, String hotel_name, int room_number, String amenity) throws Exception {
        String message = "";
        Connection con = null;
        // connection object
        ConnectionDB db = new ConnectionDB();
        // sql query
        String insertRoomQuery = "INSERT INTO room_amenities VALUES (?, ?, ?, ?);";

        // try connect to database, catch any exceptions
        try {
            con = db.getConnection(); //get Connection
            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(insertRoomQuery);
            // set every ? of statement
            stmt.setString(1, chain_name);
            stmt.setString(2, hotel_name);
            stmt.setInt(3, room_number);
            stmt.setString(4, amenity);
            // execute the query
            int output = stmt.executeUpdate();
            System.out.println(output);
            // close the statement
            stmt.close();
            // close the connection
            db.close();
        } catch (Exception e) {
            message = "Error while inserting amenity: " + e.getMessage();
        } finally {
            if (con != null) // if connection is still open, then close.
                con.close();
            if (message.equals("")) message = "Amenity successfully inserted!";
        }
        // return respective message
        return message;
    }

    public String deleteRoomAmenity(String chain_name, String hotel_name, int room_number, String amenity) throws Exception {
        Connection con = null;
        String message = "";
        // sql query
        String sql = "DELETE FROM room_amenities WHERE chain_name=? AND hotel_name=? AND room_number=? AND amenity=?;";
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
            stmt.setInt(3, room_number);
            stmt.setString(4, amenity);
            // execute the query
            int matchedRows = stmt.executeUpdate();
            // If no rows are matched, mention this in the message
            if (matchedRows<1) {
                message = "Logic Error: No rows matched (therefore delete was successful)";
            }
            // close the statement
            stmt.close();
        } catch (Exception e) {
            message = "Error while delete Amenity: " + e.getMessage();
        } finally {
            if (con != null) con.close();
            if (message.equals("")) message = "Amenity successfully deleted!";
        }
        return message;
    }

    public List<String> findRoomAdditional(String chain_name, String hotel_name, int room_number) throws Exception {
        Connection con = null;
        // sql query
        String sql = "SELECT * FROM room_additional WHERE chain_name=? AND hotel_name=? AND room_number=?;";
        // database connection object
        ConnectionDB db = new ConnectionDB();
        List<String> additionals = new ArrayList<String>();
        // try connect to database, catch any exceptions
        try {
            con = db.getConnection();
            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);
            // set every ? of statement
            stmt.setString(1, chain_name);
            stmt.setString(2, hotel_name);
            stmt.setInt(3, room_number);
            // execute the query
            ResultSet rs = stmt.executeQuery();
            // iterate through the result set
            while (rs.next()) {
                String newDetail = rs.getString("additional_details");
                additionals.add(newDetail);
            }
            // close result set
            rs.close();
            // close statement
            stmt.close();
            con.close();
            db.close();
            
            return additionals;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

    public String createRoomAdditional(String chain_name, String hotel_name, int room_number, String additional_detail) throws Exception {
        String message = "";
        Connection con = null;
        // connection object
        ConnectionDB db = new ConnectionDB();
        // sql query
        String insertRoomQuery = "INSERT INTO room_additional VALUES (?, ?, ?, ?);";

        // try connect to database, catch any exceptions
        try {
            con = db.getConnection(); //get Connection
            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(insertRoomQuery);
            // set every ? of statement
            stmt.setString(1, chain_name);
            stmt.setString(2, hotel_name);
            stmt.setInt(3, room_number);
            stmt.setString(4, additional_detail);
            // execute the query
            int output = stmt.executeUpdate();
            System.out.println(output);
            // close the statement
            stmt.close();
            // close the connection
            db.close();
        } catch (Exception e) {
            message = "Error while inserting additional detail: " + e.getMessage();
        } finally {
            if (con != null) // if connection is still open, then close.
                con.close();
            if (message.equals("")) message = "Additional room detail successfully inserted!";
        }
        // return respective message
        return message;
    }

    public String deleteRoomAdditional(String chain_name, String hotel_name, int room_number, String additional_detail) throws Exception {
        Connection con = null;
        String message = "";
        // sql query
        String sql = "DELETE FROM room_additional WHERE chain_name=? AND hotel_name=? AND room_number=? AND additional_details=?;";
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
            stmt.setInt(3, room_number);
            stmt.setString(4, additional_detail);
            // execute the query
            int matchedRows = stmt.executeUpdate();
            // If no rows are matched, mention this in the message
            if (matchedRows<1) {
                message = "Logic Error: No rows matched (therefore delete was successful)";
            }
            // close the statement
            stmt.close();
        } catch (Exception e) {
            message = "Error while delete additional_detail: " + e.getMessage();
        } finally {
            if (con != null) con.close();
            if (message.equals("")) message = "Additional_detail successfully deleted!";
        }
        return message;
    }

    public String createRoom(Room newRoom) throws Exception {
        String message = "";
        Connection con = null;

        // connection object
        ConnectionDB db = new ConnectionDB();
        System.out.println(newRoom.getChainName());
        System.out.println(newRoom.getHotelName());
        System.out.println(newRoom.getRoomNumber());
        System.out.println(newRoom.getPrice());
        System.out.println(newRoom.getCapacity());

        // sql query
        String insertRoomQuery = "INSERT INTO room VALUES (?, ?, ?, ?, ?);";

        // try connect to database, catch any exceptions
        try {
            con = db.getConnection(); //get Connection

            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(insertRoomQuery);

            // set every ? of statement
            stmt.setString(1, newRoom.getChainName());
            stmt.setString(2, newRoom.getHotelName());
            stmt.setInt(3, newRoom.getRoomNumber());
            stmt.setFloat(4, newRoom.getPrice());
            stmt.setInt(5, newRoom.getCapacity());

            // execute the query
            int output = stmt.executeUpdate();
            System.out.println(output);

            // close the statement
            stmt.close();
            // close the connection
            db.close();
        } catch (Exception e) {
            message = "Error while inserting room: " + e.getMessage();
        } finally {
            if (con != null) // if connection is still open, then close.
                con.close();
            if (message.equals("")) message = "Room successfully inserted!";

        }

        // return respective message
        return message;
    }

    public String updateRoom(Room editRoom) throws Exception {
        Connection con = null;
        String message = "";

        // sql query
        String sql = "UPDATE room SET price=?, capacity=? WHERE chain_name=? AND hotel_name=? AND room_number=?;";

        // connection object
        ConnectionDB db = new ConnectionDB();

        // try connect to database, catch any exceptions
        try {
            // get connection
            con = db.getConnection();

            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // set every ? of statement
            stmt.setFloat(1, editRoom.getPrice());
            stmt.setInt(2, editRoom.getCapacity());
            stmt.setString(3, editRoom.getChainName());
            stmt.setString(4, editRoom.getHotelName());
            stmt.setInt(5, editRoom.getRoomNumber());

            // execute the query
            int matchedRows = stmt.executeUpdate();
            // If no rows are matched, mention this in the message
            if (matchedRows<1) {
                message = "Logic Error: No rows matched (therefore update was successful)";
            }

            // close the statement
            stmt.close();

        } catch (Exception e) {
            message = "Error while updating room: " + e.getMessage();

        } finally {
            if (con != null) con.close();
            if (message.equals("")) message = "Room successfully updated!";
        }

        // return respective message
        return message;
    }


    public String deleteRoom(String chain_name, String hotel_name, int room_number) throws Exception {
        Connection con = null;
        String message = "";

        // sql query
        String sql = "DELETE FROM room WHERE chain_name=? AND hotel_name=? AND room_number=?;";

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
            stmt.setInt(3, room_number);

            // execute the query
            int matchedRows = stmt.executeUpdate();
            // If no rows are matched, mention this in the message
            if (matchedRows<1) {
                message = "Logic Error: No rows matched (therefore update was successful)";
            }

            // close the statement
            stmt.close();

        } catch (Exception e) {
            message = "Error while delete room: " + e.getMessage();
        } finally {
            if (con != null) con.close();
            if (message.equals("")) message = "Room successfully deleted!";
        }

        return message;
    }


}

