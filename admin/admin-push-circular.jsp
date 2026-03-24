<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>New Circular | SGP Admin</title>
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
            rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            :root {
                --primary: #00a8ff;
                --primary-dark: #0097e6;
                --primary-glow: rgba(0, 168, 255, 0.4);
                --bg: #f0f4f8;
                --white: #ffffff;
                --text-dark: #1e293b;
                --text-muted: #64748b;
                --glass: rgba(255, 255, 255, 0.9);
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Outfit', sans-serif;
            }

            body {
                background: radial-gradient(circle at top right, #e0e7ff, #f0f4f8);
                color: var(--text-dark);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 20px;
            }

            .modal-card {
                background: var(--glass);
                backdrop-filter: blur(10px);
                width: 100%;
                max-width: 650px;
                padding: 45px;
                border-radius: 35px;
                box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.1);
                border: 1px solid rgba(255, 255, 255, 0.7);
                position: relative;
                overflow: hidden;
            }

            .modal-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 6px;
                background: linear-gradient(90deg, var(--primary), #6366f1);
            }

            .header {
                text-align: center;
                margin-bottom: 40px;
            }

            .header .icon-box {
                width: 70px;
                height: 70px;
                background: linear-gradient(135deg, var(--primary), #6366f1);
                border-radius: 20px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 20px;
                box-shadow: 0 10px 20px var(--primary-glow);
                color: white;
                font-size: 2rem;
            }

            .header h1 {
                font-size: 2rem;
                font-weight: 800;
                letter-spacing: -0.5px;
                color: #0f172a;
            }

            .form-group {
                margin-bottom: 25px;
            }

            .form-group label {
                display: block;
                margin-bottom: 10px;
                font-weight: 700;
                color: #334155;
                font-size: 0.95rem;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .form-input {
                width: 100%;
                padding: 14px 20px;
                border: 2px solid #e2e8f0;
                border-radius: 16px;
                font-size: 1rem;
                outline: none;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                background: #f8fafc;
            }

            .form-input:focus {
                border-color: var(--primary);
                background: white;
                box-shadow: 0 0 0 4px var(--primary-glow);
            }

            textarea.form-input {
                min-height: 140px;
                resize: vertical;
            }

            /* Custom Segmented Control */
            .segmented-control {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 10px;
                background: #f1f5f9;
                padding: 6px;
                border-radius: 14px;
                border: 1px solid #e2e8f0;
                margin-top: 10px;
            }

            .segmented-control label {
                margin-bottom: 0;
                cursor: pointer;
                padding: 10px;
                text-align: center;
                border-radius: 10px;
                font-size: 0.9rem;
                font-weight: 600;
                transition: all 0.3s;
                justify-content: center;
                color: var(--text-muted);
            }

            .segmented-control input {
                display: none;
            }

            .segmented-control input:checked+label {
                background: white;
                color: var(--primary);
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            }

            /* File Input Styling */
            .file-upload-wrapper {
                position: relative;
                border: 2px dashed #cbd5e1;
                border-radius: 16px;
                padding: 20px;
                text-align: center;
                transition: all 0.3s;
                cursor: pointer;
                background: #f8fafc;
            }

            .file-upload-wrapper:hover {
                border-color: var(--primary);
                background: #f1f7ff;
            }

            .file-upload-wrapper input {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                opacity: 0;
                cursor: pointer;
            }

            .file-upload-info i {
                font-size: 1.5rem;
                color: var(--primary);
                margin-bottom: 8px;
            }

            /* Submit Button */
            .btn-submit {
                width: 100%;
                padding: 18px;
                background: linear-gradient(135deg, var(--primary), #6366f1);
                color: white;
                border: none;
                border-radius: 18px;
                font-size: 1.15rem;
                font-weight: 800;
                cursor: pointer;
                transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 12px;
                box-shadow: 0 10px 20px var(--primary-glow);
                margin-top: 10px;
            }

            .btn-submit:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 30px var(--primary-glow);
            }

            .btn-submit:active {
                transform: translateY(-2px);
            }

            .btn-back {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                margin-top: 30px;
                color: var(--text-muted);
                text-decoration: none;
                font-weight: 600;
                transition: color 0.3s;
                font-size: 0.95rem;
            }

            .btn-back:hover {
                color: var(--primary);
            }

            #filePreview {
                background: #ecfdf5;
                padding: 12px 20px;
                border-radius: 14px;
                border: 1px solid #10b981;
                margin-top: 15px;
                display: none;
                animation: slideDown 0.3s ease-out;
            }

            @keyframes slideDown {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        </style>
    </head>

    <body>
        <div class="modal-card">
            <div class="header">
                <div class="icon-box">
                    <i class="fas fa-bullhorn"></i>
                </div>
                <h1>New Circular</h1>
                <p style="color: var(--text-muted); margin-top: 10px; font-size: 0.95rem;">Send important updates and
                    documents to dashboards</p>
            </div>

            <form action="<%=request.getContextPath()%>/saveCircularServlet" method="POST" enctype="multipart/form-data" id="circularForm">
                <div class="form-group">
                    <label>Circular Title <span style="color: #e74c3c;">*</span></label>
                    <input type="text" name="title" id="circularTitle" class="form-input"
                        placeholder="e.g., Campus Placement Drive 2024" required>
                </div>

                <div class="form-group">
                    <label>Circular Message <span style="color: #e74c3c;">*</span></label>
                    <textarea name="message" id="circularMessage" class="form-input"
                        placeholder="Detailed information about the announcement..." required></textarea>
                </div>

                <div class="form-group">
                    <label>Attach File (Optional)</label>
                    <div class="file-upload-wrapper">
                        <input type="file" name="circularFile" id="circularFile" accept=".pdf,.jpg,.jpeg,.png">
                        <div class="file-upload-info">
                            <i class="fas fa-cloud-upload-alt"></i>
                            <p style="font-weight: 600; color: var(--text-dark);">Click to upload or drag and drop</p>
                            <p style="font-size: 0.8rem; color: var(--text-muted); margin-top: 4px;">PDF, JPG, PNG up to
                                5MB</p>
                        </div>
                    </div>
                    <div id="filePreview">
                        <div style="display: flex; align-items: center; gap: 12px;">
                            <i class="fas fa-check-circle" style="color: #10b981; font-size: 1.2rem;"></i>
                            <div>
                                <p id="fileName"
                                    style="margin: 0; color: #064e3b; font-weight: 700; font-size: 0.9rem;"></p>
                                <p id="fileSize" style="margin: 0; font-size: 0.8rem; color: #059669;"></p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label>Send To <span style="color: #e74c3c;">*</span></label>
                    <div class="segmented-control">
                        <input type="radio" name="sendTo" id="toStudent" value="STUDENT" checked>
                        <label for="toStudent">Student Dashboard</label>

                        <input type="radio" name="sendTo" id="toHOD" value="HOD">
                        <label for="toHOD">HOD Dashboard</label>

                        <input type="radio" name="sendTo" id="toBoth" value="BOTH">
                        <label for="toBoth">Both</label>
                    </div>
                </div>

                <div style="display: flex; justify-content: center; margin-top: 35px;">
                    <button type="submit" class="btn-submit" id="submitBtn" style="max-width: 320px;">
                        <i class="fas fa-paper-plane"></i> Send Circular
                    </button>
                </div>
            </form>

            <a href="<%=request.getContextPath()%>/AdminDashboardServlet" class="btn-back">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>

        <script>
            // File preview and validation
            document.getElementById('circularFile').addEventListener('change', function (e) {
                const file = e.target.files[0];
                const preview = document.getElementById('filePreview');
                const fileName = document.getElementById('fileName');
                const fileSize = document.getElementById('fileSize');

                if (file) {
                    if (file.size > 5 * 1024 * 1024) {
                        alert('File size should not exceed 5MB');
                        e.target.value = '';
                        preview.style.display = 'none';
                        return;
                    }
                    const validTypes = ['application/pdf', 'image/jpeg', 'image/jpg', 'image/png'];
                    if (!validTypes.includes(file.type)) {
                        alert('Please upload only PDF, JPG, or PNG files');
                        e.target.value = '';
                        preview.style.display = 'none';
                        return;
                    }

                    fileName.textContent = file.name;
                    fileSize.textContent = (file.size / 1024).toFixed(2) + ' KB';
                    preview.style.display = 'block';
                } else {
                    preview.style.display = 'none';
                }
            });

            // Form submission loading
            document.getElementById('circularForm').addEventListener('submit', function () {
                const submitBtn = document.getElementById('submitBtn');
                submitBtn.innerHTML = '<i class="fas fa-circle-notch fa-spin"></i> Sending...';
                submitBtn.style.opacity = '0.8';
                submitBtn.disabled = true;
            });

            window.addEventListener('DOMContentLoaded', function () {
                document.getElementById('circularTitle').focus();
            });
        </script>
    </body>

    </html>