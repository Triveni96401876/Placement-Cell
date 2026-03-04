package com.placementcell.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StudentResponse {
    private Long id;
    private String registerNumber;
    private String fullName;
    private String email;
    private String dateOfBirth;
    private String gender;
    private String branch;
    private String mobileNumber;
    private String alternateNumber;
    private String address;
    private AcademicDetailsResponse academicDetails;
}
