
<%@ page import="group10.HotelService,java.util.List,java.util.ArrayList,group10.Message,group10.Hotel" %>

<%
    HotelService hotelService = new HotelService();
    
    String action = String.valueOf(request.getParameter("action"));
    
    Message msg;

    String chainName = String.valueOf(request.getParameter("chainName"));
    String hotelName = String.valueOf(request.getParameter("hotelName"));
    int rating = Integer.valueOf(request.getParameter("rating"));
    String address = String.valueOf(request.getParameter("address"));
    String email = String.valueOf(request.getParameter("email"));
    int manager = Integer.valueOf(request.getParameter("manager"));
    


    if (action.equals("INSERT")) {
        try {
            String value = hotelService.createHotel(new Hotel(chainName,hotelName,rating,address,email,manager));
            if (value.contains("Error") || value.contains("error")) msg = new Message("error", value);
            else msg = new Message("success", value);
        } catch (Exception e) {
            e.printStackTrace();
            msg = new Message("error", "Unknown exception: "+e.toString());
        }
    } else if (action.equals("EDIT")) {
        try {
            String value = hotelService.updateHotel(new Hotel(chainName,hotelName,rating,address,email,manager));
            if (value.contains("Error") || value.contains("error")) msg = new Message("error", value);
            else msg = new Message("success", value);
        } catch (Exception e) {
            e.printStackTrace();
            msg = new Message("error", "Unknown exception: "+e.toString());
        }
    } else if (action.equals("DELETE")) {
        try {
            String value = hotelService.deleteHotel(chainName,hotelName);
            if (value.contains("Error") || value.contains("error")) msg = new Message("error", value);
            else msg = new Message("success", value);
        } catch (Exception e) {
            e.printStackTrace();
            msg = new Message("error", "Unknown exception: "+e.toString());
        }
    } else {
        msg = new Message("error", "Unrecognized action in hotel-controller.jsp");
    }

    // create an arraylist of messages and append the new message
    ArrayList<Message> messages = new ArrayList<>();
    messages.add(msg);
    // set session attribute named messages to messages value
    session.setAttribute("messages", messages);

    response.sendRedirect("admin.jsp");

%>