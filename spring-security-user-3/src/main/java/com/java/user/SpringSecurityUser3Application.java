package com.java.user;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;

@SpringBootApplication
@EnableWebSecurity(debug = true)
public class SpringSecurityUser3Application {

	public static void main(String[] args) {
		SpringApplication.run(SpringSecurityUser3Application.class, args);
	}

}
