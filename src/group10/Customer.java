package group10;

import java.sql.Date;

/**
 * Customer class to save Customer information
 */
public class Customer {

    private int account_number;
    private String customer_name;
    private String address;
    private int id;
    private Date date_of_registration;


    public Customer(int account_number, String customer_name, String address, int id, Date date_of_registration) {
        this.account_number = account_number;
        this.customer_name = customer_name;
        this.address = address;
        this.id = id;
        this.date_of_registration = date_of_registration;
    }

    public int getAccountNumber() {return account_number;}
    public String getCustomerName() {return customer_name;}
    public String getAddress() {return address;}
    public int getId() {return id;}
    public Date getDateOfRegistration() {return date_of_registration;}
    public void setAccountNumber(int account_number) {this.account_number = account_number;}
    public void setCustomerName(String customer_name) {this.customer_name = customer_name;}
    public void setAddress(String address) {this.address = address;}
    public void setId(int id) {this.id = id;}
    public void setDateOfRegistration(Date date_of_registration) {this.date_of_registration = date_of_registration;}


    @Override
    public String toString() {
        return "<ul>"
            + "<li>Room= " + account_number + "</li>"
            + "<li>Room= " + customer_name + "</li>"
            + "<li>Room= " + address + "</li>"
            + "<li>Room= " + id + "</li>"
            + "<li>Room= " + date_of_registration + "</li>";
    }
}
