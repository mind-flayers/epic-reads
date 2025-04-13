<%-- 
    Document   : add_books
    Created on : Aug 9, 2024, 9:25:35 PM
    Author     : User
--%>

<%@page import="app.classes.Book"%>
<%@page import="app.classes.DbConnector"%>
<%@page import="app.classes.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String book_name = request.getParameter("book_name");
    String book_author = request.getParameter("book_author");
    int quantity = Integer.parseInt(request.getParameter("quantity"));
    double price = Double.parseDouble(request.getParameter("price"));
    String category = request.getParameter("category");
    String img_url = request.getParameter("img_url");
    String description = request.getParameter("description");

    Book book = new Book(book_name, book_author, price, quantity, category, img_url, description);
    if (book.addBook(DbConnector.getConnection())) {
        response.sendRedirect("admin.jsp?s=1");
    } else {
        response.sendRedirect("admin.jsp?s=0");
    }
%>