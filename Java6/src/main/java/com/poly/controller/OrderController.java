package com.poly.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.poly.bean.Account;
import com.poly.dao.AccountDAO;
import com.poly.service.OrderService;
import com.poly.service.impl.AccountServiceImpl;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class OrderController {
	@Autowired
	AccountServiceImpl accountServiceImpl;
	
	@Autowired
	AccountDAO acdao;
	
	@Autowired
	OrderService orderService;

	@RequestMapping("/order/checkout")
	public String checkout(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		Account ac = accountServiceImpl.findByUsername(username);
		String id = ac.getId();
		model.addAttribute("nghia", id);
		return "order/checkout";
	}
	

	@RequestMapping("/order/list")
	public String list(Model model, HttpServletRequest request) {
		String Id = request.getRemoteUser();
		model.addAttribute("orders", orderService.findByIdAccount(Id));
		return "order/list";
	}

	@RequestMapping("/order/detail/{Id}")
	public String detail(@PathVariable("Id") Integer Id, Model model) {
		model.addAttribute("order", orderService.findById(Id));
		return "order/detail";
	}

}
