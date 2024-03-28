
<%@ page import="group10.EmployeeService,java.util.List,java.util.ArrayList,group10.Message,group10.Employee" %>

<%
    EmployeeService employeeService = new EmployeeService();
    
    String action = String.valueOf(request.getParameter("action"));
    
    Message msg;

    // NOTE: employeeId will not be used for insertion. Users are not allowed to set it manually
    int employeeId = Integer.valueOf(request.getParameter("employee_id"));
    
    String employeeName = String.valueOf(request.getParameter("employee_name"));
    String role = String.valueOf(request.getParameter("role"));
    int sin = Integer.valueOf(request.getParameter("sin"));
    String address = String.valueOf(request.getParameter("address"));
    String chainName = String.valueOf(request.getParameter("chainName"));    

    if (action.equals("INSERT")) {
        try {
            // NOTE: employeeId will not be used for insertion. Users are not allowed to set it manually
            String value = employeeService.createEmployee(new Employee(employeeId,employeeName,role,sin,address,chainName));
            if (value.contains("Error") || value.contains("error")) msg = new Message("error", value);
            else msg = new Message("success", value);
        } catch (Exception e) {
            e.printStackTrace();
            msg = new Message("error", "Unknown exception: "+e.toString());
        }
    } else if (action.equals("EDIT")) {
        try {
            String value = employeeService.updateEmployee(new Employee(employeeId,employeeName,role,sin,address,chainName));
            if (value.contains("Error") || value.contains("error")) msg = new Message("error", value);
            else msg = new Message("success", value);
        } catch (Exception e) {
            e.printStackTrace();
            msg = new Message("error", "Unknown exception: "+e.toString());
        }
    } else if (action.equals("DELETE")) {
        try {
            String value = employeeService.deleteEmployee(employeeId);
            if (value.contains("Error") || value.contains("error")) msg = new Message("error", value);
            else msg = new Message("success", value);
        } catch (Exception e) {
            e.printStackTrace();
            msg = new Message("error", "Unknown exception: "+e.toString());
        }
    } else {
        msg = new Message("error", "Unrecognized action in employee-controller.jsp");
    }

    // create an arraylist of messages and append the new message
    ArrayList<Message> messages = new ArrayList<>();
    messages.add(msg);
    // set session attribute named messages to messages value
    session.setAttribute("messages", messages);

    response.sendRedirect("admin.jsp");

%>