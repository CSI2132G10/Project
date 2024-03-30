<%@ page import="group10.Booking,group10.BookingService,
                group10.HotelChain,group10.HotelChainService,
                java.util.List,java.util.ArrayList,
                group10.ViewResult,group10.ViewService,
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

    //View stuff ---------------------------------------------------------------------------
    List<ViewResult> capacities = null;
    List<ViewResult> remaining = null;
    ViewService viewServ = new ViewService();
    try {
        capacities = viewServ.getHotelCapacity();
        remaining = viewServ.getRemainingRooms();
    } catch (Exception e) {
        e.printStackTrace();
    }
    if (capacities==null) {capacities = new ArrayList<ViewResult>();}
    if (remaining==null) {remaining = new ArrayList<ViewResult>();}

%>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title> Customer Dashboard </title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>

<body>

    <jsp:include page="navbar.jsp"/>

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

    <h2> Group 10 Customer Dashboard </h2>

    <div class="row p-2 my-4" style="background-color:AliceBlue;">
        <div class="col-md-4">
            <h4>Already know what hotel you're looking for?</h4>
        </div>
        <div class="col-md-6">
            <form method="POST" action="hotel.jsp">
                Chain Name: 
                <select name="chain_name">
                <% for (HotelChain chain : chains) { %>
                    <option value="<%= chain.getChainName() %>"><%= chain.getChainName() %></option>
                <% } %>
                </select><br>
                Hotel Name: <input type="text" value="" name="hotel_name" /><br>
                
                <input type="submit" value="Find rooms"/>
            </form>
        </div>
    </div>

    <div id="accordion">
        <div class="card">
            <div class="card-header" id="headingOne">
            <h5 class="mb-0">
                <button class="btn btn-link collapsed" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                Remaining Rooms per Hotel (Database View, click to open)
                </button>
            </h5>
            </div>

            <div id="collapseOne" class="collapse" aria-labelledby="headingOne" data-bs-parent="#accordion">
                <div class="card-body">
                    <% for (ViewResult remain : remaining) { %>
                        <div class="row" style="">
                            <div class="col-md-2">
                                <p>Chain Name: <%= remain.getChainName() %></p>
                            </div>
                            <div class="col-md-2">
                                <p>Hotel Name:<%= remain.getHotelName() %></p>
                            </div>
                            <div class="col-md-3">
                                <p>Remaining Room Count: <%= remain.getIntResult() %></p>
                            </div>
                            <div class="col-md-2">
                                <form method="POST" action="hotel.jsp">
                                    <input type="hidden" value="<%= remain.getChainName() %>" name="chain_name" />
                                    <input type="hidden" value="<%= remain.getHotelName() %>" name="hotel_name" />
                                    <input type="submit" value="Find rooms"/>
                                </form>
                            </div>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
        <div class="card">
            <div class="card-header" id="headingTwo">
            <h5 class="mb-0">
                <button class="btn btn-link collapsed" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                Hotel Capacity (Database View, click to open)
                </button>
            </h5>
            </div>
            <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-bs-parent="#accordion">
                <div class="card-body">
                    <% for (ViewResult cap : capacities) { %>
                        <div class="row" style="">
                            <div class="col-md-2">
                                <p>Chain Name: <%= cap.getChainName() %></p>
                            </div>
                            <div class="col-md-2">
                                <p>Hotel Name:<%= cap.getHotelName() %></p>
                            </div>
                            <div class="col-md-3">
                                <p>Capacity: <%= cap.getIntResult() %></p>
                            </div>
                            <div class="col-md-2">
                                <form method="POST" action="hotel.jsp">
                                    <input type="hidden" value="<%= cap.getChainName() %>" name="chain_name" />
                                    <input type="hidden" value="<%= cap.getHotelName() %>" name="hotel_name" />
                                    <input type="submit" value="Find rooms"/>
                                </form>
                            </div>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
    
</body>

</html>