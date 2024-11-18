package com.java.security.config;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.java.security.model.Student;
import com.java.security.repository.StudentRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StudentUserDetailsService implements UserDetailsService {
	
	private final StudentRepository studentRepository;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		try {
			Student student = studentRepository
					.findByEmail(username)
					.orElseThrow(() -> 
						new UsernameNotFoundException("Username not found for: " + username));
			
			List<GrantedAuthority> authorities = student
				.getAuthorities()
				.stream()
				.map(authority -> new SimpleGrantedAuthority(authority.getName()))
				.collect(Collectors.toList());
			
			return new User(student.getEmail(), 
					student.getPwd(), 
					authorities);
			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
