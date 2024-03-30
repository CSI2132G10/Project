/**
 * ViewResult class to save ViewResult information
 */

 package group10;

public class ViewResult {

    private String chain_name;
    private String hotel_name;
    private int intResult;

    /**
     * Constructor to create ViewResult object 
     */
    public ViewResult(String chain_name, String hotel_name, int intResult) {
        this.chain_name = chain_name;
        this.hotel_name = hotel_name;
        this.intResult = intResult;
    }

    public String getChainName() {return chain_name;}
    public void setChainName(String chain_name) {this.chain_name = chain_name;}
    public String getHotelName() {return hotel_name;}
    public void setHotelName(String hotel_name) {this.hotel_name = hotel_name;}
    public int getIntResult() {return intResult;}
    public void setIntResult(int intResult) {this.intResult = intResult;}
    

    @Override
    public String toString() {
        return "<ul>"
            + "<li>HotelChain= " + chain_name + "</li>"
            + "<li>HotelChain= " + hotel_name + "</li>"
            + "<li>HotelChain= " + intResult + "</li>";
    }
}
