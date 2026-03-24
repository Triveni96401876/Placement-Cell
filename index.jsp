<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.placementcell.model.*" %>
        <% com.placementcell.model.User sessionUser=(com.placementcell.model.User) session.getAttribute("user"); %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Sanjay Gandhi Polytechnic, Ballari | Placement Cell</title>
                <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
                <link
                    href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <style>
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                    }

                    body {
                        font-family: 'Plus Jakarta Sans', sans-serif;
                        overflow-x: hidden;
                        background: #f8fafc;
                    }

                    /* ========== HEADER ========== */
                    header {
                        background: #ffffff;
                        box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
                        position: sticky;
                        top: 0;
                        z-index: 1000;
                        padding: 0 5%;
                    }

                    .navbar {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        max-width: 1400px;
                        margin: 0 auto;
                        height: 76px;
                    }

                    .logo-container {
                        display: flex;
                        align-items: center;
                        gap: 0.9rem;
                        cursor: pointer;
                        text-decoration: none;
                    }

                    .logo-container img {
                        height: 58px;
                        width: 58px;
                        border-radius: 10px;
                        object-fit: cover;
                    }

                    .logo-text h1 {
                        font-size: 1.85rem;
                        font-weight: 800;
                        color: #003366;
                        line-height: 1;
                        margin: 0;
                        letter-spacing: -0.5px;
                    }

                    .logo-text span {
                        font-size: 0.88rem;
                        color: #64748b;
                        font-weight: 600;
                        letter-spacing: 0.3px;
                    }

                    /* ========== NAV MENU ========== */
                    .nav-menu {
                        display: flex;
                        gap: 0.2rem;
                        align-items: center;
                        list-style: none;
                    }

                    .nav-menu li a {
                        font-size: 0.97rem;
                        font-weight: 600;
                        color: #374151;
                        padding: 0.5rem 0.85rem;
                        border-radius: 6px;
                        text-decoration: none;
                        transition: color 0.2s ease, background 0.2s ease;
                    }

                    .nav-menu li a:hover {
                        color: #003366;
                        background: #f0f4ff;
                    }

                    /* ========== AUTH BUTTONS ========== */
                    .auth-area {
                        display: flex;
                        align-items: center;
                        gap: 0.75rem;
                    }

                    .btn-register {
                        border: 2px solid #003366;
                        color: #003366;
                        background: transparent;
                        padding: 0.55rem 1.5rem;
                        border-radius: 7px;
                        font-weight: 700;
                        font-size: 0.95rem;
                        cursor: pointer;
                        font-family: 'Plus Jakarta Sans', sans-serif;
                        transition: all 0.25s ease;
                    }

                    .btn-register:hover {
                        background: #003366;
                        color: white;
                    }

                    .btn-login {
                        background: #003366;
                        color: white;
                        border: 2px solid #003366;
                        padding: 0.55rem 1.6rem;
                        border-radius: 7px;
                        font-weight: 700;
                        font-size: 0.95rem;
                        cursor: pointer;
                        font-family: 'Plus Jakarta Sans', sans-serif;
                        transition: all 0.25s ease;
                    }

                    .btn-login:hover {
                        background: #00254d;
                        border-color: #00254d;
                    }

                    /* ========== HERO SECTION ========== */
                    .hero {
                        position: relative;
                        min-height: 92vh;
                        background: linear-gradient(rgba(0, 28, 68, 0.68), rgba(0, 28, 68, 0.68)),
                            url('<%=request.getContextPath()%>/images/college_background.jpg');
                        background-size: cover;
                        background-position: center;
                        background-attachment: fixed;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        text-align: center;
                        color: white;
                        padding: 3rem 2rem;
                    }

                    .hero-content {
                        max-width: 1100px;
                        width: 100%;
                    }

                    /* ========== BADGES ========== */
                    .badges-row {
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        gap: 1.5rem;
                        margin-bottom: 2.5rem;
                    }

                    .badge-circle {
                        width: 105px;
                        height: 105px;
                        border-radius: 50%;
                        background: white;
                        border: 4px solid white;
                        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.35);
                        overflow: hidden;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        transition: transform 0.3s ease, box-shadow 0.3s ease;
                        flex-shrink: 0;
                    }

                    .badge-circle:hover {
                        transform: scale(1.08) rotate(4deg);
                        box-shadow: 0 16px 40px rgba(0, 0, 0, 0.4);
                    }

                    .badge-circle img {
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                    }

                    /* ========== HERO TEXT ========== */
                    .hero-title {
                        font-size: clamp(2.4rem, 5.5vw, 5rem);
                        font-weight: 800;
                        line-height: 1.1;
                        margin-bottom: 1rem;
                        letter-spacing: -1.5px;
                        text-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
                        color: #ffffff;
                    }

                    .hero-subtitle {
                        font-size: clamp(1.1rem, 2.5vw, 1.65rem);
                        color: #FFD700;
                        font-weight: 700;
                        margin-bottom: 1.8rem;
                        display: block;
                        letter-spacing: 0.2px;
                    }

                    .hero-description {
                        max-width: 800px;
                        margin: 0 auto 3rem;
                        font-size: 1.15rem;
                        font-weight: 400;
                        line-height: 1.65;
                        color: rgba(255, 255, 255, 0.88);
                    }

                    /* ========== HERO BUTTONS ========== */
                    .hero-buttons {
                        display: flex;
                        justify-content: center;
                        gap: 1.5rem;
                        flex-wrap: wrap;
                    }

                    .btn-hero-primary {
                        background: #002244;
                        color: white;
                        border: 2px solid #002244;
                        padding: 0.9rem 2.8rem;
                        border-radius: 6px;
                        font-weight: 700;
                        font-size: 1.05rem;
                        cursor: pointer;
                        font-family: 'Plus Jakarta Sans', sans-serif;
                        transition: all 0.25s ease;
                        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.25);
                    }

                    .btn-hero-primary:hover {
                        background: #001a38;
                        transform: translateY(-2px);
                        box-shadow: 0 12px 28px rgba(0, 0, 0, 0.35);
                    }

                    .btn-hero-outline {
                        background: transparent;
                        color: white;
                        border: 2px solid white;
                        padding: 0.9rem 2.8rem;
                        border-radius: 6px;
                        font-weight: 700;
                        font-size: 1.05rem;
                        cursor: pointer;
                        font-family: 'Plus Jakarta Sans', sans-serif;
                        transition: all 0.25s ease;
                    }

                    .btn-hero-outline:hover {
                        background: rgba(255, 255, 255, 0.15);
                        transform: translateY(-2px);
                    }

                    /* ========== SECTIONS ========== */
                    section {
                        padding: 4rem 2rem;
                        max-width: 1200px;
                        margin: 0 auto;
                        background: transparent;
                        scroll-margin-top: 80px; /* Offset for sticky header */
                    }

                    .section-title {
                        text-align: center;
                        font-size: 2rem;
                        color: #003366;
                        margin-bottom: 3rem;
                        font-weight: 700;
                        position: relative;
                    }

                    .section-title::after {
                        content: '';
                        display: block;
                        width: 50px;
                        height: 3px;
                        background: #FFD700;
                        margin: 10px auto 0;
                    }

                    /* ========== ABOUT ========== */
                    .about-content {
                        background: #fff;
                        padding: 2.5rem;
                        border-radius: 12px;
                        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.07);
                        text-align: center;
                        line-height: 1.7;
                        font-size: 1.05rem;
                        color: #374151;
                    }

                    /* ========== COURSES ========== */
                    .courses-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                        gap: 2rem;
                    }

                    .course-card {
                        background: #fff;
                        padding: 2rem;
                        border-radius: 12px;
                        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.07);
                        text-align: center;
                        border-top: 4px solid #003366;
                        transition: transform 0.25s ease, box-shadow 0.25s ease;
                        cursor: pointer;
                    }

                    .course-card:hover {
                        transform: translateY(-8px);
                        box-shadow: 0 12px 28px rgba(0, 51, 102, 0.12);
                    }

                    .course-card i {
                        color: #003366;
                        margin-bottom: 1rem;
                    }

                    .course-card h3 {
                        color: #003366;
                        margin-bottom: 0.75rem;
                        font-weight: 700;
                    }

                    /* ========== PLACEMENTS ========== */
                    #placements {
                        background: transparent;
                    }

                    /* ========== FOOTER ========== */
                    footer {
                        background: #003366;
                        color: white;
                        padding: 3rem 2rem 1rem;
                    }

                    .footer-content {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                        gap: 2rem;
                        max-width: 1200px;
                        margin: 0 auto;
                    }

                    .footer-section h4 {
                        margin-bottom: 1.25rem;
                        font-size: 1.1rem;
                        border-bottom: 2px solid rgba(255, 255, 255, 0.2);
                        padding-bottom: 0.5rem;
                        display: inline-block;
                    }

                    .footer-section ul {
                        list-style: none;
                    }

                    .footer-section ul li {
                        margin-bottom: 0.5rem;
                    }

                    .footer-section ul li a {
                        color: rgba(255, 255, 255, 0.8);
                        text-decoration: none;
                        transition: color 0.2s;
                    }

                    .footer-section ul li a:hover {
                        color: #FFD700;
                    }

                    .contact-info p {
                        margin-bottom: 0.5rem;
                        display: flex;
                        align-items: center;
                        gap: 0.6rem;
                        font-size: 0.95rem;
                        color: rgba(255, 255, 255, 0.85);
                    }

                    .footer-bottom {
                        text-align: center;
                        margin-top: 2.5rem;
                        padding-top: 1rem;
                        border-top: 1px solid rgba(255, 255, 255, 0.12);
                        font-size: 0.9rem;
                        color: rgba(255, 255, 255, 0.65);
                    }

                    /* ========== FAB BUTTON ========== */
                    .fab-notify {
                        position: fixed;
                        bottom: 36px;
                        right: 36px;
                        width: 64px;
                        height: 64px;
                        background: #003366;
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        color: white;
                        font-size: 1.6rem;
                        box-shadow: 0 8px 28px rgba(0, 51, 102, 0.4);
                        cursor: pointer;
                        z-index: 9999;
                        transition: all 0.3s ease;
                        animation: pulse 2.5s infinite;
                    }

                    .fab-notify:hover {
                        transform: scale(1.1);
                        background: #0056b3;
                    }

                    .fab-badge {
                        position: absolute;
                        top: 1px;
                        right: 1px;
                        background: #ff4757;
                        width: 22px;
                        height: 22px;
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 0.75rem;
                        font-weight: 800;
                        border: 2.5px solid white;
                        color: white;
                    }

                    @keyframes pulse {
                        0% {
                            box-shadow: 0 0 0 0 rgba(0, 51, 102, 0.45);
                        }

                        70% {
                            box-shadow: 0 0 0 14px rgba(0, 51, 102, 0);
                        }

                        100% {
                            box-shadow: 0 0 0 0 rgba(0, 51, 102, 0);
                        }
                    }

                    /* ========== MODAL ========== */
                    .modal-overlay {
                        position: fixed;
                        inset: 0;
                        background: rgba(0, 0, 0, 0.5);
                        backdrop-filter: blur(3px);
                        z-index: 10001;
                        opacity: 0;
                        visibility: hidden;
                        transition: all 0.3s ease;
                    }

                    .modal-overlay.active {
                        opacity: 1;
                        visibility: visible;
                    }

                    .circular-modal {
                        position: fixed;
                        top: 50%;
                        left: 50%;
                        transform: translate(-50%, -50%) scale(0.75);
                        width: 90%;
                        max-width: 500px;
                        background: white;
                        border-radius: 18px;
                        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.25);
                        z-index: 10002;
                        padding: 2rem;
                        opacity: 0;
                        visibility: hidden;
                        transition: all 0.4s cubic-bezier(0.68, -0.55, 0.265, 1.55);
                    }

                    .circular-modal.active {
                        transform: translate(-50%, -50%) scale(1);
                        opacity: 1;
                        visibility: visible;
                    }

                    .circular-modal-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 1.25rem;
                        border-bottom: 2px solid #f1f5f9;
                        padding-bottom: 0.85rem;
                    }

                    .circular-modal-header h3 {
                        color: #003366;
                        font-weight: 700;
                        display: flex;
                        align-items: center;
                        gap: 0.5rem;
                    }

                    .close-modal {
                        cursor: pointer;
                        font-size: 1.6rem;
                        color: #94a3b8;
                        line-height: 1;
                        transition: color 0.2s;
                    }

                    .close-modal:hover {
                        color: #003366;
                    }

                    .circular-content {
                        color: #4b5563;
                        font-size: 1.05rem;
                        line-height: 1.65;
                        background: #f8fafc;
                        padding: 1.25rem;
                        border-radius: 10px;
                        border-left: 4px solid #003366;
                    }

                    /* ========== HAMBURGER ========== */
                    .hamburger {
                        display: none;
                        cursor: pointer;
                        flex-direction: column;
                        gap: 5px;
                    }

                    .bar {
                        width: 26px;
                        height: 3px;
                        background: #003366;
                        border-radius: 2px;
                        transition: all 0.25s ease;
                    }

                    /* ========== RESPONSIVE ========== */
                    @media (max-width: 900px) {
                        .nav-menu {
                            display: none;
                            position: fixed;
                            top: 76px;
                            left: 0;
                            right: 0;
                            background: white;
                            flex-direction: column;
                            padding: 1.5rem;
                            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
                            gap: 0.25rem;
                        }

                        .nav-menu.active {
                            display: flex;
                        }

                        .auth-area {
                            display: none;
                        }

                        .hamburger {
                            display: flex;
                        }

                        .hero-title {
                            letter-spacing: -0.5px;
                        }

                        .badges-row {
                            gap: 1rem;
                        }

                        .badge-circle {
                            width: 80px;
                            height: 80px;
                        }
                    }
                </style>
            </head>

            <body>

                <!-- ====== HEADER ====== -->
                <header>
                    <nav class="navbar">
                        <!-- Logo -->
                        <a class="logo-container" href="<%=request.getContextPath()%>/index.jsp">
                            <img src="<%=request.getContextPath()%>/images/sgp1.jpeg" alt="SGP Logo">
                            <div class="logo-text">
                                <h1>SGP</h1>
                                <span>Ballari</span>
                            </div>
                        </a>

                        <!-- Nav Links -->
                        <ul class="nav-menu" id="navMenu">
                            <li><a href="#home">Home</a></li>
                            <li><a href="#about">About</a></li>
                            <li><a href="#courses">Courses</a></li>
                            <li><a href="#placements">Placements</a></li>
                            <li><a href="#contact">Contact</a></li>
                        </ul>

                        <!-- Auth Buttons -->
                        <div class="auth-area">
                            <% if (sessionUser !=null) { %>
                                <button class="btn-login"
                                    onclick="window.location.href='<%=request.getContextPath()%>/LogoutServlet'">Logout</button>
                                <% } else { %>
                                    <button class="btn-login"
                                        onclick="window.location.href='<%=request.getContextPath()%>/student/login.jsp'">Login</button>
                                    <% } %>
                        </div>

                        <!-- Hamburger -->
                        <div class="hamburger" id="hamburger" onclick="toggleMenu()">
                            <span class="bar"></span>
                            <span class="bar"></span>
                            <span class="bar"></span>
                        </div>
                    </nav>
                </header>

                <!-- ====== HERO SECTION ====== -->
                <section id="home" class="hero">
                    <div class="hero-content">

                        <!-- Three Circular Badges (NBA, Anniversary, Founder) -->
                        <div class="badges-row">
                            <div class="badge-circle">
                                <img src="<%=request.getContextPath()%>/images/top-banner.png" alt="NBA Accreditation"
                                    style="width:100%; height:100%; object-fit:cover; object-position: left center;">
                            </div>
                            <div class="badge-circle" style="background: #1a1a1a; border-color: #FFD700;">
                                <div style="text-align:center; padding: 8px;">
                                    <div style="font-size: 2rem; font-weight: 900; color: #FFD700; line-height:1;">30
                                    </div>
                                    <div
                                        style="font-size: 0.45rem; color: white; letter-spacing: 1px; text-transform: uppercase; font-weight: 700;">
                                        Anniversary</div>
                                </div>
                            </div>
                            <div class="badge-circle">
                                <img src="<%=request.getContextPath()%>/images/top-banner.png" alt="Founder"
                                    style="width:100%; height:100%; object-fit:cover; object-position: right center;">
                            </div>
                        </div>

                        <!-- Main Heading -->
                        <h1 class="hero-title">Welcome to Sanjay Gandhi<br>Polytechnic, Ballari</h1>

                        <!-- Gold Subtitle -->
                        <span class="hero-subtitle">Empowering Technical Education Since 1991</span>

                        <!-- Description -->
                        <p class="hero-description">
                            Sanjay Gandhi Polytechnic (SGP), Ballari, is a premier private co-educational
                            institution committed to quality technical education and skill-based learning.
                        </p>

                        <!-- CTA Buttons -->
                        <div class="hero-buttons">
                            <button class="btn-hero-primary"
                                onclick="document.getElementById('courses').scrollIntoView({behavior:'smooth'})">
                                Explore Courses
                            </button>
                            <button class="btn-hero-outline"
                                onclick="document.getElementById('contact').scrollIntoView({behavior:'smooth'})">
                                Contact Us
                            </button>
                        </div>
                    </div>
                </section>

                <!-- ====== FLOATING NOTIFICATION BUTTON ====== -->
                <div class="fab-notify" onclick="toggleModal()">
                    <i class="fas fa-bullhorn"></i>
                    <div class="fab-badge">1</div>
                </div>

                <!-- ====== ABOUT SECTION ====== -->
                <section id="about">
                    <h2 class="section-title">About SGP</h2>
                    <div class="about-content">
                        <p>Sanjay Gandhi Polytechnic (SGP), Ballari, was established in 1991 as the first premier
                            private
                            co-educational polytechnic in the region.</p>
                        <br>
                        <p>The institute is recognized by the Government of Karnataka, approved by AICTE, New Delhi, and
                            affiliated with the Directorate of Technical Education (DTE), Bengaluru.</p>
                        <br>
                        <p>SGP focuses on academic excellence, practical exposure, and overall student development.</p>
                    </div>
                </section>

                <!-- ====== COURSES SECTION ====== -->
                <section id="courses">
                    <h2 class="section-title">Our Courses</h2>
                    <div class="courses-grid">
                        <div class="course-card" onclick="openCourseModal('Electronics &amp; Communication', 'Advanced circuitry, communication systems, signal processing and microprocessors. Our E&amp;C department focuses on preparing students for the rapidly evolving tech industry.')">
                            <i class="fas fa-microchip fa-3x"></i>
                            <h3>Electronics &amp; Communication</h3>
                            <p>Advanced circuitry and communication systems.</p>
                        </div>
                        <div class="course-card" onclick="openCourseModal('Civil Engineering', 'Infrastructure, construction, structural design, and urban planning. SGP Civil Engineering department provides hands-on survey training and latest design software exposure.')">
                            <i class="fas fa-hard-hat fa-3x"></i>
                            <h3>Civil Engineering</h3>
                            <p>Infrastructure, construction and design.</p>
                        </div>
                        <div class="course-card" onclick="openCourseModal('Mechanical Engineering', 'The Mother of Engineering! This branch deals with design, manufacturing, and mechanics of machines, engines, and thermodynamic systems.')">
                            <i class="fas fa-cogs fa-3x"></i>
                            <h3>Mechanical Engineering</h3>
                            <p>Design, manufacturing, and mechanics.</p>
                        </div>
                        <div class="course-card" onclick="openCourseModal('Electrical &amp; Electronics', 'Focuses on power generation, distribution, and automation. Students learn about microcomputers, sensors, and intelligent machines.')">
                            <i class="fas fa-bolt fa-3x"></i>
                            <h3>Electrical &amp; Electronics</h3>
                            <p>Power systems and electrical innovations.</p>
                        </div>
                        <div class="course-card" onclick="openCourseModal('Computer Science', 'Software development, coding, and algorithms. This is one of our most popular courses with excellent placement track records in top MNCS.')">
                            <i class="fas fa-laptop-code fa-3x"></i>
                            <h3>Computer Science</h3>
                            <p>Software development, coding, and algorithms.</p>
                        </div>
                        <div class="course-card" onclick="openCourseModal('Metallurgy', 'The study of physical and chemical behavior of metallic elements. Metallurgy is a specialized field with huge demand in steel and mining industries.')">
                            <i class="fas fa-hammer fa-3x"></i>
                            <h3>Metallurgy</h3>
                            <p>Material science and metal processing.</p>
                        </div>
                    </div>
                </section>

                <!-- ====== PLACEMENTS SECTION ====== -->
                <section id="placements">
                    <h2 class="section-title">Training &amp; Placements</h2>
                    <div class="about-content" style="max-width:1000px; margin:0 auto; text-align:left;">
                        <p style="text-align:center; margin-bottom:2rem;">SGP has a strong placement record with
                            students placed
                            in reputed MNCs across Karnataka. Career guidance and placement training are provided to all
                            students.</p>

                        <div
                            style="display:flex; flex-wrap:wrap; gap:2rem; align-items:flex-start; margin-bottom:2rem;">
                            <div style="flex:0 0 auto; width:220px; text-align:center;">
                                <img src="<%=request.getContextPath()%>/images/Nayeembasha.jpeg"
                                    alt="Mr. K. Nayeem Basha"
                                    style="width:100%; border-radius:10px; box-shadow:0 4px 12px rgba(0,0,0,0.12); object-fit:cover;">
                            </div>
                            <div style="flex:1; min-width:240px;">
                                <h3
                                    style="color:#003366; margin-bottom:0.75rem; border-bottom:2px solid #eee; padding-bottom:0.5rem;">
                                    Placement Officer Message</h3>
                                <h4 style="font-size:1.15rem; margin-bottom:0.2rem;">Mr. K. Nayeem Basha
                                    <span style="font-size:0.95rem; font-weight:400; color:#666;">(MBA)</span>
                                </h4>
                                <div style="margin:0.9rem 0 1.25rem;">
                                    <p style="margin-bottom:0.4rem; display:flex; align-items:center; gap:0.5rem;">
                                        <i class="fas fa-phone-alt" style="color:#003366; width:16px;"></i> 9742815857
                                    </p>
                                    <p style="display:flex; align-items:center; gap:0.5rem;">
                                        <i class="fas fa-envelope" style="color:#003366; width:16px;"></i>
                                        sgpplacement@gmail.com
                                    </p>
                                </div>
                                <p style="font-weight:600; font-size:1.05rem; margin-bottom:0.85rem; color:#003366;">
                                    Welcome to the Training &amp; Placement Cell!</p>
                                <p style="margin-bottom:0.85rem; line-height:1.65;">Training and placement cell provides
                                    a platform to
                                    the students on a professional front for exposure &amp; placement in industries and
                                    various companies.
                                    Various reputed companies conduct campus drives to hire talented diploma graduates.
                                </p>
                                <p style="line-height:1.65;">The Centre provides pre-placement training in soft skills,
                                    CV Writing,
                                    Aptitude Assessment, Mock interviews, and Group Discussion.</p>
                            </div>
                        </div>

                        <div
                            style="background:rgba(0,51,102,0.05); padding:1.25rem; border-radius:8px; margin-bottom:1.5rem; text-align:center; border-left:4px solid #003366;">
                            <p><strong>Recruiters:</strong> JSW, L&amp;T, TATA Motors etc. &nbsp;|&nbsp;
                                <strong>Impact:</strong> 250+ students placed every year.
                            </p>
                        </div>

                        <div style="text-align:center;">
                            <h3 style="color:#003366; margin-bottom:1rem;">Core Values</h3>
                            <div style="display:flex; justify-content:center; gap:0.8rem; flex-wrap:wrap;">
                                <span
                                    style="background:#003366; color:white; padding:0.45rem 1.1rem; border-radius:20px; font-weight:600;">Commitment</span>
                                <span
                                    style="background:#003366; color:white; padding:0.45rem 1.1rem; border-radius:20px; font-weight:600;">Equity</span>
                                <span
                                    style="background:#003366; color:white; padding:0.45rem 1.1rem; border-radius:20px; font-weight:600;">Team
                                    Spirit</span>
                                <span
                                    style="background:#003366; color:white; padding:0.45rem 1.1rem; border-radius:20px; font-weight:600;">Transparency</span>
                                <span
                                    style="background:#003366; color:white; padding:0.45rem 1.1rem; border-radius:20px; font-weight:600;">Quality</span>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- ====== FOOTER / CONTACT ====== -->
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
                                <li><a href="#courses"><i class="fas fa-angle-right"></i> Courses</a></li>
                                <li><a href="#placements"><i class="fas fa-angle-right"></i> Placements</a></li>
                                <li><a href="<%=request.getContextPath()%>/student/login.jsp"><i
                                            class="fas fa-angle-right"></i> Portal Login</a></li>
                                <% if (sessionUser !=null) { %>
                                    <li><a href="<%=request.getContextPath()%>/LogoutServlet"><i
                                                class="fas fa-angle-right"></i> Logout</a></li>
                                    <% } %>
                            </ul>
                        </div>
                    </div>
                    <div class="footer-bottom">
                        <p>&copy; 2024 Sanjay Gandhi Polytechnic, Ballari. All Rights Reserved.</p>
                    </div>
                </footer>

                <!-- ====== MODAL ====== -->
                <div class="modal-overlay" id="modalOverlay" onclick="closeAllModals()"></div>
                <div class="circular-modal" id="circularModal">
                    <div class="circular-modal-header">
                        <h3><i class="fas fa-bullhorn"></i> Latest Announcement</h3>
                        <span class="close-modal" onclick="toggleModal()">&times;</span>
                    </div>
                    <div class="circular-content" id="circularDynamicContent">
                        <p><strong>Loading latest update...</strong></p>
                    </div>
                </div>

                <!-- Course Detail Modal -->
                <div class="circular-modal" id="courseModal">
                    <div class="circular-modal-header">
                        <h3 id="courseModalTitle"><i class="fas fa-book-open"></i> Course Details</h3>
                        <span class="close-modal" onclick="closeCourseModal()">&times;</span>
                    </div>
                    <div class="circular-content">
                        <p id="courseModalDesc"></p>
                    </div>
                </div>

                <!-- ====== SCRIPTS ====== -->
                <script>
                    function toggleModal() {
                        document.getElementById('circularModal').classList.toggle('active');
                        document.getElementById('modalOverlay').classList.toggle('active');
                    }

                    function closeAllModals() {
                        document.getElementById('circularModal').classList.remove('active');
                        document.getElementById('courseModal').classList.remove('active');
                        document.getElementById('modalOverlay').classList.remove('active');
                    }

                    function toggleMenu() {
                        document.getElementById('navMenu').classList.toggle('active');
                    }

                    function openCourseModal(title, desc) {
                        document.getElementById('courseModalTitle').innerHTML = '<i class="fas fa-book-open"></i> ' + title;
                        document.getElementById('courseModalDesc').innerText = desc;
                        document.getElementById('courseModal').classList.add('active');
                        document.getElementById('modalOverlay').classList.add('active');
                    }

                    function closeCourseModal() {
                        closeAllModals();
                    }

                    // Fetch and show latest announcement (from list)
                    function fetchCircular() {
                        fetch('<%=request.getContextPath()%>/GetCircularServlet')
                            .then(response => response.json())
                            .then(data => {
                                if (data.status === 'success' && data.circulars && data.circulars.length > 0) {
                                    // We show the latest one (first in list)
                                    const latest = data.circulars[0];
                                    const container = document.getElementById('circularDynamicContent');
                                    
                                    let html = '<p><strong>' + (latest.title || 'Important Update') + '</strong></p>';
                                    html += '<p style="margin-top: 10px; line-height: 1.6;">' + latest.message.replace(/\n/g, '<br>') + '</p>';
                                    
                                    if (latest.filePath && latest.filePath.trim() !== '') {
                                        html += '<hr style="margin:1rem 0; border:none; border-top:1px solid #eee;">';
                                        html += '<a href="' + latest.filePath + '" target="_blank" style="display:inline-flex; align-items:center; gap:8px; background:#003366; color:white; padding:8px 20px; border-radius:50px; text-decoration:none; font-weight:700; font-size:0.85rem; margin-top:5px;">';
                                        html += '<i class="fas fa-file-pdf"></i> View Attachment</a>';
                                    }
                                    
                                    container.innerHTML = html;
                                    
                                    // Optionally auto-open the modal on load
                                    setTimeout(toggleModal, 1000);
                                } else {
                                    document.getElementById('circularDynamicContent').innerHTML = '<p>No new announcements at this moment. Stay tuned!</p>';
                                }
                            })
                            .catch(err => {
                                console.error('Error fetching announcement:', err);
                                document.getElementById('circularDynamicContent').innerHTML = '<p>Follow our placement cell for latest updates.</p>';
                            });
                    }

                    // Auto-load on page start
                    window.addEventListener('DOMContentLoaded', fetchCircular);

                    // Smooth scroll for anchor links
                    document.querySelectorAll('a[href^="#"]').forEach(link => {
                        link.addEventListener('click', function (e) {
                            const target = document.querySelector(this.getAttribute('href'));
                            if (target) {
                                e.preventDefault();
                                target.scrollIntoView({ behavior: 'smooth' });
                                
                                // Close mobile menu if open
                                document.getElementById('navMenu').classList.remove('active');
                            }
                        });
                    });
                </script>
            </body>

            </html>