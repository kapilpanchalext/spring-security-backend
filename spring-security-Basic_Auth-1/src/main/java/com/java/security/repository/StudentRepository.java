package com.java.security.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.java.security.model.Student;

public interface StudentRepository extends JpaRepository<Student, Long>{

	Optional<Student> findByEmail(String email);
}
