package app.classes;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Order {
    private Connection connection;

    public Order(Connection connection) {
        this.connection = connection;
    }

    // Method to add an order
    public int addOrder(int userId, double totalAmount, String status, String shippingAddress) throws SQLException {
        String query = "INSERT INTO orders (user_id, total_amount, status, shipping_address) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, userId);
            stmt.setDouble(2, totalAmount);
            stmt.setString(3, status);
            stmt.setString(4, shippingAddress);
            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);  // Return the order_id of the newly inserted order
                } else {
                    throw new SQLException("Creating order failed, no ID obtained.");
                }
            }
        }
    }

    // Method to get an order by ID
    public ResultSet getOrderById(int orderId) throws SQLException {
        String query = "SELECT * FROM orders WHERE order_id = ?";
        PreparedStatement stmt = connection.prepareStatement(query);
        stmt.setInt(1, orderId);
        return stmt.executeQuery();
    }

    // Method to get all orders
    public ResultSet getAllOrders() throws SQLException {
        String query = "SELECT * FROM orders";
        PreparedStatement stmt = connection.prepareStatement(query);
        return stmt.executeQuery();
    }

    // Method to delete an order
    public boolean deleteOrder(int orderId) throws SQLException {
        String query = "DELETE FROM orders WHERE order_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, orderId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Method to change order status
    public boolean changeOrderStatus(int orderId, String newStatus) throws SQLException {
        String query = "UPDATE orders SET status = ? WHERE order_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, newStatus);
            stmt.setInt(2, orderId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Method to get ordered books details by order ID
    public ResultSet getOrderedBooksByOrderId(int orderId) throws SQLException {
        String query = "SELECT oi.order_item_id, b.book_name, b.author_name, oi.quantity, oi.price " +
                       "FROM order_items oi " +
                       "JOIN books b ON oi.book_id = b.book_id " +
                       "WHERE oi.order_id = ?";
        PreparedStatement stmt = connection.prepareStatement(query);
        stmt.setInt(1, orderId);
        return stmt.executeQuery();
    }

    // Method to get the total number of orders
    public int getTotalNumberOfOrders() throws SQLException {
        String query = "SELECT COUNT(*) FROM orders";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        }
    }

    // Method to get the number of pending orders
    public int getNumberOfPendingOrders() throws SQLException {
        String query = "SELECT COUNT(*) FROM orders WHERE status = 'Pending'";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        }
    }

    // Method to get the number of completed orders
    public int getNumberOfCompletedOrders() throws SQLException {
        String query = "SELECT COUNT(*) FROM orders WHERE status = 'Completed'";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        }
    }

    // Close connection method (optional)
    public void closeConnection() throws SQLException {
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
    }
}