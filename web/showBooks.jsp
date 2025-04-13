<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="app.classes.User"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="java.util.List" %>
<%@ page import="app.classes.Book" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="app.classes.DbConnector" %>
<!DOCTYPE html>

<%@ page import="java.util.List" %>
<%@ page import="app.classes.Book" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="app.classes.DbConnector" %>
<!DOCTYPE html>
<%!Book book = new Book();%>
<%!
    Locale locale = new Locale("si", "LK");
    NumberFormat formatter = NumberFormat.getCurrencyInstance(locale);
%>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EpicReads - Bookstore</title>
    <link rel="logo" sizes="180x180" href="./images/logo.png">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <style>
        .sidebar {
            width: 250px;
            position: fixed;
            top: 70px;
            /* Adjust to fit under the navbar */
            left: 0;
            height: 100%;
            padding: 20px;
            background-color: #f8f9fa;
            overflow-y: auto;
        }

        .category-buttons {
            margin-bottom: 20px;
        }

        .category-buttons button {
            margin-bottom: 10px;
            width: 100%;
        }

        .price-filter {
            margin-bottom: 20px;
        }

        .price-filter input {
            width: 100%;
        }

        .content {
            margin-left: 270px;
            /* Adjust to fit the sidebar width */
            padding-top: 20px;
        }

        .card-container {
            display: flex;
            flex-wrap: wrap;
        }

        .card {
            flex: 1 0 21%;
            margin: 10px;
            display: none;
            /* Hide all cards initially */
            max-width: 220px;
            /* Fixed card size */
            max-height: 450px;
            /* Fixed card height */
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card img {
            height: 280px;
            object-fit: cover;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }

        .card-body {
            text-align: center;
            padding: 15px;
        }

        .card-title {
            font-size: 1.2rem;
            font-weight: bold;
        }

        .card-text {
            margin-bottom: 15px;
        }
    </style>
</head>

<body>
    <nav class="fixed-top navbar navbar-expand-lg navbar-light bg-light py-2 shadow-sm">
        <div class="container">
            <div>
                <a class="navbar-brand font-weight-bold" href="#"><span class="text-primary">Epic</span>Reads</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
            </div>
            <div class="w-100 d-flex" id="navbarNav">
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ml-auto d-flex align-items-center">
                        <% User user=new User(); if (session.getAttribute("userID") !=null) { %>
                            <li class="nav-item">
                                <a class="nav-link" href="./index.jsp">Home</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="showBooks.jsp">Shop</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="./index.jsp">About</a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                                    data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="bi bi-person-circle h3"></i>
                                </a>
                                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                    <a class="dropdown-item" href="user_profile.jsp">Profile</a>
                                    <% if (user.getRole(DbConnector.getConnection(), (Integer)
                                        session.getAttribute("userID")).equals("admin")) { %>
                                        <a class="dropdown-item" href="./admin/admin.jsp">Dashboard</a>
                                        <% } %>
                                            <a class="dropdown-item" href="logout.jsp">Logout</a>
                                </div>
                            </li>
                            <% } else { %>
                                <li class="nav-item">
                                    <a class="nav-link" href="./index.jsp">Home</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="showBooks.jsp">Shop</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="./index.jsp">About</a>
                                </li>
                                <li class="nav-item">
                                    <a class="btn btn-outline-primary nav-link text-white px-3" href="login.jsp">Sign
                                        in</a>
                                </li>
                                <% } %>
                    </ul>
                </div>
            </div>
        </div>
    </nav>

    <!-- Order Success Modal -->
    <div class="modal fade" id="orderSuccessModal" tabindex="-1" aria-labelledby="orderSuccessModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="orderSuccessModalLabel">Order Status</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>Order Placed Successfully</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <div class="sidebar col-md-3 justify-content-center">
        <h4>Category</h4>
        <div class="category-buttons">
            <button class="btn btn-outline-dark" onclick="filterBooks('all')">Show All</button>
            <button class="btn btn-primary" onclick="filterBooks('Finance')">Finance</button>
            <button class="btn btn-secondary" onclick="filterBooks('Fantasy')">Fantasy</button>
            <button class="btn btn-warning" onclick="filterBooks('Programming')">Programming</button>

            <button class="btn btn-info" onclick="filterBooks('Fiction')">Fiction</button>
        </div>

        <h4>Price</h4>
        <div class="price-filter">
            <input type="range" id="priceRange" min="1000" max="15000" value="15000" step="10"
                oninput="filterByPrice(this.value)">
            <p>Price: LKR<span id="priceValue">15000</span> or below</p>
        </div>
    </div>

    <div class="content container mt-5 col-md-9">
        <h1 class="mb-4 pt-1 text-left">Browse Our Books</h1>

        <div class="card-container">
            <% Connection con=null; try { con=DbConnector.getConnection(); Book bookModel=new Book(); List<Book> books =
                bookModel.getAllBooks(con);

                for (Book book : books) {
                String bookId = URLEncoder.encode(book.getBook_id(), "UTF-8");
                %>
                <div class="card <%= book.getCategory()%>" data-price="<%= book.getPrice()%>">
                    <img src="<%= book.getImg_url()%>" class="card-img-top" alt="<%= book.getBook_name()%>">
                    <div class="card-body">
                        <h5 class="card-title">
                            <%= book.getBook_name()%>
                        </h5>
                        <p class="card-text">
                            <%= formatter.format(book.getPrice())%>
                        </p>
                        <a href="book_details.jsp?bookId=<%= bookId%>"><button
                                class="btn btn-outline-success btn-custom mt-3">Buy Now</button></a>

                    </div>
                </div>
                <% } } catch (Exception e) { e.printStackTrace(); } finally { if (con !=null) { try { con.close(); }
                    catch (Exception e) { e.printStackTrace(); } } } %>
        </div>
    </div>

    <footer class="bg-light py-4">
        <div class="container text-center">
            <p>&copy; 2024 EpicReads. All rights reserved.</p>
        </div>
    </footer>

    <script>
        function filterBooks(category) {
            var cards = document.querySelectorAll('.card');
            cards.forEach(function (card) {
                card.style.display = 'none'; // Hide all cards
            });
            if (category === 'all') {
                cards.forEach(function (card) {
                    card.style.display = 'block'; // Show all cards
                });
            } else {
                var selectedCards = document.querySelectorAll('.' + category);
                selectedCards.forEach(function (card) {
                    card.style.display = 'block'; // Show cards of selected category
                });
            }
        }

        function filterByPrice(maxPrice) {
            document.getElementById('priceValue').textContent = maxPrice;
            var cards = document.querySelectorAll('.card');
            cards.forEach(function (card) {
                var price = parseFloat(card.getAttribute('data-price'));
                if (price <= maxPrice) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }

        // Show all books when the page loads
        window.onload = function () {
            filterBooks('all');
            filterByPrice(document.getElementById('priceRange').value);
        };

        // Check the parameter "s" and show the modal if "s" is 1
        window.onload = function () {
            filterBooks('all');
            filterByPrice(document.getElementById('priceRange').value);

            <% String s = request.getParameter("s"); %>
            if (<%= "1".equals(s) %>) {
                $('#orderSuccessModal').modal('show');
            }
        };
    </script>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>