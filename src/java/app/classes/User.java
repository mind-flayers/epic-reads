package app.classes;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class User {

    private int id;
    private String firstname;
    private String lastname;
    private String email;
    private String password;
    private String role;

    public User() {}

    public User(String email, String password) {
        this.email = email;
        this.password = MD5.getMd5(password);
    }

    public User(String firstname, String lastname, String email, String password) {
        this.firstname = firstname;
        this.lastname = lastname;
        this.email = email;
        this.password = MD5.getMd5(password);
    }

    public User(String firstname, String lastname, String email, String password, String role) {
        this.firstname = firstname;
        this.lastname = lastname;
        this.email = email;
        this.password = MD5.getMd5(password);
        this.role = role;
    }

    public int getId() {
        return id;
    }

    public String getFirstname() {
        return firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public void setUsername(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = MD5.getMd5(password);
    }

    public String getUsername() {
        return email;
    }

    public String getPassword() {
        return MD5.getMd5(password);
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
    
     public boolean register(Connection con) {
        try {
            String query = "INSERT INTO users(firstname,lastname,email,password) VALUES(?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, this.firstname);
            pstmt.setString(2, this.lastname);
            pstmt.setString(3, this.email);
            pstmt.setString(4, this.password);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    public boolean authentication(Connection con) {
        try {
            String query = "SELECT id,password FROM users WHERE email = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, this.email);
            ResultSet rs = pstmt.executeQuery();
            
            if(rs.next()) {
                String db_password = rs.getString("password");
                if(db_password.equals(this.password)) {
                    int user_id = rs.getInt("id");
                    this.setId(user_id);
                    return true;
                }else {
                    return false;
                }
            }else {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public User getUserById(Connection con) {
        try {
            String query = "SELECT * FROM users WHERE id = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, this.id); 
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                this.setId(rs.getInt("id"));
                this.setFirstname(rs.getString("firstname"));
                this.setLastname(rs.getString("lastname"));
                this.setUsername(rs.getString("email"));
                this.setPassword(rs.getString("password"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
        }
        return this;
    }


    
    public boolean updateUser(Connection con) {
        try {
            String query = "UPDATE users SET firstname = ?, lastname = ?, email = ? WHERE id = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, this.firstname);
            pstmt.setString(2, this.lastname);
            pstmt.setString(3, this.email);
            pstmt.setInt(4, this.id); // Corrected index from 5 to 4

            return pstmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public boolean updatePassword(Connection con) {
        try {
            String query = "UPDATE users SET password = ? WHERE id = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, this.password); // Correct index for password
            pstmt.setInt(2, this.id); // Correct index for user ID
    
            return pstmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    public String getRole() {
        return role;
    }
    
    
    public String getRole(Connection connection, int userID) {
        String sql = "SELECT role FROM users WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userID);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    role = resultSet.getString("role");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return role;
    }

}