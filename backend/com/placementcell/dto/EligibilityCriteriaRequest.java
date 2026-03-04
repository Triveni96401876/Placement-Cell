package com.placementcell.dto;

import lombok.*;
import javax.validation.constraints.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EligibilityCriteriaRequest {
    @NotNull(message = "Minimum SSLC percentage is required")
    @DecimalMin("0.0")
    @DecimalMax("100.0")
    private Double minSslcPercentage;

    @NotNull(message = "Minimum PUC percentage is required")
    @DecimalMin("0.0")
    @DecimalMax("100.0")
    private Double minPucPercentage;

    @NotNull(message = "Minimum CGPA is required")
    @DecimalMin("0.0")
    @DecimalMax("10.0")
    private Double minCgpa;

    @NotNull(message = "Maximum backlog count is required")
    @Min(0)
    private Integer maxBacklogCount;

    private String allowedBranches;
}
