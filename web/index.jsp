<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="app.classes.DbConnector"%>
<%@page import="app.classes.User"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="app.classes.Book"%>
<%@page import="java.util.List"%>
<%!
    Locale locale = new Locale("si", "LK");
    NumberFormat formatter = NumberFormat.getCurrencyInstance(locale);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EpicReads - Online Bookstore</title>
    <link rel="logo" sizes="180x180" href="./images/logo.png">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <style>
        .book-card {
            border: none;
            transition: transform 0.3s;
        }
        .book-card:hover {
            transform: scale(1.05);
        }
        .book-cover {
            height: 300px;
            object-fit: cover;
        }
        .nav-pills .nav-link {
            border-radius: 0.25rem;
            margin: 0 0.25rem;
        }
        .nav-pills .nav-link.active {
            background-color: #007bff;
        }
        #bCard {
            transition: transform 0.3s;
        }
        #bCard:hover {
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <!--Import Navbar-->
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
                        <%
                            User user = new User();
                            if (session.getAttribute("userID") != null) {
                        %>
                        <li class="nav-item">
                            <a class="nav-link" href="./index.jsp">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="showBooks.jsp">Shop</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#about">About</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="bi bi-person-circle h3"></i>
                            </a>
                            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item" href="user_profile.jsp">Profile</a>
                                <% if (user.getRole(DbConnector.getConnection(), (Integer) session.getAttribute("userID")).equals("admin")) { %>
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
                            <a class="btn btn-outline-primary nav-link text-white px-3" href="login.jsp">Sign in</a>
                        </li>
                        <% } %>
                    </ul>
                </div>
            </div>
        </div>
    </nav>

    <div class="hero-section d-flex align-items-center">
        <div class="container">
            <div class="row">
                <div class="col-md-6 d-flex flex-column justify-content-center">
                    <h1 class="display-3 font-weight-bold lh-1">Unleash Your Imagination</h1>
                    <p>Find your favorite books and new discoveries in our vast collection. Your next
                        adventure awaits.
                        Whether you're into thrillers, romance, science fiction, or biographies, we have
                        something for
                        everyone.</p>
                    <a href="#explore" class="btn btn-primary mt-2 btn-custom px-0">Explore Now</a>
                </div>
                <div class="col-md-6">
                    <img src="images/hero.png" class="img-fluid" alt="Hero Image">
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <h1 class="text-center mb-4 mt-5">LATEST BOOKS</h1>
    <div class="container d-flex align-items-center">
        <%
            // Create an instance of the Book class
            Book b = new Book();
            // Fetch the latest 4 books
            List<Book> latestBooks = b.getLatestBooks(4);
            if (latestBooks != null) {
                for (Book book : latestBooks) {
                    String bookId = URLEncoder.encode(book.getBook_id(), "UTF-8");
        %>
        <div class="col">
            <div class="card card-body book-card">
                <img src="<%= book.getImg_url()%>" alt="<%= book.getBook_name()%>"
                     class="card-img-top book-cover">
                <div class="card-body">
                    <h5 class="card-title"><%= book.getBook_name()%></h5>
                    <p class="card-text">by <%= book.getAuthor_name()%></p>
                    <a href="book_details.jsp?bookId=<%= bookId%>" class="btn btn-outline-primary">View Details</a>
                </div>
            </div>
        </div>
        <%  }
        } else { %>
        <div class="col">
            <div class="card text-center">
                <div class="card-body">
                    <p>No books available at the moment.</p>
                </div>
            </div>
        </div>
        <% }%>
    </div>
    <div class="container d-flex justify-content-end">
        <a href="showBooks.jsp" class="btn btn-primary mt-2 mr-3">View All Books</a>
    </div>

    <div class="container my-5 py-5" id="about">
        <h1 class="text-center mb-5">HOW CAN WE HELP</h1>
        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
            <div class="col">
                <div class="card h-100 text-center">
                    <div class="card-body">
                        <i class="bi bi-book text-primary fs-1 mb-3"></i>
                        <h5 class="card-title">Buying A Book?<br>Make Us An Offer!</h5>
                        <p class="card-text">Arrange for your text books and paperbacks to be delivered
                            quickly and
                            efficiently</p>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card h-100 text-center">
                    <div class="card-body">
                        <i class="bi bi-cash-coin text-primary fs-1 mb-3"></i>
                        <h5 class="card-title">Sell Book or Donate to Charity</h5>
                        <p class="card-text">Arrange for your text books and paperbacks to be delivered
                            quickly and
                            efficiently</p>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card h-100 text-center">
                    <div class="card-body">
                        <i class="bi bi-mortarboard text-primary fs-1 mb-3"></i>
                        <h5 class="card-title">Full Service<br>Student Ordering</h5>
                        <p class="card-text">Arrange for your text books and paperbacks to be delivered
                            quickly and
                            efficiently</p>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card h-100 text-center">
                    <div class="card-body">
                        <i class="bi bi-cart-check text-primary fs-1 mb-3"></i>
                        <h5 class="card-title">Purchasing<br>Service Plan</h5>
                        <p class="card-text">Arrange for your text books and paperbacks to be delivered
                            quickly and
                            efficiently</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container mt-5 py-5">
        <h1 class="text-center mb-4">Highly Rated</h1>
        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
            <% Book book=new Book(); List<Book> bookList = book.getAllBooks1(DbConnector.getConnection());
                int count = 0;
                for(Book bk: bookList) {
                if (count >= 4) {
                break;
                }
                String bookId = URLEncoder.encode(bk.getBook_id(), "UTF-8");
                %>
                <div class="col">
                    <div class="card card-body book-card">
                        <img src="<%= bk.getImg_url()%>" alt="<%= bk.getBook_name()%>" class="card-img-top book-cover">
                        <div class="card-body">
                            <h5 class="card-title">
                                <%= bk.getBook_name()%>
                            </h5>
                            <p class="card-text">by <%= bk.getAuthor_name()%>
                            </p>
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span class="">
                                    <%= formatter.format(bk.getPrice())%>
                                </span>
                                <span><i class="bi bi-star-fill text-warning"></i>
                                    <%= bk.getRating()%>
                                </span>
                            </div>
                            <a href="book_details.jsp?bookId=<%= bookId%>" class="btn btn-outline-primary">View Details</a>
                        </div>
                    </div>
                </div>
                <% count++; } %>
        </div>
    </div>

    <footer class="bg-light py-4">
        <div class="container text-center">
            <div class="row">
                <div class="col-md-4">
                    <h5>Contact Us</h5>
                    <p>Email: support@epicreads.com<br>
                        Phone: +1 234 567 890</p>
                </div>
                <div class="col-md-4">
                    <h5>Follow Us</h5>
                    <a href="#" class="text-primary mx-2"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="text-primary mx-2"><i class="bi bi-twitter"></i></a>
                    <a href="#" class="text-primary mx-2"><i class="bi bi-instagram"></i></a>
                </div>
                <div class="col-md-4 ">
                    <h5>Quick Links</h5>
                    <a href="./index.jsp" class="text-decoration-none d-block">Home</a>
                    <a href="./showBooks.jsp" class="text-decoration-none d-block">Shop</a>
                    <a href="#about" class="text-decoration-none d-block">About</a>
                </div>
            </div>
            <hr>
            <p>&copy; 2024 EpicReads. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>