<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Post Job Opportunity | SGP Admin</title>
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
            rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            :root {
                --primary: #6366f1;
                --primary-dark: #4f46e5;
                --bg: #f8fafc;
                --surface: #ffffff;
                --text: #0f172a;
                --text-muted: #64748b;
                --border: #e2e8f0;
                --radius-xl: 32px;
                --radius-lg: 16px;
                --shadow: 0 20px 50px -12px rgba(0, 0, 0, 0.1);
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
                padding: 40px 20px;
                background-image:
                    radial-gradient(at 100% 0%, rgba(99, 102, 241, 0.05) 0px, transparent 50%),
                    radial-gradient(at 0% 100%, rgba(79, 70, 229, 0.05) 0px, transparent 50%);
            }

            .container {
                width: 100%;
                max-width: 800px;
                animation: slideUp 0.6s cubic-bezier(0.16, 1, 0.3, 1);
            }

            @keyframes slideUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .glass-card {
                background: rgba(255, 255, 255, 0.9);
                backdrop-filter: blur(20px);
                border-radius: var(--radius-xl);
                padding: 50px;
                border: 1px solid rgba(255, 255, 255, 0.8);
                box-shadow: var(--shadow);
                position: relative;
            }

            .card-header {
                text-align: center;
                margin-bottom: 45px;
            }

            .icon-box {
                width: 80px;
                height: 80px;
                background: linear-gradient(135deg, var(--primary), var(--primary-dark));
                color: white;
                border-radius: 24px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 2.2rem;
                margin: 0 auto 25px;
                box-shadow: 0 10px 20px rgba(99, 102, 241, 0.3);
                transform: rotate(-5deg);
            }

            .card-header h1 {
                font-size: 2.2rem;
                font-weight: 800;
                color: #1e293b;
                letter-spacing: -0.5px;
            }

            .card-header p {
                color: var(--text-muted);
                margin-top: 10px;
                font-size: 1.1rem;
            }

            .form-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 25px;
            }

            .full-width {
                grid-column: span 2;
            }

            .input-group {
                display: flex;
                flex-direction: column;
                gap: 8px;
            }

            .input-group label {
                font-weight: 700;
                font-size: 0.9rem;
                color: #475569;
                margin-left: 5px;
            }

            .input-group input,
            .input-group textarea,
            .input-group select {
                padding: 16px 20px;
                background: #f1f5f9;
                border: 2px solid transparent;
                border-radius: 18px;
                font-size: 1rem;
                font-weight: 500;
                color: var(--text);
                transition: all 0.3s;
                outline: none;
            }

            .input-group input:focus,
            .input-group textarea:focus {
                background: white;
                border-color: var(--primary);
                box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
            }

            .submit-btn {
                width: 100%;
                padding: 18px;
                background: linear-gradient(to right, var(--primary), var(--primary-dark));
                color: white;
                border: none;
                border-radius: 20px;
                font-size: 1.1rem;
                font-weight: 700;
                cursor: pointer;
                transition: 0.3s;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 12px;
                margin-top: 20px;
                box-shadow: 0 10px 25px rgba(99, 102, 241, 0.4);
            }

            .submit-btn:hover {
                transform: translateY(-3px);
                box-shadow: 0 15px 30px rgba(99, 102, 241, 0.5);
            }

            .back-link {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                margin-top: 30px;
                color: var(--text-muted);
                text-decoration: none;
                font-weight: 600;
                transition: 0.2s;
            }

            .back-link:hover {
                color: var(--primary);
            }

            @media (max-width: 600px) {
                .form-grid {
                    grid-template-columns: 1fr;
                }

                .full-width {
                    grid-column: auto;
                }

                .glass-card {
                    padding: 30px;
                }
            }
        </style>
    </head>

    <body>
        <div class="container">
            <div class="glass-card">
                <div class="card-header">
                    <div class="icon-box">
                        <i class="fas fa-bullhorn"></i>
                    </div>
                    <h1>Broadcast Opportunity</h1>
                    <p>New hiring update for student community</p>
                </div>

                <form action="saveJobServlet" method="POST" class="form-grid">
                    <div class="input-group full-width">
                        <label>Opportunity Title</label>
                        <input type="text" name="title" placeholder="e.g. Talent Acquisition 2024" required>
                    </div>

                    <div class="input-group">
                        <label>Company / Organization</label>
                        <input type="text" name="company" placeholder="Company Name" required>
                    </div>

                    <div class="input-group">
                        <label>Location / Remote</label>
                        <input type="text" name="location" placeholder="Work Location" required>
                    </div>

                    <div class="input-group">
                        <label>Package / Stipend</label>
                        <input type="text" name="salary" placeholder="e.g. 5.5 LPA" required>
                    </div>

                    <div class="input-group">
                        <label>Application Deadline</label>
                        <input type="date" name="deadline" required>
                    </div>

                    <div class="input-group full-width">
                        <label>Detailed Requirements & Highlights</label>
                        <textarea name="description" style="min-height: 140px;"
                            placeholder="Eligible branches, key skills, interview process details..."
                            required></textarea>
                    </div>

                    <div class="full-width">
                        <button type="submit" class="submit-btn">
                            Publish Opportunity <i class="fas fa-paper-plane"></i>
                        </button>
                    </div>
                </form>

                <a href="AdminDashboardServlet" class="back-link">
                    <i class="fas fa-chevron-left"></i> Cancel / Return to Dashboard
                </a>
            </div>
        </div>
    </body>

    </html>