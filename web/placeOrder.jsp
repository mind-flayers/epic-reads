<%-- 
    Document   : placeOrder
    Created on : Aug 11, 2024, 10:01:41 PM
    Author     : Joyson
--%>

<%@page import="java.sql.*, app.classes.Order, app.classes.Book, app.classes.DbConnector" %>
<%
    Connection con = null;
    try {
        // Retrieve form parameters
        String bookId = request.getParameter("bookId");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        int userId = (Integer) session.getAttribute("userID"); // Ensure userId is retrieved correctly

        // Validate user session
        if (userId == 0) {
            response.sendRedirect("login.jsp"); // Redirect to login if not logged in
            return;
        }

        // Get connection and book details
        con = DbConnector.getConnection();
        Book book = new Book();
        book = book.getBookById(con, bookId);

        // Calculate total amount
        double totalAmount = book.getPrice() * quantity;

        // Create Order object and add order
        Order order = new Order(con);
        int orderId = order.addOrder(userId, totalAmount, "Pending", address);

        // Optionally, handle order items or reduce book quantity here

        // Redirect to order confirmation or success page
        response.sendRedirect("showBooks.jsp?s=1"); 
    } catch (SQLException e) {
        e.printStackTrace(); // Print stack trace to server logs
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
    } catch (NumberFormatException e) {
        e.printStackTrace(); // Print stack trace to server logs
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input format: " + e.getMessage());
    } catch (Exception e) {
        e.printStackTrace(); // Print stack trace to server logs
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unexpected error: " + e.getMessage());
    } finally {
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>