package com.home.contents.note.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.home.contents.note.entity.NoteCategoryEntity;
import com.home.contents.note.entity.NoteEntity;

@Repository
public interface NoteRepository extends JpaRepository<NoteEntity, Long> {
	Page<NoteEntity> findByIsDeleted(String status, Pageable pageable);
	Page<NoteEntity> findByIsDeletedAndNoteCategory(String status, NoteCategoryEntity category, Pageable pageable);
	List<NoteEntity> findByNoteCategory(NoteCategoryEntity entity);
}
