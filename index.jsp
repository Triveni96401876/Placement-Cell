<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.placementcell.model.User" %>
        <% com.placementcell.model.User sessionUser=(com.placementcell.model.User) session.getAttribute("user"); %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Sanjay Gandhi Polytechnic, Ballari - Welcome</title>
                <!-- CSS - Use relative paths that match deployment -->
                <link rel="stylesheet" href="css/style.css">
                <!-- Google Fonts -->
                <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
                    rel="stylesheet">
                <!-- Font Awesome -->
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            </head>

            <body>

                <!-- Header -->
                <header>
                    <div class="navbar">
                        <div class="logo-container">
                            <img src="images/sgp1.jpeg" alt="SGP Logo" class="logo-img"
                                onerror="this.src='https://cdn-icons-png.flaticon.com/512/2942/2942789.png'">
                            <div>
                                <h2 style="color: var(--primary-color); line-height: 1;">SGP</h2>
                                <span style="font-size: 0.8rem; color: #666;">Ballari</span>
                            </div>
                        </div>

                        <!-- Hamburger for Mobile -->
                        <div class="hamburger">
                            <span class="bar"></span>
                            <span class="bar"></span>
                            <span class="bar"></span>
                        </div>

                        <!-- Navigation -->
                        <ul class="nav-menu">
                            <li><a href="#home" class="nav-link">Home</a></li>
                            <li><a href="#about" class="nav-link">About</a></li>

                            <% if (sessionUser !=null) { %>
                                <% if ("ADMIN".equals(sessionUser.getRole())) { %>
                                    <li><a href="AdminDashboardServlet" class="nav-link"><i class="fas fa-th-large"></i>
                                            Dashboard</a></li>
                                    <% } else if ("HOD".equals(sessionUser.getRole())) { %>
                                        <li><a href="HODDashboardServlet" class="nav-link"><i
                                                    class="fas fa-th-large"></i> Dashboard</a></li>
                                        <% } else { %>
                                            <li><a href="DashboardServlet" class="nav-link"><i
                                                        class="fas fa-th-large"></i> Dashboard</a></li>
                                            <% } %>
                                                <% } %>

                                                    <li><a href="#courses" class="nav-link">Courses</a></li>
                                                    <li><a href="#placements" class="nav-link">Placements</a></li>
                                                    <li><a href="#contact" class="nav-link">Contact</a></li>

                                                    <!-- Auth Buttons -->
                                                    <li class="auth-buttons">
                                                        <% if (sessionUser==null) { %>
                                                            <button class="btn btn-outline"
                                                                onclick="window.location.href='register.html'">Register</button>
                                                            <button class="btn btn-primary"
                                                                onclick="window.location.href='login.html'">Login</button>
                                                            <% } else { %>
                                                                <button class="btn btn-outline"
                                                                    onclick="window.location.href='LogoutServlet'">Logout</button>
                                                                <% } %>
                                                    </li>
                        </ul>
                    </div>
                </header>

                <!-- Hero Section -->
                <section id="home" class="hero"
                    style="background: linear-gradient(rgba(0, 51, 102, 0.75), rgba(0, 51, 102, 0.75)), url('images/college_background.jpg'); height: 85vh; background-size: cover; background-position: center; display: flex; align-items: center; justify-content: center; text-align: center; color: white;">
                    <div class="hero-content">
                        <img src="images/sgp image,png.png" alt="SGP Logo" class="hero-logo"
                            style="width: 220px; margin-bottom: 2.5rem;">
                        <h1 style="font-size: 3.5rem; font-weight: 700; margin-bottom: 1rem;">Welcome to Sanjay Gandhi
                            Polytechnic, Ballari</h1>
                        <h3 class="hero-subtitle"
                            style="color: #ffd700; font-size: 1.5rem; margin-bottom: 1.5rem; font-weight: 400;">
                            Empowering Technical Education Since 1991</h3>
                        <p style="max-width: 700px; margin: 0 auto 2rem; font-size: 1.1rem;">Sanjay Gandhi Polytechnic
                            (SGP), Ballari, is a premier private co-educational institution committed to
                            quality technical education and skill-based learning.</p>
                        <div class="hero-buttons">
                            <a href="#courses" class="btn btn-primary">Explore Courses</a>
                            <a href="#contact" class="btn btn-outline"
                                style="color: white; border: 2px solid white; padding: 0.5rem 1.5rem; border-radius: 5px; margin-left: 1rem;">Contact
                                Us</a>
                        </div>
                    </div>
                </section>

                <!-- About Section -->
                <section id="about">
                    <h2 class="section-title">About SGP</h2>
                    <div class="about-content">
                        <p>Sanjay Gandhi Polytechnic (SGP), Ballari, was established in 1991 as the first premier
                            private
                            co-educational polytechnic.</p>
                        <br>
                        <p>The institute is recognized by the Government of Karnataka, approved by AICTE, New Delhi, and
                            affiliated
                            with the Directorate of Technical Education (DTE), Bengaluru.</p>
                        <br>
                        <p>SGP focuses on academic excellence, practical exposure, and overall student development.</p>
                    </div>
                </section>

                <!-- Courses Section -->
                <section id="courses">
                    <h2 class="section-title">Our Courses</h2>
                    <div class="courses-grid">
                        <div class="course-card">
                            <i class="fas fa-microchip fa-3x"
                                style="color:var(--primary-color); margin-bottom:1rem;"></i>
                            <h3>Electronics & Communication</h3>
                            <p>Advanced circuitry and communication systems.</p>
                        </div>
                        <div class="course-card">
                            <i class="fas fa-laptop-code fa-3x"
                                style="color:var(--primary-color); margin-bottom:1rem;"></i>
                            <h3>Computer Science</h3>
                            <p>Software development, coding, and algorithms.</p>
                        </div>
                        <div class="course-card">
                            <i class="fas fa-cogs fa-3x" style="color:var(--primary-color); margin-bottom:1rem;"></i>
                            <h3>Mechanical Engineering</h3>
                            <p>Design, manufacturing, and mechanics.</p>
                        </div>
                        <div class="course-card">
                            <i class="fas fa-bolt fa-3x" style="color:var(--primary-color); margin-bottom:1rem;"></i>
                            <h3>Electrical & Electronics</h3>
                            <p>Power systems and electrical innovatons.</p>
                        </div>
                        <div class="course-card">
                            <i class="fas fa-building fa-3x"
                                style="color:var(--primary-color); margin-bottom:1rem;"></i>
                            <h3>Civil Engineering</h3>
                            <p>Infrastructure, construction, and design.</p>
                        </div>
                        <div class="course-card">
                            <i class="fas fa-hammer fa-3x" style="color:var(--primary-color); margin-bottom:1rem;"></i>
                            <h3>Metallurgy</h3>
                            <p>Material science and metal processing.</p>
                        </div>
                    </div>
                </section>

                <!-- Footer / Contact -->
                <footer id="contact">
                    <div class="footer-content">
                        <div class="footer-section">
                            <h4>Contact Us</h4>
                            <div class="contact-info">
                                <p><strong>Sanjay Gandhi Polytechnic (SGP)</strong></p>
                                <p><i class="fas fa-map-marker-alt"></i> Ballari – 583104, Karnataka.</p>
                                <p><i class="fas fa-phone-alt"></i> 08392 266331</p>
                                <p><i class="fas fa-envelope"></i> sgpbellary@gmail.com</p>
                            </div>
                        </div>

                        <div class="footer-section">
                            <h4>Quick Links</h4>
                            <ul>
                                <li><a href="#about"><i class="fas fa-angle-right"></i> About Us</a></li>
                                <li><a href="login.html"><i class="fas fa-angle-right"></i> Portal Login</a></li>
                                <% if (sessionUser !=null) { %>
                                    <li><a href="LogoutServlet"><i class="fas fa-angle-right"></i> Logout</a></li>
                                    <% } %>
                            </ul>
                        </div>
                    </div>
                    <div class="footer-bottom">
                        <p>&copy; 2024 Sanjay Gandhi Polytechnic, Ballari. All Rights Reserved.</p>
                    </div>
                </footer>

                <!-- JavaScript -->
                <script src="js/main.js"></script>
            </body>

            </html>