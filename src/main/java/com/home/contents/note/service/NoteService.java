package com.home.contents.note.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.home.common.file.FileUtils;
import com.home.contents.note.entity.NoteCategoryEntity;
import com.home.contents.note.entity.NoteFileEntity;
import com.home.contents.note.repository.NoteCategoryRepository;
import com.home.contents.note.repository.NoteFileRepository;

@Service
@Transactional
public class NoteService {
    private static final Logger logger = LoggerFactory.getLogger(NoteService.class);

    @Autowired
    NoteCategoryRepository noteCategoryRepository;
    @Autowired
    NoteFileRepository noteFileRepository;
    @Autowired
    Environment environment;

    public List<NoteCategoryEntity> findNoteCategoryList() {
        return noteCategoryRepository.findAll();
    }

    public NoteFileEntity findFile(Long seq) {
        return noteFileRepository.findBySeq(seq);
    }
    
    public List<NoteCategoryEntity> updateCategory(List<String> arr) {
    	List<String> arrList = new LinkedList<String>(arr);
    	//마지막 빈 카테고리 삭제
    	arrList.remove(arrList.size()-1);
    	List<NoteCategoryEntity> categoryList = this.findNoteCategoryList();
    	List<String> result = this.insertCategory(arrList);
    	for(int i = 0; i < categoryList.size(); i++) {
    		boolean chk = true;
    		for(int j = 0; j < result.size(); j++) {
    			String seq = result.get(j).split(",")[0];
    			String type = result.get(j).split(",")[1];
    			if(categoryList.get(i).getSeq().equals(Long.valueOf(seq))) {
    				categoryList.get(i).setType(type);
    				chk = false;
    				break;
    			}
    		}
    		if(chk) {
    			noteCategoryRepository.delete(categoryList.get(i));
    		}
    	}
    	return categoryList;
    }

	public List<String> insertCategory(List<String> arr) {
		List<String> result = new ArrayList<>();
		for(int i = 0; i < arr.size(); i++) {
			String seq = arr.get(i).split(",")[0];
			String type = arr.get(i).split(",")[1];
			if(seq.equals("new")) {
				NoteCategoryEntity category = new NoteCategoryEntity();
				category.setType(type);
				noteCategoryRepository.save(category);
			} else {
				result.add(seq+","+type);
			}
    	}
		return result;
	}

    //게시글 첨부파일 저장
    public NoteFileEntity insertFile(MultipartFile multipartFile) throws Exception {
        logger.debug("Inserting File - insertFile({})");

        if (multipartFile.isEmpty()) {
            throw new Exception("Failed to store empty file " + multipartFile.getOriginalFilename());
        }

        String genId = UUID.randomUUID().toString().replace("-", "");

        String uploadPath = environment.getRequiredProperty("app.home") + environment.getRequiredProperty("note.file.path");
        String saveFilePath = FileUtils.fileSave(uploadPath, multipartFile, genId, "image");

        Date date = new Date();
        NoteFileEntity file = new NoteFileEntity();
        file.setFileName(multipartFile.getOriginalFilename());
        file.setContentType(multipartFile.getContentType());
        file.setFilePath(uploadPath+saveFilePath);
        file.setFileKey(genId);
        file.setFileSize(multipartFile.getSize());
        file.setCreatedDate(date);
        file.setUpdatedDate(date);
        file.setIsDeleted("F");
        file = noteFileRepository.save(file);
        return file;
    }
}
