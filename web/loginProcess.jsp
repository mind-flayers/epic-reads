<%-- 
    Document   : loginProcess
    Created on : Aug 7, 2024, 10:47:17 AM
    Author     : Joyson
--%>

<%@page import="app.classes.DbConnector" %>
<%@page import="app.classes.User" %>

<%
    String email = request.getParameter("email");
    String password = request.getParameter("pwd");
    String redirectURL = request.getParameter("redirectURL");
    
    User user = new User(email, password);
    
    if(user.authentication(DbConnector.getConnection())) {
        session.setAttribute("userID", user.getId());
        
        String role = user.getRole(DbConnector.getConnection(),user.getId()); // Assume getRole() method exists
        
        if ("admin".equals(role)) {
            response.sendRedirect("./admin/admin.jsp");
        } else {
            if (redirectURL != null && !redirectURL.isEmpty()) {
                response.sendRedirect(redirectURL);
            } else {
                response.sendRedirect("index.jsp");
            }
        }
    } else {
        response.sendRedirect("login.jsp?s=0");
    }
%>