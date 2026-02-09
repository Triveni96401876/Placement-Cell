package com.placementcell.controller;

import com.placementcell.dao.StudentDAO;
import com.placementcell.model.Student;
import com.placementcell.util.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    private StudentDAO studentDAO = new StudentDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect("login.html");
            return;
        }

        Student student = (Student) session.getAttribute("student");

        // Fetch form data
        String fullName = request.getParameter("fullName");
        String dob = request.getParameter("dob");
        String mobile = request.getParameter("mobile");
        String altMobile = request.getParameter("altMobile");
        String address = request.getParameter("address");

        String sslc = request.getParameter("sslc");
        String sslcYear = request.getParameter("sslcYear");
        String puc = request.getParameter("puc");
        String pucYear = request.getParameter("pucYear");

        String sem1 = request.getParameter("sem1");
        String sem2 = request.getParameter("sem2");
        String sem3 = request.getParameter("sem3");
        String sem4 = request.getParameter("sem4");
        String sem5 = request.getParameter("sem5");
        String sem6 = request.getParameter("sem6");
        String cgpa = request.getParameter("cgpa");
        String backlogHistory = request.getParameter("backlogHistory");
        String skills = request.getParameter("skills");

        try {
            // Update Student object in memory
            student.setFullName(fullName);
            if (dob != null && !dob.isEmpty())
                student.setDateOfBirth(Date.valueOf(dob));
            student.setMobileNumber(mobile);
            student.setAlternativeMobileNumber(altMobile);
            student.setAddress(address);

            student.setSslcPercentage(parseOptionDouble(sslc));
            student.setSslcYear(parseOptionInt(sslcYear));
            student.setPucPercentage(parseOptionDouble(puc));
            student.setPucYear(parseOptionInt(pucYear));

            student.setSem1(parseOptionDouble(sem1));
            student.setSem2(parseOptionDouble(sem2));
            student.setSem3(parseOptionDouble(sem3));
            student.setSem4(parseOptionDouble(sem4));
            student.setSem5(parseOptionDouble(sem5));
            student.setSem6(parseOptionDouble(sem6));

            student.setCgpa(parseOptionDouble(cgpa));
            student.setBacklogHistory(backlogHistory);
            student.setSkills(skills);

            // Update Database
            try (Connection conn = DBConnection.getConnection()) {
                conn.setAutoCommit(false);

                // 1. Update students table
                String sqlStudent = "UPDATE students SET full_name = ?, date_of_birth = ?, mobile_number = ?, alternate_number = ?, address = ? WHERE id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sqlStudent)) {
                    stmt.setString(1, student.getFullName());
                    stmt.setDate(2, student.getDateOfBirth());
                    stmt.setString(3, student.getMobileNumber());
                    stmt.setString(4, student.getAlternativeMobileNumber());
                    stmt.setString(5, student.getAddress());
                    stmt.setLong(6, student.getId());
                    stmt.executeUpdate();
                }

                // 2. Update academic_details table
                String sqlAcademic = "UPDATE academic_details SET sslc_percentage = ?, sslc_year = ?, puc_percentage = ?, puc_year = ?, sem1 = ?, sem2 = ?, sem3 = ?, sem4 = ?, sem5 = ?, sem6 = ?, cgpa = ?, history_of_backlogs = ?, backlog_status = ?, current_backlog_count = ? WHERE student_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sqlAcademic)) {
                    stmt.setDouble(1, student.getSslcPercentage());
                    stmt.setInt(2, student.getSslcYear());
                    stmt.setDouble(3, student.getPucPercentage());
                    stmt.setInt(4, student.getPucYear());
                    stmt.setDouble(5, student.getSem1());
                    stmt.setDouble(6, student.getSem2());
                    stmt.setDouble(7, student.getSem3());
                    stmt.setDouble(8, student.getSem4());
                    stmt.setDouble(9, student.getSem5());
                    stmt.setDouble(10, student.getSem6());
                    stmt.setDouble(11, student.getCgpa());
                    stmt.setString(12, student.getBacklogHistory());
                    stmt.setString(13, student.getBacklogStatus());
                    stmt.setInt(14, student.getBacklogCount());
                    stmt.setLong(15, student.getId());
                    stmt.executeUpdate();
                }

                // 3. Update skills
                studentDAO.saveSkills(student.getId(), skills);

                conn.commit();
                session.setAttribute("student", student);
                response.sendRedirect("DashboardServlet?success=profile_updated");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("profile.jsp?error=update_failed");
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
