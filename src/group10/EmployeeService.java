package group10;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class EmployeeService {

    /**
     * Method to get all employees from database
     *
     * @return list of all employees found in database
     * @throws Exception when trying to connect to database
     */
    public List<Employee> getEmployees() throws Exception {

        // sql query
        String sql = "SELECT * FROM employee";
        // connection object
        ConnectionDB db = new ConnectionDB();

        // data structure to keep all Employees retrieved from database
        List<Employee> employees = new ArrayList<Employee>();

        // try connect to database, catch any exceptions
        try (Connection con = db.getConnection()) {
            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // get the results from executing the query
            ResultSet rs = stmt.executeQuery();

            // iterate through the result set
            while (rs.next()) {
                // create new Employee object
                Employee newEmp = new Employee(
                    rs.getInt("employee_id"),
                    rs.getString("employee_name"),
                    rs.getString("role"),
                    rs.getInt("sin"),
                    rs.getString("address"),
                    rs.getString("chain_name")
                );

                // append Employee in Employees list
                employees.add(newEmp);
            }

            // close result set
            rs.close();
            // close statement
            stmt.close();
            con.close();
            db.close();

            // return result
            return employees;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

    public String createEmployee(Employee newEmp) throws Exception {
        String message = "";
        Connection con = null;

        // connection object
        ConnectionDB db = new ConnectionDB();
        System.out.println(newEmp.getEmployeeId());
        System.out.println(newEmp.getEmployeeName());
        System.out.println(newEmp.getRole());
        System.out.println(newEmp.getSin());
        System.out.println(newEmp.getAddress());
        System.out.println(newEmp.getChainName());

        // sql query
        String insertEmployeeQuery = "INSERT INTO employee(employee_name,role,sin,address,chain_name) VALUES (?, ?, ?, ?, ?);";

        // try connect to database, catch any exceptions
        try {
            con = db.getConnection(); //get Connection

            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(insertEmployeeQuery);

            // set every ? of statement
            stmt.setString(1, newEmp.getEmployeeName());
            stmt.setString(2, newEmp.getRole());
            stmt.setInt(3, newEmp.getSin());
            stmt.setString(4, newEmp.getAddress());
            stmt.setString(5, newEmp.getChainName());

            // execute the query
            int output = stmt.executeUpdate();
            System.out.println(output);

            // close the statement
            stmt.close();
            // close the connection
            db.close();
        } catch (Exception e) {
            message = "Error while inserting Employee: " + e.getMessage();
        } finally {
            if (con != null) // if connection is still open, then close.
                con.close();
            if (message.equals("")) message = "Employee successfully inserted!";

        }

        // return respective message
        return message;
    }

    public String updateEmployee(Employee editEmp) throws Exception {
        Connection con = null;
        String message = "";

        // sql query
        String sql = "UPDATE employee SET employee_name=?, role=?, sin=?, address=?, chain_name=? WHERE employee_id=?;";

        // connection object
        ConnectionDB db = new ConnectionDB();

        // try connect to database, catch any exceptions
        try {
            // get connection
            con = db.getConnection();

            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // set every ? of statement
            stmt.setString(1, editEmp.getEmployeeName());
            stmt.setString(2, editEmp.getRole());
            stmt.setInt(3, editEmp.getSin());
            stmt.setString(4, editEmp.getAddress());
            stmt.setString(5, editEmp.getChainName());
            stmt.setInt(6, editEmp.getEmployeeId());


            // execute the query
            stmt.executeUpdate();

            // close the statement
            stmt.close();

        } catch (Exception e) {
            message = "Error while updating Employee: " + e.getMessage();

        } finally {
            if (con != null) con.close();
            if (message.equals("")) message = "Employee successfully updated!";
        }

        // return respective message
        return message;
    }


    public String deleteEmployee(int employee_id) throws Exception {
        Connection con = null;
        String message = "";

        // sql query
        String sql = "DELETE FROM employee WHERE employee_id=?;";

        // database connection object
        ConnectionDB db = new ConnectionDB();

        // try connect to database, catch any exceptions
        try {
            con = db.getConnection();

            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // set every ? of statement
            stmt.setInt(1, employee_id);

            // execute the query
            stmt.executeUpdate();

            // close the statement
            stmt.close();

        } catch (Exception e) {
            message = "Error while delete Employee: " + e.getMessage();
        } finally {
            if (con != null) con.close();
            if (message.equals("")) message = "Employee successfully deleted!";
        }

        return message;
    }


}

