package com.home.contents.note.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.home.contents.note.entity.NoteEntity;
import com.home.contents.note.entity.NoteFileEntity;

@Repository
public interface NoteFileRepository extends JpaRepository<NoteFileEntity, Long> {
	List<NoteFileEntity> findByFileNameIn(String[] fileName);
	List<NoteFileEntity> findByNoteEntityIsNull();
	List<NoteFileEntity> findByNoteEntity(NoteEntity noteEntity);
}
