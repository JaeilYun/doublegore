package com.home.contents.note.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.home.common.annotation.breadcrumb.Breadcrumb;
import com.home.common.annotation.menu.Menu;
import com.home.common.types.MenuTypes;
import com.home.contents.note.entity.NoteCategoryEntity;
import com.home.contents.note.entity.NoteCategoryForm;
import com.home.contents.note.entity.NoteEntity;
import com.home.contents.note.entity.NoteFileEntity;
import com.home.contents.note.entity.NoteForm;
import com.home.contents.note.service.NoteService;

@Controller
@RequestMapping(value = "/note")
public class NoteController {
	private static final Logger log = LoggerFactory.getLogger(NoteController.class);

	@Autowired
	NoteService noteService;

    @Autowired
    Environment environment;

    //노트 메인화면 이동
	@Menu(type = MenuTypes.NOTE)
	@Breadcrumb(values = { "note.main" })
	@RequestMapping(value = "/main")
	public ModelAndView main() {
		log.debug("[NoteController] main()");
		ModelAndView mav = new ModelAndView("note/noteMain");
		return mav;
	}
	
	//카테고리 불러오기
	@RequestMapping(value = "/selectNoteCategory")
	public @ResponseBody List<NoteCategoryForm> selectNoteCategory() {
		log.debug("[NoteController] selectNoteCategory()");
		
		List<NoteCategoryForm> categoryFormList = noteService.findNoteCategoryFormList();
		return categoryFormList;
	}
	
	//카테고리 수정
	@RequestMapping(value = "/updateCategory")
	public @ResponseBody String[] updateCategory(@RequestParam(value="categoryArr[]") String[] categoryArr){
		log.debug("[FileController] updateCategory()");
		List<String> strList = Arrays.asList(categoryArr);
		noteService.updateCategory(strList);
		return categoryArr;
	}
	
	//노트 1개 불러오기
	@RequestMapping(value = "/selectNote")
	public @ResponseBody Map<String, Object> loadNote(Long seq){
		log.debug("[FileController] loadNote()");
		NoteEntity note = noteService.findNote(seq);
		List<NoteFileEntity> fileList = noteService.findNoteFileList(note);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("note", note);
		map.put("fileList", fileList);
		
		return map;
	}
	
	//노트 삭제
	@RequestMapping(value = "/deleteNote")
	public @ResponseBody String deleteNote(Long seq, String page){
		log.debug("[FileController] deleteNote()");
		
		noteService.deleteNote(seq);
		return page;
	}
	
	//카테고리 삭제 시 존재 유무 확인
	@RequestMapping(value = "/checkNoteWhenCategoryDelete")
	public @ResponseBody int checkNoteWhenCategoryDelete(Long seq){
		log.debug("[FileController] checkNoteWhenCategoryDelete()");
		NoteCategoryEntity category = noteService.findNoteCategory(seq);
		List<NoteEntity> noteList = noteService.findByNoteCategory(category);
		return noteList.size();
	}
	
	//노트 저장 및 수정
	@Menu(type = MenuTypes.NOTE)
	@Breadcrumb(values = { "note.main" })
	@RequestMapping(value = "/insertNote")
	public String insertNote(NoteForm form) {
		log.debug("[NoteController] insertNote()");

		if(form.getSeq() == null) {
			NoteEntity note = noteService.insertNote(form);
			if(form.getAttachImage() != null && form.getAttachImage().length > 0) {
				noteService.insertNoteFile(note, form);
			}
		} else {
			NoteEntity note = noteService.updateNote(form);
			if(form.getAttachImage() != null && form.getAttachImage().length > 0) {
				noteService.updateNoteFile(note, form);
			}
		}
		
		return "redirect:/note/main";
	}
	
	//이미지 팝업창 띄우기
	@RequestMapping(value = "/imagePopup")
	public ModelAndView imagePopup() {
		log.debug("[NoteController] imagePopup()");

		ModelAndView mav = new ModelAndView("note/image/popup");	
		return mav;
	}
	
	//노트 이미지 저장
	@RequestMapping(value = "/imageUpload")
	public @ResponseBody HashMap<String, Object> imageUpload(@RequestParam("Filedata") MultipartFile multipartFile, HttpSession httpSession) {
		log.debug("[NoteController] imagePopup()");
		
		HashMap<String, Object> fileInfo = noteService.insertFile(multipartFile);
		return fileInfo; // @ResponseBody 어노테이션을 사용하여 Map을 JSON형태로 반환
	}
	
	//노트 페이징
	@RequestMapping(value = "/search")
	public @ResponseBody Map<String, Object> search(String page, String size, String category) {
		log.debug("[NoteController] search()");
		
		PageRequest request = new PageRequest(Integer.parseInt(page), Integer.parseInt(size), new Sort(Direction.DESC, "seq"));
		Page<NoteEntity> noteList = noteService.findNoteAll(request, category);
		List<NoteCategoryForm> categoryList = noteService.findNoteCategoryFormList();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("noteList", noteList);
		map.put("categoryList", categoryList);
		return map;
	}
}
