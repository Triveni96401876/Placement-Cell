package com.placementcell.controller;

import com.placementcell.dao.StudentDAO;
import com.placementcell.dao.UserDAO;
import com.placementcell.model.Student;
import com.placementcell.model.User;
import com.placementcell.util.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;

@WebServlet("/RegisterServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();
    private StudentDAO studentDAO = new StudentDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Personal Details
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String regNo = request.getParameter("regNo");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String branch = request.getParameter("branch");
        String mobile = request.getParameter("mobile");
        String altMobile = request.getParameter("altMobile");
        String address = request.getParameter("address");

        // 2. Academic (Schooling)
        String sslc = request.getParameter("sslc");
        String sslcYear = request.getParameter("sslcYear");
        String puc = request.getParameter("puc");
        String pucYear = request.getParameter("pucYear");
        String iti = request.getParameter("iti");
        String itiYear = request.getParameter("itiYear");

        // 3. Diploma Semesters
        String sem1 = request.getParameter("sem1");
        String sem2 = request.getParameter("sem2");
        String sem3 = request.getParameter("sem3");
        String sem4 = request.getParameter("sem4");
        String sem5 = request.getParameter("sem5");
        String sem6 = request.getParameter("sem6");
        String cgpa = request.getParameter("cgpa");
        String backlogs = request.getParameter("backlogs");
        String backlogHistory = request.getParameter("backlogHistory");

        // 4. Skills
        String skills = request.getParameter("skills");

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            // Create User account
            User user = new User();
            user.setEmail(email);
            user.setPassword(password);
            user.setRole("STUDENT");
            Long userId = userDAO.registerUser(user);
            user.setId(userId);

            if (userId != null) {
                // Map data to Student model
                Student student = new Student();
                student.setUserId(userId);
                student.setFullName(fullName);
                student.setRegisterNumber(regNo);
                student.setMobileNumber(mobile);
                student.setAlternativeMobileNumber(altMobile);
                student.setAddress(address);
                student.setGender(gender);
                student.setBranch(branch);

                try {
                    if (dob != null && !dob.isEmpty())
                        student.setDateOfBirth(Date.valueOf(dob));
                    else
                        student.setDateOfBirth(Date.valueOf("2000-01-01"));
                } catch (Exception e) {
                    student.setDateOfBirth(Date.valueOf("2000-01-01"));
                }

                // Parse numeric fields
                student.setSslcPercentage(parseOptionDouble(sslc));
                student.setSslcYear(parseOptionInt(sslcYear));
                student.setPucPercentage(parseOptionDouble(puc));
                student.setPucYear(parseOptionInt(pucYear));
                student.setItiPercentage(parseOptionDouble(iti));
                student.setItiYear(parseOptionInt(itiYear));

                student.setSem1(parseOptionDouble(sem1));
                student.setSem2(parseOptionDouble(sem2));
                student.setSem3(parseOptionDouble(sem3));
                student.setSem4(parseOptionDouble(sem4));
                student.setSem5(parseOptionDouble(sem5));
                student.setSem6(parseOptionDouble(sem6));

                student.setCgpa(parseOptionDouble(cgpa));
                Integer balcklogCount = parseOptionInt(backlogs);
                student.setBacklogCount(balcklogCount);
                student.setBacklogStatus(balcklogCount > 0 ? "HAS_BACKLOGS" : "NO_BACKLOGS");
                student.setBacklogHistory(backlogHistory);
                student.setSkills(skills);

                // 5. Handle File Uploads (Resume & Photo)
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists())
                    uploadDir.mkdir();

                // Handle Resume
                Part resumePart = request.getPart("resume");
                if (resumePart != null && resumePart.getSize() > 0) {
                    String fileName = regNo + "_resume.pdf";
                    resumePart.write(uploadPath + File.separator + fileName);
                    student.setResumePath(fileName);
                }

                // Handle Photo
                Part photoPart = request.getPart("photo");
                if (photoPart != null && photoPart.getSize() > 0) {
                    String fileName = regNo + "_photo.jpg";
                    photoPart.write(uploadPath + File.separator + fileName);
                }

                // Handle SSLC Card
                Part sslcPart = request.getPart("sslcCard");
                if (sslcPart != null && sslcPart.getSize() > 0) {
                    String fileName = regNo + "_sslc_card.pdf";
                    sslcPart.write(uploadPath + File.separator + fileName);
                    student.setSslcCardPath(fileName);
                }

                // Handle Diploma Card
                Part diplomaPart = request.getPart("diplomaCard");
                if (diplomaPart != null && diplomaPart.getSize() > 0) {
                    String fileName = regNo + "_diploma_latest.pdf";
                    diplomaPart.write(uploadPath + File.separator + fileName);
                    student.setDiplomaCardPath(fileName);
                }

                // Save Student and Academic details
                studentDAO.registerStudent(student);
                studentDAO.saveAcademicDetails(student.getId(), student);

                if (skills != null && !skills.isEmpty()) {
                    studentDAO.saveSkills(student.getId(), skills);
                }

                // Save documents (marksheet paths)
                studentDAO.saveDocuments(student.getId(), student.getSslcCardPath(), student.getDiplomaCardPath(),
                        student.getResumePath());

                conn.commit();

                // Redirect back to register page with success flag
                response.sendRedirect("register.html?status=success");
            } else {
                response.sendRedirect("register.html?error=registration_failed");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("register.html?error=exception");
        }
    }

    private Double parseOptionDouble(String val) {
        try {
            return (val != null && !val.isEmpty()) ? Double.parseDouble(val) : 0.0;
        } catch (NumberFormatException e) {
            return 0.0;
        }
    }

    private Integer parseOptionInt(String val) {
        try {
            return (val != null && !val.isEmpty()) ? Integer.parseInt(val) : 0;
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}
