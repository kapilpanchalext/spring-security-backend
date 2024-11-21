package com.java.security.filter;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

import javax.crypto.SecretKey;

import org.springframework.core.env.Environment;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class JwtTokenValidatorFilter extends OncePerRequestFilter{

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		
		String jwt = request.getHeader("Authorization");
		
		if(jwt != null){
			try {
				Environment env = getEnvironment();
				if(env != null) {
					String secret = env.getProperty("JWT_SECRET", 
							"$2a$12$JbnxIJbhzcPMK3452345324234xXCOL49BekIcqu41ZAMfDL0pQ/J58zhX5WhgZlIC");
					SecretKey secretKey = Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
					
					if(secretKey != null) {
						Claims claims = Jwts
							.parser()
							.verifyWith(secretKey)
							.build()
							.parseSignedClaims(jwt)
							.getPayload();
						
						String username = String.valueOf(claims.get("username"));
						String authorities = String.valueOf(claims.get("authorities"));
						
						Authentication authentication = 
								new UsernamePasswordAuthenticationToken(username, null, 
										AuthorityUtils.commaSeparatedStringToAuthorityList(authorities));
						SecurityContextHolder.getContext().setAuthentication(authentication);
						
					}
				}
			} catch(Exception e) {
				throw new BadCredentialsException("Invalid Token Received!");
			}
		}
		filterChain.doFilter(request, response);
	}

	@Override
	protected boolean shouldNotFilter(HttpServletRequest request) throws ServletException {
		return request.getServletPath().equals("/api/v1/helloworld");
	}
}