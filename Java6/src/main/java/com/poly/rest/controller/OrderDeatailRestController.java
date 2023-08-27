package com.poly.rest.controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


import com.poly.bean.OrderDetail;
import com.poly.bean.Report;
import com.poly.bean.Top10;
import com.poly.service.OrderDetailService;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/orderdetails")
public class OrderDeatailRestController {

	@Autowired
	OrderDetailService orderDetailService;

	@GetMapping
	public List<OrderDetail> getAll() {
		return orderDetailService.findAll();
	}
	
	@GetMapping("/top10")
	public List<Top10> getTop10() {
		return orderDetailService.getTop10();
	}
	
	/*
	 * @GetMapping("{id}") public OrderDetail getOne(@PathVariable("id") String id)
	 * { return orderDetailService.findById(id); }
	 */
	@GetMapping("{id}")
	public List<OrderDetail> getAllByIdUser(@PathVariable("id") Integer id) {
		return orderDetailService.findByIdOrder(id);
	}
	
	@GetMapping("/thongke")
	public List<Report> tongdoanhthu(){
		return orderDetailService.tongdoanhthu();
	}
	
	@GetMapping("/tadao")
	public Integer getSum() {
		return orderDetailService.getSum();
	}
}
