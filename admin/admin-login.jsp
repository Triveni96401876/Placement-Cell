<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Login | SGP Placement Cell</title>
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            :root {
                --primary: #00a8ff;
                --primary-dark: #0097e6;
                --bg-dark: #0f172a;
                --text-main: #1e293b;
                --text-muted: #64748b;
                --white: #ffffff;
                --shadow: 0 20px 50px rgba(0, 0, 0, 0.1);
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Outfit', sans-serif;
            }

            body {
                background: #f8fafc;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                overflow: hidden;
            }

            .background-blob {
                position: fixed;
                width: 800px;
                height: 800px;
                background: linear-gradient(135deg, rgba(0, 168, 255, 0.1), rgba(0, 151, 230, 0.05));
                filter: blur(80px);
                border-radius: 50%;
                z-index: -1;
                top: -200px;
                right: -200px;
            }

            .background-blob-2 {
                position: fixed;
                width: 600px;
                height: 600px;
                background: linear-gradient(135deg, rgba(15, 23, 42, 0.05), rgba(0, 168, 255, 0.02));
                filter: blur(60px);
                border-radius: 50%;
                z-index: -1;
                bottom: -150px;
                left: -150px;
            }

            .login-card {
                background: var(--white);
                width: 90%;
                max-width: 480px;
                padding: 50px 40px;
                border-radius: 32px;
                box-shadow: var(--shadow);
                border: 1px solid rgba(255, 255, 255, 0.8);
                backdrop-filter: blur(10px);
                text-align: center;
                position: relative;
            }

            .logo-section {
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 15px;
                margin-bottom: 40px;
            }

            .logo-vessel {
                width: 70px;
                height: 70px;
                background: white;
                border-radius: 20px;
                padding: 5px;
                border: 2px solid var(--primary);
                display: flex;
                align-items: center;
                justify-content: center;
                box-shadow: 0 10px 20px rgba(0, 168, 255, 0.15);
            }

            .logo-vessel img {
                width: 100%;
                height: 100%;
                object-fit: contain;
            }

            .admin-page-title {
                font-size: 2rem;
                font-weight: 800;
                color: var(--bg-dark);
                margin-top: 10px;
            }

            .admin-note {
                background: #f1f5f9;
                padding: 12px 20px;
                border-radius: 12px;
                font-size: 0.85rem;
                color: var(--text-muted);
                margin-bottom: 30px;
                display: inline-flex;
                align-items: center;
                gap: 10px;
            }

            .admin-note i {
                color: var(--primary);
            }

            .form-group {
                margin-bottom: 24px;
                text-align: left;
                position: relative;
            }

            .form-group label {
                display: block;
                font-size: 0.9rem;
                font-weight: 600;
                color: var(--text-main);
                margin-bottom: 10px;
                margin-left: 5px;
            }

            .input-wrapper {
                position: relative;
                display: flex;
                align-items: center;
            }

            .input-wrapper i {
                position: absolute;
                left: 20px;
                color: var(--text-muted);
                font-size: 1.1rem;
                transition: color 0.3s;
            }

            .input-wrapper input {
                width: 100%;
                padding: 16px 20px 16px 55px;
                border: 2px solid #e2e8f0;
                border-radius: 16px;
                font-size: 1rem;
                color: var(--text-main);
                outline: none;
                transition: all 0.3s ease;
                background: #f8fafc;
            }

            .input-wrapper input:focus {
                border-color: var(--primary);
                background: white;
                box-shadow: 0 0 15px rgba(0, 168, 255, 0.1);
            }

            .input-wrapper input:focus+i {
                color: var(--primary);
            }

            .btn-login {
                width: 100%;
                padding: 18px;
                background: var(--primary);
                color: white;
                border: none;
                border-radius: 16px;
                font-size: 1.1rem;
                font-weight: 700;
                cursor: pointer;
                transition: all 0.3s ease;
                box-shadow: 0 8px 25px rgba(0, 168, 255, 0.3);
                margin-top: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
            }

            .btn-login:hover {
                background: var(--primary-dark);
                transform: translateY(-3px);
                box-shadow: 0 12px 30px rgba(0, 168, 255, 0.4);
            }

            .login-card footer {
                margin-top: 40px;
                display: flex;
                justify-content: center;
                gap: 20px;
                border-top: 1px solid #f1f5f9;
                padding-top: 25px;
            }

            .login-card footer a {
                font-size: 0.85rem;
                color: var(--text-muted);
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s;
            }

            .login-card footer a:hover {
                color: var(--primary);
            }

            .error-message {
                background: #fef2f2;
                color: #ef4444;
                padding: 12px;
                border-radius: 12px;
                font-size: 0.85rem;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
            }
        </style>
    </head>

    <body>
        <div class="background-blob"></div>
        <div class="background-blob-2"></div>

        <div class="login-card">
            <div class="logo-section">
                <div class="logo-vessel">
                    <img src="images/sgp1.jpeg?v=5.0" alt="Logo">
                </div>
                <h1 class="admin-page-title">Admin Login</h1>
            </div>

            <div class="admin-note">
                <i class="fas fa-shield-alt"></i>
                Dedicated Portal for Placement Administrators
            </div>

            <% String error=request.getParameter("error"); if (error !=null) { %>
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i>
                    <% if ("invalid_credentials".equals(error)) { %>
                        Invalid Admin ID or Password
                        <% } else if ("invalid_admin_role".equals(error)) { %>
                            Access Denied: Admin role required
                            <% } else { %>
                                An error occurred. Please try again.
                                <% } %>
                </div>
                <% } %>

                    <form action="LoginServlet" method="POST">
                        <input type="hidden" name="role" value="admin">

                        <div class="form-group">
                            <label>Admin ID</label>
                            <div class="input-wrapper">
                                <i class="fas fa-user-tie"></i>
                                <input type="text" name="email" placeholder="Enter Administrator ID" required autofocus>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Password</label>
                            <div class="input-wrapper">
                                <i class="fas fa-lock"></i>
                                <input type="password" name="password" placeholder="••••••••" required>
                            </div>
                        </div>

                        <button type="submit" class="btn-login">
                            Login to Dashboard <i class="fas fa-arrow-right"></i>
                        </button>
                    </form>

                    <footer>
                        <a href="#">Terms of use</a>
                        <a href="#">Privacy policy</a>
                    </footer>
        </div>
    </body>

    </html>