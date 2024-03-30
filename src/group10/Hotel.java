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
    private int num_rooms;


    public Hotel(String chain_name, String hotel_name, int rating, String address, String email, int manager, int num_rooms) {
        this.chain_name = chain_name;
        this.hotel_name = hotel_name;
        this.rating = rating;
        this.address = address;
        this.email = email;
        this.manager = manager;
        this.num_rooms = num_rooms;
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
    public int getNumRooms() {return num_rooms;}
    public void setNumRooms(int num_rooms) {this.num_rooms = num_rooms;}


    @Override
    public String toString() {
        return "<ul>"
            + "<li>Room= " + chain_name + "</li>"
            + "<li>Room= " + hotel_name + "</li>"
            + "<li>Room= " + rating + "</li>"
            + "<li>Room= " + address + "</li>"
            + "<li>Room= " + email + "</li>"
            + "<li>Room= " + manager + "</li>"
            + "<li>Room= " + num_rooms + "</li>";
    }
}
