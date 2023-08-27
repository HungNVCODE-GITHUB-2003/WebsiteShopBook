package com.poly.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poly.bean.Shipper;

public interface ShipperDAO extends JpaRepository<Shipper, String> {

}
