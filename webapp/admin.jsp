<%@ page import="group10.Room,group10.RoomService,group10.HotelChain,group10.HotelChainService,java.util.List" %>
<%
    List<HotelChain> chains = null;
    HotelChainService chainServ = new HotelChainService();
    try {
        chains = chainServ.getHotelChains();

    } catch (Exception e) {
        e.printStackTrace();
    }

    List<Room> rooms = null;
    RoomService roomserv = new RoomService();
    try {
        rooms = roomserv.getRooms();

    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title> Admin Dashboard </title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>

<body>

    <jsp:include page="navbar.jsp"/>

    <h2> Group 10 Admin Dashboard </h2>

    <tbody>
    <%
    for (HotelChain chain : chains) { %>
    <tr>
        <td><%= chain.getChainName() %></td>
    </tr>
    <% } %>
    </tbody>

    <tbody>
    <%
    for (Room room : rooms) { %>
    <tr>
        <td><%= room.getRoomNumber() %></td>
        <td><%= room.getHotelName() %></td>
        <td><%= room.getChainName() %></td>
        <form method="POST" action="delete-room-controller.jsp">
            <td>
                <input type="hidden" value="<%= room.getRoomNumber() %>" name="roomNumber" />
                <input type="hidden" value="<%= room.getHotelName() %>" name="hotelName" />
                <input type="hidden" value="<%= room.getChainName() %>" name="chainName" />
                <button style="all: unset; cursor: pointer;" type="submit"><i class="fa fa-trash"></i></button>
            </td>
        </form>
    </tr>
    <% } %>
    </tbody>

</body>

</html>