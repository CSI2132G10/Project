
<%@ page import="group10.CustomerService,java.util.List,java.util.ArrayList,group10.Message,group10.Customer,java.sql.Date" %>

<%
    CustomerService customerService = new CustomerService();
    
    String action = String.valueOf(request.getParameter("action"));
    
    Message msg;

    // NOTE: account_number will not be used for insertion. Users are not allowed to set it manually
    int account_number = Integer.valueOf(request.getParameter("account_number"));
    
    String customerName = String.valueOf(request.getParameter("customer_name"));
    int id = Integer.valueOf(request.getParameter("id"));
    String address = String.valueOf(request.getParameter("address"));
    Date date_of_registration = Date.valueOf(request.getParameter("date_of_registration"));    

    if (action.equals("INSERT")) {
        try {
            // NOTE: account_number will not be used for insertion. Users are not allowed to set it manually
            String value = customerService.createCustomer(new Customer(account_number,customerName,address,id,date_of_registration));
            if (value.contains("Error") || value.contains("error")) msg = new Message("error", value);
            else msg = new Message("success", value);
        } catch (Exception e) {
            e.printStackTrace();
            msg = new Message("error", "Unknown exception: "+e.toString());
        }
    } else if (action.equals("EDIT")) {
        try {
            String value = customerService.updateCustomer(new Customer(account_number,customerName,address,id,date_of_registration));
            if (value.contains("Error") || value.contains("error")) msg = new Message("error", value);
            else msg = new Message("success", value);
        } catch (Exception e) {
            e.printStackTrace();
            msg = new Message("error", "Unknown exception: "+e.toString());
        }
    } else if (action.equals("DELETE")) {
        try {
            String value = customerService.deleteCustomer(account_number);
            if (value.contains("Error") || value.contains("error")) msg = new Message("error", value);
            else msg = new Message("success", value);
        } catch (Exception e) {
            e.printStackTrace();
            msg = new Message("error", "Unknown exception: "+e.toString());
        }
    } else {
        msg = new Message("error", "Unrecognized action in customer-controller.jsp");
    }

    // create an arraylist of messages and append the new message
    ArrayList<Message> messages = new ArrayList<>();
    messages.add(msg);
    // set session attribute named messages to messages value
    session.setAttribute("messages", messages);

    response.sendRedirect("admin.jsp");

%>