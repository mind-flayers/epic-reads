<%-- Document : admin Created on : Aug 9, 2024, 10:12:43 AM Author : User --%>

<%@page import="app.classes.User"%>
<%@page import="app.classes.DbConnector"%>
<%@page import="app.classes.Book"%>
<%@page import="app.classes.Order"%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<%
    // Get the userID from the session
    Integer userID = (Integer) session.getAttribute("userID");
    
    if (userID == null) {
        // If there's no userID in session, redirect to login page
        response.sendRedirect("../login.jsp");
        return;
    }

    // Create a User object with the userID
    User user = new User();
    user.setId(userID);
    
    // Fetch the role of the user
    String role = user.getRole(DbConnector.getConnection(), userID);
    
    // Check if the role is not "admin"
    if (!"admin".equals(role)) {
        // Redirect to another page if the role is not admin
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="logo" sizes="180x180" href="./images/logo.png">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <link href="../styles.css" rel="stylesheet">
    <style>
        .card {
            text-align: center;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1), 0 6px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }

        .card:hover {
            transform: translateY(-10px);
        }

        .card img {
            width: 50px;
            height: 50px;
        }
        
        .nav-pills .nav-link {
                border-radius: 0.25rem;
                margin: 0 0.25rem;
            }

            .nav-pills .nav-link.active {
                background-color: #007bff;
            }
    </style>

</head>

<body>
    <%@include file="navbar.jsp" %>
    <div class="container">
        <div class="row">
            

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-12 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <div class="h5">Hello, Admin</div>
                    <%
                        if (request.getParameter("s") != null) {
                            String message;
                            if (request.getParameter("s").equals("1")) {
                                message = "<h6 class='text-success'>Book added successfully</h6>";
                            } else {
                                message = "<h6 class='text-danger'>An error occurred. Please try again.</h6>";
                            }
                    %>
                    <script>
                        document.addEventListener("DOMContentLoaded", function() {
                            var message = `<%= message %>`;
                            document.getElementById("modalMessage").innerHTML = message;
                            $('#messageModal').modal('show');
                        });
                    </script>
                    <%
                        }
                    %>
                    <div class="h5">Dashboard</div>
                </div>

                <!-- Summary Cards -->
                <div class="row row-cols-1 row-cols-md-2 row-cols-xl-4 g-4 mb-4">
                    <div class="col">
                        <div class="card text-white bg-primary">
                            <div class="card-body">
                                <h5 class="card-title">Total Books</h5>
                                <%
                                  Book book = new Book();
                                  int totalBooks = book.countTotalBooks(DbConnector.getConnection());
                                %>
                                <p class="card-text" id="totalBooks"><%= totalBooks %></p>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="card text-white bg-success">
                            <div class="card-body">
                                <h5 class="card-title">Total Orders</h5>
                                <%
                                  Order order = new Order(DbConnector.getConnection());
                                  int totalOrders = order.getTotalNumberOfOrders();
                                %>
                                <p class="card-text" id="totalOrders"><%= totalOrders %></p>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="card text-white bg-warning">
                            <div class="card-body">
                                <h5 class="card-title">Pending Orders</h5>
                                <%
                                  int pendingOrders = order.getNumberOfPendingOrders();
                                %>
                                <p class="card-text" id="pendingOrders"><%= pendingOrders %></p>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="card text-white bg-info">
                            <div class="card-body">
                                <h5 class="card-title">Completed Orders</h5>
                                <%
                                  int completedOrders = order.getNumberOfCompletedOrders();
                                %>
                                <p class="card-text" id="completedOrders"><%= completedOrders %></p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="container text-center mt-5">
                    <div class="row mt-4">
                        <div class="col-md-4 btn" data-toggle="modal" data-target="#addBookModal">
                            <div class="card shadow-sm">
                                <div class="card-body">
                                    <img src="https://img.icons8.com/ios-filled/50/000000/add-book.png" alt="Add Books" class="img-fluid mb-3">
                                    <h5 class="card-title">Add Books</h5>
                                    <hr>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4 btn">
                            <div class="card shadow-sm">
                                <a href="all_books.jsp" class="text-decoration-none text-dark">
                                    <div class="card-body">
                                        <img src="https://img.icons8.com/ios-filled/50/000000/books.png" alt="All Books" class="img-fluid mb-3">
                                        <h5 class="card-title">All Books</h5>
                                        <hr>
                                    </div>
                                </a>
                            </div>
                        </div>

                        <div class="col-md-4 btn">
                            <div class="card shadow-sm">
                                <a href="orders.jsp" class="text-decoration-none text-dark">
                                    <div class="card-body">
                                        <img src="https://img.icons8.com/ios-filled/50/000000/box.png" alt="Orders" class="img-fluid mb-3">
                                        <h5 class="card-title">Orders</h5>
                                        <hr>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <%@include file="footer.jsp" %>

                <!-- Add Book popup Modal -->
                <div class="modal fade" id="addBookModal" tabindex="-1" role="dialog" aria-labelledby="addBookModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addBookModalLabel">Add Book Details</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form action="addBook.jsp" method="post">
                                    <div class="form-group">
                                        <label for="book_name">Book Title</label>
                                        <input type="text" class="form-control" id="book_name" name="book_name" placeholder="Enter book title">
                                    </div>
                                    <div class="form-group">
                                        <label for="book_author">Author</label>
                                        <input type="text" class="form-control" id="book_author" name="book_author" placeholder="Enter author name">
                                    </div>
                                    <div class="form-group">
                                        <label for="quantity">Stock</label>
                                        <input type="number" class="form-control" id="quantity" name="quantity" placeholder="Enter stock">
                                    </div>
                                    <div class="form-group">
                                        <label for="price">Price</label>
                                        <input type="number" class="form-control" id="price" step="0.01" name="price" placeholder="Enter price">
                                    </div>
                                    <div class="form-group">
                                        <label for="category">Category</label>
                                        <input type="text" class="form-control" id="category" name="category" placeholder="Enter book category">
                                    </div>
                                    <div class="form-group">
                                        <label for="description">Description</label>
                                        <textarea class="form-control" id="description" name="description"
                                            placeholder="Enter book description"></textarea>
                                    </div>
                                    <div class="form-group">
                                        <label for="img_url">Upload Photo</label>
                                        <input name="img_url" type="text" class="form-control-file" id="img_url">
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        <input type="submit" class="btn btn-primary" value="Add Book">
                                    </div>
                                </form>
                            </div>
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

                <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
                <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
                <script src="../script/script.js"></script>
            </main>
        </div>
    </div>
</body>

</html>