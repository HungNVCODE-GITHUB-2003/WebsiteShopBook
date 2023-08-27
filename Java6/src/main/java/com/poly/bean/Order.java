package com.poly.bean;

import java.io.Serializable;

import java.util.Date;
import java.util.List;



import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "Orders")
public class Order implements Serializable {
	@Id 
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="Id")
	Integer id;
	
	@ManyToOne
	@JoinColumn(name = "Account_id")
	Account account;

	@Temporal(TemporalType.DATE)
	Date date = new Date();

	String Address;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "Discount_id")
	Discount discount;

	@ManyToOne
	@JoinColumn(name = "Shipper_id")
	Shipper shipper;

	@ManyToOne
	@JoinColumn(name = "State_id")
	States state;

	@JsonIgnore
	@OneToMany(mappedBy = "order")
	List<OrderDetail> orderDetail;
}
