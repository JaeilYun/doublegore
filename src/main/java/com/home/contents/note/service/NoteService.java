package com.home.contents.note.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.home.common.file.FileUtils;
import com.home.contents.note.entity.NoteCategoryEntity;
import com.home.contents.note.entity.NoteCategoryForm;
import com.home.contents.note.entity.NoteEntity;
import com.home.contents.note.entity.NoteFileEntity;
import com.home.contents.note.entity.NoteForm;
import com.home.contents.note.repository.NoteCategoryRepository;
import com.home.contents.note.repository.NoteFileRepository;
import com.home.contents.note.repository.NoteRepository;

@Service
@Transactional
public class NoteService {
    private static final Logger logger = LoggerFactory.getLogger(NoteService.class);

    @Autowired
    NoteCategoryRepository noteCategoryRepository;
    @Autowired
    NoteFileRepository noteFileRepository;
    @Autowired
    NoteRepository noteRepository;
    @Autowired
    Environment environment;
    
    public List<NoteCategoryEntity> findNoteCategoryList() {
        return noteCategoryRepository.findAll();
    }
    
    public NoteCategoryEntity findNoteCategory(Long seq) {
        return noteCategoryRepository.findOne(seq);
    }

    public Page<NoteEntity> findNoteAll(PageRequest request) {
        return noteRepository.findByIsDeleted("F", request);
    }
    
    public List<NoteCategoryForm> findNoteCategoryFormList() {
    	List<NoteCategoryEntity> categoryList = findNoteCategoryList();
    	List<NoteCategoryForm> formList = new ArrayList<>();
    	for(NoteCategoryEntity list : categoryList) {
    		NoteCategoryForm form = new NoteCategoryForm();
    		form.setSeq(list.getSeq());
    		form.setType(list.getType());
    		formList.add(form);
    	}
        return formList;
    }
    
    public void insertNote(NoteForm form) {
    	Date date = new Date();
    	NoteCategoryEntity noteCategoryEntity = noteCategoryRepository.findOne(form.getSelect());
    	NoteEntity noteEntity = new NoteEntity();
    	noteEntity.setTitle(form.getTitle());
    	noteEntity.setNoteCategory(noteCategoryEntity);
    	noteEntity.setContents(form.getContent());
    	noteEntity.setCreatedDate(date);
    	noteEntity.setUpdatedDate(date);
    	noteEntity.setIsDeleted("F");
    	noteRepository.save(noteEntity);    	
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
    public HashMap<String, Object> insertFile(MultipartFile multipartFile) {
        logger.debug("Inserting File - insertFile({})");

        HashMap<String, Object> fileInfo = new HashMap<String, Object>(); // CallBack할 때 이미지 정보를 담을 Map 

		// 확장자 제한 
		String originalName = multipartFile.getOriginalFilename(); // 실제 파일명 
		String originalNameExtension = originalName.substring(originalName.lastIndexOf(".") + 1).toLowerCase(); // 실제파일 확장자 (소문자변경) 
		
		String genId = UUID.randomUUID().toString().replace("-", "");
		String fileName = genId + "." + originalNameExtension;
        try {
        	// 업로드 파일이 존재하면 
    		if(multipartFile != null && !(multipartFile.getOriginalFilename().equals(""))) { 
    			
    			if( !( (originalNameExtension.equals("jpg")) || 
    					(originalNameExtension.equals("jpeg")) || 
    					(originalNameExtension.equals("gif")) || 
    					(originalNameExtension.equals("png")) || 
    					(originalNameExtension.equals("bmp")) ) ){ 
    				fileInfo.put("result", -1); // 허용 확장자가 아닐 경우 
    				return fileInfo;
    			} 

    	        String uploadPath = environment.getRequiredProperty("app.home") + environment.getRequiredProperty("note.file.path");
    	        String saveFilePath = FileUtils.fileSave(uploadPath, multipartFile, genId, "image");

    	        Date date = new Date();
    	        NoteFileEntity file = new NoteFileEntity();
    	        file.setFileName(fileName);
    	        file.setContentType(multipartFile.getContentType());
    	        file.setFilePath(uploadPath+saveFilePath);
    	        file.setFileKey(genId);
    	        file.setFileSize(multipartFile.getSize());
    	        file.setCreatedDate(date);
    	        file.setUpdatedDate(date);
    	        file.setIsDeleted("F");
    	        file = noteFileRepository.save(file);
    			
    			// CallBack - Map에 담기 
    			String imageurl = environment.getRequiredProperty("note.file.path") + File.separator + "image" +File.separator + fileName; // separator와는 다름! 
    			fileInfo.put("imageurl", imageurl); // 상대파일경로(사이즈변환이나 변형된 파일) 
    			fileInfo.put("filename", fileName); // 파일명 
    			fileInfo.put("filesize", multipartFile.getSize()); // 파일사이즈
    			fileInfo.put("imagealign", "C"); // 이미지정렬(C:center) 
    			fileInfo.put("originalurl", imageurl); // 실제파일경로 
    			fileInfo.put("thumburl", imageurl); // 썸네일파일경로(사이즈변환이나 변형된 파일) 
    			fileInfo.put("result", 1); // -1, -2를 제외한 아무거나 싣어도 됨 
    		} else {
    			throw new Exception("Failed to store empty file " + fileName);
    		}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return fileInfo;
    }
}
