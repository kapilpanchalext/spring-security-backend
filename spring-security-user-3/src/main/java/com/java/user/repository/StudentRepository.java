package com.java.user.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.java.user.model.Student;

public interface StudentRepository extends JpaRepository<Student, Long>{

	Optional<Student> findByEmail(String email);
	
}
