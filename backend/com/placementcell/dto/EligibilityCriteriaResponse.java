package com.placementcell.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EligibilityCriteriaResponse {
    private Long id;
    private Double minSslcPercentage;
    private Double minPucPercentage;
    private Double minCgpa;
    private Integer maxBacklogCount;
    private String allowedBranches;
    private String createdAt;
}
