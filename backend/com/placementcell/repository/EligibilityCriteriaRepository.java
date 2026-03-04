package com.placementcell.repository;

import com.placementcell.model.EligibilityCriteria;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EligibilityCriteriaRepository extends JpaRepository<EligibilityCriteria, Long> {
}
