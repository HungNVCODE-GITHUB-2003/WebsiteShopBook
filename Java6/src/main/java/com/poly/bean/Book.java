package com.poly.bean;

import java.io.Serializable;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "Books")
public class Book implements Serializable {

	@Id
	@Column(name = "Id")
	private String Id;

	String Name;

	private String Image;

	
	private Float price;

	private String Author;

	private Integer pagecount;

	private String Description;

	@Temporal(TemporalType.DATE)
	@Column(name = "Publication_date")
	private Date publication_date = new Date();

	@ManyToOne
	@JoinColumn(name = "Genres_id")
	Genres genres;

	private String Publisher;

	private Integer Stock_quantity;

	private Boolean Available;

	@JsonIgnore
	@OneToMany(mappedBy = "book")
	List<OrderDetail> orderDetail;

	@Override
	public String toString() {
		return "";
	}
	
	private String Image1;
	private String Image2;
	private String Image3;

}
