package com.poly.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.poly.bean.States;
import com.poly.dao.StateDAO;
import com.poly.service.StateService;

@Service
public class StateServiceImpl implements StateService {
	@Autowired
	StateDAO dao;

	@Override
	public List<States> findAll() {
		return dao.findAll();
	}

}
