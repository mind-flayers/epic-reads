<%@ page import="app.classes.DbConnector" %>
<%@ page import="app.classes.User" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>

<%
    // Retrieve form parameters
    String password = request.getParameter("newPassword");
    int userId = Integer.parseInt(request.getParameter("userId"));

    // Update user in the database
    User user = new User();
    user.setId(userId);
    user.setPassword(password);

    if (user.updatePassword(DbConnector.getConnection())) {
        response.sendRedirect("user_profile.jsp?s=1");
    } else {
        response.sendRedirect("user_profile.jsp?s=0");
    }
%>
