package group10;

/**
 * Room class to save Room information
 */
public class Room {

    private String chain_name;
    private String hotel_name;
    private int room_number;
    private float price;
    private int capacity;

    public Room(String chain_name, String hotel_name, int room_number, float price, int capacity) {
        this.chain_name = chain_name;
        this.hotel_name = hotel_name;
        this.room_number = room_number;
        this.price = price;
        this.capacity = capacity;
    }

    public String getChainName() {return chain_name;}
    public void setChainName(String chain_name) {this.chain_name = chain_name;}
    public String getHotelName() {return hotel_name;}
    public void setHotelName(String hotel_name) {this.hotel_name = hotel_name;}
    public int getRoomNumber() {return room_number;}
    public void setRoomNumber(int room_number) {this.room_number = room_number;}
    public float getPrice() {return price;}
    public void setPrice(float price) {this.price = price;}
    public int getCapacity() {return capacity;}
    public void setCapacity(int capacity) {this.capacity = capacity;}

    @Override
    public String toString() {
        return "<ul>"
            + "<li>Room= " + chain_name + "</li>"
            + "<li>Room= " + hotel_name + "</li>"
            + "<li>Room= " + room_number + "</li>"
            + "<li>Room= " + price + "</li>"
            + "<li>Room= " + capacity + "</li>";
    }
}
