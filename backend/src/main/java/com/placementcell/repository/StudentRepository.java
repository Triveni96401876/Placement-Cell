package com.placementcell.repository;

import com.placementcell.model.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface StudentRepository extends JpaRepository<Student, Long> {
    Optional<Student> findByRegisterNumber(String registerNumber);
    Optional<Student> findByUserId(Long userId);
    
    @Query("SELECT s FROM Student s WHERE s.branch = :branch")
    List<Student> findByBranch(@Param("branch") String branch);
    
    @Query("SELECT s FROM Student s JOIN s.academicDetails a WHERE a.cgpa >= :minCgpa")
    List<Student> findByMinCgpa(@Param("minCgpa") Double minCgpa);
    
    @Query("SELECT s FROM Student s WHERE s.fullName LIKE %:name%")
    List<Student> searchByName(@Param("name") String name);
}
