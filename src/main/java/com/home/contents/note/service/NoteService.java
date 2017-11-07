package com.home.contents.note.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
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
    public static final long IMAGE_SIZE = 10;
    public static final long FILE_SIZE = 20;

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

    public Page<NoteEntity> findNoteAll(PageRequest request, String categorySeq) {
    	if(categorySeq.equals("ALL")) {
    		return noteRepository.findByIsDeleted("F", request);
    	} else {
    		NoteCategoryEntity category = noteCategoryRepository.findOne(Long.parseLong(categorySeq));
    		return noteRepository.findByIsDeletedAndNoteCategory("F", category, request);
    	}
    }
    
    public List<NoteEntity> findByNoteCategory(NoteCategoryEntity entity) {
    	return noteRepository.findByNoteCategory(entity);
    }
    
    public NoteEntity findNote(Long seq) {
    	return noteRepository.findOne(seq);
    }
    
    public List<NoteFileEntity> findNoteFileList(NoteEntity note) {
    	return noteFileRepository.findByNoteEntity(note);
    }
    
    public void deleteNote(Long seq) {
    	NoteEntity note = this.findNote(seq);
    	List<NoteFileEntity> fileList = noteFileRepository.findByNoteEntity(note);
    	for(NoteFileEntity file : fileList) {
    		//파일 삭제
    		String s = file.getFilePath();
    	    File f = new File(s);
    	    if (f.exists()) {
    	    	f.delete();
    	    }
			noteFileRepository.delete(file);
    	}
    	
    	noteRepository.delete(note);
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
    
    public NoteEntity insertNote(NoteForm form) {
    	Date date = new Date();
    	NoteCategoryEntity noteCategoryEntity = noteCategoryRepository.findOne(form.getSelect());
    	NoteEntity noteEntity = new NoteEntity();
    	noteEntity.setTitle(form.getTitle());
    	noteEntity.setNoteCategory(noteCategoryEntity);
    	noteEntity.setContents(form.getContent());
    	noteEntity.setCreatedDate(date);
    	noteEntity.setUpdatedDate(date);
    	noteEntity.setIsDeleted("F");
    	return noteRepository.save(noteEntity);    	
    }
    
    public NoteEntity updateNote(NoteForm form) {
    	NoteEntity note = this.findNote(form.getSeq());
    	Date date = new Date();
    	NoteCategoryEntity noteCategoryEntity = noteCategoryRepository.findOne(form.getSelect());
    	note.setTitle(form.getTitle());
    	note.setNoteCategory(noteCategoryEntity);
    	note.setContents(form.getContent());
    	note.setUpdatedDate(date);
    	note.setIsDeleted("F");
    	return note;
    }
    
    public void insertNoteFile(NoteEntity note, NoteForm form) {
    	//노트파일에 note_seq 추가
    	List<NoteFileEntity> noteFileList = noteFileRepository.findByFileNameIn(form.getAttach());
    	for(NoteFileEntity noteFile : noteFileList) {
    		noteFile.setNoteEntity(note);
    	}
    	
    	//노트파일 중 note_seq없는것 삭제
    	List<NoteFileEntity> deleteNoteFileList = noteFileRepository.findByNoteEntityIsNull();
    	for(NoteFileEntity noteFile : deleteNoteFileList) {
    		noteFileDelete(noteFile);
    	}
    }
    
    public void updateNoteFile(NoteEntity note, NoteForm form) {
    	//기존 파일 삭제
    	List<NoteFileEntity> deleteFileList = noteFileRepository.findByNoteEntity(note);
    	List<String> updateForm = Arrays.asList(form.getAttach());
		for(NoteFileEntity file : deleteFileList) {
			if(!updateForm.contains(file.getFileName())) {
				noteFileDelete(file);
			}
		}
		this.insertNoteFile(note, form);
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
	
	public void noteFileDelete(NoteFileEntity noteFile) {
		//파일 삭제
		String s = noteFile.getFilePath();
	    File f = new File(s);
	    if (f.exists()) {
	    	f.delete();
	    }
	    //DB삭제
		noteFileRepository.delete(noteFile);
	}

    //게시글 첨부파일 저장
    public HashMap<String, Object> insertFile(MultipartFile multipartFile, String type) {
        logger.debug("Inserting File - insertFile({})");

        HashMap<String, Object> fileInfo = new HashMap<String, Object>(); // CallBack할 때 이미지 정보를 담을 Map 

		// 확장자 제한 
		String originalName = multipartFile.getOriginalFilename(); // 실제 파일명 
		String originalNameExtension = originalName.substring(originalName.lastIndexOf(".") + 1).toLowerCase(); // 실제파일 확장자 (소문자변경) 
		
		String genId = UUID.randomUUID().toString().replace("-", "");
		String fileName = genId + "." + originalNameExtension;
        try {
        	long limitFileSize = type.equals("image") ? IMAGE_SIZE*1024*1024 : FILE_SIZE*1024*1024; // 10MB or 20MB
        	// 업로드 파일이 존재하면 
    		if(multipartFile != null && !(multipartFile.getOriginalFilename().equals(""))) {
    			long fileSize = multipartFile.getSize();
    			if(type.equals("image")) {
    				if( !( (originalNameExtension.toLowerCase().equals("jpg")) || 
        					(originalNameExtension.toLowerCase().equals("jpeg")) || 
        					(originalNameExtension.toLowerCase().equals("gif")) || 
        					(originalNameExtension.toLowerCase().equals("png")) || 
        					(originalNameExtension.toLowerCase().equals("bmp")) ) ){ 
        				fileInfo.put("result", -1); // 허용 확장자가 아닐 경우 
        				return fileInfo;
        			} 
    			}
    			
    			if(limitFileSize < fileSize){ // 제한보다 파일크기가 클 경우 
					fileInfo.put("result", -2); 
					return fileInfo; 
				}

    	        String uploadPath = environment.getRequiredProperty("app.home") + environment.getRequiredProperty("note.file.path");
    	        String saveFilePath = FileUtils.fileSave(uploadPath, multipartFile, genId, type);

    	        Date date = new Date();
    	        NoteFileEntity file = new NoteFileEntity();
    	        file.setFileName(fileName);
    	        file.setContentType(multipartFile.getContentType());
    	        file.setFilePath(uploadPath+saveFilePath);
    	        file.setFileUrl(environment.getRequiredProperty("note.file.path") + saveFilePath.replaceAll("/", "\\\\"));
    	        file.setFileKey(genId);
    	        file.setFileSize(multipartFile.getSize());
    	        file.setCreatedDate(date);
    	        file.setUpdatedDate(date);
    	        file.setIsDeleted("F");
    	        file = noteFileRepository.save(file);
    			
    			// CallBack - Map에 담기 
    			String fileUrl = environment.getRequiredProperty("note.file.path") + File.separator + type +File.separator + fileName; // separator와는 다름! 
    			if(type.equals("image")) {
    				fileInfo.put("imageurl", fileUrl); // 상대파일경로(사이즈변환이나 변형된 파일) 
        			fileInfo.put("filename", fileName); // 파일명 
        			fileInfo.put("filesize", fileSize); // 파일사이즈
        			fileInfo.put("imagealign", "C"); // 이미지정렬(C:center) 
        			fileInfo.put("originalurl", fileUrl); // 실제파일경로 
        			fileInfo.put("thumburl", fileUrl); // 썸네일파일경로(사이즈변환이나 변형된 파일) 
        			fileInfo.put("result", 1); // -1, -2를 제외한 아무거나 싣어도 됨 
    			} else {
    				fileInfo.put("attachurl", fileUrl); // 상대파일경로(사이즈변환이나 변형된 파일) 
    				fileInfo.put("filemime", multipartFile.getContentType()); // mime 
    				fileInfo.put("filename", fileName); // 파일명 
    				fileInfo.put("filesize", multipartFile.getSize()); // 파일사이즈 
    				fileInfo.put("result", 1); // -1을 제외한 아무거나 싣어도 됨
    			}
    			
    		} else {
    			throw new Exception("Failed to store empty file " + fileName);
    		}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return fileInfo;
    }
}
