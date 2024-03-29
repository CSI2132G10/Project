
<%@ page import="group10.BookingService,java.util.List,java.util.ArrayList,group10.Message,group10.Booking,java.sql.Timestamp" %>

<%
    BookingService bookingService = new BookingService();
    
    String action = String.valueOf(request.getParameter("action"));
    
    Message msg;

    String chainName = String.valueOf(request.getParameter("chain_name"));
    String hotelName = String.valueOf(request.getParameter("hotel_name"));
    int room_number = Integer.valueOf(request.getParameter("room_number"));
    int account_number = Integer.valueOf(request.getParameter("account_number"));
    boolean is_renting = Boolean.valueOf(request.getParameter("is_renting"));

    // The html datetime-local format does not match the java.sql.Timestamp format
    // Here I replace the "T" with a " ", and add the ":00" seconds if it does not already exist.
    String string_start = request.getParameter("booking_start").replace("T"," ");
    String string_end = request.getParameter("booking_end").replace("T"," ");
    if (string_start.length()-string_start.replace(":","").length() == 1) {
        string_start += ":00";
    }
    if (string_end.length()-string_end.replace(":","").length() == 1) {
        string_end += ":00";
    }
    Timestamp booking_start = Timestamp.valueOf(string_start);
    Timestamp booking_end = Timestamp.valueOf(string_end);

    int employee_id = Integer.valueOf(request.getParameter("employee_id"));
    

    if (action.equals("INSERT")) {
        try {
            String value = bookingService.createRenting(new Booking(chainName,hotelName,room_number,account_number,booking_start,booking_end,is_renting),employee_id);
            if (value.contains("Error") || value.contains("error")) msg = new Message("error", value);
            else msg = new Message("success", value);
        } catch (Exception e) {
            e.printStackTrace();
            msg = new Message("error", "Unknown exception: "+e.toString());
        }
    } else if (action.equals("EDIT")) {
        try {
            String value = bookingService.convertBookingToRenting(new Booking(chainName,hotelName,room_number,account_number,booking_start,booking_end,is_renting),employee_id);
            if (value.contains("Error") || value.contains("error")) msg = new Message("error", value);
            else msg = new Message("success", value);
        } catch (Exception e) {
            e.printStackTrace();
            msg = new Message("error", "Unknown exception: "+e.toString());
        }
    } else if (action.equals("DELETE")) {
        try {
            String value = bookingService.archiveBookingRenting(new Booking(chainName,hotelName,room_number,account_number,booking_start,booking_end,is_renting));
            if (value.contains("Error") || value.contains("error")) msg = new Message("error", value);
            else msg = new Message("success", value);
        } catch (Exception e) {
            e.printStackTrace();
            msg = new Message("error", "Unknown exception: "+e.toString());
        }
    } else {
        msg = new Message("error", "Unrecognized action in booking-controller.jsp");
    }

    // create an arraylist of messages and append the new message
    ArrayList<Message> messages = new ArrayList<>();
    messages.add(msg);
    // set session attribute named messages to messages value
    session.setAttribute("messages", messages);

    response.sendRedirect("employee.jsp");

%>