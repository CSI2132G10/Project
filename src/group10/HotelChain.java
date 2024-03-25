/**
 * HotelChain class to save HotelChain information
 */

 package group10;

public class HotelChain {

    private String chain_name;
    private int num_hotels;

    /**
     * Constructor to create HotelChain object 
     *
     * @param chain_name name of the hotel chain
     * @param num_hotels number of hotels
     */
    public HotelChain(String chain_name, int num_hotels) {
        this.chain_name = chain_name;
        this.num_hotels = num_hotels;
    }

    /* Getters */
    public String getChainName() { return this.chain_name; }
    public int getNumHotels() { return this.num_hotels; }

    /* Setters */
    public void setChainName(String chain_name) { this.chain_name = chain_name; }
    public void setNumHotels(int num_hotels) { this.num_hotels = num_hotels; }

    @Override
    public String toString() {
        return "<ul>"
            + "<li>HotelChain= " + chain_name + "</li>"
            + "<li>HotelChain= " + num_hotels + "</li>";
    }
}
