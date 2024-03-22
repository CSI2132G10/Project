import java.sql.*;
import java.util.List;




// THIS IS FOR TESTING PURPOSES ONLY. DELETE AND EDIT AS YOU SEE FIT
public class Main {

    public static void main(String[] args)
    {
        //connectionTest("hotel");
        //serviceTest();
    }

    public static void connectionTest(String tableName)
    {
        try {
            Connection db = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres"
                    , "postgres", "admin");
            Statement st = db.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM "+tableName);
            ResultSetMetaData rsm = rs.getMetaData();
            int columnCount = rsm.getColumnCount();

            for (int i = 1; i <= columnCount; i++) {
                System.out.print(rsm.getColumnName(i));
                System.out.print("\t");
            }
            System.out.println();
            while (rs.next())
            {
                for (int i = 1; i <= columnCount; i++) {
                    System.out.print(rs.getString(i));
                    System.out.print("\t");
                }
                System.out.println();
            }
            rs.close();
            st.close();
        }
        catch(SQLException exception) {
            System.out.println("An exception was thrown:"+exception.getMessage());
        }
    }

    public static void serviceTest()
    {
        HotelChainService testService1 = new HotelChainService();
        List<HotelChain> toBePrinted;
        try{
            toBePrinted = testService1.getHotelChains();
            for (int i=0;i<toBePrinted.size();i++) {
                System.out.println(toBePrinted.get(i));
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
    
}
