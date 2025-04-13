
<%@page import="app.classes.User"%>
<nav class="fixed-top navbar navbar-expand-lg navbar-light bg-light py-2 shadow-sm">
    <div class="container">
        <div>
            <a class="navbar-brand font-weight-bold" href="#"><span
                    class="text-primary">Epic</span>Reads</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>

        <div class="w-100 d-flex" id="navbarNav">
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">

                    <%
                        User user = new User();
                        if (session.getAttribute("userID") != null) {

                    %>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="bi bi-person-circle h3" ></i>
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="profile.jsp">Profile</a>
                            <a class="dropdown-item" href="logout.jsp">Logout</a>
                        </div>
                    </li>
                    <% } else { %>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#explore">Shop</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#about">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-outline-primary nav-link text-white px-3" href="login.jsp">Sign in</a>
                    </li>
                    <% }%>
                </ul>
            </div>
        </div>
    </div>
</nav>

