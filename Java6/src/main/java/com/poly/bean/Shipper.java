package com.poly.bean;

import java.io.Serializable;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "Shippers")
public class Shipper implements Serializable {
	@Id
	String Id;
	String Name;
	Date birthday = new Date();
	String Phone;
	@JsonIgnore
	@OneToMany(mappedBy = "shipper")
	List<Order> order;

}
