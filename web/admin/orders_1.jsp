<%@ page import="java.sql.*, app.classes.Order, app.classes.DbConnector" %>
<!DOCTYPE html>
<html>
<head>
    <title>Orders</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        body {
            background-color: #f8f9fa; /* Light gray background color */
        }
        .page-header {
            background-color: #22b09b; /* Bootstrap primary color */
            color: white;
            padding: 20px;
            border-radius: 5px;
        }
        .table th, .table td {
            text-align: center;
        }
        .btn-success {
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="page-header">
            <h1 class="text-center">Orders List</h1>
        </div>
        <table class="table table-striped table-bordered mt-4">
            <thead class="thead-dark">
                <tr>
                    <th>Order ID</th>
                    <th>User ID</th>
                    <th>Order Date</th>
                    <th>Total Amount</th>
                    <th>Status</th>
                    <th>Shipping Address</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    Connection connection = null;
                    Order orderManager = null;
                    ResultSet rs = null;
                    try {
                        connection = DbConnector.getConnection();
                        orderManager = new Order(connection);

                        // Handle mark as completed request
                        if (request.getParameter("action") != null && "complete".equals(request.getParameter("action"))) {
                            int orderIdToComplete = Integer.parseInt(request.getParameter("order_id"));
                            boolean updated = orderManager.changeOrderStatus(orderIdToComplete, "Completed");
                            if (updated) {
                                response.sendRedirect("orders.jsp");
                                return;
                            } else {
                                out.println("<div class='alert alert-danger'>Error updating order status.</div>");
                            }
                        }

                        // Handle delete request
                        if (request.getParameter("delete") != null) {
                            int orderIdToDelete = Integer.parseInt(request.getParameter("order_id"));
                            boolean deleted = orderManager.deleteOrder(orderIdToDelete);
                            if (deleted) {
                                response.sendRedirect("orders.jsp");
                                return;
                            } else {
                                out.println("<div class='alert alert-danger'>Error deleting order.</div>");
                            }
                        }

                        // Fetch all orders
                        rs = orderManager.getAllOrders();
                        while (rs.next()) {
                            int orderId = rs.getInt("order_id");
                            int userId = rs.getInt("user_id");
                            Timestamp orderDate = rs.getTimestamp("order_date");
                            double totalAmount = rs.getDouble("total_amount");
                            String status = rs.getString("status");
                            String shippingAddress = rs.getString("shipping_address");
                %>
                <tr>
                    <td><%= orderId %></td>
                    <td><%= userId %></td>
                    <td><%= orderDate %></td>
                    <td><%= totalAmount %></td>
                    <td><%= status %></td>
                    <td><%= shippingAddress %></td>
                    <td>
                        <form action="orders.jsp" method="post" style="display:inline;">
                            <input type="hidden" name="order_id" value="<%= orderId %>">
                            <input type="hidden" name="action" value="complete">
                            <button type="submit" class="btn btn-success btn-sm" <% if (!"Pending".equals(status)) { %> disabled <% } %>>Mark as Completed</button>
                        </form>
                        <form action="orders.jsp" method="post" style="display:inline;">
                            <input type="hidden" name="order_id" value="<%= orderId %>">
                            <input type="hidden" name="delete" value="true">
                            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                        </form>
                    </td>
                </tr>
                <% 
                        }
                    } catch (SQLException e) {
                        out.println("<div class='alert alert-danger'>SQL Error: " + e.getMessage() + "</div>");
                    } finally {
                        if (rs != null) {
                            try {
                                rs.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                        if (connection != null) {
                            try {
                                connection.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
