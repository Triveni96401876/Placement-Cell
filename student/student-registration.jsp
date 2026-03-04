<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Student Registration | SGP Portal</title>
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap rel="
            stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            :root {
                --primary: #00a8ff;
                --primary-dark: #0097e6;
                --bg: #f8fafc;
                --card: #ffffff;
                --text: #1e293b;
                --muted: #64748b;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Outfit', sans-serif;
            }

            body {
                background: var(--bg);
                color: var(--text);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 20px;
            }

            .registration-card {
                background: var(--card);
                width: 100%;
                max-width: 500px;
                padding: 40px;
                border-radius: 24px;
                box-shadow: 0 20px 50px rgba(0, 0, 0, 0.05);
                border: 1px solid rgba(0, 0, 0, 0.02);
            }

            .header {
                text-align: center;
                margin-bottom: 30px;
            }

            .header i {
                font-size: 3rem;
                color: var(--primary);
                margin-bottom: 15px;
            }

            .header h1 {
                font-size: 1.8rem;
                font-weight: 800;
                color: #0f172a;
            }

            .header p {
                color: var(--muted);
                margin-top: 5px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                color: #475569;
                font-size: 0.9rem;
            }

            .input-wrapper {
                position: relative;
                display: flex;
                align-items: center;
            }

            .input-wrapper i {
                position: absolute;
                left: 16px;
                color: var(--muted);
                font-size: 1.1rem;
            }

            .input-wrapper input,
            .input-wrapper select {
                width: 100%;
                padding: 14px 16px 14px 48px;
                border: 2px solid #e2e8f0;
                border-radius: 12px;
                outline: none;
                transition: 0.3s;
                font-size: 1rem;
                background: #fdfdfd;
            }

            .input-wrapper input:focus,
            .input-wrapper select:focus {
                border-color: var(--primary);
                background: #fff;
                box-shadow: 0 0 0 4px rgba(0, 168, 255, 0.1);
            }

            .btn-submit {
                width: 100%;
                padding: 16px;
                background: var(--primary);
                color: white;
                border: none;
                border-radius: 14px;
                font-size: 1.1rem;
                font-weight: 700;
                cursor: pointer;
                transition: 0.3s;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
                margin-top: 25px;
                box-shadow: 0 10px 20px rgba(0, 168, 255, 0.2);
            }

            .btn-submit:hover {
                background: var(--primary-dark);
                transform: translateY(-2px);
            }

            .footer-links {
                text-align: center;
                margin-top: 25px;
                font-size: 0.9rem;
                color: var(--muted);
            }

            .footer-links a {
                color: var(--primary);
                text-decoration: none;
                font-weight: 600;
            }

            /* Success Overlay */
            .success-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(15, 23, 42, 0.98);
                backdrop-filter: blur(15px);
                z-index: 9999;
                justify-content: center;
                align-items: center;
                animation: fadeIn 0.5s ease-out;
            }

            .success-card {
                background: white;
                padding: 50px 40px;
                border-radius: 35px;
                text-align: center;
                max-width: 500px;
                width: 90%;
                box-shadow: 0 30px 60px -12px rgba(0, 0, 0, 0.5);
                position: relative;
                overflow: hidden;
                animation: slideUp 0.6s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            }

            .success-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 8px;
                background: linear-gradient(90deg, #10b981, #34d399);
            }

            .success-icon {
                font-size: 85px;
                color: #10b981;
                margin-bottom: 25px;
                animation: scaleIn 0.5s 0.3s both;
            }

            .success-card h2 {
                color: #0f172a;
                font-size: 2.2rem;
                font-weight: 800;
                margin-bottom: 15px;
            }

            .success-card p {
                color: #64748b;
                line-height: 1.6;
                margin-bottom: 30px;
                font-size: 1.1rem;
            }

            .success-loader {
                height: 6px;
                background: #f1f5f9;
                border-radius: 10px;
                overflow: hidden;
                margin: 20px auto;
                width: 80%;
            }

            .loader-bar {
                height: 100%;
                width: 0;
                background: #10b981;
                animation: loadingProgress 3s linear forwards;
            }

            @keyframes slideUp {
                from {
                    transform: translateY(50px);
                    opacity: 0;
                }

                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }

            @keyframes scaleIn {
                from {
                    transform: scale(0);
                }

                to {
                    transform: scale(1);
                }
            }

            @keyframes loadingProgress {
                to {
                    width: 100%;
                }
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                }

                to {
                    opacity: 1;
                }
            }
        </style>
    </head>

    <body>
        <div class="registration-card">
            <div class="header">
                <i class="fas fa-user-plus"></i>
                <h1>Student Registration</h1>
                <p>Join the SGP Placement Cell</p>
            </div>

            <form id="regForm" action="SimpleRegisterServlet" method="POST">
                <div class="form-group">
                    <label>Full Name</label>
                    <div class="input-wrapper">
                        <i class="fas fa-user"></i>
                        <input type="text" name="fullName" placeholder="Enter your full name" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Email Address</label>
                    <div class="input-wrapper">
                        <i class="fas fa-envelope"></i>
                        <input type="email" name="email" placeholder="name@example.com" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Phone Number</label>
                    <div class="input-wrapper">
                        <i class="fas fa-phone"></i>
                        <input type="tel" name="phone" placeholder="10-digit mobile number" pattern="[0-9]{10}"
                            required>
                    </div>
                </div>

                <div class=" form-group">
                    <label>Course / Branch</label>
                    <div class="input-wrapper">
                        <i class="fas fa-graduation-cap"></i>
                        <select name="branch" required>
                            <option value="" disabled selected>Select your branch</option>
                            <option value="Computer Science">Computer Science</option>
                            <option value="Mechanical">Mechanical</option>
                            <option value="Civil">Civil</option>
                            <option value="Electrical & Electronics">Electrical & Electronics</option>
                            <option value="Metallurgy">Metallurgy</option>
                            <option value="Electronics">Electronics</option>
                            <option value="Information Technology">Information Technology</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label>Set Password</label>
                    <div class="input-wrapper">
                        <i class="fas fa-lock"></i>
                        <input type="password" name="password" placeholder="••••••••" required>
                    </div>
                </div>

                <button type="submit" class="btn-submit">
                    Complete Registration <i class="fas fa-check-circle"></i>
                </button>
            </form>

            <div class="footer-links">
                Already have an account? <a href="login.jsp">Login Here</a>
            </div>
        </div>

        <div id="successOverlay" class="success-overlay">
            <div class="success-card">
                <div class="success-icon"><i class="fas fa-check-circle"></i></div>
                <h2>Successfully Completed!</h2>
                <p>Welcome to SGP Placement Portal. Redirecting you to your Dashboard...</p>
                <div class="success-loader">
                    <div class="loader-bar"></div>
                </div>
            </div>
        </div>

        <script>
            document.getElementById('regForm').onsubmit = function (e) {
                // Success animation script (handled by URL parameter or AJAX)
                // For now, let it submit normally.
            };

            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('status') === 'success') {
                document.getElementById('successOverlay').className = 'success-overlay active';
                setTimeout(() => {
                    window.location.href = 'DashboardServlet?status=registered';
                }, 3000);
            }
        </script>
    </body>

    </html>