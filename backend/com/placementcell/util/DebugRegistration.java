package com.placementcell.util;

import com.placementcell.dao.StudentDAO;
import com.placementcell.dao.UserDAO;
import com.placementcell.model.Student;
import com.placementcell.model.User;
import java.sql.Date;
import java.sql.SQLException;

public class DebugRegistration {

    public static void main(String[] args) {
        System.out.println("Starting registration debug...");

        UserDAO userDAO = new UserDAO();
        StudentDAO studentDAO = new StudentDAO();

        // Mock data representing what the form sends
        String email = "debug_student_" + System.currentTimeMillis() + "@test.com";
        String password = "password123";
        String regNo = "REG" + System.currentTimeMillis();
        String mobile = "9876543210"; // Valid 10 digit

        try {
            // Step 1: Create User
            System.out.println("Attempting to create User...");
            User user = new User();
            user.setEmail(email);
            user.setPassword(password);
            user.setRole("STUDENT");

            Long userId = userDAO.registerUser(user);
            System.out.println("User created with ID: " + userId);

            if (userId == null) {
                System.err.println("Failed to create user (UserId is null)");
                return;
            }

            // Step 2: Create Student
            System.out.println("Attempting to create Student...");
            Student student = new Student();
            student.setUserId(userId);
            student.setRegisterNumber(regNo);
            student.setFullName("Debug Student");
            student.setDateOfBirth(Date.valueOf("2000-01-01"));
            student.setGender("Male");
            student.setBranch("CSE");
            student.setMobileNumber(mobile);
            student.setAlternativeMobileNumber(null);
            student.setAddress("123 Debug Lane");

            // Academic Data (matches RegisterServlet defaults)
            student.setSslcPercentage(85.5);
            student.setSslcYear(2016);
            student.setPucPercentage(88.2);
            student.setPucYear(2018);
            student.setCgpa(8.5);
            student.setBacklogStatus("NO_BACKLOGS");
            student.setBacklogCount(0);

            studentDAO.registerStudent(student);
            System.out.println("Student basic details saved.");

            // Step 3: Save Academic Details
            System.out.println("Attempting to save academic details...");
            studentDAO.saveAcademicDetails(student.getId(), student);
            System.out.println("Academic details saved.");

            System.out.println("[SUCCESS] REGISTRATION SUCCESSFUL! The code logic is fine.");

        } catch (SQLException e) {
            System.err.println("\n[FAILED] REGISTRATION FAILED!");
            System.err.println("--------------------------------------------------");
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            System.err.println("Message: " + e.getMessage());
            System.err.println("--------------------------------------------------");
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("\n[ERROR] UNEXPECTED ERROR!");
            e.printStackTrace();
        }

    }
}
