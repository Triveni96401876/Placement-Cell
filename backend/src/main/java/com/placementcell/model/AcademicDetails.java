package com.placementcell.model;

import lombok.*;
import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "academic_details")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AcademicDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "student_id", nullable = false)
    private Student student;

    @Column(nullable = false)
    private Double sslcPercentage;

    @Column(nullable = false)
    private Integer sslcYear;

    @Column(nullable = false)
    private Double pucPercentage;

    @Column(nullable = false)
    private Integer pucYear;

    private Double diplomaPercentage;

    private Integer diplomaYear;

    private Double itiPercentage;

    private Integer itiYear;

    @Column(nullable = false)
    private String backlogStatus;

    @Column(nullable = false)
    private Integer currentBacklogCount;

    private String historyOfBacklogs;

    @Column(nullable = false)
    private Double cgpa;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}
