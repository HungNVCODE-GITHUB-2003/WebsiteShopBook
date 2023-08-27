package com.poly.rest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.poly.bean.Genres;
import com.poly.service.GenresService;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/categories")
public class CategoriesRestController {

	@Autowired
	GenresService genresService;

	@GetMapping()
	public List<Genres> getAll() {
		return genresService.findAll();
	}

	@GetMapping("{id}")
	public Genres getOne(@PathVariable("id") String id) {
		return genresService.findById(id);
	}

	@PostMapping()
	public Genres create(@RequestBody Genres genres) {
		return genresService.create(genres);
	}

	@PutMapping("{id}")
	public Genres update(@PathVariable("id") String id, @RequestBody Genres genres) {
		return genresService.update(genres);
	}

	@DeleteMapping("{id}")
	public void delete(@PathVariable("id") String id) {
		genresService.delete(id);
	}

}
