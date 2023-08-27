package com.poly.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import com.poly.bean.Genres;

public interface GenresDAO extends JpaRepository<Genres, String> {

}
