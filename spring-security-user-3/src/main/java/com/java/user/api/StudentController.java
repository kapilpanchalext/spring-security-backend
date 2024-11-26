package com.java.user.api;

import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.java.user.model.Role;
import com.java.user.model.Student;
import com.java.user.repository.RolesRepository;
import com.java.user.repository.StudentRepository;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class StudentController {
	
	private final StudentRepository repo;
	private final RolesRepository rolesRepo;
	private final PasswordEncoder passwordEncoder;

	@PostMapping(path = "/register-student")
	public ResponseEntity<String> registerStudent(@RequestBody Student student){
		try {
			String hashPwd = passwordEncoder.encode(student.getPassword());
			student.setPassword(hashPwd);
			Student savedStudent = repo.save(student);
			
			if(savedStudent.getStudent_id() > 0) {
				return ResponseEntity
						.status(HttpStatus.CREATED)
						.body("User Registered Successfully!");
			} else {
				return ResponseEntity
						.status(HttpStatus.BAD_REQUEST)
						.body("Bad Request");
			}
		} catch(Exception e) {
			return ResponseEntity
					.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("An Exception Occurred: " + e.getMessage());
		}
	}
	
	@PostMapping(path = "/register-role")
	public ResponseEntity<String> registerNewRole(@RequestBody Role role){
		try {
			Role savedRole = rolesRepo.save(role);
			
			if(savedRole.getId() > 0) {
				return ResponseEntity
						.status(HttpStatus.CREATED)
						.body("New Role Created Successfully!");
			} else {
				return ResponseEntity
						.status(HttpStatus.BAD_REQUEST)
						.body("Bad Request");
			}
		} catch(Exception e) {
			return ResponseEntity
					.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("An Exception Occurred: " + e.getMessage());
		}
	}
	
	@PostMapping(path = "assign-roles")
	public ResponseEntity<String> assignRoleToStudent(@RequestParam String role, 
														@RequestParam long studentId){
		
		Student student = repo.getById(studentId);
		Role studentRole = Role.builder().name(role).build();
		
//		student.setRoles(new HashSet<Role>(studentRole));
		
		System.err.println(student);
		System.err.println(studentRole);
		
		return ResponseEntity
				.status(HttpStatus.OK)
				.body("Role Assigned To Student");
	}
	
	@GetMapping(path = "/student")
	public ResponseEntity<String> getStudentDetails(Authentication authentication) {
		Optional<Student> optionalStudent = repo.findByEmail(authentication.getName());
		return ResponseEntity.status(HttpStatus.OK).body(optionalStudent.get().toString());
	}
}
