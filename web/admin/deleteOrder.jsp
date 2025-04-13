<%@ page import="java.sql.*, app.classes.Order, app.classes.DbConnector" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Order</title>
</head>
<body>
    <% 
        Connection connection = null;
        Order orderManager = null;
        int orderId = Integer.parseInt(request.getParameter("order_id"));

        try {
            connection = DbConnector.getConnection();
            orderManager = new Order(connection);

            // Perform the deletion
            boolean deleted = orderManager.deleteOrder(orderId);

            if (deleted) {
                response.sendRedirect("orders.jsp"); // Redirect back to orders list
            } else {
                out.println("Error deleting order.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</body>
</html>
