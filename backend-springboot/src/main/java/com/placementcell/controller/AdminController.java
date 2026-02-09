package com.placementcell.controller;

import com.placementcell.model.Student;
import com.placementcell.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/admin")
@CrossOrigin(origins = "*")
public class AdminController {

    @Autowired
    private StudentService studentService;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody AdminLoginRequest request) {
        // Hardcoded admin for demo as per common requirement
        if ("admin".equals(request.getUsername()) && "nayeembashasir".equals(request.getPassword())) {
            return ResponseEntity.ok("Admin Login Successful");
        }
        return ResponseEntity.status(401).body("Invalid Admin Credentials");
    }

    @GetMapping("/students")
    public List<Student> getStudents(
            @RequestParam(required = false) String branch,
            @RequestParam(required = false) Double minCgpa,
            @RequestParam(required = false) String hasBacklog) {

        List<Student> allStudents = studentService.getAllStudents();

        return allStudents.stream()
                .filter(s -> branch == null || branch.isEmpty() || s.getBranch().equalsIgnoreCase(branch))
                .filter(s -> minCgpa == null || s.getCgpa() >= minCgpa)
                .filter(s -> hasBacklog == null || hasBacklog.isEmpty()
                        || s.getHistoryOfBacklog().equalsIgnoreCase(hasBacklog))
                .collect(Collectors.toList());
    }
}

class AdminLoginRequest {
    private String username;
    private String password;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
