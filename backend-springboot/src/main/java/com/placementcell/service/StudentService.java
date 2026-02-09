package com.placementcell.service;

import com.placementcell.model.Student;
import com.placementcell.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class StudentService {

    @Autowired
    private StudentRepository studentRepository;

    public Student registerStudent(Student student) {
        return studentRepository.save(student);
    }

    public Optional<Student> login(String identifier, String password) {
        // Identifier can be Register Number or Email
        Optional<Student> byEmail = studentRepository.findByEmailAndPassword(identifier, password);
        if (byEmail.isPresent())
            return byEmail;

        return studentRepository.findByRegisterNumberAndPassword(identifier, password);
    }

    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }

    public Student getStudentById(Long id) {
        return studentRepository.findById(id).orElseThrow(() -> new RuntimeException("Student not found"));
    }

    public Student updateStudent(Long id, Student studentDetails) {
        Student student = getStudentById(id);
        student.setFullName(studentDetails.getFullName());
        student.setEmail(studentDetails.getEmail());
        student.setPhoneNumber(studentDetails.getPhoneNumber());
        student.setAddress(studentDetails.getAddress());
        student.setBranch(studentDetails.getBranch());
        student.setGender(studentDetails.getGender());
        student.setCgpa(studentDetails.getCgpa());
        student.setHistoryOfBacklog(studentDetails.getHistoryOfBacklog());
        student.setSslcCardPath(studentDetails.getSslcCardPath());
        student.setDiplomaCardPath(studentDetails.getDiplomaCardPath());
        student.setResumePath(studentDetails.getResumePath());
        student.setPhotoPath(studentDetails.getPhotoPath());
        // Add more fields if necessary
        return studentRepository.save(student);
    }
}
