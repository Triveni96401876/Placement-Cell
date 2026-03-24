<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HOD Portal - SGP Placement Cell</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #0d9488;
            --primary-hover: #0f766e;
            --bg: #f0fdfa;
            --white: #ffffff;
            --text: #0f172a;
            --text-muted: #64748b;
            --border: #e2e8f0;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Outfit', sans-serif;
        }

        body {
            background-color: var(--bg);
            background-image: radial-gradient(circle at 2px 2px, #ccfbf1 1px, transparent 0);
            background-size: 40px 40px;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        header {
            background: var(--white);
            padding: 1rem 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #ccfbf1;
        }

        .logo-box {
            display: flex;
            align-items: center;
            gap: 1rem;
            text-decoration: none;
        }

        .logo-circle {
            width: 40px;
            height: 40px;
            background: var(--primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 800;
        }

        .logo-text {
            font-size: 1.4rem;
            font-weight: 800;
            color: var(--primary);
        }

        .home-link {
            text-decoration: none;
            color: var(--text-muted);
            font-weight: 600;
            transition: color 0.2s;
        }

        .home-link:hover {
            color: var(--primary);
        }

        main {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }

        .login-container {
            width: 100%;
            max-width: 450px;
            background: var(--white);
            padding: 1.5rem 2rem;
            border-radius: 24px;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05), 0 10px 10px -5px rgba(0, 0, 0, 0.02);
            border: 1px solid #ccfbf1;
            position: relative;
        }

        .hod-icon {
            width: 50px;
            height: 50px;
            background: #f0fdfa;
            color: var(--primary);
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin: 0 auto 1rem;
            transform: rotate(-5deg);
        }

        .login-container h1 {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--text);
            text-align: center;
            margin-bottom: 0.25rem;
        }

        .login-container p.subtitle {
            text-align: center;
            color: var(--text-muted);
            margin-bottom: 1.5rem;
            font-size: 0.85rem;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-group label {
            display: block;
            font-weight: 700;
            font-size: 0.85rem;
            color: var(--text);
            margin-bottom: 0.6rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-control {
            width: 100%;
            padding: 0.85rem;
            border: 2px solid #f1f5f9;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.2s;
            background: #f8fafc;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            background: white;
            box-shadow: 0 0 0 4px rgba(13, 148, 136, 0.1);
        }

        .btn-login {
            width: 100%;
            background: var(--primary);
            color: white;
            border: none;
            padding: 0.85rem;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s;
            box-shadow: 0 10px 15px -3px rgba(13, 148, 136, 0.3);
        }

        .btn-login:hover {
            background: var(--primary-hover);
            transform: translateY(-2px);
        }

        .portal-nav {
            margin-top: 2rem;
            display: flex;
            justify-content: center;
            gap: 1.5rem;
            border-top: 1px solid #f1f5f9;
            padding-top: 1.5rem;
        }

        .portal-nav a {
            text-decoration: none;
            font-size: 0.85rem;
            color: var(--text-muted);
            font-weight: 600;
            transition: color 0.2s;
        }

        .portal-nav a:hover {
            color: var(--primary);
        }

        .alert {
            padding: 1rem;
            background: #fff1f2;
            color: #e11d48;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            font-weight: 600;
            text-align: center;
        }
    </style>
</head>

<body>
    <header>
        <a href="../index.jsp" class="logo-box">
            <div class="logo-circle">S</div>
            <span class="logo-text">SGP HOD Portal</span>
        </a>
        <a href="../index.jsp" class="home-link"><i class="fas fa-home"></i> Home</a>
    </header>

    <main>
        <div class="login-container">
            <div class="hod-icon">
                <i class="fas fa-university"></i>
            </div>
            <h1>Department Login</h1>
            <p class="subtitle">Secure access for Heads of Departments</p>

            <% String error=request.getParameter("error"); if (error !=null) { %>
                <div class="alert">
                    Invalid email or password. Please try again.
                </div>
                <% } %>

                    <form action="../LoginServlet" method="POST">
                        <input type="hidden" name="role" value="HOD">
                        <div class="form-group">
                            <label>HOD Email ID</label>
                            <input type="email" name="email" class="form-control" placeholder="hod.dept@sgp.edu"
                                required autofocus>
                        </div>
                        <div class="form-group">
                            <label>Password</label>
                            <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                        </div>
                        <button type="submit" class="btn-login">
                            Authorize & Login
                        </button>
                    </form>

                    <div class="portal-nav">
                        <a href="../student/login.jsp">Student Portal</a>
                        <a href="../admin/admin-login.jsp">Admin Portal</a>
                    </div>
        </div>
    </main>
</body>

</html>