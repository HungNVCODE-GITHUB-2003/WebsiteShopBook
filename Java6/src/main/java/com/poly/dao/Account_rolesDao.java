package com.poly.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.poly.bean.Account;
import com.poly.bean.Account_roles;


public interface Account_rolesDao extends JpaRepository<Account_roles, Integer> {


	@Query("SELECT DISTINCT a FROM Account_roles a WHERE a.account IN ?1")
	List<Account_roles> authoritesOf(List<Account> accounts);

}
