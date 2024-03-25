
<%@ page import="group10.RoomService,java.util.List" %>

<%
    // get the id that was sent
    Integer roomNum = Integer.valueOf(request.getParameter("roomNumber"));
    String hotelName = String.valueOf(request.getParameter("hotelName"));
    String chainName = String.valueOf(request.getParameter("chainName"));

    // try to delete a grade
    try {
        RoomService roomService = new RoomService();
        // save the message returned from trying to delete a grade
        String value = roomService.deleteRoom(chainName,hotelName,roomNum);
    } catch (Exception e) {
        e.printStackTrace();
    }

    // redirect to grades
    response.sendRedirect("index.jsp");
%>