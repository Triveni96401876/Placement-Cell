<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login | SGP Placement Cell</title>
        <!-- CSS -->
        <link rel="stylesheet" href="css/style.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">
        <style>
            body {
                background: linear-gradient(135deg, #003366 0%, #0056b3 100%);
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .login-card {
                background: white;
                padding: 3rem;
                border-radius: 20px;
                box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
                width: 100%;
                max-width: 400px;
            }

            .login-card h2 {
                color: #003366;
                text-align: center;
                margin-bottom: 2rem;
            }

            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-group label {
                display: block;
                margin-bottom: 0.5rem;
                font-weight: 500;
            }

            .form-control {
                width: 100%;
                padding: 0.8rem;
                border: 2px solid #eee;
                border-radius: 10px;
                transition: 0.3s;
            }

            .form-control:focus {
                border-color: #003366;
                outline: none;
            }

            .btn-login {
                width: 100%;
                background: #003366;
                color: white;
                border: none;
                padding: 1rem;
                border-radius: 10px;
                font-weight: 600;
                cursor: pointer;
                transition: 0.3s;
            }

            .btn-login:hover {
                background: #0056b3;
            }

            .alert {
                padding: 10px;
                border-radius: 5px;
                margin-bottom: 1rem;
                text-align: center;
                font-size: 0.9rem;
            }

            .alert-error {
                background: #fee2e2;
                color: #dc2626;
                border: 1px solid #fecaca;
            }

            .alert-success {
                background: #dcfce7;
                color: #16a34a;
                border: 1px solid #bbf7d0;
            }
        </style>
    </head>

    <body>

        <div class="login-card">
            <h2>Student Login</h2>

            <% if(request.getParameter("error") !=null) { %>
                <div class="alert alert-error">Invalid email or password!</div>
                <% } %>
                    <% if(request.getParameter("msg") !=null) { %>
                        <div class="alert alert-success">Logout successful.</div>
                        <% } %>

                            <form action="LoginServlet" method="POST">
                                <div class="form-group">
                                    <label>Email Address</label>
                                    <input type="email" name="email" class="form-control" required
                                        placeholder="name@example.com">
                                </div>
                                <div class="form-group">
                                    <label>Password</label>
                                    <input type="password" name="password" class="form-control" required
                                        placeholder="••••••••">
                                </div>
                                <button type="submit" class="btn-login">Login to Dashboard</button>
                                <p style="text-align: center; margin-top: 1.5rem; font-size: 0.9rem;">
                                    Don't have an account? <a href="register.jsp"
                                        style="color: #003366; font-weight: 600;">Register Here</a>
                                </p>
                            </form>
        </div>

    </body>

    </html>