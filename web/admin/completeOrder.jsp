<%@ page import="app.classes.Order, app.classes.DbConnector" %>
<%@ page import="java.sql.Connection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Completion</title>
</head>
<body>

<%
    Connection connection = null;
    try {
        // Get the order ID from the form submission
        int orderId = Integer.parseInt(request.getParameter("order_id"));

        // Initialize the DbConnector class and get the connection
        DbConnector dbConnector = new DbConnector();
        connection = dbConnector.getConnection();

        // Initialize the Order class and update the status to "Completed"
        Order order = new Order(connection);
        boolean success = order.changeOrderStatus(orderId, "Completed");

        if (success) {
            out.println("<p>Order marked as completed successfully.</p>");
        } else {
            out.println("<p>Failed to mark the order as completed.</p>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (connection != null) connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<a href="orders.jsp">Back to Orders</a>

</body>
</html>
