package com.poly.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poly.bean.States;

public interface StateDAO extends JpaRepository<States, Integer> {

}
