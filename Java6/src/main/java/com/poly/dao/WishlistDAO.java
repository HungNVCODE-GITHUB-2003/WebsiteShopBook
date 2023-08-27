package com.poly.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poly.bean.Wishlist;

public interface WishlistDAO extends JpaRepository<Wishlist, String> {

}
