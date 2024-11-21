package com.java.security.api;

import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.java.security.model.Student;
import com.java.security.repository.StudentRepository;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class StudentController {
	
	private final StudentRepository studentRepository;
//	private final PasswordEncoder passwordEncoder;

//	@PostMapping(path = "/register")
//	public ResponseEntity<String> registerStudent(@RequestBody Student student){
//		try {
//			String hashPwd = passwordEncoder.encode(student.getPwd());
//			student.setPwd(hashPwd);
//			Student savedStudent = studentRepository.save(student);
//			
//			if(savedStudent.getStudent_id() > 0) {
//				return ResponseEntity
//						.status(HttpStatus.CREATED)
//						.body("User Registered Successfully!");
//			} else {
//				return ResponseEntity
//						.status(HttpStatus.BAD_REQUEST)
//						.body("Bad Request");
//			}
//		} catch(Exception e) {
//			return ResponseEntity
//					.status(HttpStatus.INTERNAL_SERVER_ERROR)
//					.body("An Exception Occurred: " + e.getMessage());
//		}
//	}
	
	@GetMapping(path = "/student")
	public ResponseEntity<String> getStudentDetails(Authentication authentication) {
		Optional<Student> optionalStudent = studentRepository.findByEmail(authentication.getName());
		return ResponseEntity.status(HttpStatus.OK).body(optionalStudent.get().toString());
	}
}
