package group10;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CustomerService {

    /**
     * Method to get all Customers from database
     *
     * @return list of all Customers found in database
     * @throws Exception when trying to connect to database
     */
    public List<Customer> getCustomers() throws Exception {

        // sql query
        String sql = "SELECT * FROM customer";
        // connection object
        ConnectionDB db = new ConnectionDB();

        // data structure to keep all Customers retrieved from database
        List<Customer> customers = new ArrayList<Customer>();

        // try connect to database, catch any exceptions
        try (Connection con = db.getConnection()) {
            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // get the results from executing the query
            ResultSet rs = stmt.executeQuery();

            // iterate through the result set
            while (rs.next()) {
                // create new Customer object
                Customer newCust = new Customer(
                    rs.getInt("account_number"),
                    rs.getString("customer_name"),
                    rs.getString("address"),
                    rs.getInt("id"),
                    rs.getDate("date_of_registration")
                );

                // append Customer in Customers list
                customers.add(newCust);
            }

            // close result set
            rs.close();
            // close statement
            stmt.close();
            con.close();
            db.close();

            // return result
            return customers;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

    public String createCustomer(Customer newCust) throws Exception {
        String message = "";
        Connection con = null;

        // connection object
        ConnectionDB db = new ConnectionDB();
        System.out.println(newCust.getAccountNumber());
        System.out.println(newCust.getCustomerName());
        System.out.println(newCust.getAddress());
        System.out.println(newCust.getId());
        System.out.println(newCust.getDateOfRegistration());

        // sql query
        String insertCustomerQuery = "INSERT INTO customer(customer_name,address,id,date_of_registration) VALUES (?, ?, ?, ?);";

        // try connect to database, catch any exceptions
        try {
            con = db.getConnection(); //get Connection

            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(insertCustomerQuery);

            // set every ? of statement
            stmt.setString(1, newCust.getCustomerName());
            stmt.setString(2, newCust.getAddress());
            stmt.setInt(3, newCust.getId());
            stmt.setDate(4, newCust.getDateOfRegistration());

            // execute the query
            int output = stmt.executeUpdate();
            System.out.println(output);

            // close the statement
            stmt.close();
            // close the connection
            db.close();
        } catch (Exception e) {
            message = "Error while inserting Customer: " + e.getMessage();
        } finally {
            if (con != null) // if connection is still open, then close.
                con.close();
            if (message.equals("")) message = "Customer successfully inserted!";

        }

        // return respective message
        return message;
    }

    public String updateCustomer(Customer editCust) throws Exception {
        Connection con = null;
        String message = "";

        // sql query
        String sql = "UPDATE customer SET customer_name=?, address=?, id=?, date_of_registration=? WHERE account_number=?;";

        // connection object
        ConnectionDB db = new ConnectionDB();

        // try connect to database, catch any exceptions
        try {
            // get connection
            con = db.getConnection();

            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // set every ? of statement
            stmt.setString(1, editCust.getCustomerName());
            stmt.setString(2, editCust.getAddress());
            stmt.setInt(3, editCust.getId());
            stmt.setDate(4, editCust.getDateOfRegistration());
            stmt.setInt(5, editCust.getAccountNumber());


            // execute the query
            stmt.executeUpdate();

            // close the statement
            stmt.close();

        } catch (Exception e) {
            message = "Error while updating Customer: " + e.getMessage();

        } finally {
            if (con != null) con.close();
            if (message.equals("")) message = "Customer successfully updated!";
        }

        // return respective message
        return message;
    }


    public String deleteCustomer(int account_number) throws Exception {
        Connection con = null;
        String message = "";

        // sql query
        String sql = "DELETE FROM customer WHERE account_number=?;";

        // database connection object
        ConnectionDB db = new ConnectionDB();

        // try connect to database, catch any exceptions
        try {
            con = db.getConnection();

            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // set every ? of statement
            stmt.setInt(1, account_number);

            // execute the query
            stmt.executeUpdate();

            // close the statement
            stmt.close();

        } catch (Exception e) {
            message = "Error while delete Customer: " + e.getMessage();
        } finally {
            if (con != null) con.close();
            if (message.equals("")) message = "Customer successfully deleted!";
        }

        return message;
    }


}

