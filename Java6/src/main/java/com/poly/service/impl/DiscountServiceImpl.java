package com.poly.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.poly.bean.Discount;
import com.poly.dao.DiscountDAO;
import com.poly.service.DiscountService;

@Service
public class DiscountServiceImpl implements DiscountService {
	@Autowired
	DiscountDAO dao;

	@Override
	public List<Discount> findAll() {
		// TODO Auto-generated method stub
		return dao.findAll();
	}

}
