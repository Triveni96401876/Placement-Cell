package com.placementcell.dao;

import com.placementcell.model.Student;
import com.placementcell.util.DBConnection;
import java.sql.*;

public class StudentDAO {

    public void registerStudent(Student student) throws SQLException {
        String sql = "INSERT INTO students (user_id, register_number, full_name, date_of_birth, gender, branch, mobile_number, alternate_number, address) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setLong(1, student.getUserId());
            stmt.setString(2, student.getRegisterNumber());
            stmt.setString(3, student.getFullName());
            stmt.setDate(4, student.getDateOfBirth());
            stmt.setString(5, student.getGender());
            stmt.setString(6, student.getBranch());
            stmt.setString(7, student.getMobileNumber());
            stmt.setString(8, student.getAlternativeMobileNumber());
            stmt.setString(9, student.getAddress());
            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                student.setId(rs.getLong(1));
            }
        }
    }

    public void saveAcademicDetails(Long studentId, Student student) throws SQLException {
        String sql = "INSERT INTO academic_details (student_id, sslc_percentage, sslc_year, puc_percentage, puc_year, iti_percentage, iti_year, sem1, sem2, sem3, sem4, sem5, sem6, backlog_status, current_backlog_count, history_of_backlogs, cgpa) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, studentId);
            stmt.setDouble(2, student.getSslcPercentage() != null ? student.getSslcPercentage() : 0.0);
            stmt.setInt(3, student.getSslcYear() != null ? student.getSslcYear() : 0);
            stmt.setDouble(4, student.getPucPercentage() != null ? student.getPucPercentage() : 0.0);
            stmt.setInt(5, student.getPucYear() != null ? student.getPucYear() : 0);
            stmt.setDouble(6, student.getItiPercentage() != null ? student.getItiPercentage() : 0.0);
            stmt.setInt(7, student.getItiYear() != null ? student.getItiYear() : 0);
            stmt.setDouble(8, student.getSem1() != null ? student.getSem1() : 0.0);
            stmt.setDouble(9, student.getSem2() != null ? student.getSem2() : 0.0);
            stmt.setDouble(10, student.getSem3() != null ? student.getSem3() : 0.0);
            stmt.setDouble(11, student.getSem4() != null ? student.getSem4() : 0.0);
            stmt.setDouble(12, student.getSem5() != null ? student.getSem5() : 0.0);
            stmt.setDouble(13, student.getSem6() != null ? student.getSem6() : 0.0);
            stmt.setString(14, student.getBacklogStatus());
            stmt.setInt(15, student.getBacklogCount() != null ? student.getBacklogCount() : 0);
            stmt.setString(16, student.getBacklogHistory());
            stmt.setDouble(17, student.getCgpa() != null ? student.getCgpa() : 0.0);
            stmt.executeUpdate();
        }
    }

    public void saveSkills(Long studentId, String skills) throws SQLException {
        String sql = "INSERT INTO resumes (student_id, skills) VALUES (?, ?) ON DUPLICATE KEY UPDATE skills = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, studentId);
            stmt.setString(2, skills);
            stmt.setString(3, skills);
            stmt.executeUpdate();
        }
    }

    public void saveDocuments(Long studentId, String sslcPath, String diplomaPath, String resumePath)
            throws SQLException {
        String sql = "INSERT INTO resumes (student_id, sslc_path, diploma_path, resume_path) VALUES (?, ?, ?, ?) " +
                "ON DUPLICATE KEY UPDATE sslc_path = ?, diploma_path = ?, resume_path = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, studentId);
            stmt.setString(2, sslcPath);
            stmt.setString(3, diplomaPath);
            stmt.setString(4, resumePath);
            stmt.setString(5, sslcPath);
            stmt.setString(6, diplomaPath);
            stmt.setString(7, resumePath);
            stmt.executeUpdate();
        }
    }

    public void updateResume(Long studentId, String resumePath, String description) throws SQLException {
        String sql = "UPDATE resumes SET resume_path = ?, resume_description = ?, career_objective = ? WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, resumePath);
            stmt.setString(2, description);
            stmt.setString(3, description);
            stmt.setLong(4, studentId);
            stmt.executeUpdate();
        }
    }

    public Student getStudentByUserId(Long userId) {
        String sql = "SELECT s.*, ad.*, r.skills, r.sslc_path, r.diploma_path, r.resume_path, r.resume_description " +
                "FROM students s " +
                "LEFT JOIN academic_details ad ON s.id = ad.student_id " +
                "LEFT JOIN resumes r ON s.id = r.student_id " +
                "WHERE s.user_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Student s = new Student();
                s.setId(rs.getLong("id"));
                s.setUserId(rs.getLong("user_id"));
                s.setFullName(rs.getString("full_name"));
                s.setRegisterNumber(rs.getString("register_number"));
                s.setBranch(rs.getString("branch"));
                s.setGender(rs.getString("gender"));
                s.setDateOfBirth(rs.getDate("date_of_birth"));
                s.setMobileNumber(rs.getString("mobile_number"));
                s.setAlternativeMobileNumber(rs.getString("alternate_number"));
                s.setAddress(rs.getString("address"));

                s.setSslcPercentage(rs.getDouble("sslc_percentage"));
                s.setSslcYear(rs.getInt("sslc_year"));
                s.setPucPercentage(rs.getDouble("puc_percentage"));
                s.setPucYear(rs.getInt("puc_year"));
                s.setItiPercentage(rs.getDouble("iti_percentage"));
                s.setItiYear(rs.getInt("iti_year"));

                s.setSem1(rs.getDouble("sem1"));
                s.setSem2(rs.getDouble("sem2"));
                s.setSem3(rs.getDouble("sem3"));
                s.setSem4(rs.getDouble("sem4"));
                s.setSem5(rs.getDouble("sem5"));
                s.setSem6(rs.getDouble("sem6"));

                s.setBacklogStatus(rs.getString("backlog_status"));
                s.setBacklogCount(rs.getInt("current_backlog_count"));
                s.setBacklogHistory(rs.getString("history_of_backlogs"));
                s.setCgpa(rs.getDouble("cgpa"));
                s.setSkills(rs.getString("skills"));
                s.setCareerObjective(rs.getString("career_objective"));
                s.setSslcCardPath(rs.getString("sslc_path"));
                s.setDiplomaCardPath(rs.getString("diploma_path"));
                s.setResumePath(rs.getString("resume_path"));
                s.setResumeDescription(rs.getString("resume_description"));
                return s;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Student getStudentById(Long studentId) {
        String sql = "SELECT s.*, ad.*, r.skills, r.sslc_path, r.diploma_path, r.resume_path, r.resume_description " +
                "FROM students s " +
                "LEFT JOIN academic_details ad ON s.id = ad.student_id " +
                "LEFT JOIN resumes r ON s.id = r.student_id " +
                "WHERE s.id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, studentId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Student s = new Student();
                s.setId(rs.getLong("id"));
                s.setUserId(rs.getLong("user_id"));
                s.setFullName(rs.getString("full_name"));
                s.setRegisterNumber(rs.getString("register_number"));
                s.setBranch(rs.getString("branch"));
                s.setGender(rs.getString("gender"));
                s.setDateOfBirth(rs.getDate("date_of_birth"));
                s.setMobileNumber(rs.getString("mobile_number"));
                s.setAlternativeMobileNumber(rs.getString("alternate_number"));
                s.setAddress(rs.getString("address"));

                s.setSslcPercentage(rs.getDouble("sslc_percentage"));
                s.setSslcYear(rs.getInt("sslc_year"));
                s.setPucPercentage(rs.getDouble("puc_percentage"));
                s.setPucYear(rs.getInt("puc_year"));
                s.setItiPercentage(rs.getDouble("iti_percentage"));
                s.setItiYear(rs.getInt("iti_year"));

                s.setSem1(rs.getDouble("sem1"));
                s.setSem2(rs.getDouble("sem2"));
                s.setSem3(rs.getDouble("sem3"));
                s.setSem4(rs.getDouble("sem4"));
                s.setSem5(rs.getDouble("sem5"));
                s.setSem6(rs.getDouble("sem6"));

                s.setBacklogStatus(rs.getString("backlog_status"));
                s.setBacklogCount(rs.getInt("current_backlog_count"));
                s.setBacklogHistory(rs.getString("history_of_backlogs"));
                s.setCgpa(rs.getDouble("cgpa"));
                s.setSkills(rs.getString("skills"));
                s.setCareerObjective(rs.getString("career_objective"));
                s.setSslcCardPath(rs.getString("sslc_path"));
                s.setDiplomaCardPath(rs.getString("diploma_path"));
                s.setResumePath(rs.getString("resume_path"));
                s.setResumeDescription(rs.getString("resume_description"));
                return s;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
