package com.home.contents.note.repository;

import com.home.contents.note.entity.NoteCategoryEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NoteCategoryRepository extends JpaRepository<NoteCategoryEntity, Long> {
}
