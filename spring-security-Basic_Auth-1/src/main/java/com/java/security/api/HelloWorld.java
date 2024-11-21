package com.java.security.api;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/api/v1")
public class HelloWorld {
	
	@Value("${app.api.key}")
	private String myApiKey;

	@GetMapping(path = "/helloworld")
	public ResponseEntity<String> getHelloWorld() {
		
		return ResponseEntity
					.status(HttpStatus.OK)
					.body(myApiKey);
	}
}
