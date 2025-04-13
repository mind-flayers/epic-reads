jsp
<%@page import="app.classes.DbConnector"%>
<%@page import="app.classes.Book"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String author = request.getParameter("author");
    String priceStr = request.getParameter("price");
    String category = request.getParameter("category");
    String stockStr = request.getParameter("stock");
    String imgUrl = request.getParameter("img_url");
    boolean success = false;

    
    double price = Double.parseDouble(priceStr);
    int stock = Integer.parseInt(stockStr);

    Book book = new Book();
    book.setBook_id(id);
    book.setBook_name(name);
    book.setAuthor_name(author);
    book.setPrice(price);
    book.setCategory(category);
    book.setQuantity(stock);
    book.setImg_url(imgUrl);
   
    if (book.updateBook(DbConnector.getConnection())) {
        response.sendRedirect("all_books.jsp?a=1");
    } else {
        response.sendRedirect("all_books.jsp?a=0");
    }
%>