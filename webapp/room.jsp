<%@ page import="group10.RoomService,java.util.List,java.util.ArrayList,group10.Message,group10.Room" %>

<%
    //Status message code  ---------------------------------------------------------------------------
    ArrayList<Message> messages;

    //Room stuff  ---------------------------------------------------------------------------

    RoomService roomService = new RoomService();
    
    String action = String.valueOf(request.getParameter("action"));
    
    Message msg;

    String chainName = String.valueOf(request.getParameter("chainName"));
    String hotelName = String.valueOf(request.getParameter("hotelName"));
    int room_number = Integer.valueOf(request.getParameter("room_number"));

    List<Room> rooms = null;
    RoomService roomserv = new RoomService();
    try {
        rooms = roomserv.findRoom(chainName, hotelName, room_number);
        if (rooms.size()!=1) {
            msg = new Message("error", "Error: Room query count != 1. Room likely does not exist");
            // create an arraylist of messages and append the new message
            messages = new ArrayList<>();
            messages.add(msg);
            // set session attribute named messages to messages value
            session.setAttribute("messages", messages);
            response.sendRedirect("admin.jsp");
        }

    } catch (Exception e) {
        msg = new Message("error", "Unknown exception: "+e.toString());
        e.printStackTrace();
        // create an arraylist of messages and append the new message
        messages = new ArrayList<>();
        messages.add(msg);
        // set session attribute named messages to messages value
        session.setAttribute("messages", messages);
        response.sendRedirect("admin.jsp");
    }

    //Amenity stuff  ---------------------------------------------------------------------------
    List<String> amenities = null;
    try {
        amenities = roomService.findRoomAmenities(chainName,hotelName,room_number);
    } catch (Exception e) {
        msg = new Message("error", "Unknown exception: "+e.toString());
        e.printStackTrace();
        // create an arraylist of messages and append the new message
        messages = new ArrayList<>();
        messages.add(msg);
        // set session attribute named messages to messages value
        session.setAttribute("messages", messages);
        response.sendRedirect("admin.jsp");
    }

    //Additional detail stuff  ---------------------------------------------------------------------------
    List<String> details = null;
    try {
        details = roomService.findRoomAdditional(chainName,hotelName,room_number);
    } catch (Exception e) {
        msg = new Message("error", "Unknown exception: "+e.toString());
        e.printStackTrace();
        // create an arraylist of messages and append the new message
        messages = new ArrayList<>();
        messages.add(msg);
        // set session attribute named messages to messages value
        session.setAttribute("messages", messages);
        response.sendRedirect("admin.jsp");
    }

%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title> Room Manager </title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>

<body>
    
    <jsp:include page="navbar.jsp"/>

    <h2> Group 10 Room Manager </h2>
    
    <% for (Room r : rooms) { %>
        <div class="row p-2 my-4" style="background-color:AliceBlue;">
            <h2>Room Editor/Deleter</h2>
            <div class="col-md-4">
                <h4>Chain Name: <%= r.getChainName() %></h4>
                <h4>Hotel Name: <%= r.getHotelName() %></h4>
                <h4>Room Number: <%= r.getRoomNumber() %></h4>
                <form method="POST" action="room-controller.jsp">
                    <input type="hidden" value="EDIT" name="action"/>
                    <input type="hidden" value=<%= r.getChainName() %> name="chainName"/>
                    <input type="hidden" value=<%= r.getHotelName() %> name="hotelName"/>
                    <input type="hidden" value=<%= r.getRoomNumber() %> name="room_number"/>

                    price: <input type="number" min="0" value="" name="price" /><br>
                    capacity: <input type="number" min="0" value="" name="capacity" /><br>
                    <input type="submit" value="Update Listing"/>
                </form>
                <form method="POST" action="room-controller.jsp">
                    <input type="hidden" value="DELETE" name="action"/>
                    <input type="hidden" value=<%= r.getChainName() %> name="chainName"/>
                    <input type="hidden" value=<%= r.getHotelName() %> name="hotelName"/>
                    <input type="hidden" value=<%= r.getRoomNumber() %> name="room_number"/>
                    <!-- Trash values. Not needed for deletion -->
                    <input type="hidden" value="0" name="price"/>
                    <input type="hidden" value="0" name="capacity"/>
                    <input type="submit" value="Delete Room"/>
                </form>

            </div>
            <div class="col-md-4">
                <h2>Room Amenity Add/Remove</h2>
                <h4>Add new Amenity: </h4>
                <form method="POST" action="room-controller.jsp">
                    <input type="hidden" value="INSERTAMENITY" name="action"/>
                    <input type="hidden" value=<%= r.getChainName() %> name="chainName"/>
                    <input type="hidden" value=<%= r.getHotelName() %> name="hotelName"/>
                    <input type="hidden" value=<%= r.getRoomNumber() %> name="room_number"/>
                    <input type="text" value="" name="amenity"/>
                    <input type="submit" value="Add amenity"/>
                </form>

                <h4>Current Amenities: </h4>
                <% for (String amen : amenities) { %>
                    <h5><%=amen%></h5>
                    <form method="POST" action="room-controller.jsp">
                        <input type="hidden" value="DELETEAMENITY" name="action"/>
                        <input type="hidden" value=<%= r.getChainName() %> name="chainName"/>
                        <input type="hidden" value=<%= r.getHotelName() %> name="hotelName"/>
                        <input type="hidden" value=<%= r.getRoomNumber() %> name="room_number"/>
                        <input type="hidden" value=<%= amen %> name="amenity"/>
                        <button style="all: unset; cursor: pointer;" type="submit"><i class="fa fa-trash"></i></button>
                    </form>
                <% } %>

            </div>
            <div class="col-md-4">
                <h2>Room Additional Details Add/Remove</h2>
                <h4>Add new Detail: </h4>
                <form method="POST" action="room-controller.jsp">
                    <input type="hidden" value="INSERTDETAIL" name="action"/>
                    <input type="hidden" value=<%= r.getChainName() %> name="chainName"/>
                    <input type="hidden" value=<%= r.getHotelName() %> name="hotelName"/>
                    <input type="hidden" value=<%= r.getRoomNumber() %> name="room_number"/>
                    <input type="text" value="" name="detail"/>
                    <input type="submit" value="Add Additional Detail"/>
                </form>

                <h4>Current Additional Details: </h4>
                <% for (String det : details) { %>
                    <h5><%=det%></h5>
                    <form method="POST" action="room-controller.jsp">
                        <input type="hidden" value="DELETEDETAIL" name="action"/>
                        <input type="hidden" value=<%= r.getChainName() %> name="chainName"/>
                        <input type="hidden" value=<%= r.getHotelName() %> name="hotelName"/>
                        <input type="hidden" value=<%= r.getRoomNumber() %> name="room_number"/>
                        <input type="hidden" value=<%= det %> name="detail"/>
                        <button style="all: unset; cursor: pointer;" type="submit"><i class="fa fa-trash"></i></button>
                    </form>
                <% } %>

            </div>
            
        </div>
    <% } %>

</body>

</html>