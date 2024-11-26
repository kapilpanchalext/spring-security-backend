package com.java.user.model;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "student")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Student implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "student_id")
	private long student_id;
	private String name;
	private String email;

	@Column(name = "mobile_number")
	private String mobileNumber;
	
	@JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
	private String pwd;
//	private String role;

	@Column(name = "create_dt")
	@JsonIgnore
	private LocalDate createDt = LocalDate.now();

	@OneToMany(mappedBy = "student", fetch = FetchType.EAGER)
	private Set<Authority> authorities;
	
	@OneToMany(mappedBy = "student", fetch = FetchType.EAGER)
	private Set<Role> roles;
}
