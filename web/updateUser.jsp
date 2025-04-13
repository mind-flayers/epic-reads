<%@page import="app.classes.DbConnector"%>
<%@page import="app.classes.User"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>

<%
    // Retrieve form parameters
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    int userId = Integer.parseInt(request.getParameter("userId"));

    // Update user in the database
    User user = new User();
    user.setId(userId);
    user.setFirstname(firstName);
    user.setLastname(lastName);
    user.setEmail(email);

    if (user.updateUser(DbConnector.getConnection())) {
        response.sendRedirect("user_profile.jsp?s=1");
    } else {
        response.sendRedirect("user_profile.jsp?s=0");
    }
%>