package com.poly.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.poly.bean.Book;
import com.poly.bean.Report;

public interface BookService {

	// danh sách sản phẩm và phân trang
	Page<Book> findAll(Pageable pageable);

	// Danh sách sản phẩm
	List<Book> findAll();

	// tìm sản phẩm theo id
	Book findById(String id);

	// thêm sản phẩm
	Book create(Book book);

	// cập nhật sản phẩm
	Book update(Book book);

	// xóa sản phẩm
	void delete(String id);

	// tìm sản phẩm và phân trang
	Page<Book> findByCategoryId(String id, Pageable pageable);

	// tìm sản phẩm theo keyword
	Page<Book> findProductByKeyword(String keyword, Pageable pageable);

	// tìm sản phẩm theo loại bằng keyword
	Page<Book> findCategoryByKeyword(String keyword, Pageable pageable);

	List<Report> getTk_sp();

	List<Report> getTk_loai();
}
