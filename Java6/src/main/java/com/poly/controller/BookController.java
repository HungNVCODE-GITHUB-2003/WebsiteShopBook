package com.poly.controller;

import java.util.List;


import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.poly.bean.Book;
import com.poly.service.BookService;

@Controller
public class BookController {
	@Autowired
	BookService bookService;

	@RequestMapping("/product/shop_list")
	public String shop_list(Model model, @RequestParam("cid") Optional<String> cid,
			@RequestParam("page") Optional<Integer> page, @RequestParam("size") Optional<Integer> size,
			@RequestParam("sort") Optional<String> sort) {
		String valueFieldString;
		String[] split;
		int currentPage = page.orElse(0);
		int pageSize = size.orElse(12);
		if (pageSize > 15) {
			pageSize = 15;
		}
		if (cid.isPresent()) {
			Pageable pageable = PageRequest.of(currentPage, pageSize);
			Page<Book> pageF = bookService.findByCategoryId(cid.get(), pageable);
			int totalPages = pageF.getTotalPages();
			if (totalPages > 0) {
				List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages).boxed().collect(Collectors.toList());
				model.addAttribute("pageNumbers", pageNumbers);
			}
			model.addAttribute("pagePresent", currentPage);
			model.addAttribute("items", pageF);
			model.addAttribute("cid", cid.get());
		} else {
			Pageable pageable = PageRequest.of(currentPage, pageSize);
			Page<Book> pageF = bookService.findAll(pageable);
			int totalPages = pageF.getTotalPages();
			if (totalPages > 0) {
				List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages).boxed().collect(Collectors.toList());
				model.addAttribute("pageNumbers", pageNumbers);
			}
			model.addAttribute("pagePresent", currentPage);
			model.addAttribute("items", pageF);
		}
		return "product/shop_list";

	}

	@RequestMapping("/product/search")
	public String search(@RequestParam("key") Optional<String> keySearch,
			@RequestParam("keyword") Optional<String> valueSearch, @RequestParam("page") Optional<Integer> page,
			@RequestParam("size") Optional<Integer> size, @RequestParam("sort") Optional<String> sort, Model model) {
		Page<Book> productPage = null;
		String valueFieldString;
		String[] split;

		int currentPage = page.orElse(0);
		int pageSize = size.orElse(12);
		if (pageSize > 15) {
			pageSize = 15;
		}
		if (keySearch.get().equals("nameProduct")) {
			Pageable pageable = PageRequest.of(currentPage, pageSize);
			productPage = bookService.findProductByKeyword("%" + valueSearch.get() + "%", pageable);
		} else {
			Pageable pageable = PageRequest.of(currentPage, pageSize);
			productPage = bookService.findCategoryByKeyword("%" + valueSearch.get() + "%", pageable);
		}
		int totalPages = productPage.getTotalPages();
		if (totalPages > 0) {
			List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages).boxed().collect(Collectors.toList());
			model.addAttribute("pageNumbers", pageNumbers);
		}
		model.addAttribute("valueSearch", valueSearch.get());
		model.addAttribute("keySearch", valueSearch.get());
		model.addAttribute("pagePresent", currentPage);
		model.addAttribute("items", productPage);
		return "product/shop_list";
	}

	@RequestMapping("/product/detail/{id}")
	public String detail(Model model, @PathVariable("id") String id) {
		Book item = bookService.findById(id);
		model.addAttribute("item", item);
		return "product/detail";
	}

	@RequestMapping("/product/blog")
	public String blog(Model model) {
		List<Book> list = bookService.findAll();
		model.addAttribute("items", list);
		return "product/blog";
	}

	@RequestMapping("/product/portfolio")
	public String portfolio(Model model) {
		List<Book> list = bookService.findAll();
		model.addAttribute("items", list);
		return "product/portfolio";
	}

	@RequestMapping("/product/contact")
	public String shop_list3(Model model) {
		List<Book> list = bookService.findAll();
		model.addAttribute("items", list);
		return "product/contact";
	}

}
