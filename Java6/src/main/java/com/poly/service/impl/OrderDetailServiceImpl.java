package com.poly.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poly.bean.OrderDetail;
import com.poly.bean.Report;
import com.poly.bean.Top10;
import com.poly.dao.OrderDetailDAO;
import com.poly.service.OrderDetailService;

@Service
public class OrderDetailServiceImpl implements OrderDetailService {
	@Autowired
	OrderDetailDAO dao;

	@Override
	public List<OrderDetail> findAll() {
		// TODO Auto-generated method stub
		return dao.findAll();
	}

	@Override
	public List<Top10> getTop10() {
		return dao.getTop10();
	}

	@Override
	public OrderDetail findById(String id) {
		// TODO Auto-generated method stub
		return dao.findById(id).get();
	}

	/*
	 * @Override public List<OrderDetail> findByIdOrder(String id) { // TODO
	 * Auto-generated method stub return dao.findByIdOrder(id); }
	 */

	@Override
	public List<Report> tongdoanhthu() {
		// TODO Auto-generated method stub
		return dao.reportTheoLuotMuaHang();
	}

	@Override
	public Integer getSum() {
		// TODO Auto-generated method stub
		return dao.getSum();
	}

	@Override
	public List<OrderDetail> findByIdOrder(Integer id) {
		// TODO Auto-generated method stub
		return dao.findByIdOrder(id);
	}



	/*
	 * @Override public List<Report> tongdoanhthu() { return dao.daonhthu(); }
	 */

}
