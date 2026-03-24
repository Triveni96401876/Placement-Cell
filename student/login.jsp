<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Portal - SGP Placement Cell</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #2563eb;
            --primary-light: #60a5fa;
            --secondary: #f59e0b;
            --bg: #f0f9ff;
            --white: #ffffff;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --border: #e2e8f0;
            --shadow-sm: 0 4px 6px -1px rgb(0 0 0 / 0.1);
            --shadow-md: 0 10px 15px -3px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 20px 25px -5px rgb(0 0 0 / 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            color: var(--text-main);
        }

        /* Header */
        header {
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(12px);
            padding: 1rem 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.3);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .logo-box {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            text-decoration: none;
        }

        .logo-box img {
            width: 40px;
            height: 40px;
            border-radius: 10px;
        }

        .logo-text {
            font-weight: 800;
            font-size: 1.5rem;
            color: var(--primary);
            letter-spacing: -0.5px;
        }

        .nav-links a {
            text-decoration: none;
            color: var(--text-muted);
            font-weight: 600;
            font-size: 0.95rem;
            transition: color 0.2s;
        }

        .nav-links a:hover {
            color: var(--primary);
        }

        /* Main Grid */
        main {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 5%;
        }

        .auth-container {
            width: 100%;
            max-width: 500px;
            background: var(--white);
            border-radius: 30px;
            box-shadow: var(--shadow-lg);
            overflow: hidden;
            position: relative;
        }

        .auth-header {
            padding: 1.5rem 2rem 0.75rem;
            text-align: center;
            background: linear-gradient(to bottom, #f8fafc, #ffffff);
        }

        .student-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: #dbeafe;
            color: var(--primary);
            padding: 0.5rem 1.25rem;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 700;
            margin-bottom: 1rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .auth-header h1 {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--text-main);
            margin-bottom: 0.25rem;
        }
        .auth-header p {
            color: var(--text-muted);
            font-size: 0.85rem;
        }

        /* Tabs */
        .auth-tabs {
            display: flex;
            padding: 0 1.5rem;
            gap: 1.5rem;
            margin-bottom: 1rem;
            border-bottom: 2px solid #f1f5f9;
        }

        .tab-btn {
            padding-bottom: 0.75rem;
            font-size: 1rem;
            font-weight: 700;
            color: var(--text-muted);
            background: none;
            border: none;
            cursor: pointer;
            position: relative;
            transition: color 0.2s;
        }

        .tab-btn.active {
            color: var(--primary);
        }

        .tab-btn.active::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 100%;
            height: 2px;
            background: var(--primary);
        }

        .auth-form {
            padding: 0 1.5rem 1.5rem;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-group label {
            display: block;
            font-size: 0.9rem;
            font-weight: 700;
            color: var(--text-main);
            margin-bottom: 0.6rem;
        }

        .form-control {
            width: 100%;
            padding: 0.9rem 1.1rem;
            border: 1.5px solid var(--border);
            border-radius: 12px;
            font-size: 0.95rem;
            color: var(--text-main);
            transition: all 0.2s;
            background: #f8fafc;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-light);
            background: var(--white);
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1);
        }

        .btn-submit {
            width: 100%;
            padding: 0.85rem;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 0.95rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.25);
            margin-top: 0.5rem;
        }

        .btn-submit:hover {
            background: #1d4ed8;
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(37, 99, 235, 0.3);
        }

        .btn-outline {
            width: 100%;
            padding: 0.8rem;
            background: transparent;
            color: var(--primary);
            border: 2px solid var(--primary);
            border-radius: 12px;
            font-size: 0.95rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-outline:hover {
            background: rgba(37, 99, 235, 0.05);
            border-color: #1d4ed8;
            color: #1d4ed8;
        }

        .alert-error {
            background: #fef2f2;
            color: #ef4444;
            padding: 1rem;
            border-radius: 12px;
            font-size: 0.9rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            border: 1px solid #fee2e2;
        }

        /* Register Section Specifics */
        .register-form {
            max-height: 50vh;
            overflow-y: auto;
            padding-right: 0.5rem;
        }

        .register-form::-webkit-scrollbar {
            width: 6px;
        }

        .register-form::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 10px;
        }

        .grid-2 {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }

        .portal-switch {
            margin-top: 0.25rem;
            padding-top: 0.75rem;
            border-top: 1px solid #f1f5f9;
            text-align: center;
        }

        .portal-links {
            display: flex;
            justify-content: center;
            gap: 1.5rem;
            margin-top: 0.5rem;
        }

        .portal-links a {
            font-size: 0.85rem;
            color: var(--text-muted);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.2s;
        }

        .portal-links a:hover {
            color: var(--primary);
        }

        #register-content {
            display: none;
        }
    </style>
</head>

<body>
    <header>
        <a href="../index.jsp" class="logo-box">
            <img src="../images/sgp1.jpeg" alt="SGP Logo">
            <div>
                <span class="logo-text" style="display: block; line-height: 1;">SGP PLACEMENT CELL</span>
                <span style="font-size: 0.75rem; color: var(--text-muted); font-weight: 600;">Sanjay Gandhi Polytechnic</span>
            </div>
        </a>
        <nav class="nav-links">
            <a href="../index.jsp"><i class="fas fa-home"></i> Back to Home</a>
        </nav>
    </header>

    <main>
        <div class="auth-container">
            <div class="auth-header">
                <div class="student-badge"><i class="fas fa-graduation-cap"></i> Placement Cell</div>
                <h1 id="main-title">Sanjay Gandhi Polytechnic</h1>
                <p id="main-subtitle">Student Portal Access</p>
            </div>

            <div class="auth-tabs">
                <button class="tab-btn active" id="login-tab">Login</button>
            </div>

            <div class="auth-form">
                <% String error=request.getParameter("error"); if (error !=null) { %>
                    <div class="alert-error">
                        <i class="fas fa-exclamation-circle"></i>
                        <%= "invalid_credentials".equals(error) ? "Invalid email or password!" : "Authentication failed!" %>
                    </div>
                <% } %>

                <!-- Login Content -->
                <div id="login-content">
                    <form action="../LoginServlet" method="POST">
                        <input type="hidden" name="role" value="STUDENT">
                        <div class="form-group">
                            <label>Registered Email</label>
                            <input type="email" name="email" class="form-control" placeholder="name@example.com" required>
                        </div>
                        <div class="form-group">
                            <label>Password</label>
                            <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                        </div>
                        <button type="submit" class="btn-submit">Sign In to Dashboard</button>
                        
                        <div style="margin-top: 1rem; text-align: center;">
                            <p style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 0.75rem;">Don't have an account yet?</p>
                            <button type="button" class="btn-outline" onclick="window.location.href='register.jsp'">Register Now</button>
                        </div>
                    </form>
                </div>


                <div class="portal-switch">
                    <p style="font-size: 0.85rem; color: var(--text-muted);">Switch to other portals</p>
                    <div class="portal-links">
                        <a href="../hod/hod-login.jsp">HOD Portal</a>
                        <a href="../admin/admin-login.jsp">Admin Portal</a>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script>
        // Tab system removed as registration is now handled separately
        function switchAuth(type) {
            // No longer used
        }
    </script>
</body>

</html>