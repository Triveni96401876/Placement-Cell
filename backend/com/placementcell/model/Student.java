package com.placementcell.model;

import java.io.Serializable;
import java.sql.Date;

public class Student implements Serializable {
    private Long id;
    private Long userId;
    private String registerNumber;
    private String fullName;
    private Date dateOfBirth;
    private String gender;
    private String branch;
    private String mobileNumber;
    private String alternativeMobileNumber;
    private String address;

    // Academic Details
    private Double sslcPercentage;
    private Integer sslcYear;
    private Double pucPercentage;
    private Integer pucYear;
    private Double itiPercentage;
    private Integer itiYear;

    // Semester details
    private Double sem1;
    private Double sem2;
    private Double sem3;
    private Double sem4;
    private Double sem5;
    private Double sem6;

    private Double cgpa;
    private Integer backlogCount;
    private String backlogStatus;
    private String backlogHistory;
    private String skills;

    private String sslcCardPath;
    private String diplomaCardPath;
    private String resumePath;
    private String resumeDescription;
    private String careerObjective;

    private String email;
    private String approvalStatus;
    private String placementStatus;
    private String placedCompany;
    private String internship;
    private Double diplomaPercentage;
    private Integer diplomaYear;
    private String preference;

    public Student() {
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }

    public String getPlacementStatus() {
        return placementStatus;
    }

    public void setPlacementStatus(String placementStatus) {
        this.placementStatus = placementStatus;
    }

    public String getPlacedCompany() {
        return placedCompany;
    }

    public void setPlacedCompany(String placedCompany) {
        this.placedCompany = placedCompany;
    }

    public String getInternship() {
        return internship;
    }

    public void setInternship(String internship) {
        this.internship = internship;
    }

    public Double getDiplomaPercentage() {
        return diplomaPercentage;
    }

    public void setDiplomaPercentage(Double diplomaPercentage) {
        this.diplomaPercentage = diplomaPercentage;
    }

    public Integer getDiplomaYear() {
        return diplomaYear;
    }

    public void setDiplomaYear(Integer diplomaYear) {
        this.diplomaYear = diplomaYear;
    }

    public String getPreference() {
        return preference;
    }

    public void setPreference(String preference) {
        this.preference = preference;
    }

    public String getCareerObjective() {
        return careerObjective;
    }

    public void setCareerObjective(String careerObjective) {
        this.careerObjective = careerObjective;
    }

    public String getResumePath() {
        return resumePath;
    }

    public void setResumePath(String resumePath) {
        this.resumePath = resumePath;
    }

    public String getResumeDescription() {
        return resumeDescription;
    }

    public void setResumeDescription(String resumeDescription) {
        this.resumeDescription = resumeDescription;
    }

    public String getSslcCardPath() {
        return sslcCardPath;
    }

    public void setSslcCardPath(String sslcCardPath) {
        this.sslcCardPath = sslcCardPath;
    }

    public String getDiplomaCardPath() {
        return diplomaCardPath;
    }

    public void setDiplomaCardPath(String diplomaCardPath) {
        this.diplomaCardPath = diplomaCardPath;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getRegisterNumber() {
        return registerNumber;
    }

    public void setRegisterNumber(String registerNumber) {
        this.registerNumber = registerNumber;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getBranch() {
        return branch;
    }

    public void setBranch(String branch) {
        this.branch = branch;
    }

    public String getMobileNumber() {
        return mobileNumber;
    }

    public void setMobileNumber(String mobileNumber) {
        this.mobileNumber = mobileNumber;
    }

    public String getAlternativeMobileNumber() {
        return alternativeMobileNumber;
    }

    public void setAlternativeMobileNumber(String alternativeMobileNumber) {
        this.alternativeMobileNumber = alternativeMobileNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Double getSslcPercentage() {
        return sslcPercentage;
    }

    public void setSslcPercentage(Double sslcPercentage) {
        this.sslcPercentage = sslcPercentage;
    }

    public Integer getSslcYear() {
        return sslcYear;
    }

    public void setSslcYear(Integer sslcYear) {
        this.sslcYear = sslcYear;
    }

    public Double getPucPercentage() {
        return pucPercentage;
    }

    public void setPucPercentage(Double pucPercentage) {
        this.pucPercentage = pucPercentage;
    }

    public Integer getPucYear() {
        return pucYear;
    }

    public void setPucYear(Integer pucYear) {
        this.pucYear = pucYear;
    }

    public Double getItiPercentage() {
        return itiPercentage;
    }

    public void setItiPercentage(Double itiPercentage) {
        this.itiPercentage = itiPercentage;
    }

    public Integer getItiYear() {
        return itiYear;
    }

    public void setItiYear(Integer itiYear) {
        this.itiYear = itiYear;
    }

    public Double getSem1() {
        return sem1;
    }

    public void setSem1(Double sem1) {
        this.sem1 = sem1;
    }

    public Double getSem2() {
        return sem2;
    }

    public void setSem2(Double sem2) {
        this.sem2 = sem2;
    }

    public Double getSem3() {
        return sem3;
    }

    public void setSem3(Double sem3) {
        this.sem3 = sem3;
    }

    public Double getSem4() {
        return sem4;
    }

    public void setSem4(Double sem4) {
        this.sem4 = sem4;
    }

    public Double getSem5() {
        return sem5;
    }

    public void setSem5(Double sem5) {
        this.sem5 = sem5;
    }

    public Double getSem6() {
        return sem6;
    }

    public void setSem6(Double sem6) {
        this.sem6 = sem6;
    }

    public Double getCgpa() {
        return cgpa;
    }

    public void setCgpa(Double cgpa) {
        this.cgpa = cgpa;
    }

    public Integer getBacklogCount() {
        return backlogCount;
    }

    public void setBacklogCount(Integer backlogCount) {
        this.backlogCount = backlogCount;
    }

    public String getBacklogStatus() {
        return backlogStatus;
    }

    public void setBacklogStatus(String backlogStatus) {
        this.backlogStatus = backlogStatus;
    }

    public String getBacklogHistory() {
        return backlogHistory;
    }

    public void setBacklogHistory(String backlogHistory) {
        this.backlogHistory = backlogHistory;
    }

    public String getSkills() {
        return skills;
    }

    public String getWelcomeName() {
        if (fullName == null || fullName.isEmpty())
            return registerNumber;
        String name = fullName;
        // Remove "Student" prefix if it exists
        if (name.toLowerCase().startsWith("student")) {
            name = name.substring(7).trim();
        }
        // Extract from parentheses if they exist
        if (name.contains("(") && name.contains(")")) {
            name = name.substring(name.indexOf("(") + 1, name.indexOf(")")).trim();
        }
        return name;
    }

    public void setSkills(String skills) {
        this.skills = skills;
    }
}
