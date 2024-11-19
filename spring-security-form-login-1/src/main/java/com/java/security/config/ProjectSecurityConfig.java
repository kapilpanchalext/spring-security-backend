package com.java.security.config;

import static org.springframework.security.config.Customizer.withDefaults;

import java.util.Arrays;
import java.util.Collections;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;
import org.springframework.security.web.csrf.CsrfTokenRequestAttributeHandler;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import com.java.security.filter.CsrfCookieFilter;
import com.java.security.filter.JwtTokenGeneratorFilter;
import com.java.security.filter.JwtTokenValidatorFilter;

@Configuration
@Profile("!prod")
public class ProjectSecurityConfig {
	
	@Bean
    SecurityFilterChain defaultSecurityFilterChain(HttpSecurity http) throws Exception {
		CsrfTokenRequestAttributeHandler csrfTokenRequestAttributeHandler = 
				new CsrfTokenRequestAttributeHandler();
		
        http
        	.sessionManagement((sessionConfig) -> sessionConfig
        											.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
            
        	.cors(withDefaults())
            
            .csrf((csrfConfig) -> csrfConfig
            		.ignoringRequestMatchers("/home" ,"/register", "/login")
            		.csrfTokenRequestHandler(csrfTokenRequestAttributeHandler)
            		.csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse()))
            
            .addFilterBefore(new JwtTokenValidatorFilter(), BasicAuthenticationFilter.class)
            .addFilterAfter(new CsrfCookieFilter(), BasicAuthenticationFilter.class)
            .addFilterAfter(new JwtTokenGeneratorFilter(), BasicAuthenticationFilter.class)
            
            .authorizeHttpRequests((requests) -> 
                requests.requestMatchers("/api/v1/**").hasRole("ADMIN")
                		.requestMatchers("/student").authenticated()
                        .requestMatchers("/home", "/about", "/contact", "/register", "/error").permitAll());
        
        http.formLogin((flc) -> flc.defaultSuccessUrl("/home"));
        http.httpBasic(withDefaults());
        return http.build();
    }

    @Bean
    CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOrigins(Collections.singletonList("http://localhost:3000"));
        configuration.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        configuration.setAllowedHeaders(Arrays.asList("Authorization", "Content-Type"));
        configuration.setAllowCredentials(true);
        configuration.setExposedHeaders(Arrays.asList("Authorization"));
        configuration.setMaxAge(3600L);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }

	@Bean
	PasswordEncoder passwordEncoder() {
		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}
}
