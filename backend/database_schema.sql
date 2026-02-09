-- Create Database
CREATE DATABASE IF NOT EXISTS placement_cell;
USE placement_cell;

-- User Table (Base for Student and Admin)
CREATE TABLE users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'STUDENT',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT chk_role CHECK (role IN ('STUDENT', 'ADMIN'))
);

-- Student Table
CREATE TABLE students (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL UNIQUE,
    register_number VARCHAR(50) NOT NULL UNIQUE,
    full_name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10) NOT NULL,
    branch VARCHAR(100) NOT NULL,
    mobile_number VARCHAR(10) NOT NULL,
    alternate_number VARCHAR(10),
    address VARCHAR(255),
    CONSTRAINT chk_mobile CHECK (mobile_number REGEXP '^[0-9]{10}$'),
    CONSTRAINT chk_alternate CHECK (alternate_number IS NULL OR alternate_number REGEXP '^[0-9]{10}$'),
    profile_picture LONGBLOB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Academic Details Table
CREATE TABLE academic_details (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    student_id BIGINT NOT NULL UNIQUE,
    sslc_percentage DECIMAL(5,2) NOT NULL,
    sslc_year INT NOT NULL,
    puc_percentage DECIMAL(5,2) NOT NULL,
    puc_year INT NOT NULL,
    diploma_percentage DECIMAL(5,2),
    diploma_year INT,
    iti_percentage DECIMAL(5,2),
    iti_year INT,
    sem1 DECIMAL(5,2),
    sem2 DECIMAL(5,2),
    sem3 DECIMAL(5,2),
    sem4 DECIMAL(5,2),
    sem5 DECIMAL(5,2),
    sem6 DECIMAL(5,2),
    backlog_status VARCHAR(50) DEFAULT 'NO_BACKLOG',
    current_backlog_count INT DEFAULT 0,
    history_of_backlogs VARCHAR(255),
    cgpa DECIMAL(3,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

-- Eligibility Criteria Table
CREATE TABLE eligibility_criteria (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    min_sslc_percentage DECIMAL(5,2) NOT NULL,
    min_puc_percentage DECIMAL(5,2) NOT NULL,
    min_cgpa DECIMAL(3,2) NOT NULL,
    max_backlog_count INT NOT NULL DEFAULT 0,
    allowed_branches VARCHAR(255),
    created_by BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id)
);

-- Eligible Students Table (Auto-generated based on criteria)
CREATE TABLE eligible_students (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    criteria_id BIGINT NOT NULL,
    student_id BIGINT NOT NULL,
    eligibility_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'ELIGIBLE',
    FOREIGN KEY (criteria_id) REFERENCES eligibility_criteria(id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    UNIQUE KEY unique_criteria_student (criteria_id, student_id)
);

-- Announcements Table
CREATE TABLE announcements (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    announcement_type VARCHAR(50) NOT NULL,
    created_by BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id)
);

-- Admin Table
CREATE TABLE admins (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL UNIQUE,
    full_name VARCHAR(255) NOT NULL,
    mobile_number VARCHAR(20) NOT NULL,
    department VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Resumes Table
CREATE TABLE IF NOT EXISTS resumes (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    student_id BIGINT NOT NULL UNIQUE,
    career_objective TEXT,
    skills TEXT,
    experience VARCHAR(100),
    project_details TEXT,
    achievements TEXT,
    sslc_path VARCHAR(255),
    diploma_path VARCHAR(255),
    resume_path VARCHAR(255),
    resume_description TEXT,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

-- Circulars Table for popups
CREATE TABLE IF NOT EXISTS circulars (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    message TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by BIGINT,
    FOREIGN KEY (created_by) REFERENCES users(id)
);

-- Create Indexes for Better Performance
CREATE INDEX idx_user_email ON users(email);
CREATE INDEX idx_user_role ON users(role);
CREATE INDEX idx_student_user ON students(user_id);
CREATE INDEX idx_student_register ON students(register_number);
CREATE INDEX idx_student_branch ON students(branch);
CREATE INDEX idx_academic_student ON academic_details(student_id);
CREATE INDEX idx_eligible_criteria ON eligible_students(criteria_id);
CREATE INDEX idx_eligible_student ON eligible_students(student_id);
CREATE INDEX idx_announcement_creator ON announcements(created_by);
CREATE INDEX idx_resume_student ON resumes(student_id);
CREATE INDEX idx_circular_active ON circulars(is_active);
