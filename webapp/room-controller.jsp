
<%@ page import="group10.RoomService,java.util.List,java.util.ArrayList,group10.Message,group10.Room" %>

<%
    
    RoomService roomService = new RoomService();
    
    String action = String.valueOf(request.getParameter("action"));
    
    Message msg;

    String chainName = String.valueOf(request.getParameter("chainName"));
    String hotelName = String.valueOf(request.getParameter("hotelName"));
    int room_number = Integer.valueOf(request.getParameter("room_number"));
    float price;
    int capacity;
    String amenity;
    String detail;

    if (action.equals("INSERTAMENITY") || action.equals("DELETEAMENITY")) {
        amenity = String.valueOf(request.getParameter("amenity"));
        // Filling with trash to avoid error
        price = 0;
        capacity = 0;
        detail = "";
    } else if (action.equals("INSERTDETAIL") || action.equals("DELETEDETAIL")) {
        detail = String.valueOf(request.getParameter("detail"));
        // Filling with trash to avoid error
        price = 0;
        capacity = 0;
        amenity = "";
    } else {
        price = Float.valueOf(request.getParameter("price"));
        capacity = Integer.valueOf(request.getParameter("capacity"));
        // Filling with trash to avoid error
        amenity = "";
        detail = "";
    }


    if (action.equals("INSERT")) {
        try {
            String value = roomService.createRoom(new Room(chainName,hotelName,room_number,price,capacity));
            if (value.contains("Error") || value.contains("error")) msg = new Message("error", value);
            else msg = new Message("success", value);
        } catch (Exception e) {
            e.printStackTrace();
            msg = new Message("error", "Unknown exception: "+e.toString());
        }
    } else if (action.equals("EDIT")) {
        try {
            String value = roomService.updateRoom(new Room(chainName,hotelName,room_number,price,capacity));
            if (value.contains("Error") || value.contains("error")) msg = new Message("error", value);
            else msg = new Message("success", value);
        } catch (Exception e) {
            e.printStackTrace();
            msg = new Message("error", "Unknown exception: "+e.toString());
        }
    } else if (action.equals("DELETE")) {
        try {
            String value = roomService.deleteRoom(chainName,hotelName,room_number);
            if (value.contains("Error") || value.contains("error")) msg = new Message("error", value);
            else msg = new Message("success", value);
        } catch (Exception e) {
            e.printStackTrace();
            msg = new Message("error", "Unknown exception: "+e.toString());
        }
    } else if (action.equals("INSERTAMENITY")) {
        try {
            String value = roomService.createRoomAmenity(chainName,hotelName,room_number,amenity);
            if (value.contains("Error") || value.contains("error")) msg = new Message("error", value);
            else msg = new Message("success", value);
        } catch (Exception e) {
            e.printStackTrace();
            msg = new Message("error", "Unknown exception: "+e.toString());
        }
    } else if (action.equals("DELETEAMENITY")) {
        try {
            String value = roomService.deleteRoomAmenity(chainName,hotelName,room_number,amenity);
            if (value.contains("Error") || value.contains("error")) msg = new Message("error", value);
            else msg = new Message("success", value);
        } catch (Exception e) {
            e.printStackTrace();
            msg = new Message("error", "Unknown exception: "+e.toString());
        }
    } else if (action.equals("INSERTDETAIL")) {
        try {
            String value = roomService.createRoomAdditional(chainName,hotelName,room_number,detail);
            if (value.contains("Error") || value.contains("error")) msg = new Message("error", value);
            else msg = new Message("success", value);
        } catch (Exception e) {
            e.printStackTrace();
            msg = new Message("error", "Unknown exception: "+e.toString());
        }
    } else if (action.equals("DELETEDETAIL")) {
        try {
            String value = roomService.deleteRoomAdditional(chainName,hotelName,room_number,detail);
            if (value.contains("Error") || value.contains("error")) msg = new Message("error", value);
            else msg = new Message("success", value);
        } catch (Exception e) {
            e.printStackTrace();
            msg = new Message("error", "Unknown exception: "+e.toString());
        }
    }
    else {
        msg = new Message("error", "Unrecognized action in hotel-controller.jsp");
    }

    // create an arraylist of messages and append the new message
    ArrayList<Message> messages = new ArrayList<>();
    messages.add(msg);
    // set session attribute named messages to messages value
    session.setAttribute("messages", messages);

    response.sendRedirect("admin.jsp");

%>