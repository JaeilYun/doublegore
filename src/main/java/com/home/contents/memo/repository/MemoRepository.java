package com.home.contents.memo.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.home.contents.memo.entity.MemoEntity;

@Repository
public interface MemoRepository extends JpaRepository<MemoEntity, Long> {
	Page<MemoEntity> findByIsDeleted(String status, Pageable pageable);
}
