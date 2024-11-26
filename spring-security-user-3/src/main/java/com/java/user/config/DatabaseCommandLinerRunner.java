package com.java.user.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.java.user.model.Role;
import com.java.user.repository.RolesRepository;

import lombok.RequiredArgsConstructor;

@Configuration
@RequiredArgsConstructor
public class DatabaseCommandLinerRunner {

	private final RolesRepository repo;
	
//	@Bean
//    CommandLineRunner runner() {
//        return (args) -> {
//            Role role = new Role();
//            role.setName("SUPER_ADMIN");
//
//            repo.save(role);
//            System.err.println(repo.getByName("SUPER_ADMIN"));
//        };
//	}
}
