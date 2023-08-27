package com.poly.rest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.poly.bean.Shipper;
import com.poly.service.ShipperService;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/shippers")
public class ShipperRestController {
	@Autowired
	ShipperService shipperService;

	@GetMapping
	public List<Shipper> getAll() {
		return shipperService.findAll();
	}

}
