<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.placementcell.model.Student, com.placementcell.model.User, com.placementcell.dao.StudentDAO" %>
        <% Student student=(Student) request.getAttribute("studentData"); if (student==null) {
            javax.servlet.http.HttpSession sess=request.getSession(false); if (sess !=null && sess.getAttribute("user")
            !=null) { User u=(User) sess.getAttribute("user"); student=new StudentDAO().getStudentByUserId(u.getId()); }
            } if (student==null) { response.sendRedirect(request.getContextPath() + "/student/login.jsp" ); return; }
            String ctx=request.getContextPath(); %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>About SGP | SGP Placement Cell</title>
                <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

                <style>
                    :root {
                        --primary: #00b4ff;
                        --primary-dark: #0091cc;
                        --accent: #0055a5;
                        --bg: #f0f4f8;
                        --white: #ffffff;
                        --dark: #1e293b;
                        --muted: #64748b;
                        --border: #e2e8f0;
                        --card-shadow: 0 4px 24px rgba(0, 0, 0, 0.06);
                    }

                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                        font-family: 'Poppins', sans-serif;
                    }

                    body {
                        background: var(--bg);
                        display: flex;
                        height: 100vh;
                        overflow: hidden;
                        flex-direction: column;
                    }

                    /* ── TOP NAVBAR ── */
                    .top-navbar {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        padding: 0 2rem;
                        background: var(--white);
                        height: 68px;
                        box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
                        z-index: 100;
                        flex-shrink: 0;
                    }

                    .logo-area {
                        display: flex;
                        align-items: center;
                        gap: 12px;
                    }

                    .logo-area img {
                        height: 42px;
                        border-radius: 50%;
                        object-fit: cover;
                    }

                    .logo-area span {
                        font-weight: 700;
                        color: #0088cc;
                        font-size: 1.05rem;
                        letter-spacing: .4px;
                    }

                    .user-area {
                        display: flex;
                        align-items: center;
                        gap: 18px;
                    }

                    .user-area span {
                        font-weight: 500;
                        color: #4a5568;
                        font-size: .93rem;
                    }

                    .btn-logout {
                        background: var(--primary);
                        color: #fff;
                        border: none;
                        padding: 8px 22px;
                        border-radius: 20px;
                        font-weight: 600;
                        font-size: .9rem;
                        text-decoration: none;
                        transition: .3s;
                        box-shadow: 0 4px 10px rgba(0, 180, 255, .25);
                    }

                    .btn-logout:hover {
                        opacity: .88;
                        transform: translateY(-2px);
                    }

                    /* ── MAIN SHELL ── */
                    .main-container {
                        display: flex;
                        flex: 1;
                        overflow: hidden;
                    }

                    /* ── SIDEBAR ── */
                    .sidebar {
                        width: 240px;
                        background: var(--white);
                        border-right: 1px solid var(--border);
                        display: flex;
                        flex-direction: column;
                        padding-top: 2rem;
                        flex-shrink: 0;
                    }

                    .sidebar-brand {
                        display: flex;
                        align-items: center;
                        gap: 12px;
                        padding: 0 1.4rem 2rem 1.4rem;
                    }

                    .sidebar-brand img {
                        height: 44px;
                        border-radius: 50%;
                        object-fit: cover;
                        box-shadow: 0 2px 8px rgba(0, 0, 0, .12);
                    }

                    .sidebar-brand span {
                        font-weight: 800;
                        color: var(--dark);
                        font-size: .82rem;
                        line-height: 1.3;
                    }

                    .nav-links {
                        list-style: none;
                        padding: 0 .8rem;
                    }

                    .nav-links li {
                        margin-bottom: 4px;
                    }

                    .nav-links li a {
                        display: flex;
                        align-items: center;
                        gap: 14px;
                        padding: 11px 18px;
                        color: #6b7280;
                        text-decoration: none;
                        font-weight: 600;
                        font-size: .92rem;
                        border-radius: 12px;
                        transition: .25s;
                    }

                    .nav-links li.active>a {
                        background: var(--primary);
                        color: #fff;
                        box-shadow: 0 4px 14px rgba(0, 180, 255, .25);
                    }

                    .nav-links li a:hover:not(.active-link) {
                        background: #f1f5f9;
                        color: var(--dark);
                    }

                    .nav-links li i {
                        font-size: 1rem;
                        width: 18px;
                    }

                    /* ── CONTENT ── */
                    .content-area {
                        flex: 1;
                        padding: 2.5rem 3rem;
                        overflow-y: auto;
                        background: var(--bg);
                    }

                    /* Page heading */
                    .page-heading {
                        font-size: 1.9rem;
                        font-weight: 800;
                        color: var(--dark);
                        margin-bottom: 2rem;
                        display: flex;
                        align-items: center;
                        gap: 14px;
                    }

                    .page-heading i {
                        color: var(--primary);
                        font-size: 1.7rem;
                    }

                    /* Cards */
                    .card {
                        background: var(--white);
                        border-radius: 20px;
                        padding: 36px 40px;
                        box-shadow: var(--card-shadow);
                        margin-bottom: 1.8rem;
                    }

                    .card-title {
                        font-size: 1.1rem;
                        font-weight: 700;
                        color: var(--accent);
                        text-transform: uppercase;
                        letter-spacing: .8px;
                        margin-bottom: 1.2rem;
                        display: flex;
                        align-items: center;
                        gap: 10px;
                    }

                    .card-title::after {
                        content: '';
                        flex: 1;
                        height: 2px;
                        background: linear-gradient(90deg, var(--primary) 0%, transparent 100%);
                        border-radius: 2px;
                    }

                    /* About hero row */
                    .about-hero {
                        display: flex;
                        gap: 32px;
                        align-items: flex-start;
                    }

                    .college-logo-wrap {
                        flex-shrink: 0;
                        width: 150px;
                        height: 150px;
                        border-radius: 50%;
                        overflow: hidden;
                        border: 4px solid var(--primary);
                        box-shadow: 0 8px 24px rgba(0, 180, 255, .2);
                    }

                    .college-logo-wrap img {
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                    }

                    .about-text p {
                        color: #4a5568;
                        line-height: 1.85;
                        margin-bottom: 12px;
                        font-size: 1rem;
                    }

                    /* Courses grid */
                    .courses-grid {
                        display: grid;
                        grid-template-columns: repeat(3, 1fr);
                        gap: 16px;
                    }

                    .course-card {
                        background: #f8fafc;
                        border: 1.5px solid var(--border);
                        border-radius: 16px;
                        padding: 22px 16px;
                        text-align: center;
                        transition: .3s;
                        cursor: default;
                    }

                    .course-card:hover {
                        border-color: var(--primary);
                        transform: translateY(-5px);
                        box-shadow: 0 10px 24px rgba(0, 180, 255, .12);
                    }

                    .course-card .c-icon {
                        font-size: 2rem;
                        color: var(--primary);
                        margin-bottom: 10px;
                    }

                    .course-card h3 {
                        font-size: .95rem;
                        font-weight: 700;
                        color: var(--dark);
                        margin-bottom: 6px;
                    }

                    .course-card p {
                        font-size: .82rem;
                        color: var(--muted);
                        line-height: 1.5;
                    }

                    /* Placement section */
                    .placement-text {
                        color: #4a5568;
                        line-height: 1.8;
                        margin-bottom: 18px;
                        font-size: 1rem;
                    }

                    /* Officer card */
                    .officer-card {
                        display: flex;
                        gap: 28px;
                        align-items: center;
                        background: linear-gradient(135deg, #ebf8ff 0%, #f0f9ff 100%);
                        border: 1.5px solid rgba(0, 180, 255, .25);
                        border-radius: 20px;
                        padding: 28px 32px;
                        margin-top: 20px;
                    }

                    .officer-photo {
                        width: 100px;
                        height: 100px;
                        border-radius: 50%;
                        object-fit: cover;
                        object-position: top;
                        border: 3px solid var(--primary);
                        box-shadow: 0 6px 18px rgba(0, 180, 255, .2);
                        flex-shrink: 0;
                    }

                    .officer-info h3 {
                        font-size: 1.2rem;
                        font-weight: 800;
                        color: var(--dark);
                        margin-bottom: 2px;
                    }

                    .officer-info .role {
                        font-size: .85rem;
                        font-weight: 600;
                        color: var(--primary);
                        margin-bottom: 10px;
                    }

                    .officer-info .contact-row {
                        display: flex;
                        gap: 18px;
                        flex-wrap: wrap;
                        margin-bottom: 6px;
                    }

                    .officer-info .contact-row a,
                    .officer-info .contact-row span {
                        font-size: .9rem;
                        color: #4a5568;
                        font-weight: 500;
                        text-decoration: none;
                        display: flex;
                        align-items: center;
                        gap: 6px;
                    }

                    .officer-info .contact-row a:hover {
                        color: var(--primary);
                    }

                    .officer-info .contact-row i {
                        color: var(--primary);
                    }

                    .officer-message {
                        margin-top: 16px;
                        padding: 16px 20px;
                        background: rgba(255, 255, 255, .85);
                        border-left: 4px solid var(--primary);
                        border-radius: 10px;
                        font-size: .93rem;
                        color: #4a5568;
                        line-height: 1.7;
                    }

                    /* Stats bar */
                    .pill {
                        background: #fff;
                        border: 1.5px solid var(--primary);
                        border-radius: 50px;
                        padding: 8px 20px;
                        font-size: .87rem;
                        font-weight: 600;
                        color: var(--accent);
                        display: flex;
                        align-items: center;
                        gap: 8px;
                    }

                    /* NEW STYLES FOR IMAGE MATCH */
                    .hero-card {
                        background: white;
                        border-radius: 24px;
                        padding: 30px;
                        display: flex;
                        gap: 30px;
                        align-items: center;
                        margin-bottom: 30px;
                        box-shadow: 0 4px 20px rgba(0,0,0,0.04);
                        border: 1px solid #f1f5f9;
                    }

                    .hero-logo {
                        width: 140px;
                        height: 140px;
                        border: 3px solid #00b4ff;
                        border-radius: 20px;
                        padding: 10px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                    }

                    .hero-logo img {
                        width: 100%;
                        height: auto;
                    }

                    .hero-content p {
                        font-size: 0.95rem;
                        color: #475569;
                        line-height: 1.7;
                        margin-bottom: 12px;
                    }

                    .section-header {
                        display: flex;
                        align-items: center;
                        gap: 12px;
                        color: #004a99;
                        font-size: 0.95rem;
                        font-weight: 800;
                        text-transform: uppercase;
                        letter-spacing: 1px;
                        margin: 40px 0 20px 0;
                    }

                    .course-row {
                        display: grid;
                        grid-template-columns: repeat(5, 1fr);
                        gap: 15px;
                        margin-bottom: 40px;
                    }

                    .compact-course-card {
                        background: white;
                        border: 1.5px solid #e2e8f0;
                        border-radius: 12px;
                        padding: 25px 15px;
                        text-align: center;
                        transition: all 0.3s;
                        cursor: pointer;
                        display: flex;
                        flex-direction: column;
                        align-items: center;
                        gap: 12px;
                    }

                    .compact-course-card:hover {
                        border-color: #00b4ff;
                        transform: translateY(-5px);
                        box-shadow: 0 10px 20px rgba(0, 180, 255, 0.1);
                    }

                    .compact-course-card .c-icon {
                        width: 45px;
                        height: 45px;
                        background: #f0f9ff;
                        color: #00b4ff;
                        border-radius: 10px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 1.4rem;
                    }

                    .compact-course-card h3 {
                        font-size: 0.85rem;
                        font-weight: 700;
                        color: #1e293b;
                        line-height: 1.3;
                    }

                    .tp-section {
                        background: #f0f9ff;
                        border-radius: 16px;
                        padding: 30px;
                        border-left: 5px solid #00b4ff;
                        margin-top: 30px;
                    }

                    .tp-header {
                        display: flex;
                        align-items: center;
                        gap: 10px;
                        font-weight: 800;
                        color: #1e293b;
                        margin-bottom: 15px;
                        font-size: 1rem;
                    }

                    .tp-content {
                        font-size: 0.95rem;
                        color: #475569;
                        line-height: 1.7;
                    }
                </style>
            </head>

            <body>

                <!-- Top Navbar -->
                <header class="top-navbar">
                    <div class="logo-area">
                        <img src="<%= ctx %>/images/sgp1.jpeg" alt="SGP Logo" onerror="this.src='../images/sgp1.jpeg'">
                        <span>SGP PLACEMENT CELL</span>
                    </div>
                    <div class="user-area">
                        <span>Welcome, <%= student.getWelcomeName().toUpperCase() %></span>
                        <a href="<%= ctx %>/LogoutServlet" class="btn-logout">Logout</a>
                    </div>
                </header>

                <!-- Main Container -->
                <div class="main-container">

                    <!-- Sidebar -->
                    <aside class="sidebar">
                        <div class="sidebar-brand">
                            <img src="<%= ctx %>/images/sgp1.jpeg" alt="SGP Logo"
                                onerror="this.src='../images/sgp1.jpeg'">
                            <span>SGP<br>PLACEMENT<br>CELL</span>
                        </div>
                        <ul class="nav-links">
                            <li>
                                <a href="<%= ctx %>/DashboardServlet"><i class="fas fa-th-large"></i> Dashboard</a>
                            </li>
                            <li>
                                <a href="<%= ctx %>/JobPortalServlet"><i class="fas fa-briefcase"></i> Job Portal</a>
                            </li>
                            <li>
                                <a href="<%= ctx %>/studentViewServlet"><i class="fas fa-user-circle"></i> Profile</a>
                            </li>
                            <li class="active">
                                <a href="<%= ctx %>/student/about-sgp.jsp" class="active-link"><i
                                        class="fas fa-university"></i> About SGP</a>
                            </li>
                        </ul>
                    </aside>

                    <!-- Content Area -->
                    <main class="content-area">

                        <h1 class="page-heading"><i class="fas fa-university"></i> About SGP</h1>

                        <div class="hero-card">
                            <div class="hero-logo">
                                <img src="<%= ctx %>/images/sgp1.jpeg" alt="SGP Logo" onerror="this.src='../images/sgp1.jpeg'">
                            </div>
                            <div class="hero-content">
                                <p><strong>Sanjay Gandhi Polytechnic (SGP), Ballari</strong>, was established in <strong>1991</strong> as the first premier private co-educational polytechnic in the region.</p>
                                <p>The institute is recognized by the Government of Karnataka, approved by AICTE, New Delhi, and affiliated with DTE Bengaluru. SGP focuses on academic excellence and practical exposure.</p>
                            </div>
                        </div>

                        <div class="section-header">
                            <i class="fas fa-book"></i> OUR DIPLOMA COURSES
                        </div>

                        <div class="course-row">
                            <div class="compact-course-card" onclick="showBranchDetails('CS')">
                                <div class="c-icon"><i class="fas fa-laptop-code"></i></div>
                                <h3>Computer<br>Science</h3>
                            </div>
                            <div class="compact-course-card" onclick="showBranchDetails('ME')">
                                <div class="c-icon"><i class="fas fa-cogs"></i></div>
                                <h3>Mechanical<br>Engineering</h3>
                            </div>
                            <div class="compact-course-card" onclick="showBranchDetails('CV')">
                                <div class="c-icon"><i class="fas fa-hard-hat"></i></div>
                                <h3>Civil<br>Engineering</h3>
                            </div>
                            <div class="compact-course-card" onclick="showBranchDetails('MT')">
                                <div class="c-icon"><i class="fas fa-flask"></i></div>
                                <h3>Metallurgy<br>Engineering</h3>
                            </div>
                            <div class="compact-course-card" onclick="showBranchDetails('EC')">
                                <div class="c-icon"><i class="fas fa-microchip"></i></div>
                                <h3>Electronics<br>Engineering</h3>
                            </div>
                        </div>

                        <div class="tp-section">
                            <div class="tp-header">
                                <i class="fas fa-handshake"></i> Training & Placements
                            </div>
                            <div class="tp-content">
                                SGP has a strong placement record with students placed in reputed MNCs like JSW, L&T, and TATA Motors. Career guidance and placement training are provided to every student.
                            </div>
                        </div>

                    </main>
                </div>

                <!-- ── BRANCH INFO MODAL ── -->
                <div id="branchModal" style="display: none; position: fixed; inset: 0; background: rgba(15, 23, 42, 0.7); backdrop-filter: blur(4px); z-index: 1000; justify-content: center; align-items: center; padding: 20px;">
                    <div style="background: white; width: 100%; max-width: 600px; border-radius: 24px; padding: 40px; position: relative; box-shadow: 0 25px 50px -12px rgba(0,0,0,0.25); animation: modalIn 0.4s cubic-bezier(0.16, 1, 0.3, 1);">
                        <button onclick="document.getElementById('branchModal').style.display='none'" style="position: absolute; top: 20px; right: 20px; background: #f1f5f9; border: none; width: 36px; height: 36px; border-radius: 50%; cursor: pointer; color: #64748b; transition: 0.2s;"><i class="fas fa-times"></i></button>
                        
                        <div id="modalIcon" style="width: 70px; height: 70px; background: #ebf8ff; color: var(--primary); border-radius: 18px; display: flex; align-items: center; justify-content: center; font-size: 2rem; margin-bottom: 24px;"></div>
                        
                        <h2 id="modalTitle" style="font-size: 1.6rem; color: var(--dark); margin-bottom: 8px; font-weight: 800;"></h2>
                        <p id="modalDesc" style="color: var(--muted); font-size: 0.95rem; margin-bottom: 24px; line-height: 1.6;"></p>
                        
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; text-align: left;">
                            <div>
                                <h4 style="font-size: 0.85rem; color: var(--primary); text-transform: uppercase; letter-spacing: 1px; margin-bottom: 12px; font-weight: 700;">Core Subjects</h4>
                                <ul id="modalSubjects" style="list-style: none; font-size: 0.9rem; color: #475569; line-height: 1.8;"></ul>
                            </div>
                            <div>
                                <h4 style="font-size: 0.85rem; color: var(--primary); text-transform: uppercase; letter-spacing: 1px; margin-bottom: 12px; font-weight: 700;">Career Paths</h4>
                                <ul id="modalCareers" style="list-style: none; font-size: 0.9rem; color: #475569; line-height: 1.8;"></ul>
                            </div>
                        </div>
                        
                        <div style="margin-top: 30px; padding-top: 24px; border-top: 1px solid #f1f5f9; display: flex; justify-content: space-between; align-items: center;">
                            <div style="display: flex; gap: 8px;">
                                <span style="background: #f1f5f9; padding: 6px 12px; border-radius: 6px; font-size: 0.75rem; font-weight: 600; color: #64748b;">3 Years Course</span>
                                <span style="background: #f1f5f9; padding: 6px 12px; border-radius: 6px; font-size: 0.75rem; font-weight: 600; color: #64748b;">AICTE Approved</span>
                            </div>
                            <button onclick="document.getElementById('branchModal').style.display='none'" style="background: var(--primary); color: white; border: none; padding: 10px 24px; border-radius: 12px; font-weight: 600; cursor: pointer; box-shadow: 0 4px 12px rgba(0, 180, 255, 0.2);">Got It</button>
                        </div>
                    </div>
                </div>

                <style>
                    @keyframes modalIn { from { opacity: 0; transform: scale(0.95) translateY(10px); } to { opacity: 1; transform: scale(1) translateY(0); } }
                    .course-card { cursor: pointer !important; }
                </style>

                <script>
                    const branchData = {
                        'CS': {
                            title: 'Computer Science & Engineering',
                            icon: 'fa-laptop-code',
                            desc: 'Focuses on the fundamentals of computer systems, software development, and theoretical foundations of information and computation.',
                            subjects: ['• Data Structures', '• Web Technologies', '• DBMS', '• Operating Systems'],
                            careers: ['• Software Developer', '• Web Designer', '• System Admin', '• App Developer']
                        },
                        'EC': {
                            title: 'Electronics & Communication',
                            icon: 'fa-microchip',
                            desc: 'Covers electronic devices, communication networks, microprocessors, and integrated circuits essential for the modern digital age.',
                            subjects: ['• Analog Electronics', '• Digital Circuits', '• Microcontrollers', '• VLSI Design'],
                            careers: ['• Telecom Engineer', '• Service Engineer', '• Embedded Systems', '• R&D Assistant']
                        },
                        'CV': {
                            title: 'Civil Engineering',
                            icon: 'fa-hard-hat',
                            desc: 'Deal with the design, construction, and maintenance of the physical and naturally built environment, including public works.',
                            subjects: ['• Surveying', '• Concrete Technology', '• Structural Design', '• Estimating & Costing'],
                            careers: ['• Site Engineer', '• CAD Drafter', '• Quality Controller', '• Surveyor']
                        },
                        'ME': {
                            title: 'Mechanical Engineering',
                            icon: 'fa-cogs',
                            desc: 'Applying engineering, physics, and materials science principles to design, analyze, manufacture, and maintain mechanical systems.',
                            subjects: ['• Thermodynamics', '• CAD/CAM', '• Machine Design', '• Mechatronics'],
                            careers: ['• Production Engineer', '• QC Inspector', '• Design Engineer', '• Plant Supervisor']
                        },
                        'EE': {
                            title: 'Electrical & Electronics',
                            icon: 'fa-bolt',
                            desc: 'Involves study of electricity, electronics, and electromagnetism, focusing on power generation, storage and transmission.',
                            subjects: ['• Power Electronics', '• Electrical Machines', '• Control Systems', '• Transmission & Distrib.'],
                            careers: ['• Maintenance Engineer', '• Electrical Supervisor', '• Energy Auditor', '• Utility Engineer']
                        },
                        'MT': {
                            title: 'Metallurgy Engineering',
                            icon: 'fa-flask',
                            desc: 'Study of the physical and chemical behavior of metallic elements, their inter-metallic compounds, and their mixtures.',
                            subjects: ['• Foundry Technology', '• Extractive Metallurgy', '• Heat Treatment', '• Material Testing'],
                            careers: ['• Metal Melter', '• Materials Auditor', '• Quality Inspector', '• Process Controller']
                        }
                    };

                    function showBranchDetails(code) {
                        const data = branchData[code];
                        if (!data) return;
                        
                        document.getElementById('modalTitle').innerText = data.title;
                        document.getElementById('modalDesc').innerText = data.desc;
                        document.getElementById('modalIcon').innerHTML = `<i class="fas \${data.icon}"></i>`;
                        
                        document.getElementById('modalSubjects').innerHTML = data.subjects.map(s => `<li>\${s}</li>`).join('');
                        document.getElementById('modalCareers').innerHTML = data.careers.map(c => `<li>\${c}</li>`).join('');
                        
                        document.getElementById('branchModal').style.display = 'flex';
                    }

                    // Close modal on click outside
                    window.onclick = function(event) {
                        const modal = document.getElementById('branchModal');
                        if (event.target == modal) {
                            modal.style.display = 'none';
                        }
                    }
                </script>
            </body>

            </html>