package com.placementcell.model;

import lombok.*;
import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "eligible_students")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EligibleStudent {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "criteria_id", nullable = false)
    private EligibilityCriteria criteria;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "student_id", nullable = false)
    private Student student;

    @Column(name = "eligibility_date", nullable = false, updatable = false)
    private LocalDateTime eligibilityDate;

    @Column(nullable = false)
    private String status;

    @PrePersist
    protected void onCreate() {
        if (eligibilityDate == null) {
            eligibilityDate = LocalDateTime.now();
        }
    }
}
