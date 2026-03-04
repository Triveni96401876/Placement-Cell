<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.placementcell.model.Student" %>
        <% Student student=(Student) request.getAttribute("studentData"); if (student==null) {
            response.sendRedirect("login.jsp"); return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Dashboard | SGP Placement Cell</title>
                <!-- Google Fonts -->
                <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
                    rel="stylesheet">
                <!-- Font Awesome -->
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

                <style>
                    :root {
                        --primary-blue: #00b4ff;
                        --sidebar-text: #6b7280;
                        --bg-color: #f8f9fa;
                        --white: #ffffff;
                        --text-dark: #1e293b;
                    }

                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                        font-family: 'Poppins', sans-serif;
                    }

                    body {
                        background-color: var(--bg-color);
                        display: flex;
                        height: 100vh;
                        overflow: hidden;
                        flex-direction: column;
                    }

                    /* Top Header */
                    .top-navbar {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        padding: 0 2rem;
                        background: var(--white);
                        height: 70px;
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.03);
                        z-index: 1000;
                    }

                    .top-navbar .logo-area {
                        display: flex;
                        align-items: center;
                        gap: 15px;
                    }

                    .top-navbar .logo-area img {
                        height: 40px;
                        border-radius: 8px;
                    }

                    .top-navbar .logo-area span {
                        font-weight: 700;
                        color: #0088cc;
                        font-size: 1.1rem;
                        letter-spacing: 0.5px;
                    }

                    .top-navbar .user-area {
                        display: flex;
                        align-items: center;
                        gap: 20px;
                    }

                    .top-navbar .user-area span {
                        font-weight: 500;
                        color: #4a5568;
                        font-size: 0.95rem;
                    }

                    .btn-logout {
                        background-color: #00b4ff;
                        color: var(--white);
                        border: none;
                        padding: 8px 24px;
                        border-radius: 20px;
                        font-weight: 600;
                        font-size: 0.95rem;
                        text-decoration: none;
                        transition: 0.3s;
                        box-shadow: 0 4px 10px rgba(0, 180, 255, 0.2);
                    }

                    .btn-logout:hover {
                        opacity: 0.9;
                        transform: translateY(-2px);
                    }

                    /* Main Container layout */
                    .main-container {
                        display: flex;
                        flex: 1;
                        overflow: hidden;
                    }

                    /* Sidebar */
                    .sidebar {
                        width: 250px;
                        background: var(--white);
                        border-right: 1px solid #edf2f7;
                        display: flex;
                        flex-direction: column;
                        padding-top: 2rem;
                    }

                    .sidebar-brand {
                        display: flex;
                        align-items: center;
                        gap: 15px;
                        padding: 0 1.5rem 2.5rem 1.5rem;
                    }

                    .sidebar-brand img {
                        height: 45px;
                        border-radius: 8px;
                        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                    }

                    .sidebar-brand span {
                        font-weight: 800;
                        color: #1e293b;
                        font-size: 0.85rem;
                        line-height: 1.2;
                    }

                    .nav-links {
                        list-style: none;
                        padding: 0 1rem;
                    }

                    .nav-links li {
                        margin-bottom: 5px;
                    }

                    .nav-links li a {
                        display: flex;
                        align-items: center;
                        gap: 15px;
                        padding: 12px 20px;
                        color: var(--sidebar-text);
                        text-decoration: none;
                        font-weight: 600;
                        font-size: 0.95rem;
                        border-radius: 12px;
                        transition: 0.3s;
                    }

                    .nav-links li.active a {
                        background-color: #00b4ff;
                        color: var(--white);
                        box-shadow: 0 4px 15px rgba(0, 180, 255, 0.2);
                    }

                    .nav-links li a:hover:not(.active) {
                        background-color: #f8fafc;
                        color: var(--text-dark);
                    }

                    .nav-links li i {
                        font-size: 1.1rem;
                        width: 20px;
                    }

                    /* Content Area */
                    .content-area {
                        flex: 1;
                        padding: 3rem;
                        overflow-y: auto;
                        background: var(--bg-color);
                    }

                    .greeting {
                        color: #00a8ff;
                        font-size: 2.2rem;
                        font-weight: 800;
                        margin-bottom: 2.5rem;
                        letter-spacing: -0.5px;
                    }

                    .cards-container {
                        display: grid;
                        grid-template-columns: repeat(2, 1fr);
                        gap: 2rem;
                        max-width: 900px;
                    }

                    .action-card {
                        background: var(--white);
                        border-radius: 20px;
                        padding: 50px 20px;
                        text-align: center;
                        text-decoration: none;
                        color: var(--text-dark);
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.02);
                        transition: 0.3s;
                        display: flex;
                        flex-direction: column;
                        align-items: center;
                        justify-content: center;
                        gap: 20px;
                        border-bottom: 4px solid #f0f4ff;
                        position: relative;
                        overflow: hidden;
                    }

                    .action-card:hover {
                        transform: translateY(-5px);
                        box-shadow: 0 15px 35px rgba(0, 168, 255, 0.1);
                        border-bottom-color: #00b4ff;
                    }

                    /* Subtle bottom gradient shadow effect as per design */
                    .action-card::after {
                        content: '';
                        position: absolute;
                        bottom: 0;
                        left: 0;
                        width: 100%;
                        height: 10px;
                        background: linear-gradient(to right, #00b4ff, #00d2ff);
                        opacity: 0.7;
                        transform: scaleY(0);
                        transform-origin: bottom;
                        transition: transform 0.3s ease;
                        border-radius: 0 0 20px 20px;
                    }

                    .action-card:hover::after {
                        transform: scaleY(1);
                    }

                    .action-card i {
                        color: #00b4ff;
                        font-size: 3rem;
                    }

                    .action-card span {
                        font-weight: 700;
                        font-size: 1.15rem;
                        color: #1e293b;
                    }

                    /* About SGP Styles */
                    .content-card {
                        background: var(--white);
                        border-radius: 20px;
                        padding: 40px;
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.02);
                        margin-top: 2rem;
                        margin-bottom: 2rem;
                        max-width: 900px;
                    }

                    .section-title {
                        color: var(--text-dark);
                        font-size: 1.8rem;
                        margin-bottom: 20px;
                        border-bottom: 2px solid #edf2f7;
                        padding-bottom: 10px;
                    }

                    .content-card p {
                        color: #4a5568;
                        line-height: 1.8;
                        margin-bottom: 15px;
                        font-size: 1.05rem;
                    }

                    .courses-grid {
                        display: grid;
                        grid-template-columns: repeat(2, 1fr);
                        gap: 20px;
                        margin-top: 20px;
                    }

                    .course-card {
                        background: #f8fafc;
                        padding: 20px;
                        border-radius: 15px;
                        text-align: center;
                        border: 1px solid #e2e8f0;
                        transition: 0.3s;
                    }

                    .course-card:hover {
                        border-color: #00b4ff;
                        transform: translateY(-5px);
                        box-shadow: 0 10px 20px rgba(0, 180, 255, 0.1);
                    }

                    .course-card h3 {
                        color: var(--text-dark);
                        margin: 10px 0;
                        font-size: 1.1rem;
                    }

                    .course-card p {
                        font-size: 0.9rem;
                        color: #64748b;
                        margin: 0;
                    }

                    /* Circular Modal Styles */
                    .circular-modal {
                        display: none;
                        position: fixed;
                        top: 0;
                        left: 0;
                        width: 100%;
                        height: 100%;
                        background: rgba(15, 23, 42, 0.5);
                        backdrop-filter: blur(8px);
                        z-index: 2000;
                        align-items: center;
                        justify-content: center;
                        padding: 24px;
                    }

                    .circular-card {
                        background: white;
                        width: 100%;
                        max-width: 500px;
                        border-radius: 32px;
                        padding: 40px;
                        text-align: center;
                        box-shadow: 0 32px 64px -12px rgba(0, 0, 0, 0.14);
                        animation: modalIn 0.4s cubic-bezier(0.34, 1.56, 0.64, 1) forwards;
                        position: relative;
                    }

                    @keyframes modalIn {
                        from {
                            transform: scale(0.9);
                            opacity: 0;
                        }

                        to {
                            transform: scale(1);
                            opacity: 1;
                        }
                    }

                    .circular-icon-box {
                        width: 80px;
                        height: 80px;
                        background: rgba(92, 103, 242, 0.1);
                        color: #5c67f2;
                        border-radius: 24px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 2.5rem;
                        margin: 0 auto 24px;
                    }

                    #circularTitle {
                        font-size: 1.5rem;
                        font-weight: 800;
                        color: #1e293b;
                        margin-bottom: 12px;
                    }

                    #circularText {
                        color: #64748b;
                        font-size: 1.05rem;
                        line-height: 1.7;
                        margin-bottom: 32px;
                    }

                    .btn-attachment {
                        display: inline-flex;
                        align-items: center;
                        gap: 12px;
                        padding: 14px 24px;
                        background: #f8fafc;
                        border: 2px solid #5c67f2;
                        border-radius: 16px;
                        text-decoration: none;
                        color: #5c67f2;
                        font-weight: 700;
                        margin-bottom: 24px;
                        transition: all 0.2s;
                        width: 100%;
                        justify-content: center;
                    }

                    .btn-attachment:hover {
                        background: #5c67f2;
                        color: white;
                    }

                    .btn-got-it {
                        width: 100%;
                        padding: 16px;
                        background: #1e293b;
                        color: white;
                        border: none;
                        border-radius: 16px;
                        font-weight: 700;
                        font-size: 1rem;
                        cursor: pointer;
                        transition: all 0.2s;
                    }

                    .btn-got-it:hover {
                        background: #0f172a;
                        transform: translateY(-2px);
                    }
                </style>
            </head>

            <body>

                <!-- Top Navbar -->
                <header class="top-navbar">
                    <div class="logo-area">
                        <img src="../assets/images/sgp1.jpeg" alt="Logo" onerror="this.src='images/sgp1.jpeg'">
                        <span>SGP PLACEMENT CELL</span>
                    </div>
                    <div class="user-area">
                        <span>Welcome, <%= student.getWelcomeName().toUpperCase() %></span>
                        <a href="LogoutServlet" class="btn-logout">Logout</a>
                    </div>
                </header>

                <!-- Main Container -->
                <div class="main-container">
                    <!-- Sidebar -->
                    <aside class="sidebar">
                        <div class="sidebar-brand">
                            <img src="../assets/images/sgp1.jpeg" alt="SGP Logo" onerror="this.src='images/sgp1.jpeg'">
                            <span>SGP<br>PLACEMENT<br>CELL</span>
                        </div>
                        <ul class="nav-links">
                            <li class="active">
                                <a href="DashboardServlet"><i class="fas fa-th-large"></i> Dashboard</a>
                            </li>
                            <li>
                                <a href="profile.jsp"><i class="fas fa-user-circle"></i> Account</a>
                            </li>
                            <li>
                                <a href="about-sgp.jsp"><i class="fas fa-university"></i> About SGP</a>
                            </li>
                            <li style="margin-top: 20px;">
                                <a href="javascript:void(0)" onclick="checkCirculars(true)"
                                    style="background: rgba(92, 103, 242, 0.05); color: #5c67f2; border: 1.5px solid rgba(92, 103, 242, 0.1);">
                                    <i class="fas fa-bullhorn"></i> View Circulars
                                </a>
                            </li>
                        </ul>
                    </aside>

                    <!-- Content Area -->
                    <main class="content-area">
                        <h1 class="greeting">Hello, <%= student.getWelcomeName().toUpperCase() %> !</h1>

                        <div class="cards-container">
                            <a href="profile.jsp" class="action-card">
                                <i class="fas fa-id-card"></i>
                                <span>View Profile</span>
                            </a>

                            <a href="ResumeServlet" class="action-card">
                                <i class="fas fa-file-alt"></i>
                                <span>Resume Update</span>
                            </a>

                        </div>

                        <!-- Inline About SGP Content -->
                        <div class="content-card">
                            <h2 class="section-title">About Sanjay Gandhi Polytechnic</h2>
                            <div style="display: flex; gap: 30px; align-items: flex-start;">
                                <img src="../assets/images/sgp1.jpeg" alt="SGP Logo"
                                    style="width: 150px; border-radius: 15px; box-shadow: 0 5px 15px rgba(0,0,0,0.1);"
                                    onerror="this.src='images/sgp1.jpeg'">
                                <div>
                                    <p>Sanjay Gandhi Polytechnic (SGP), Ballari, was established in 1991 as the first
                                        premier private co-educational polytechnic.</p>
                                    <p>The institute is recognized by the Government of Karnataka, approved by AICTE,
                                        New Delhi, and affiliated with the Directorate of Technical Education (DTE),
                                        Bengaluru.</p>
                                    <p>SGP focuses on academic excellence, practical exposure, and overall student
                                        development.</p>
                                </div>
                            </div>
                        </div>

                        <div class="content-card">
                            <h2 class="section-title">Our Technical Courses</h2>
                            <div class="courses-grid">
                                <div class="course-card">
                                    <i class="fas fa-microchip fa-3x"
                                        style="color:var(--primary-blue); margin-bottom:1rem;"></i>
                                    <h3>Electronics & Communication</h3>
                                    <p>Advanced circuitry and communication systems.</p>
                                </div>
                                <div class="course-card">
                                    <i class="fas fa-laptop-code fa-3x"
                                        style="color:var(--primary-blue); margin-bottom:1rem;"></i>
                                    <h3>Computer Science</h3>
                                    <p>Software development, coding, and algorithms.</p>
                                </div>
                                <div class="course-card">
                                    <i class="fas fa-cogs fa-3x"
                                        style="color:var(--primary-blue); margin-bottom:1rem;"></i>
                                    <h3>Mechanical Engineering</h3>
                                    <p>Design, manufacturing, and mechanics.</p>
                                </div>
                                <div class="course-card">
                                    <i class="fas fa-bolt fa-3x"
                                        style="color:var(--primary-blue); margin-bottom:1rem;"></i>
                                    <h3>Electrical & Electronics</h3>
                                    <p>Power systems and electrical innovations.</p>
                                </div>
                                <div class="course-card">
                                    <i class="fas fa-building fa-3x"
                                        style="color:var(--primary-blue); margin-bottom:1rem;"></i>
                                    <h3>Civil Engineering</h3>
                                    <p>Infrastructure, construction, and design.</p>
                                </div>
                                <div class="course-card">
                                    <i class="fas fa-hammer fa-3x"
                                        style="color:var(--primary-blue); margin-bottom:1rem;"></i>
                                    <h3>Metallurgy</h3>
                                    <p>Material science and metal processing.</p>
                                </div>
                            </div>
                        </div>

                        <div class="content-card">
                            <h2 class="section-title">Training & Placements</h2>
                            <p>SGP has a strong placement record with students placed in reputed MNCs across Karnataka.
                                Career guidance and placement training are provided to all students.</p>
                            <div
                                style="background: #f8fafc; padding: 25px; border-radius: 15px; margin-top: 20px; border-left: 5px solid var(--primary-blue);">
                                <h3 style="color: var(--text-dark); margin-bottom: 15px;"><i
                                        class="fas fa-briefcase"></i> Training & Placement Cell</h3>
                                <p style="margin-bottom: 10px;">The Centre provides pre-placement training in soft
                                    skills, CV Writing, Aptitude Assessment, Mock interviews, and Group Discussion.</p>
                                <p style="margin-bottom: 10px;"><strong>Top Recruiters:</strong> JSW, L&T, TATA Motors,
                                    TVS Upasana etc.</p>
                                <p><strong>Impact:</strong> Over 250+ students placed every year in successful careers.
                                </p>
                                <div style="margin-top: 20px; font-weight: 500; color: #1e293b;">
                                    <p><i class="fas fa-user-tie"></i> Mr. K. Nayeem Basha (Placement Officer)</p>
                                    <p><i class="fas fa-envelope"></i> sgpplacement@gmail.com | <i
                                            class="fas fa-phone"></i> 9742815857</p>
                                </div>
                            </div>
                        </div>



                    </main>
                </div>

                <!-- Circular Modal Container -->
                <div id="circularModal" class="circular-modal">
                    <div class="circular-card">
                        <div class="circular-icon-box"><i class="fas fa-bullhorn"></i></div>
                        <h3 id="circularTitle">Circular Update</h3>
                        <p id="circularText"></p>
                        <div id="circularFileSection" style="display: none;">
                            <a id="circularFileLink" href="#" target="_blank" class="btn-attachment">
                                <i class="fas fa-file-pdf"></i>
                                <span>View Attachment</span>
                            </a>
                        </div>
                        <button class="btn-got-it" onclick="closeCircular()">Got it, Thanks!</button>
                    </div>
                </div>

                <script>
                    function checkCirculars(isManual = false) {
                        fetch('GetCircularServlet')
                            .then(response => response.json())
                            .then(data => {
                                if (data.status === 'success') {
                                    document.getElementById('circularTitle').innerText = data.title || 'Important Update';
                                    document.getElementById('circularText').innerHTML = data.message ? data.message.replace(/\n/g, '<br>') : '';
                                    const fileSection = document.getElementById('circularFileSection');
                                    const fileLink = document.getElementById('circularFileLink');

                                    if (data.filePath && data.filePath.trim() !== '') {
                                        fileLink.href = data.filePath;
                                        fileSection.style.display = 'block';

                                        const ext = data.filePath.split('.').pop().toLowerCase();
                                        const icon = fileLink.querySelector('i');
                                        if (ext === 'pdf') icon.className = 'fas fa-file-pdf';
                                        else if (['jpg', 'jpeg', 'png', 'gif'].includes(ext)) icon.className = 'fas fa-file-image';
                                        else icon.className = 'fas fa-file-alt';
                                    } else {
                                        fileSection.style.display = 'none';
                                    }
                                    document.getElementById('circularModal').style.display = 'flex';
                                } else if (isManual) {
                                    alert('No active circulars at the moment.');
                                }
                            })
                            .catch(err => {
                                console.error('Error fetching circulars:', err);
                                if (isManual) alert('Could not fetch circulars.');
                            });
                    }

                    function closeCircular() {
                        document.getElementById('circularModal').style.display = 'none';
                    }

                    // On page load
                    window.onload = function () {
                        // Small delay for better UX
                        setTimeout(() => checkCirculars(false), 800);
                    };
                </script>


            </body>

            </html>