package com.poly.bean;

import java.io.Serializable;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "Reviews")
public class Review implements Serializable {
	@Id
	String Id;
	@ManyToOne
	@JoinColumn(name = "Book_id")
	Book book;
	@ManyToOne
	@JoinColumn(name = "Account_id")
	Account account;
	String Review;
	Date date = new Date();
}
