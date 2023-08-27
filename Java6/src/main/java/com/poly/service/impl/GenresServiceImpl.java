package com.poly.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poly.bean.Genres;
import com.poly.dao.GenresDAO;
import com.poly.service.GenresService;

@Service
public class GenresServiceImpl implements GenresService {
	@Autowired
	GenresDAO dao;

	public List<Genres> findAll() {
		return dao.findAll();
	}

	@Override
	public Genres findById(String id) {
		return dao.findById(id).get();
	}

	@Override
	public Genres create(Genres genres) {
		return dao.save(genres);
	}

	@Override
	public Genres update(Genres genres) {
		return dao.save(genres);
	}

	@Override
	public void delete(String id) {
		dao.deleteById(id);

	}

}
