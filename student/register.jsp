<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register | SGP Placement Cell</title>
        <!-- CSS -->
        <link rel="stylesheet" href="css/style.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">
        <style>
            body {
                background: #f0f4f8;
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 2rem;
            }

            .reg-card {
                background: white;
                padding: 2.5rem;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 600px;
            }

            .reg-card h2 {
                color: #003366;
                text-align: center;
                margin-bottom: 2rem;
            }

            .grid-form {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1rem;
            }

            .form-group {
                margin-bottom: 1.2rem;
            }

            .form-group.full {
                grid-column: span 2;
            }

            .form-group label {
                display: block;
                margin-bottom: 0.5rem;
                font-weight: 500;
                font-size: 0.9rem;
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

            .btn-reg {
                grid-column: span 2;
                background: #003366;
                color: white;
                border: none;
                padding: 1rem;
                border-radius: 10px;
                font-weight: 600;
                cursor: pointer;
                transition: 0.3s;
                margin-top: 1rem;
            }

            .btn-reg:hover {
                background: #0056b3;
            }
        </style>
    </head>

    <body>

        <div class="reg-card">
            <h2>Student Registration</h2>
            <form action="RegisterServlet" method="POST" enctype="multipart/form-data">
                <div class="grid-form">
                    <div class="form-group full">
                        <label>Full Name</label>
                        <input type="text" name="fullName" class="form-control" required placeholder="John Doe">
                    </div>
                    <div class="form-group">
                        <label>Email Address</label>
                        <input type="email" name="email" class="form-control" required placeholder="john@example.com">
                    </div>
                    <div class="form-group">
                        <label>Password</label>
                        <input type="password" name="password" class="form-control" required placeholder="••••••••">
                    </div>
                    <div class="form-group">
                        <label>Register Number</label>
                        <input type="text" name="regNo" class="form-control" required placeholder="SGP2024001">
                    </div>
                    <div class="form-group">
                        <label>Mobile Number</label>
                        <input type="tel" name="mobile" class="form-control" required placeholder="9876543210"
                            maxlength="10" minlength="10" pattern="[0-9]{10}">
                    </div>
                    <div class="form-group">
                        <label>Branch</label>
                        <select name="branch" class="form-control" required>
                            <option value="">Select Branch</option>
                            <option value="Computer Science">Computer Science</option>
                            <option value="Mechanical">Mechanical</option>
                            <option value="Electronics">Electronics</option>
                            <option value="Civil">Civil</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Gender</label>
                        <select name="gender" class="form-control" required>
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                    <!-- Upload Section -->
                    <div class="form-group full">
                        <label>Upload SSLC Marks Card (PDF/Image)</label>
                        <input type="file" name="sslcCard" class="form-control" required>
                    </div>
                    <div class="form-group full">
                        <label>Upload Diploma Marksheet (Latest Sem)</label>
                        <input type="file" name="diplomaCard" class="form-control" required>
                    </div>
                    <button type="submit" class="btn-reg">Create Account & Login</button>
                </div>
                <p style="text-align: center; margin-top: 1.5rem; font-size: 0.9rem;">
                    Already registered? <a href="login.jsp" style="color: #003366; font-weight: 600;">Login here</a>
                </p>
            </form>
        </div>

    </body>

    </html>