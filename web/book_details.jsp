<%-- Document : book_details Created on : Aug 9, 2024, 6:00:09 PM Author : User --%>

<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.sql.Connection"%>
<%@page import="app.classes.DbConnector"%>
<%@page import="app.classes.Book"%>
<%@page import="app.classes.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="app.classes.DbConnector"%>
<%@page import="app.classes.Book"%>
<%@page import="app.classes.User"%>
<%!User user = new User();
    Book book = new Book();%>
<%!
    Locale locale = new Locale("si", "LK");
    NumberFormat formatter = NumberFormat.getCurrencyInstance(locale);
%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Book Details</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="styles.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
        <style>
            .book-image {
                max-width: 80%;
                height: 400px;
            }

            .book-details {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .rating {
                color: #ffc107;
            }

            .related-books img {
                max-width: 100%;
                height: auto;
            }

            .review {
                margin-bottom: 20px;
            }

            .review img {
                border-radius: 50%;
                width: 100px;
                /* Ensure the image is a square */
                height: 100px;
                /* Ensure the image is a square */
                object-fit: cover;
                /* Ensure the image covers the entire area */
            }

            .star-rating {
                direction: rtl;
                /* Right-to-left for better visual alignment */
                display: inline-flex;
                font-size: 2rem;
                /* Adjust the size of the stars */
            }

            .star-rating input[type="radio"] {
                display: none;
                /* Hide the radio buttons */
            }

            .star-rating label {
                color: #ddd;
                /* Default star color */
                cursor: pointer;
                padding: 0 5px;
            }

            .star-rating input[type="radio"]:checked~label {
                color: #f5b301;
                /* Color for selected stars */
            }

            .star-rating label:hover,
            .star-rating label:hover~label {
                color: #f5b301;
                /* Color for hovered stars */
            }
        </style>
    </head>

    <body>

        <nav class="navbar navbar-expand-lg navbar-light bg-light py-2 shadow-sm">
            <div class="container">
                <div>
                    <a class="navbar-brand font-weight-bold" href="index.jsp"><span
                            class="text-primary">Epic</span>Reads</a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                </div>

                <div class="w-100 d-flex" id="navbarNav">
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav ml-auto d-flex align-items-center">
                            <%
                                User user = new User();
                                if (session.getAttribute("userID") != null) {

                            %>
                            <li class="nav-item">
                                <a class="nav-link" href="index.jsp">Home</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="showBooks.jsp">Shop</a>
                            </li>

                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="bi bi-person-circle h3" ></i>
                                </a>
                                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                    <a class="dropdown-item" href="user_profile.jsp">Profile</a>
                                    <a class="dropdown-item" href="logout.jsp">Logout</a>
                                </div>
                            </li>
                            <% } else { %>
                            <li class="nav-item">
                                <a class="nav-link" href="#">Home</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="showBooks.jsp">Shop</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#about">About</a>
                            </li>
                            <li class="nav-item">
                                <a class="btn btn-outline-primary nav-link text-white px-3" href="login.jsp">Sign in</a>
                            </li>
                            <% } %>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>


        <%
            String bookId = request.getParameter("bookId");
            if (bookId != null) {
                try {
                    Connection con = DbConnector.getConnection();
                    Book bookDetails = book.getBookById(con, bookId);
                    // Fetch user details if the user is logged in
                    if (session.getAttribute("userID") != null) {
                        Integer userId = (Integer) session.getAttribute("userID");
                        user.setId(userId);
                        user.getUserById(con);  // Assuming you have this method in your User class
                    }
        %>


        <div class="container mt-5">
            <div class="row">
                <div class="col-md-4 d-flex justify-content-center">
                    <img src="<%= bookDetails.getImg_url()%>" alt="Book Cover" class="book-image">
                </div>
                <div class="col-md-7">
                    <div class="book-details">
                        <h1><%= bookDetails.getBook_name()%></h1>
                        <h4><%= bookDetails.getAuthor_name()%></h4>
                        <p><%= formatter.format(bookDetails.getPrice())%></p>
                        <div class="rating">
                            <span><%= bookDetails.getRating()%></span>
                        </div>

                        <!-- Buy Now button -->
                        <%
                            if (session.getAttribute("userID") != null) {
                        %>
                        <!-- If logged in, open the order modal -->
                        <button class="btn btn-success btn-custom mt-3" data-toggle="modal" data-target="#orderModal">Buy Now</button>
                        <%
                        } else {
                        %>
                        <!-- If not logged in, open the login modal -->
                        <button class="btn btn-success btn-custom mt-3" data-toggle="modal" data-target="#loginModal">Buy Now</button>
                        <%
                            }
                        %>

                        <!--                        <button class="btn btn-success btn-custom mt-3" data-toggle="modal" data-target="#orderModal">Buy Now</button>-->
                        <h5 class="mt-4">About the Book</h5>
                        <p><%= bookDetails.getDescription()%></p>
                        <div>
                            <button class="btn btn-outline-primary"><%= bookDetails.getCategory()%></button>
                            <!-- Add more categories if needed -->
                        </div>
                    </div>
                </div>
            </div>
        </div>





        <footer class="bg-light py-4">
            <div class="container text-center">
                <div class="row">
                    <div class="col-md-4">
                        <h5>Contact Us</h5>
                        <p>Email: support@epicreads.com</p>
                        <p>Phone: +1 234 567 890</p>
                    </div>
                    <div class="col-md-4">
                        <h5>Follow Us</h5>
                        <a href="#" class="text-primary mx-2"><i class="bi bi-facebook"></i></a>
                        <a href="#" class="text-primary mx-2"><i class="bi bi-twitter"></i></a>
                        <a href="#" class="text-primary mx-2"><i class="bi bi-instagram"></i></a>
                    </div>
                    <div class="col-md-4">
                        <h5>Quick Links</h5>
                        <a href="#" class="d-block">Home</a>
                        <a href="#explore" class="d-block">Shop</a>
                        <a href="#" class="d-block">About</a>
                    </div>
                </div>
                <hr>
                <p>&copy; 2024 EpicReads. All rights reserved.</p>
            </div>
        </footer>

        <!-- Order Modal -->
        <div class="modal fade" id="orderModal" tabindex="-1" aria-labelledby="orderModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="orderModalLabel">Place Order</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="orderForm" action="placeOrder.jsp" method="post">
                            <input type="hidden" name="bookId" value="<%= bookId%>">
                            <div class="form-group">
                                <label for="email">Email Address</label>
                                <input type="email" class="form-control" id="email" name="email"  value="<%= user.getEmail()%>" required>
                            </div>
                            <div class="form-group">
                                <label for="firstName">First Name</label>
                                <input type="text" class="form-control" id="firstName" name="firstName" value="<%= user.getFirstname()%>" required>
                            </div>
                            <div class="form-group">
                                <label for="lastName">Last Name</label>
                                <input type="text" class="form-control" id="lastName" name="lastName" value="<%= user.getLastname()%>" required>
                            </div>
                            <div class="mb-3">
                                <label for="quantity" class="form-label">Quantity</label>
                                <input type="number" class="form-control" id="quantity" name="quantity" required>
                            </div>
                            <div class="mb-3">
                                <label for="phone" class="form-label">Phone Number</label>
                                <input type="text" class="form-control" id="phone" name="phone" required>
                            </div>
                            <div class="mb-3">
                                <label for="address" class="form-label">Shipping Address</label>
                                <textarea class="form-control" id="address" name="address" rows="3" required></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">Place Order</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <!-- Order Success Modal -->
        <!-- Success Modal HTML -->
        <div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="successModalLabel">Order Success</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p>Your order has been placed successfully!</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
                    </div>
                </div>
            </div>
        </div>


        <!-- Login Modal -->
        <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="loginModalLabel">Login Required</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="loginForm" action="loginProcess.jsp" method="post">
                            <div class="form-group">
                                <label for="loginEmail">Email Address</label>
                                <input type="email" class="form-control" id="loginEmail" name="email" required>
                            </div>
                            <div class="form-group">
                                <label for="loginPassword">Password</label>
                                <input type="password" class="form-control" id="loginPassword" name="pwd" required>
                            </div>
                            <!-- Hidden field to store the current page's URL -->
                            <input type="hidden" name="redirectURL" value="<%= request.getRequestURI() + "?bookId=" + request.getParameter("bookId")%>">
                            <input type="submit" class="btn btn-primary" value="Login">
                        </form>
                    </div>
                </div>
            </div>
        </div>



        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="./script/script.js"></script>
        

    </body>

</html>

<%

        } catch (Exception e) {
            e.printStackTrace();
        }

    } else {
        out.println("<p>No book ID specified.</p>");
    }
%>