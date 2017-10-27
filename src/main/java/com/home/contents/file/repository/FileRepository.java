package com.home.contents.file.repository;

import com.home.contents.file.entity.FileEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FileRepository extends JpaRepository<FileEntity, Long> {
    List<FileEntity> findByNodeIdAndIsDeleted(String nodeId, String isDeleted);
    List<FileEntity> findByNodeIdAndFileNameAndIsDeleted(String nodeId, String fileName, String isDeleted);
    FileEntity findTop1ByNodeIdAndFileNameAndIsDeleted(String nodeId, String fileName, String isDeleted);
    List<FileEntity> findByNodeIdAndFileNameInAndIsDeleted(String nodeId, String[] fileName, String isDeleted);
    List<FileEntity> findByNodeIdAndFileTypeInAndIsDeleted(String nodeId, String[] fileType, String isDeleted);
}
