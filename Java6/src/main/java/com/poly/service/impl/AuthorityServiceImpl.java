package com.poly.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.poly.bean.Account;
import com.poly.bean.Account_roles;
import com.poly.dao.AccountDAO;
import com.poly.dao.Account_rolesDao;
import com.poly.service.AuthorityService;


@Service
public class AuthorityServiceImpl implements AuthorityService{
	@Autowired
	Account_rolesDao dao;
	
	@Autowired
	AccountDAO acdao;

	public List<Account_roles> findAll() {
		return dao.findAll();
	}

	public Account_roles create(Account_roles auth) {
		return dao.save(auth);
	}

	public void delete(Integer id) {
		dao.deleteById(id);
		
	}

	public List<Account_roles> findAuthoritesOfAdministrators() {
		List<Account> accounts = acdao.getAdministrators();
		return dao.authoritesOf(accounts);
	}

	
	
}
