/**
 * HotelChain class to save HotelChain information
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

    public String getChain_name() {return chain_name;}
    public void setChain_name(String chain_name) {this.chain_name = chain_name;}
    public String getHotel_name() {return hotel_name;}
    public void setHotel_name(String hotel_name) {this.hotel_name = hotel_name;}
    public int getRoom_number() {return room_number;}
    public void setRoom_number(int room_number) {this.room_number = room_number;}
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
