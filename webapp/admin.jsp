<%@ page import="group10.Room,group10.RoomService,
                group10.HotelChain,group10.HotelChainService,
                java.util.List,java.util.ArrayList,
                group10.Message,
                group10.Hotel,group10.HotelService,
                group10.Employee,group10.EmployeeService,
                group10.Customer,group10.CustomerService" %>
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
    
    //Hotel chain stuff ---------------------------------------------------------------------------
    List<HotelChain> chains = null;
    HotelChainService chainServ = new HotelChainService();
    try {
        chains = chainServ.getHotelChains();

    } catch (Exception e) {
        e.printStackTrace();
    }
    if (chains==null) {chains = new ArrayList<HotelChain>();}

    //Hotel stuff ---------------------------------------------------------------------------
    List<Hotel> hotels = null;
    HotelService hotelServ = new HotelService();
    try {
        hotels = hotelServ.getHotels();

    } catch (Exception e) {
        e.printStackTrace();
    }
    if (hotels==null) {hotels = new ArrayList<Hotel>();}

    //Room stuff  ---------------------------------------------------------------------------
    List<Room> rooms = null;
    RoomService roomserv = new RoomService();
    try {
        rooms = roomserv.getRooms();
    } catch (Exception e) {
        e.printStackTrace();
    }
    if (rooms==null) {rooms = new ArrayList<Room>();}

    //employee stuff  ---------------------------------------------------------------------------
    List<Employee> employees = null;
    EmployeeService empserv = new EmployeeService();
    try {
        employees = empserv.getEmployees();

    } catch (Exception e) {
        e.printStackTrace();
    }
    if (employees==null) {employees = new ArrayList<Employee>();}

    //Customer stuff  ---------------------------------------------------------------------------
    List<Customer> customers = null;
    CustomerService cusServ = new CustomerService();
    try {
        customers = cusServ.getCustomers();

    } catch (Exception e) {
        e.printStackTrace();
    }
    if (customers==null) {customers = new ArrayList<Customer>();}
    
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
            <h3>Hotel tool</h3>

            <div class="col-md-4">
                <h4>Insert Hotels</h4>
                <form method="POST" action="hotel-controller.jsp">
                    <input type="hidden" value="INSERT" name="action"/>

                    Chain Name: 
                    <select name="chainName">
                    <% for (HotelChain chain : chains) { %>
                        <option value="<%= chain.getChainName() %>"><%= chain.getChainName() %></option>
                    <% } %>
                    </select><br>
                    Hotel Name: <input type="text" value="" name="hotelName" /><br>
                    Rating: <input type="number" min="1" max="5" value="" name="rating" /><br>
                    Address: <input type="text" value="" name="address" /><br>
                    Email: <input type="text" value="" name="email" /><br>
                    Manager ID: 
                    <input list="employees" type="text" value="" name="manager"/><br>
                    <datalist id="employees">
                        <% for (Employee emp : employees) { %>
                            <option><%= emp.getEmployeeId() %></option>
                        <% } %>
                    </datalist>
                    <input type="submit" value="Submit"/>
                </form>
            </div>
            <div class="col-md-4">
                <h4>Edit Hotels</h4>
                <form method="POST" action="hotel-controller.jsp">
                    <input type="hidden" value="EDIT" name="action"/>

                    Chain Name: 
                    <select name="chainName">
                    <% for (HotelChain chain : chains) { %>
                        <option value="<%= chain.getChainName() %>"><%= chain.getChainName() %></option>
                    <% } %>
                    </select><br>
                    Hotel Name: 
                    <select name="hotelName">
                    <% for (Hotel hotel: hotels) { %>
                        <option value="<%= hotel.getHotelName() %>"><%= hotel.getHotelName() %></option>
                    <% } %>
                    </select><br>
                    Rating: <input type="number" min="1" max="5"  value="" name="rating" /><br>
                    Address: <input type="text" value="" name="address" /><br>
                    Email: <input type="text" value="" name="email" /><br>
                    Manager ID: <input type="text" value="" name="manager" /><br>
                    <input type="submit" value="Submit"/>
                </form>
                
            </div>
            <div class="col-md-4">
                <h4>Delete Hotels</h4>
                <form method="POST" action="hotel-controller.jsp">
                    <input type="hidden" value="DELETE" name="action"/>

                    Chain Name: 
                    <select name="chainName">
                    <% for (HotelChain chain : chains) { %>
                        <option value="<%= chain.getChainName() %>"><%= chain.getChainName() %></option>
                    <% } %>
                    </select><br>
                    Hotel Name: 
                    <select name="hotelName">
                    <% for (Hotel hotel: hotels) { %>
                        <option value="<%= hotel.getHotelName() %>"><%= hotel.getHotelName() %></option>
                    <% } %>
                    </select><br>
                    <!--Just some worthless values inserted. These arent needed for deletion-->
                    <input type="hidden" value="1" name="rating" /><br>
                    <input type="hidden" value="a" name="address" /><br>
                    <input type="hidden" value="e" name="email" /><br>
                    <input type="hidden" value="1" name="manager" /><br>
                    
                    <input type="submit" value="Submit"/>
                </form>
            
            </div>
        </div>

        <div class="row p-2 my-4" style="background-color:AliceBlue;">
            <h3>Room tool</h3>

            <div class="col-md-4">
                <h4>Insert Room</h4>
                <form method="POST" action="room-controller.jsp">
                    <input type="hidden" value="INSERT" name="action"/>

                    Chain Name: 
                    <select name="chainName">
                    <% for (HotelChain chain : chains) { %>
                        <option value="<%= chain.getChainName() %>"><%= chain.getChainName() %></option>
                    <% } %>
                    </select><br>
                    Hotel Name: 
                    <select name="hotelName">
                    <% for (Hotel hotel: hotels) { %>
                        <option value="<%= hotel.getHotelName() %>"><%= hotel.getHotelName() %></option>
                    <% } %>
                    </select><br>
                    room_number: <input type="number" min="0" value="" name="room_number" /><br>
                    price: <input type="number" step="0.01" min="0" value="" name="price" /><br>
                    capacity: <input type="number" min="0" value="" name="capacity" /><br>
                    <input type="submit" value="Submit"/>
                </form>
            </div>
            <div class="col-md-4">
                <h4>Room Editor/Deleter</h4>
                <form method="POST" action="room.jsp">
                    Chain Name: 
                    <select name="chainName">
                    <% for (HotelChain chain : chains) { %>
                        <option value="<%= chain.getChainName() %>"><%= chain.getChainName() %></option>
                    <% } %>
                    </select><br>
                    Hotel Name: 
                    <select name="hotelName">
                    <% for (Hotel hotel: hotels) { %>
                        <option value="<%= hotel.getHotelName() %>"><%= hotel.getHotelName() %></option>
                    <% } %>
                    </select><br>
                    room_number: <input type="number" min="0" value="" name="room_number" /><br>
                    <input type="submit" value="Go to Editor Page"/>
                </form>
            </div>

        </div>

        <div class="row p-2 my-4" style="background-color:AliceBlue;">
            <h3>Employee tool</h3>

            <div class="col-md-4">
                <h4>Insert Employee</h4>
                <form method="POST" action="employee-controller.jsp">
                    <input type="hidden" value="INSERT" name="action"/>

                    <!--Just some worthless values inserted. The employee id cannot be set by admin-->
                    <input type="hidden" value="0" name="employee_id" /><br>

                    Employee Name: <input type="text" value="" name="employee_name" /><br>
                    Role: <input type="text" value="" name="role" /><br>
                    SSN/SIN: <input type="text" value="" name="sin" /><br>
                    Address: <input type="text" value="" name="address" /><br>
                    Chain Name: 
                    <select name="chainName">
                    <% for (HotelChain chain : chains) { %>
                        <option value="<%= chain.getChainName() %>"><%= chain.getChainName() %></option>
                    <% } %>
                    </select><br>
                    <input type="submit" value="Submit"/>
                </form>
            </div>
            <div class="col-md-4">
                <h4>Edit Employee</h4>
                <form method="POST" action="employee-controller.jsp">
                    <input type="hidden" value="EDIT" name="action"/>

                    Employee ID: 
                    <input list="employees" type="text" value="" name="employee_id"/><br>
                    <datalist id="employees">
                        <% for (Employee emp : employees) { %>
                            <option><%= emp.getEmployeeId() %></option>
                        <% } %>
                    </datalist>
                    Employee Name: <input type="text" value="" name="employee_name" /><br>
                    Role: <input type="text" value="" name="role" /><br>
                    SSN/SIN: <input type="text" value="" name="sin" /><br>
                    Address: <input type="text" value="" name="address" /><br>
                    Chain Name: 
                    <select name="chainName">
                    <% for (HotelChain chain : chains) { %>
                        <option value="<%= chain.getChainName() %>"><%= chain.getChainName() %></option>
                    <% } %>
                    </select><br>
                    <input type="submit" value="Submit"/>
                </form>
                
            </div>
            <div class="col-md-4">
                <h4>Delete Employee</h4>
                <form method="POST" action="employee-controller.jsp">
                    <input type="hidden" value="DELETE" name="action"/>

                    Employee ID: 
                    <input list="employees" type="text" value="" name="employee_id"/><br>
                    <datalist id="employees">
                        <% for (Employee emp : employees) { %>
                            <option><%= emp.getEmployeeId() %></option>
                        <% } %>
                    </datalist>
                    <!--Just some worthless values inserted. These arent needed for deletion-->
                    <input type="hidden" value="e" name="employee_name" /><br>
                    <input type="hidden" value="e" name="role" /><br>
                    <input type="hidden" value="1" name="sin" /><br>
                    <input type="hidden" value="e" name="address" /><br>
                    <input type="hidden" value="e" name="chain_name" /><br>
                    
                    <input type="submit" value="Submit"/>
                </form>
            
            </div>
        </div>

        <div class="row p-2 my-4" style="background-color:AliceBlue;">
            <h3>Customer tool</h3>

            <div class="col-md-4">
                <h4>Insert Customer</h4>
                <form method="POST" action="customer-controller.jsp">
                    <input type="hidden" value="INSERT" name="action"/>

                    <!--Just some worthless values inserted. The employee id cannot be set by admin-->
                    <input type="hidden" value="0" name="account_number" /><br>

                    Customer Name: <input type="text" value="" name="customer_name" /><br>
                    Address: <input type="text" value="" name="address" /><br>
                    ID: <input type="number" value="" name="id" /><br>
                    Date of Registration: <input type="date" value="" name="date_of_registration" /><br>
                    <input type="submit" value="Submit"/>
                </form>
            </div>
            <div class="col-md-4">
                <h4>Edit Customer</h4>
                <form method="POST" action="customer-controller.jsp">
                    <input type="hidden" value="EDIT" name="action"/>

                    Account Number: 
                    <input list="customers" type="text" value="" name="account_number"/><br>
                    <datalist id="customers">
                        <% for (Customer cus : customers) { %>
                            <option><%= cus.getAccountNumber() %></option>
                        <% } %>
                    </datalist>
                    Customer Name: <input type="text" value="" name="customer_name" /><br>
                    Address: <input type="text" value="" name="address" /><br>
                    ID: <input type="number" value="" name="id" /><br>
                    Date of Registration: <input type="date" value="" name="date_of_registration" /><br>
                    <input type="submit" value="Submit"/>
                </form>
                
            </div>
            <div class="col-md-4">
                <h4>Delete Customer</h4>
                <form method="POST" action="customer-controller.jsp">
                    <input type="hidden" value="DELETE" name="action"/>

                    Account Number: 
                    <input list="customers" type="text" value="" name="account_number"/><br>
                    <datalist id="customers">
                        <% for (Customer cus : customers) { %>
                            <option><%= cus.getAccountNumber() %></option>
                        <% } %>
                    </datalist>
                    <!--Just some worthless values inserted. These arent needed for deletion-->
                    <input type="hidden" value="e" name="customer_name" /><br>
                    <input type="hidden" value="e" name="address" /><br>
                    <input type="hidden" value="1" name="id" /><br>
                    <input type="hidden" value="2000-01-01" name="date_of_registration" /><br>
                    
                    <input type="submit" value="Submit"/>
                </form>
            
            </div>
        </div>
    </div>


</body>

</html>