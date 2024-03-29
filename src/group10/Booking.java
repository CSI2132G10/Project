package group10;

import java.sql.Timestamp;

/**
 * Booking class to save Booking information
 */
public class Booking {

    private String chain_name;
    private String hotel_name;
    private int room_number;
    private int account_number;
    private Timestamp booking_start;
    private Timestamp booking_end;
    private boolean is_renting;


    public Booking(String chain_name, String hotel_name, int room_number, int account_number, Timestamp booking_start, Timestamp booking_end, boolean is_renting) {
        this.chain_name = chain_name;
        this.hotel_name = hotel_name;
        this.room_number = room_number;
        this.account_number = account_number;
        this.booking_start = booking_start;
        this.booking_end = booking_end;
        this.is_renting = is_renting;
    }

    public String getChainName() {return chain_name;}
    public void setChainName(String chain_name) {this.chain_name = chain_name;}
    public String getHotelName() {return hotel_name;}
    public void setHotelName(String hotel_name) {this.hotel_name = hotel_name;}
    public int getRoomNumber() {return room_number;}
    public void setRoomNumber(int room_number) {this.room_number = room_number;}
    public int getAccountNumber() {return account_number;}
    public void setAccountNumber(int account_number) {this.account_number = account_number;}
    public Timestamp getBookingStart() {return booking_start;}
    public void setBookingStart(Timestamp booking_start) {this.booking_start = booking_start;}
    public Timestamp getBookingEnd() {return booking_end;}
    public void setBookingEnd(Timestamp booking_end) {this.booking_end = booking_end;}
    public boolean getIsRenting() {return is_renting;}
    public void setIsRenting(boolean is_renting) {this.is_renting = is_renting;}
    
    
    @Override
    public String toString() {
        return "<ul>"
            + "<li>Room= " + chain_name + "</li>"
            + "<li>Room= " + hotel_name + "</li>"
            + "<li>Room= " + room_number + "</li>"
            + "<li>Room= " + account_number + "</li>"
            + "<li>Room= " + booking_start + "</li>"
            + "<li>Room= " + booking_end + "</li>"
            + "<li>Room= " + is_renting + "</li>";

    }
}
