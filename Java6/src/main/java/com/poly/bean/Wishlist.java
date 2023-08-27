package com.poly.bean;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "Wishlist")
public class Wishlist {
	@Id
	String Image;
	String Name;
	Float Price;
	Integer Stock_quantity;
}