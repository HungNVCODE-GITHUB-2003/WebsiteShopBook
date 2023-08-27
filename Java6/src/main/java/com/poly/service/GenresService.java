package com.poly.service;

import java.util.List;

import com.poly.bean.Genres;

public interface GenresService {

	List<Genres> findAll();

	Genres findById(String id);

	Genres create(Genres genres);

	Genres update(Genres genres);

	void delete(String id);
}
