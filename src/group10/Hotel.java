package group10;

/**
 * Hotel class to save Hotel information
 */
public class Hotel {

    private String chain_name;
    private String hotel_name;
    private int rating;
    private String address;
    private String email;
    private int manager;


    public Hotel(String chain_name, String hotel_name, int rating, String address, String email, int manager) {
        this.chain_name = chain_name;
        this.hotel_name = hotel_name;
        this.rating = rating;
        this.address = address;
        this.email = email;
        this.manager = manager;
    }

    public String getChainName() {return chain_name;}
    public void setChainName(String chain_name) {this.chain_name = chain_name;}
    public String getHotelName() {return hotel_name;}
    public void setHotelName(String hotel_name) {this.hotel_name = hotel_name;}
    public int getRating() {return rating;}
    public String getAddress() {return address;}
    public String getEmail() {return email;}
    public int getManager() {return manager;}
    public void setRating(int rating) {this.rating = rating;}
    public void setAddress(String address) {this.address = address;}
    public void setEmail(String email) {this.email = email;}
    public void setManager(int manager) {this.manager = manager;}


    @Override
    public String toString() {
        return "<ul>"
            + "<li>Room= " + chain_name + "</li>"
            + "<li>Room= " + hotel_name + "</li>"
            + "<li>Room= " + rating + "</li>"
            + "<li>Room= " + address + "</li>"
            + "<li>Room= " + email + "</li>"
            + "<li>Room= " + manager + "</li>";
    }
}
