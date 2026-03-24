<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.placementcell.model.Student" %>
        <% Student student=(Student) request.getAttribute("studentResume"); if (student==null) {
            response.sendRedirect("login.jsp"); return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>
                    <%= student.getFullName() %> - Resume
                </title>
                <!-- Google Fonts -->
                <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <style>
                    :root {
                        --primary-color: #2c3e50;
                        --secondary-color: #34495e;
                        --accent-color: #3498db;
                        --text-color: #333;
                        --light-bg: #f5f6fa;
                        --border-color: #bdc3c7;
                    }

                    body {
                        font-family: 'Roboto', sans-serif;
                        background-color: var(--light-bg);
                        color: var(--text-color);
                        margin: 0;
                        padding: 20px;
                        display: flex;
                        justify-content: center;
                    }

                    .resume-container {
                        background-color: #fff;
                        width: 100%;
                        max-width: 850px;
                        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                        padding: 40px;
                        box-sizing: border-box;
                        border-top: 6px solid var(--accent-color);
                    }

                    .header {
                        border-bottom: 2px solid var(--border-color);
                        padding-bottom: 20px;
                        margin-bottom: 30px;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                    }

                    .header h1 {
                        color: var(--primary-color);
                        margin: 0 0 10px 0;
                        font-size: 2.5rem;
                        text-transform: uppercase;
                    }

                    .header p {
                        margin: 5px 0;
                        font-size: 1.1rem;
                        color: var(--secondary-color);
                    }

                    .contact-info {
                        text-align: right;
                        font-size: 0.95rem;
                        line-height: 1.6;
                    }

                    .contact-info i {
                        color: var(--accent-color);
                        width: 20px;
                        text-align: center;
                        margin-right: 5px;
                    }

                    .section {
                        margin-bottom: 30px;
                    }

                    .section-title {
                        color: var(--primary-color);
                        font-size: 1.4rem;
                        text-transform: uppercase;
                        border-bottom: 1px solid var(--border-color);
                        padding-bottom: 5px;
                        margin-bottom: 15px;
                        display: flex;
                        align-items: center;
                        gap: 10px;
                    }

                    .section-title i {
                        color: var(--accent-color);
                    }

                    .item {
                        margin-bottom: 15px;
                    }

                    .item h3 {
                        margin: 0 0 5px 0;
                        font-size: 1.1rem;
                        color: var(--secondary-color);
                    }

                    .item span.date {
                        float: right;
                        color: #7f8c8d;
                        font-size: 0.9rem;
                        font-weight: 500;
                    }

                    .item p {
                        margin: 5px 0;
                        line-height: 1.5;
                    }

                    .skills-list {
                        display: flex;
                        flex-wrap: wrap;
                        gap: 10px;
                    }

                    .skill-tag {
                        background-color: var(--light-bg);
                        border: 1px solid var(--border-color);
                        padding: 5px 12px;
                        border-radius: 4px;
                        font-size: 0.9rem;
                        color: var(--secondary-color);
                    }

                    table.marks-table {
                        width: 100%;
                        border-collapse: collapse;
                        margin-top: 10px;
                    }

                    table.marks-table th,
                    table.marks-table td {
                        border: 1px solid var(--border-color);
                        padding: 8px 12px;
                        text-align: left;
                    }

                    table.marks-table th {
                        background-color: var(--light-bg);
                        color: var(--primary-color);
                        font-weight: 600;
                    }

                    .print-btn {
                        position: fixed;
                        bottom: 30px;
                        right: 30px;
                        background-color: var(--accent-color);
                        color: #fff;
                        border: none;
                        padding: 12px 24px;
                        border-radius: 30px;
                        font-size: 1rem;
                        cursor: pointer;
                        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                        display: flex;
                        align-items: center;
                        gap: 10px;
                        transition: 0.3s;
                    }

                    .print-btn:hover {
                        background-color: #2980b9;
                    }

                    @media print {
                        body {
                            background-color: #fff;
                            padding: 0;
                        }

                        .resume-container {
                            box-shadow: none;
                            border-top: none;
                            padding: 0;
                        }

                        .print-btn {
                            display: none;
                        }
                    }
                </style>
            </head>

            <body>

                <div class="resume-container">
                    <!-- Header Section -->
                    <div class="header">
                        <div>
                            <h1>
                                <%= student.getFullName() %>
                            </h1>
                            <p><strong>
                                    <%= student.getBranch() %> Engineering
                                </strong></p>
                            <p>Register Number: <%= student.getRegisterNumber() %>
                            </p>
                        </div>
                        <div class="contact-info">
                            <% if(student.getEmail() !=null && !student.getEmail().isEmpty()) { %>
                                <div><i class="fas fa-envelope"></i>
                                    <%= student.getEmail() %>
                                </div>
                                <% } %>
                                    <div><i class="fas fa-phone"></i>
                                        <%= student.getMobileNumber() %>
                                    </div>
                                    <% if(student.getAddress() !=null && !student.getAddress().isEmpty()) { %>
                                        <div><i class="fas fa-map-marker-alt"></i>
                                            <%= student.getAddress() %>
                                        </div>
                                        <% } %>
                        </div>
                    </div>

                    <!-- Career Objective -->
                    <div class="section">
                        <h2 class="section-title"><i class="fas fa-bullseye"></i> Career Objective</h2>
                        <p>
                            <% if(student.getResumeDescription() !=null && !student.getResumeDescription().isEmpty()) {
                                %>
                                <%= student.getResumeDescription() %>
                                    <% } else { %>
                                        To secure a challenging position in a reputable organization to expand my
                                        learnings, knowledge, and skills based on my educational background in <%=
                                            student.getBranch() %> Engineering.
                                            <% } %>
                        </p>
                    </div>

                    <!-- Education -->
                    <div class="section">
                        <h2 class="section-title"><i class="fas fa-graduation-cap"></i> Academic Qualifications</h2>

                        <table class="marks-table">
                            <thead>
                                <tr>
                                    <th>Qualification</th>
                                    <th>Institution</th>
                                    <th>Year of Passing</th>
                                    <th>Percentage / CGPA</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Diploma in <%= student.getBranch() %>
                                    </td>
                                    <td>Sanjay Gandhi Polytechnic, Ballari</td>
                                    <td>
                                        <%= "2024" %>
                                    </td>
                                    <td><strong>
                                            <%= student.getCgpa() %> CGPA
                                        </strong></td>
                                </tr>
                                <% if(student.getPucPercentage() !=null) { %>
                                    <tr>
                                        <td>PUC (Pre-University)</td>
                                        <td>Recognized Board</td>
                                        <td>-</td>
                                        <td>
                                            <%= student.getPucPercentage() %>%
                                        </td>
                                    </tr>
                                    <% } %>
                                        <% if(student.getSslcPercentage() !=null) { %>
                                            <tr>
                                                <td>SSLC (10th)</td>
                                                <td>Recognized State Board</td>
                                                <td>-</td>
                                                <td>
                                                    <%= student.getSslcPercentage() %>%
                                                </td>
                                            </tr>
                                            <% } %>
                            </tbody>
                        </table>
                    </div>

                    <!-- Skills -->
                    <div class="section">
                        <h2 class="section-title"><i class="fas fa-cogs"></i> Technical Skills</h2>
                        <div class="skills-list">
                            <% String skillsStr=student.getSkills(); if (skillsStr !=null &&
                                !skillsStr.trim().isEmpty()) { String[] skills=skillsStr.split(","); for(String skill :
                                skills) { %>
                                <span class="skill-tag">
                                    <%= skill.trim() %>
                                </span>
                                <% } } else { %>
                                    <span class="skill-tag">Basic Computer Knowledge</span>
                                    <span class="skill-tag">Problem Solving</span>
                                    <span class="skill-tag">Communication</span>
                                    <% } %>
                        </div>
                    </div>

                    <!-- Personal Information -->
                    <div class="section">
                        <h2 class="section-title"><i class="fas fa-user"></i> Personal Information</h2>
                        <table style="width: 100%; border: none;">
                            <% if(student.getDateOfBirth() !=null) { %>
                                <tr>
                                    <td style="width: 200px; padding: 5px 0;"><strong>Date of Birth:</strong></td>
                                    <td>
                                        <%= student.getDateOfBirth() %>
                                    </td>
                                </tr>
                                <% } %>
                                    <% if(student.getGender() !=null) { %>
                                        <tr>
                                            <td style="width: 200px; padding: 5px 0;"><strong>Gender:</strong></td>
                                            <td>
                                                <%= student.getGender() %>
                                            </td>
                                        </tr>
                                        <% } %>
                                            <tr>
                                                <td style="width: 200px; padding: 5px 0;"><strong>Languages
                                                        Known:</strong></td>
                                                <td>English, Kannada, Hindi</td>
                                            </tr>
                        </table>
                    </div>

                    <!-- Declaration -->
                    <div class="section" style="margin-top: 50px;">
                        <p><strong>Declaration:</strong></p>
                        <p>I hereby declare that the above-mentioned information is correct and true to the best of my
                            knowledge and belief.</p>

                        <div style="margin-top: 40px; display: flex; justify-content: space-between;">
                            <div>
                                <p><strong>Date:</strong> _________________</p>
                                <p><strong>Place:</strong> _________________</p>
                            </div>
                            <div style="text-align: center;">
                                <p>___________________________________</p>
                                <p><strong>(<%= student.getFullName() %>)</strong></p>
                            </div>
                        </div>
                    </div>

                </div>

                <button class="print-btn" onclick="window.print()">
                    <i class="fas fa-print"></i> Print Resume
                </button>

            </body>

            </html>