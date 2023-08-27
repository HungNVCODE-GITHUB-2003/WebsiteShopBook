package com.poly.service;

import java.util.List;

import com.poly.bean.Account_roles;


public interface AuthorityService {

	public List<Account_roles> findAll();

	public Account_roles create(Account_roles auth);

	public void delete(Integer id);
	
	public List<Account_roles> findAuthoritesOfAdministrators();

}
