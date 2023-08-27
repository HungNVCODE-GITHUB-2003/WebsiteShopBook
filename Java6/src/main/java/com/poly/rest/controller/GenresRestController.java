package com.poly.rest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.poly.bean.Book;
import com.poly.dao.BookDAO;
import com.poly.dao.GenresDAO;

@CrossOrigin("*")
@RestController
public class GenresRestController {

	@Autowired
	private GenresDAO dao;

	@Autowired
	private BookDAO booksdao;

	@GetMapping("/rest/genres")
	public ResponseEntity<List<Book>> getAll(Model model) {
		return ResponseEntity.ok(booksdao.findAll());
	}

}
