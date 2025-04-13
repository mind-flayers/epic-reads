package app.classes;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DbConnector {
    
    private static final String DRIVER = "com.mysql.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3308/epic_reads";
    private static final String DBUSER = "root";
    private static final String DBPW = "";
    
    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName(DRIVER);
            con = DriverManager.getConnection(URL,DBUSER,DBPW);
            
            return con;
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DbConnector.class.getName()).log(Level.SEVERE, null, ex);
        }
        return con;
    }
    
}
