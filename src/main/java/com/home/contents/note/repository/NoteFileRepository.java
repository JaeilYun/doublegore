package com.home.contents.note.repository;

import com.home.contents.note.entity.NoteFileEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NoteFileRepository extends JpaRepository<NoteFileEntity, Long> {
    NoteFileEntity findBySeq(Long seq);
}
