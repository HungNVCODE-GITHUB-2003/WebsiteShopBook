package com.poly.bean;

import java.io.Serializable;


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
@Table(name = "Orders_details")
public class OrderDetail implements Serializable {
	@Id
	String Id;
	
	Integer Quantity;

	@ManyToOne
	@JoinColumn(name = "Order_id")
	Order order;

	@ManyToOne
	@JoinColumn(name = "Book_id")
	Book book;

	Float Price;

}
