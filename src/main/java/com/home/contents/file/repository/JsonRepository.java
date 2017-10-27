package com.home.contents.file.repository;

import com.home.contents.file.entity.JsonEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface JsonRepository extends JpaRepository<JsonEntity, Long> {
    JsonEntity findTopBy();
}
