package com.placementcell.repository;

import com.placementcell.model.EligibleStudent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EligibleStudentRepository extends JpaRepository<EligibleStudent, Long> {
    List<EligibleStudent> findByCriteriaId(Long criteriaId);
    List<EligibleStudent> findByStudentId(Long studentId);
}
