package com.poly.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poly.bean.Role;
import com.poly.dao.RoleDao;
import com.poly.service.RoleService;

@Service
public class RoleServiceImpl implements RoleService {

	@Autowired
	RoleDao rdao;

	@Override
	public List<Role> findAll() {
		return rdao.findAll();
	}

}
