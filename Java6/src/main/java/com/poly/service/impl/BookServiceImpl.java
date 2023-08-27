package com.poly.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.poly.bean.Book;
import com.poly.bean.Report;
import com.poly.dao.BookDAO;
import com.poly.service.BookService;

@Service
public class BookServiceImpl implements BookService {
	@Autowired
	BookDAO dao;

	@Override
	public Page<Book> findAll(Pageable pageable) {
		return dao.findAll(pageable);
	}

	@Override
	public Book findById(String cid) {
		return dao.findById(cid).get();
	}

	@Override
	public Page<Book> findByCategoryId(String cid, Pageable pageable) {
		return dao.findByCategoryId(cid, pageable);
	}

	@Override
	public Book create(Book book) {
		return dao.save(book);
	}

	@Override
	public Book update(Book book) {
		return dao.save(book);
	}

	@Override
	public void delete(String id) {
		// TODO Auto-generated method stub
		dao.deleteById(id);
	}

	@Override
	public List<Book> findAll() {
		return dao.findAll();
	}

	@Override
	public Page<Book> findProductByKeyword(String keyword, Pageable pageable) {
		return dao.findProductByKeyword(keyword, pageable);
	}

	@Override
	public Page<Book> findCategoryByKeyword(String keyword, Pageable pageable) {
		return dao.findCategoryByKeyword(keyword, pageable);
	}



	@Override
	public List<Report> getTk_loai() {
		// TODO Auto-generated method stub
		return dao.getInventoryByCategory();
	}

	

	@Override
	public List<Report> getTk_sp() {
		// TODO Auto-generated method stub
		return dao.reportTheoProduct();
	}
}
