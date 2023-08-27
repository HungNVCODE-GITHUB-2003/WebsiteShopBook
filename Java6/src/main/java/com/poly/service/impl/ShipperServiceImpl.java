package com.poly.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poly.bean.Shipper;
import com.poly.dao.ShipperDAO;
import com.poly.service.ShipperService;

@Service
public class ShipperServiceImpl implements ShipperService {

	@Autowired
	ShipperDAO dao;

	@Override
	public List<Shipper> findAll() {
		// TODO Auto-generated method stub
		return dao.findAll();
	}

}
