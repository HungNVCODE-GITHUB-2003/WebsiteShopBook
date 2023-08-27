package com.poly.rest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.poly.bean.States;
import com.poly.service.StateService;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/states")
public class StateRestController {
	@Autowired
	StateService stateService;

	@GetMapping()
	public List<States> getAll() {
		return stateService.findAll();
	}

	/*
	 * @GetMapping("{id}") public States getOne(@PathVariable("id") String id) {
	 * return stateService.findById(id); }
	 * 
	 * @PutMapping("{id}") public States update(@PathVariable("id")String
	 * id,@RequestBody Genres genres) { return stateService.update(genres); }
	 */
}
