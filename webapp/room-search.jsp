
<%@ page import="group10.Booking,group10.BookingService,
                group10.Room,group10.RoomService,
                java.util.List,java.util.ArrayList,
                group10.Message" %>
<%
    //Status message code  ---------------------------------------------------------------------------
    ArrayList<Message> messages;

    // get any incoming messages from session attribute named messages
    // if nothing exists then messages is an empty arraylist
    if ((ArrayList<Message>) session.getAttribute("messages") == null) messages = new ArrayList<>();
        // else get that value
    else messages = (ArrayList<Message>) session.getAttribute("messages");

    String msgField = "";

    // create the object in the form of a stringified json
    for (Message m : messages) {
        msgField += "{\"type\":\"" + m.type + "\",\"value\":\"" + m.value.replaceAll("['\"]+", "") + "\"},";
    }

    // empty session messages
    session.setAttribute("messages", new ArrayList<Message>());
    
    //Booking stuff ---------------------------------------------------------------------------
    List<Booking> bookings = null;
    BookingService bookingServ = new BookingService();
    try {
        bookings = bookingServ.getBookingRenting();

    } catch (Exception e) {
        e.printStackTrace();
    }
    if (bookings==null) {bookings = new ArrayList<Booking>();}

    //Room search stuff ---------------------------------------------------------------------------

    String chain_name = String.valueOf(request.getParameter("chain_name"));
    int rating = -1;
    int num_rooms = -1;
    float price = -1;
    int capacity = -1;
    if (!request.getParameter("rating").equals("")) {
        rating = Integer.valueOf(request.getParameter("rating"));
    }
    if (!request.getParameter("num_rooms").equals("")) {
        num_rooms = Integer.valueOf(request.getParameter("num_rooms"));
    }
    if (!request.getParameter("price").equals("")) {
        price = Float.valueOf(request.getParameter("price"));
    }
    if (!request.getParameter("capacity").equals("")) {
        capacity = Integer.valueOf(request.getParameter("capacity"));
    }
    
    List<Room> rooms = null;
    RoomService roomServ = new RoomService();
    try {
        rooms = roomServ.complexRoomSearch(chain_name,rating,num_rooms,price,capacity);
    } catch (Exception e) {
        e.printStackTrace();
    }
    if (rooms==null) {rooms = new ArrayList<Room>();}
    
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title> Room Search </title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>

<body>

    <jsp:include page="navbar.jsp"/>

    <h2> Group 10 Room Search </h2>

    <div class="row m-2" style="background-color:AliceBlue;">
        <h4>Search Details: </h4>
        <p>Chain Name: <%=chain_name%></p>
        <p>Hotel Rating: <%=rating%></p>
        <p>Number of Rooms: <%=num_rooms%></p>
        <p>Maximum Price: <%=price%></p>
        <p>Capacity: <%=capacity%></p>
    </div>

    <div class="container">

        <div class="row p-2 my-4" style="background-color:AliceBlue;">
            <h4>Search Results:</h4>
           
            <ul class="list-group">
                
                <% for (Room room : rooms) { %>
                    <li class="list-group-item">
                    <div class="row" style="background-color:Beige;">
                        <div class="col-md-3">
                            <p class="m-0">Chain Name: <%= room.getChainName() %></p>
                            <p class="m-0">Hotel Name: <%= room.getHotelName() %></p>
                            <p class="m-0">Room Number: <%= room.getRoomNumber() %></p>
                        </div>
                        <div class="col-md-3">
                            <p class="m-0">Price: <%= room.getPrice() %></p>
                            <p class="m-0">Capacity: <%= room.getCapacity() %></p>
                        </div>

                        <div class="col-md-4">
                            <form method="POST" action="booking-controller.jsp">
                                <input type="hidden" value="INSERTBOOKING" name="action"/>
                                
                                <input type="hidden" value="<%= room.getChainName() %>" name="chain_name"/>
                                <input type="hidden" value="<%= room.getHotelName() %>" name="hotel_name"/>
                                <input type="hidden" value="<%= room.getRoomNumber() %>" name="room_number"/>
                                <input type="hidden" value="false" name="is_renting"/>

                                Booking Start Date:<input type="datetime-local" value="" name="booking_start"/><br>
                                Booking End Date:<input type="datetime-local" value="" name="booking_end"/><br>
                                Your Customer Account Number:<input type="number" value="" name="account_number"/><br>
                                
                                <input type="submit" value="Place Booking"/>
                            </form>
                        </div>
                    </div>
                    </li>

                <% } %>
                
            </ul>

        </div>

    </div>


</body>

</html>