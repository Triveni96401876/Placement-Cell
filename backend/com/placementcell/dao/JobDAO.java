package com.placementcell.dao;

import com.placementcell.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JobDAO {

    public boolean postJob(String companyName, String jobRole, String description, String salary, String location,
            String branch, String lastDate, String logo) {
        String sql = "INSERT INTO jobs (company_name, job_role, description, salary, location, branch, last_date, logo) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, companyName);
            pstmt.setString(2, jobRole);
            pstmt.setString(3, description);
            pstmt.setString(4, salary);
            pstmt.setString(5, location);
            pstmt.setString(6, branch);
            pstmt.setString(7, lastDate);
            pstmt.setString(8, logo);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<String[]> getAllJobs() {
        List<String[]> jobs = new ArrayList<>();
        String sql = "SELECT * FROM jobs ORDER BY id DESC";
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                jobs.add(new String[] {
                        rs.getString("id"),
                        rs.getString("company_name"),
                        rs.getString("job_role"),
                        rs.getString("description"),
                        rs.getString("salary"),
                        rs.getString("location"),
                        rs.getString("branch"),
                        rs.getString("last_date"),
                        rs.getString("logo")
                });
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return jobs;
    }

    public boolean deleteJob(int id) {
        String sql = "DELETE FROM jobs WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean applyJob(String name, String regNo, String branch, String email, String phone, int jobId,
            String companyName, String jobRole, String resume) {
        String sql = "INSERT INTO job_applications (student_name, register_number, branch, email, phone, job_id, company_name, job_role, resume) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, name);
            pstmt.setString(2, regNo);
            pstmt.setString(3, branch);
            pstmt.setString(4, email);
            pstmt.setString(5, phone);
            pstmt.setInt(6, jobId);
            pstmt.setString(7, companyName);
            pstmt.setString(8, jobRole);
            pstmt.setString(9, resume);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<String[]> getApplicants(int jobId) {
        List<String[]> applicants = new ArrayList<>();
        String sql = "SELECT * FROM job_applications WHERE job_id = ? ORDER BY applied_date DESC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, jobId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                applicants.add(new String[] {
                        rs.getString("student_name"),
                        rs.getString("register_number"),
                        rs.getString("branch"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("company_name"),
                        rs.getString("job_role"),
                        rs.getTimestamp("applied_date").toString(),
                        rs.getString("resume")
                });
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return applicants;
    }

    public List<String[]> getAllApplicants() {
        List<String[]> applicants = new ArrayList<>();
        String sql = "SELECT * FROM job_applications ORDER BY applied_date DESC";
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                applicants.add(new String[] {
                        rs.getString("student_name"),
                        rs.getString("register_number"),
                        rs.getString("branch"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("company_name"),
                        rs.getString("job_role"),
                        rs.getTimestamp("applied_date").toString(),
                        rs.getString("resume")
                });
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return applicants;
    }

    public List<String[]> getApplicantsByBranch(String branch) {
        System.out.println("DEBUG: Searching job applications for branch: [" + branch + "]");
        List<String[]> applicants = new ArrayList<>();
        if (branch == null || branch.isEmpty())
            return applicants;

        String queryBranch = branch.trim();
        String altBranch = queryBranch;

        // Map various forms to standardized codes
        String bUpper = queryBranch.toUpperCase();
        if (bUpper.contains("COMPUTER") || bUpper.equals("CSE") || bUpper.equals("CS")) {
            queryBranch = "CSE";
            altBranch = "CS";
        } else if (bUpper.contains("MECHANICAL") || bUpper.equals("MECH")) {
            queryBranch = "MECH";
            altBranch = "MECHANICAL";
        } else if (bUpper.contains("CIVIL")) {
            queryBranch = "CIVIL";
            altBranch = "CIVIL";
        } else if (bUpper.contains("METALLURGY") || bUpper.equals("MT")) {
            queryBranch = "MT";
            altBranch = "METALLURGY";
        } else if (bUpper.contains("ELECTRICAL") || bUpper.equals("EEE")) {
            queryBranch = "EEE";
            altBranch = "EEE";
        }

        // Use LIKE and TRIM for maximum compatibility
        String sql = "SELECT * FROM job_applications WHERE TRIM(branch) LIKE ? OR TRIM(branch) LIKE ? OR TRIM(branch) LIKE ? ORDER BY applied_date DESC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "%" + branch.trim() + "%");
            pstmt.setString(2, "%" + queryBranch + "%");
            pstmt.setString(3, "%" + altBranch + "%");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                applicants.add(new String[] {
                        rs.getString("student_name"),
                        rs.getString("register_number"),
                        rs.getString("branch"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("company_name"),
                        rs.getString("job_role"),
                        rs.getTimestamp("applied_date").toString(),
                        rs.getString("resume")
                });
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return applicants;
    }

    public String[] getJobById(int id) {
        String sql = "SELECT * FROM jobs WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return new String[] {
                        rs.getString("id"),
                        rs.getString("company_name"),
                        rs.getString("job_role"),
                        rs.getString("description"),
                        rs.getString("salary"),
                        rs.getString("location"),
                        rs.getString("branch"),
                        rs.getString("last_date"),
                        rs.getString("logo")
                };
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
