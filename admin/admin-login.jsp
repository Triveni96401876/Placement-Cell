<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Access - SGP Placement Cell</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #334155;
            --accent: #3b82f6;
            --bg: #0f172a;
            --white: #ffffff;
            --text-main: #f8fafc;
            --text-dim: #94a3b8;
            --card-bg: #1e293b;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: var(--bg);
            background-image: 
                radial-gradient(at 0% 0%, rgba(59, 130, 246, 0.15) 0, transparent 50%), 
                radial-gradient(at 50% 0%, rgba(30, 41, 59, 0.1) 0, transparent 50%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            color: var(--text-main);
        }

        header {
            padding: 2rem 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: 900;
            letter-spacing: -1px;
            color: var(--white);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .logo i { color: var(--accent); }

        .back-btn {
            color: var(--text-dim);
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 600;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.05);
            transition: all 0.2s;
        }

        .back-btn:hover {
            color: var(--white);
            background: rgba(255, 255, 255, 0.1);
        }

        main {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }

        .admin-card {
            width: 100%;
            max-width: 420px;
            background: var(--card-bg);
            padding: 1.5rem 2rem;
            border-radius: 24px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
            border: 1px solid rgba(255, 255, 255, 0.05);
        }

        .shield-icon {
            width: 64px;
            height: 64px;
            background: rgba(59, 130, 246, 0.1);
            color: var(--accent);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            margin: 0 auto 1.25rem;
            border: 1px solid rgba(59, 130, 246, 0.2);
        }

        h1 {
            text-align: center;
            font-size: 1.75rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
        }

        .subtitle {
            text-align: center;
            color: var(--text-dim);
            font-size: 0.95rem;
            margin-bottom: 1.5rem;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-group label {
            display: block;
            font-size: 0.8rem;
            font-weight: 700;
            color: var(--text-dim);
            margin-bottom: 0.5rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .form-control {
            width: 100%;
            padding: 0.85rem;
            background: rgba(15, 23, 42, 0.5);
            border: 1.5px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            color: white;
            font-size: 1rem;
            transition: all 0.2s;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--accent);
            background: rgba(15, 23, 42, 0.8);
        }

        .submit-btn {
            width: 100%;
            padding: 0.85rem;
            background: var(--accent);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s;
            margin-top: 1rem;
        }

        .submit-btn:hover {
            background: #2563eb;
            box-shadow: 0 0 20px rgba(59, 130, 246, 0.4);
        }

        .portal-links {
            margin-top: 2rem;
            text-align: center;
            font-size: 0.85rem;
        }

        .portal-links a {
            color: var(--text-dim);
            text-decoration: none;
            margin: 0 0.75rem;
            transition: color 0.2s;
        }

        .portal-links a:hover {
            color: var(--accent);
        }

        .alert {
            background: rgba(239, 68, 68, 0.1);
            color: #ef4444;
            padding: 1rem;
            border-radius: 12px;
            font-size: 0.85rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            text-align: center;
            border: 1px solid rgba(239, 68, 68, 0.2);
        }
    </style>
</head>

<body>
    <header>
        <div class="logo"><i class="fas fa-shield-halved"></i> SGP ROOT</div>
        <a href="../index.jsp" class="back-btn">Exit Portal</a>
    </header>

    <main>
        <div class="admin-card">
            <div class="shield-icon">
                <i class="fas fa-lock"></i>
            </div>
            <h1>Admin Console</h1>
            <p class="subtitle">Secure administrative access required</p>

            <% String error=request.getParameter("error"); if (error !=null) { %>
                <div class="alert">
                    Invalid administrator credentials. Access denied.
                </div>
                <% } %>

                    <form action="../LoginServlet" method="POST">
                        <input type="hidden" name="role" value="admin">
                        <div class="form-group">
                            <label>Admin Identifier</label>
                            <input type="text" name="email" class="form-control" placeholder="Root ID" required
                                autofocus>
                        </div>
                        <div class="form-group">
                            <label>Secure Token</label>
                            <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                        </div>
                        <button type="submit" class="submit-btn">Authorize Entry</button>
                    </form>

                    <div class="portal-links">
                        <a href="../student/login.jsp">Student Portal</a>
                        <a href="../hod/hod-login.jsp">HOD Portal</a>
                    </div>
        </div>
    </main>
</body>

</html>