
<%@ page import="group10.Booking,group10.BookingService,
                group10.HotelChain,group10.HotelChainService,
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

    //Hotel chain stuff ---------------------------------------------------------------------------
    List<HotelChain> chains = null;
    HotelChainService chainServ = new HotelChainService();
    try {
        chains = chainServ.getHotelChains();

    } catch (Exception e) {
        e.printStackTrace();
    }
    if (chains==null) {chains = new ArrayList<HotelChain>();}

    
    
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title> Employee Dashboard </title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>

<body>

    <jsp:include page="navbar.jsp"/>

    <h2> Group 10 Employee Dashboard </h2>


    <% 
    for (Message m : messages) { 
        if (m.type.equals("error")) {
    %>
        <div class="alert alert-danger">
            <%=m.value.replaceAll("['\"]+", "")%>
        </div>
    <% } else { %>
        <div class="alert alert-success">
            <%=m.value.replaceAll("['\"]+", "")%>
        </div>
    <% } } %>

    <div class="container">
        
        <div class="row p-2 my-4" style="background-color:AliceBlue;">
           
            <div class="col-md-2">
                <h3>Create new Renting</h3>
            </div>
            <div class="col-md-8">
                <form method="POST" action="booking-controller.jsp">
                    <input type="hidden" value="INSERT" name="action"/>
                    
                    <input type="hidden" value="true" name="is_renting"/>
                    Chain Name: 
                    <select name="chain_name">
                    <% for (HotelChain chain : chains) { %>
                        <option value="<%= chain.getChainName() %>"><%= chain.getChainName() %></option>
                    <% } %>
                    </select><br>
                    Hotel Name:<input type="text" value="" name="hotel_name"/><br>
                    Room Number:<input type="number" value="" name="room_number"/><br>
                    Booking Start Date:<input type="datetime-local" value="" name="booking_start"/><br>
                    Booking End Date:<input type="datetime-local" value="" name="booking_end"/><br>
                    Customer Account Number:<input type="number" value="" name="account_number"/><br>
                    Your Employee ID Number:<input type="number" value="" name="employee_id"/><br>
                    
                    <input type="submit" value="Insert New Renting"/>
                </form>
            </div>
        </div>

        <div class="row p-2 my-4" style="background-color:AliceBlue;">
           
            <ul class="list-group">
                
                <% for (Booking book : bookings) { %>
                    <li class="list-group-item">
                    <div class="row" style="background-color:Beige;">
                        <div class="col-md-3">
                            <p class="m-0">Chain Name: <%= book.getChainName() %></p>
                            <p class="m-0">Hotel Name: <%= book.getHotelName() %></p>
                            <p class="m-0">Room Number: <%= book.getRoomNumber() %></p>
                        </div>
                        <div class="col-md-3">
                            <p class="m-0">Booking Start Date: <%= book.getBookingStart() %></p>
                            <p class="m-0">Booking End Date: <%= book.getBookingEnd() %></p>
                            <p class="m-0">Customer Account Number: <%= book.getAccountNumber() %></p>
                            <p class="m-0">Renting?: <%= book.getIsRenting() %></p>
                        </div>

                        <div class="col-md-4">
                            <% if (!book.getIsRenting()) { %>
                                <form method="POST" action="booking-controller.jsp">
                                    <input type="hidden" value="EDIT" name="action"/>
                                    
                                    <input type="hidden" value="<%= book.getChainName() %>" name="chain_name"/>
                                    <input type="hidden" value="<%= book.getHotelName() %>" name="hotel_name"/>
                                    <input type="hidden" value="<%= book.getRoomNumber() %>" name="room_number"/>
                                    <input type="hidden" value="<%= book.getBookingStart() %>" name="booking_start"/>
                                    <input type="hidden" value="<%= book.getBookingEnd() %>" name="booking_end"/>
                                    <input type="hidden" value="<%= book.getAccountNumber() %>" name="account_number"/>
                                    <input type="hidden" value="<%= book.getIsRenting() %>" name="is_renting"/>

                                    Your Employee ID Number:<input type="number" value="" name="employee_id"/>
                                    
                                    <input type="submit" value="Convert to Renting"/>
                                </form>
                            <% } %>
                            <form method="POST" action="booking-controller.jsp">
                                <input type="hidden" value="DELETE" name="action"/>
                                
                                <input type="hidden" value="<%= book.getChainName() %>" name="chain_name"/>
                                <input type="hidden" value="<%= book.getHotelName() %>" name="hotel_name"/>
                                <input type="hidden" value="<%= book.getRoomNumber() %>" name="room_number"/>
                                <input type="hidden" value="<%= book.getBookingStart() %>" name="booking_start"/>
                                <input type="hidden" value="<%= book.getBookingEnd() %>" name="booking_end"/>
                                <input type="hidden" value="<%= book.getAccountNumber() %>" name="account_number"/>
                                <input type="hidden" value="<%= book.getIsRenting() %>" name="is_renting"/>

                                Your Employee ID Number:<input type="number" value="" name="employee_id"/>
                                
                                <input type="submit" value="Archive/Delete Booking/Renting"/>
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