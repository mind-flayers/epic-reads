<%-- 
    Document   : registerProcess
    Created on : Aug 7, 2024, 10:15:39 AM
    Author     : Joyson
--%>

<%@page import="app.classes.DbConnector" %>
<%@page import="app.classes.User" %>

<%
    String firstname = request.getParameter("fname");
    String lastname = request.getParameter("lname");
    String email = request.getParameter("email");
    String password = request.getParameter("pwd");
    String role = "customer";
    
    
    User user = new User(firstname, lastname, email, password, role);
    if(user.register(DbConnector.getConnection())){
        response.sendRedirect("login.jsp?s=1");
    }else {
        response.sendRedirect("register.jsp?s=0");
    }
%>