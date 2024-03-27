package group10;

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
            stmt.executeUpdate();

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
            stmt.executeUpdate();

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
