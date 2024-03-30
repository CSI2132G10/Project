package group10;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class ViewService {

    public List<ViewResult> getHotelCapacity() throws Exception {

        // sql query
        String sql = "SELECT * FROM hotel_capacity_view";
        // connection object
        ConnectionDB db = new ConnectionDB();

        // data structure to keep all HotelChains retrieved from database
        List<ViewResult> results = new ArrayList<ViewResult>();

        // try connect to database, catch any exceptions
        try (Connection con = db.getConnection()) {
            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // get the results from executing the query
            ResultSet rs = stmt.executeQuery();

            // iterate through the result set
            while (rs.next()) {
                // create new HotelChain object
                ViewResult viewRes = new ViewResult(
                    rs.getString("chain_name"),
                    rs.getString("hotel_name"),
                    rs.getInt("total_capacity")
                );

                // append HotelChain in HotelChains list
                results.add(viewRes);
            }

            // close result set
            rs.close();
            // close statement
            stmt.close();
            con.close();
            db.close();

            // return result
            return results;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

    public List<ViewResult> getRemainingRooms() throws Exception {

        // sql query
        String sql = "SELECT * FROM remaining_rooms_view";
        // connection object
        ConnectionDB db = new ConnectionDB();

        // data structure to keep all HotelChains retrieved from database
        List<ViewResult> results = new ArrayList<ViewResult>();

        // try connect to database, catch any exceptions
        try (Connection con = db.getConnection()) {
            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // get the results from executing the query
            ResultSet rs = stmt.executeQuery();

            // iterate through the result set
            while (rs.next()) {
                // create new HotelChain object
                ViewResult viewRes = new ViewResult(
                    rs.getString("chain_name"),
                    rs.getString("hotel_name"),
                    rs.getInt("remaining_rooms")
                );

                // append HotelChain in HotelChains list
                results.add(viewRes);
            }

            // close result set
            rs.close();
            // close statement
            stmt.close();
            con.close();
            db.close();

            // return result
            return results;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

}
