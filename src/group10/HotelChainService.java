package group10;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class HotelChainService {

    /**
     * Method to get all hotel chains from database
     *
     * @return list of all chains found in database
     * @throws Exception when trying to connect to database
     */
    public List<HotelChain> getHotelChains() throws Exception {

        // sql query
        String sql = "SELECT * FROM hotel_chain";
        // connection object
        ConnectionDB db = new ConnectionDB();

        // data structure to keep all HotelChains retrieved from database
        List<HotelChain> chains = new ArrayList<HotelChain>();

        // try connect to database, catch any exceptions
        try (Connection con = db.getConnection()) {
            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // get the results from executing the query
            ResultSet rs = stmt.executeQuery();

            // iterate through the result set
            while (rs.next()) {
                // create new HotelChain object
                HotelChain chain = new HotelChain(
                    rs.getString("chain_name"),
                    rs.getInt("num_hotels")
                );

                // append HotelChain in HotelChains list
                chains.add(chain);
            }

            // close result set
            rs.close();
            // close statement
            stmt.close();
            con.close();
            db.close();

            // return result
            return chains;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

}
