<%@page import="app.classes.Book"%>
<%@page import="app.classes.DbConnector"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.logging.Logger"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Logger logger = Logger.getLogger("DeleteBookLogger");
    String book_id = request.getParameter("delete-id"); // Corrected parameter name

    if (book_id != null && !book_id.isEmpty()) {
        Book book = new Book();
        book.setBook_id(book_id);

        Connection conn = null;
        try {
            conn = DbConnector.getConnection();
            if (book.deleteBook(conn)) {
                response.sendRedirect("all_books.jsp?s=1");
            } else {
                response.sendRedirect("all_books.jsp?s=0");
            }
        } catch (Exception e) {
            logger.severe("Error deleting book: " + e.getMessage());
            response.sendRedirect("all_books.jsp?s=0");
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    logger.severe("Error closing connection: " + e.getMessage());
                }
            }
        }
    } else {
        response.sendRedirect("all_books.jsp?s=0");
    }
%>