package com.placementcell.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;

@Entity
@Table(name = "students")
@Data
public class Student {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String registerNumber;

    @Column(nullable = false)
    private String fullName;

    private LocalDate dateOfBirth;
    private String gender;
    private String branch;

    @Column(unique = true, nullable = false)
    private String email;

    private String phoneNumber;
    private String address;
    private String password;

    // Academic fields for filtering
    private Double sslcPercentage;
    private Double pucPercentage;
    private Double cgpa;
    private String historyOfBacklog;

    // Document Paths
    private String sslcCardPath;
    private String diplomaCardPath;
    private String resumePath;
    private String photoPath;
}
