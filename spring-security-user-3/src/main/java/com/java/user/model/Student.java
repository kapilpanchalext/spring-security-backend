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
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "student")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Student implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;

	@Column(name = "student_id")
	private int student_id;
	private String name;
	private String email;

	@Column(name = "mobile_number")
	private String mobileNumber;

	@JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
	private String password;

	@Column(name = "created_date")
	@JsonIgnore
	@Builder.Default
	private LocalDate createdDate = LocalDate.now();

	@Column(name = "created_by")
	@JsonIgnore
	@Builder.Default
	private String createdBy = "admin";

	@Column(name = "last_modified_date")
	@JsonIgnore
	@Builder.Default
	private LocalDate lastModifiDate = LocalDate.now();

	@Column(name = "last_modified_by")
	@JsonIgnore
	@Builder.Default
	private String lastModifiedBy = "admin";

	@OneToMany(mappedBy = "student", fetch = FetchType.EAGER)
	private Set<Role> roles;
}
