package com.poly.rest.controller;

import java.util.List;




import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.poly.bean.Book;
import com.poly.bean.Report;

import com.poly.service.BookService;



@CrossOrigin("*")
@RestController
@RequestMapping("/rest/products")
public class BookRestController {

	@Autowired
	BookService bookService;

	@GetMapping("{id}")
	public ResponseEntity<Book> getOne(@PathVariable("id") String id) {
		return new ResponseEntity<>(bookService.findById(id), HttpStatus.OK);
	}

	@GetMapping()
	public ResponseEntity<List<Book>> getList() {
		return new ResponseEntity<>(bookService.findAll(), HttpStatus.OK);
	}

	@PostMapping()
	public Book create(@RequestBody Book book) {
		return bookService.create(book);
	}

	@PutMapping("{id}")
	public Book update(@PathVariable("id") String id, @RequestBody Book book) {
		return bookService.update(book);
	}

	@DeleteMapping("{id}")
	public void delete(@PathVariable("id") String id) {
		bookService.delete(id);
	}
	
	
	@GetMapping("/thongke/sp")
	public ResponseEntity<List<Report>> getTK_SP() {
		return new ResponseEntity<>(bookService.getTk_sp(), HttpStatus.OK);
	}
	

	@GetMapping("/thongke/loai")
	public List<Report> getTK_Loai() {
		return bookService.getTk_loai();
	}
	
	

}
