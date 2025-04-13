<%-- 
    Document   : sign_out
    Created on : Jul 29, 2024, 10:59:16 PM
    Author     : User
--%>

<%
session.invalidate();
response.sendRedirect("index.jsp");
%>
