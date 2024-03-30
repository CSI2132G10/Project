<%@ page import="group10.RoomService,java.util.List,java.util.ArrayList,group10.Message,group10.Room,group10.HotelService,group10.Hotel" %>

<%
    //Status message code  ---------------------------------------------------------------------------
    ArrayList<Message> messages;

    //Room stuff  ---------------------------------------------------------------------------

    RoomService roomService = new RoomService();
    HotelService hotelService = new HotelService();
        
    Message msg;

    String chainName = String.valueOf(request.getParameter("chain_name"));
    String hotelName = String.valueOf(request.getParameter("hotel_name"));

    List<Hotel> hotels = null;
    List<Room> rooms = null;
    try {
        hotels = hotelService.findHotel(chainName,hotelName);
        rooms = roomService.getRooms();
        if (hotels.size()!=1) {
            msg = new Message("error", "Error: Hotel query count != 1. Hotel likely does not exist");
            // create an arraylist of messages and append the new message
            messages = new ArrayList<>();
            messages.add(msg);
            // set session attribute named messages to messages value
            session.setAttribute("messages", messages);
            response.sendRedirect("customer.jsp");
        }
    } catch (Exception e) {
        msg = new Message("error", "Unknown exception: "+e.toString());
        e.printStackTrace();
        // create an arraylist of messages and append the new message
        messages = new ArrayList<>();
        messages.add(msg);
        // set session attribute named messages to messages value
        session.setAttribute("messages", messages);
        response.sendRedirect("customer.jsp");
    }



    List<Room> relevantRooms = new ArrayList<Room>();
    for (Room room : rooms) {
        if (room.getHotelName().equals(hotelName) && room.getChainName().equals(chainName)) {
            relevantRooms.add(room);
        }
    }

    //Amenity and Additional stuff  ---------------------------------------------------------------------------
    List<List<String>> amenities = new ArrayList<List<String>>();
    List<List<String>> details = new ArrayList<List<String>>();
    try {
        for (Room room : relevantRooms) {
            amenities.add(roomService.findRoomAmenities(chainName,hotelName,room.getRoomNumber()));
            details.add(roomService.findRoomAdditional(chainName,hotelName,room.getRoomNumber()));
        }
    } catch (Exception e) {
        msg = new Message("error", "Unknown exception: "+e.toString());
        e.printStackTrace();
        // create an arraylist of messages and append the new message
        messages = new ArrayList<>();
        messages.add(msg);
        // set session attribute named messages to messages value
        session.setAttribute("messages", messages);
        response.sendRedirect("customer.jsp");
    }

%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title> Room Viewer </title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>

<body>
    
    <jsp:include page="navbar.jsp"/>

    <h2> Group 10 Room Manager </h2>

    <div class="row m-2" style="background-color:AliceBlue;">
        <h4>Hotel Details: </h4>
        <p>Chain Name: <%=hotels.get(0).getChainName()%></p>
        <p>Hotel Name: <%=hotels.get(0).getHotelName()%></p>
        <p>Rating: <%=hotels.get(0).getRating()%></p>
        <p>Address: <%=hotels.get(0).getAddress()%></p>
        <p>Email: <%=hotels.get(0).getEmail()%></p>
        <p>Number of Rooms: <%=hotels.get(0).getNumRooms()%></p>
    </div>

    
    <% for (int i=0;i<relevantRooms.size();i++) { %>
        <li class="list-group-item">
        <div class="row" style="background-color:Beige;">
            <div class="col-md-2">
                <p class="m-0">Room Number: <%= relevantRooms.get(i).getRoomNumber() %></p>
                <p class="m-0">Price: <%= relevantRooms.get(i).getPrice() %></p>
                <p class="m-0">Capacity: <%= relevantRooms.get(i).getCapacity() %></p>
            </div>
            <div class="col-md-2">
                <p>Room Amenities:</p>
                <% if (amenities.get(i)!=null) { %>
                    <% for (String amen : amenities.get(i)) { %>
                        <p><%=amen%></p>
                    <% } %>
                <% } %>
            </div>
            <div class="col-md-2">
                <p>Room Additional Features:</p>
                <% if (details.get(i)!=null) { %>
                    <% for (String det : details.get(i)) { %>
                        <p><%=det%></p>
                    <% } %>
                <% } %>
            </div>

            <div class="col-md-5">
                <form method="POST" action="booking-controller.jsp">
                    <input type="hidden" value="INSERTBOOKING" name="action"/>

                    <input type="hidden" value=<%= chainName %> name="chain_name"/>
                    <input type="hidden" value=<%= hotelName %> name="hotel_name"/>
                    <input type="hidden" value=<%= relevantRooms.get(i).getRoomNumber() %> name="room_number"/>

                    Booking Start Date:<input type="datetime-local" value="" name="booking_start"/><br>
                    Booking End Date:<input type="datetime-local" value="" name="booking_end"/><br>
                    Your Customer Account Number:<input type="number" value="" name="account_number"/><br>

                    <input type="hidden" value="false" name="is_renting"/>
                    
                    <input type="submit" value="Place Booking"/>
                </form>
            </div>
        </div>
        </li>

    <% } %>

</body>

</html>