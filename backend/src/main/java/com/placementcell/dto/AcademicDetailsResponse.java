package com.placementcell.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AcademicDetailsResponse {
    private Double sslcPercentage;
    private Integer sslcYear;
    private Double pucPercentage;
    private Integer pucYear;
    private Double diplomaPercentage;
    private Integer diplomaYear;
    private Double itiPercentage;
    private Integer itiYear;
    private Double cgpa;
    private String backlogStatus;
    private Integer currentBacklogCount;
    private String historyOfBacklogs;
}
