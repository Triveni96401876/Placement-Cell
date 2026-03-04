package com.placementcell.dto;

import lombok.*;
import javax.validation.constraints.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StudentRegistrationRequest {
    @NotBlank(message = "Email is required")
    @Email(message = "Email should be valid")
    private String email;

    @NotBlank(message = "Password is required")
    @Size(min = 6, message = "Password should be minimum 6 characters")
    private String password;

    @NotBlank(message = "Register number is required")
    private String registerNumber;

    @NotBlank(message = "Full name is required")
    private String fullName;

    @NotNull(message = "Date of birth is required")
    private String dateOfBirth;

    @NotBlank(message = "Gender is required")
    private String gender;

    @NotBlank(message = "Branch is required")
    private String branch;

    @NotBlank(message = "Mobile number is required")
    @Pattern(regexp = "^[0-9]{10}$", message = "Mobile number should be 10 digits")
    private String mobileNumber;

    private String alternateNumber;

    private String address;

    @NotNull(message = "SSLC percentage is required")
    @DecimalMin("0.0")
    @DecimalMax("100.0")
    private Double sslcPercentage;

    @NotNull(message = "SSLC year is required")
    private Integer sslcYear;

    @NotNull(message = "PUC percentage is required")
    @DecimalMin("0.0")
    @DecimalMax("100.0")
    private Double pucPercentage;

    @NotNull(message = "PUC year is required")
    private Integer pucYear;

    @DecimalMin("0.0")
    @DecimalMax("100.0")
    private Double diplomaPercentage;

    private Integer diplomaYear;

    @DecimalMin("0.0")
    @DecimalMax("100.0")
    private Double itiPercentage;

    private Integer itiYear;

    @NotNull(message = "Current CGPA is required")
    @DecimalMin("0.0")
    @DecimalMax("10.0")
    private Double cgpa;

    @NotNull(message = "Backlog status is required")
    private String backlogStatus;

    @NotNull(message = "Current backlog count is required")
    @Min(0)
    private Integer currentBacklogCount;

    private String historyOfBacklogs;
}
