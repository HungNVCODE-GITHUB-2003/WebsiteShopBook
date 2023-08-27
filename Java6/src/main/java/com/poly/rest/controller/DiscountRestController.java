package com.poly.rest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.poly.bean.Discount;
import com.poly.service.DiscountService;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/discounts")
public class DiscountRestController {
	@Autowired
	DiscountService discountService;

	@GetMapping
	public List<Discount> getAll() {
		return discountService.findAll();
	}
}
