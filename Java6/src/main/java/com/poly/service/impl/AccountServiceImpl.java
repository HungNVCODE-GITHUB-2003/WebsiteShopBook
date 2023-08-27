package com.poly.service.impl;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.stereotype.Service;

import com.poly.bean.Account;
import com.poly.bean.Role;
import com.poly.dao.AccountDAO;
import com.poly.service.AccountService;

@Service
public class AccountServiceImpl implements AccountService, UserDetailsService {
	@Autowired
	PasswordEncoder pe;
	
	@Autowired
	AccountDAO adao;

	
	
	@Override
	public List<Account> findAll() {
		return adao.findAll();
	}

	@Override
	public Account findById(String id) {
		return adao.findById(id).get();
	}

	@Override
	public Account create(Account account) {
		return adao.save(account);
	}

	@Override
	public Account update(Account account) {
		return adao.save(account);
	}

	@Override
	public void delete(String id) {
		adao.deleteById(id);

	}

	@Override
	public Account findByUsername(String username) {
		// TODO Auto-generated method stub
		return adao.findByUsername(username);
	}

	//find by usser
	public AccountServiceImpl(AccountDAO accountdao) {
		this.adao = accountdao;
	}
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		Account account = adao.findByUsername(username);
		if (account == null) {
            throw new UsernameNotFoundException("Invalid username or password.");
        }else {
        	return User.builder().username(account.getUsername())
                    .password(account.getPassword())
                    .roles(account.getAccountroles().stream().map(er -> er.getRole().getName()).collect(Collectors.toList()).toArray(new String [0])).build();
        }
		
	}

	
	 private Collection<? extends GrantedAuthority> mapRolesToAuthorities(Collection<Role> roles) {
	        Collection<? extends GrantedAuthority> mapRoles = roles.stream()
	                .map(role -> new SimpleGrantedAuthority(role.getName()))
	                .collect(Collectors.toList());
	        return mapRoles;
	    }

	 public void loginFormOAuth2(OAuth2AuthenticationToken oauth2) {
			String email = oauth2.getPrincipal().getAttribute("email");
			String password = Long.toHexString(System.currentTimeMillis());
			
			UserDetails user = User.withUsername(email)
					.password(pe.encode(password)).roles("1","2").build();
			org.springframework.security.core.Authentication auth = new UsernamePasswordAuthenticationToken(password, null,user.getAuthorities());
			SecurityContextHolder.getContext().setAuthentication(auth);
//			Authentication auth = new UsernamePasswordAuthenticationToken(user , null, user.getAuthorities());
//			SecurityContextHolder.getContext().setAuthentication(auth);
			
		}

	@Override
	public List<Account> getAdministrators() {
		// TODO Auto-generated method stub
		return adao.getAdministrators();
	};
}
