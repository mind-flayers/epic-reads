<%@page import="java.util.List"%>
<%@page import="app.classes.DbConnector"%>
<%@page import="app.classes.Book"%>
<%@page import="app.classes.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!User user = new User();
    Book book = new Book();%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Book List</title>
        <link rel="logo" sizes="180x180" href="./images/logo.png">
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../styles.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
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
        <%@include file="navbar.jsp" %>
        <%
            if (request.getParameter("s") != null) {
                String deleteMessage;
                if (request.getParameter("s").equals("1")) {
                    deleteMessage = "<h6 class='text-success'>Book deleted successfully</h6>";
                } else {
                    deleteMessage = "<h6 class='text-danger'>An error occurred. Please try again.</h6>";
                }
        %>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var deleteMessage = `<%= deleteMessage%>`;
                document.getElementById("modalMessage").innerHTML = deleteMessage;
                $('#messageModal').modal('show');
            });
        </script>
        <%
            }
        %>
        
        <%
            if (request.getParameter("a") != null) {
                String updateMessage;
                if (request.getParameter("a").equals("1")) {
                    updateMessage = "<h6 class='text-success'>Book updated successfully</h6>";
                } else {
                    updateMessage = "<h6 class='text-danger'>An error occurred. Please try again.</h6>";
                }
        %>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var updateMessage = `<%= updateMessage%>`;
                document.getElementById("modalMessage").innerHTML = updateMessage;
                $('#messageModal').modal('show');
            });
        </script>
        <%
            }
        %>
        
        
        <div class="container mt-5"> 
            <div class="page-header mb-3">
                <h1 class="text-center">Manage All Books</h1>
            </div>
            <table class="table table-striped">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">Id</th>
                        <th scope="col">Book Name</th>
                        <th scope="col">Author Name</th>
                        <th scope="col">Price</th>
                        <th scope="col">Book Categories</th>
                        <th scope="col">Stock</th>
                        <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Book book = new Book();
                        List<Book> bookList = book.getAllBooks(DbConnector.getConnection());
                        for (Book b : bookList) {
                    %>
                    <tr>
                        <td><%=b.getBook_id()%></td>
                        <td><%=b.getBook_name()%></td>
                        <td><%=b.getAuthor_name()%></td>
                        <td><%=b.getPrice()%></td>
                        <td><%=b.getCategory()%></td>
                        <td><%=b.getQuantity()%></td>
                        <td>
                            <button class="btn btn-success btn-sm" data-toggle="modal" data-target="#editModal" 
                                    data-id="<%=b.getBook_id()%>" 
                                    data-name="<%=b.getBook_name()%>" 
                                    data-author="<%=b.getAuthor_name()%>" 
                                    data-price="<%=b.getPrice()%>" 
                                    data-category="<%=b.getCategory()%>" 
                                    data-stock="<%=b.getQuantity()%>" 
                                    data-imgurl="<%=b.getImg_url()%>">Edit</button>
                            <button class="btn btn-danger btn-sm" data-toggle="modal" data-target="#deleteModal" data-id="<%=b.getBook_id()%>">Delete</button>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>

        <!-- Edit popup Modal -->
        <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editModalLabel">Edit Book</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="editForm" action="updateBook.jsp" method="post">
                            <input type="hidden" id="edit-id" name="id">
                            <div class="form-group">
                                <label for="edit-name">Book Name</label>
                                <input type="text" class="form-control" id="edit-name" name="name" required>
                            </div>
                            <div class="form-group">
                                <label for="edit-author">Author Name</label>
                                <input type="text" class="form-control" id="edit-author" name="author" required>
                            </div>
                            <div class="form-group">
                                <label for="edit-price">Price</label>
                                <input type="number" class="form-control" id="edit-price" name="price" step="0.01" required>
                            </div>
                            <div class="form-group">
                                <label for="edit-category">Book Categories</label>
                                <input type="text" class="form-control" id="edit-category" name="category" required>
                            </div>
                            <div class="form-group">
                                <label for="edit-stock">Stock</label>
                                <input type="number" class="form-control" id="edit-stock" name="stock" required>
                            </div>
                            <div class="form-group">
                                <label for="edit-img-url">Book Image</label>
                                <input type="text" class="form-control" id="edit-img-url" name="img_url" required>
                            </div>
                            <input type="submit" class="btn btn-primary" value="Save Changes">
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Delete popup Modal -->
        <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="deleteBook.jsp" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title" id="deleteModalLabel">Delete Book</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>Are you sure you want to delete this book?</p>
                            <input type="hidden" name="delete-id" id="delete-id">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            <input type="submit" class="btn btn-danger" value="Delete">
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Success message popup modal -->
        <div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="messageModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="messageModalLabel">Notification</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" id="modalMessage">
                        <!-- Message will be injected here -->
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="footer.jsp" %>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="../script/script_all_books.js"></script>
    </body>
</html>
