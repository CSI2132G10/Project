package group10;

/**
 * Employee class to save Employee information
 */
public class Employee {

    private int employee_id;
    private String employee_name;
    private String role;
    private int sin;
    private String address;
    private String chain_name;


    public Employee(int employee_id, String employee_name, String role, int sin, String address, String chain_name) {
        this.chain_name = chain_name;
        this.employee_id = employee_id;
        this.employee_name = employee_name;
        this.role = role;
        this.sin = sin;
        this.address = address;
    }

    public String getChainName() {return chain_name;}
    public void setChainName(String chain_name) {this.chain_name = chain_name;}
    public int getEmployeeId() {return employee_id;}
    public String getEmployeeName() {return employee_name;}
    public String getRole() {return role;}
    public int getSin() {return sin;}
    public String getAddress() {return address;}
    public void setEmployeeId(int employee_id) {this.employee_id = employee_id;}
    public void setEmployeeName(String employee_name) {this.employee_name = employee_name;}
    public void setRole(String role) {this.role = role;}
    public void setSin(int sin) {this.sin = sin;}
    public void setAddress(String address) {this.address = address;}


    @Override
    public String toString() {
        return "<ul>"
            + "<li>Room= " + employee_id + "</li>"
            + "<li>Room= " + employee_name + "</li>"
            + "<li>Room= " + role + "</li>"
            + "<li>Room= " + sin + "</li>"
            + "<li>Room= " + address + "</li>"
            + "<li>Room= " + chain_name + "</li>";
    }
}
