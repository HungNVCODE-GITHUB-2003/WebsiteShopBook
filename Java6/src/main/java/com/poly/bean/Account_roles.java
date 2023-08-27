package com.poly.bean;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.Data;

@Data
@Entity
@Table(name = "Accounts_roles", uniqueConstraints = { @UniqueConstraint(columnNames = { "Account_id", "Roles_id" }) })
public class Account_roles implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@ManyToOne
	@JoinColumn(name = "Account_id")
	private Account account;
	@ManyToOne
	@JoinColumn(name = "Roles_id")
	private Role role;
}
