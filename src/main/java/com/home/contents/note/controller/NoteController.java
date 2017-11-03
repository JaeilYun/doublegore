package com.home.contents.note.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

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

	@Menu(type = MenuTypes.NOTE)
	@Breadcrumb(values = { "note.main" })
	@RequestMapping(value = "/main")
	public ModelAndView main(@RequestParam(value="page", defaultValue="0") String page, @RequestParam(value="size", defaultValue="10") String size) {
		log.debug("[NoteController] main()");
		ModelAndView mav = new ModelAndView("note/noteMain");
		
		List<NoteCategoryEntity> categoryList = noteService.findNoteCategoryList();
		mav.addObject("categoryList", categoryList);
		return mav;
	}

	@Menu(type = MenuTypes.NOTE)
	@Breadcrumb(values = { "note.main" })
	@RequestMapping(value = "/register")
	public ModelAndView register() {
		log.debug("[NoteController] register()");

		ModelAndView mav = new ModelAndView("note/noteRegister");
		List<NoteCategoryEntity> categoryList = noteService.findNoteCategoryList();

		mav.addObject("categoryList", categoryList);
		return mav;
	}
	
	@RequestMapping(value = "/selectNoteCategory")
	public @ResponseBody List<NoteCategoryForm> selectNoteCategory() {
		log.debug("[NoteController] selectNoteCategory()");
		
		List<NoteCategoryForm> categoryFormList = noteService.findNoteCategoryFormList();
		return categoryFormList;
	}
	
	@RequestMapping(value = "/updateCategory")
	public @ResponseBody String[] updateCategory(@RequestParam(value="categoryArr[]") String[] categoryArr){
		log.debug("[FileController] updateCategory()");
		List<String> strList = Arrays.asList(categoryArr);
		noteService.updateCategory(strList);
		return categoryArr;
	}
	
	@RequestMapping(value = "/selectNote")
	public @ResponseBody NoteEntity selectNoate(Long seq){
		log.debug("[FileController] selectNote()");
		NoteEntity note = noteService.findNote(seq);
		return note;
	}
	
	@RequestMapping(value = "/editNote")
	public ModelAndView editNote(Long seq){
		log.debug("[FileController] editNote()");
		ModelAndView mav = new ModelAndView("note/noteUpdate");
		NoteEntity note = noteService.findNote(seq);
		List<NoteCategoryEntity> categoryList = noteService.findNoteCategoryList();
		mav.addObject("categoryList", categoryList);
		mav.addObject("note", note);
		return mav;
	}
	
	@RequestMapping(value = "/deleteNote")
	public @ResponseBody String deleteNote(Long seq, String page){
		log.debug("[FileController] deleteNote()");
		noteService.deleteNote(seq);
		return page;
	}
	
	@RequestMapping(value = "/checkNoteWhenCategoryDelete")
	public @ResponseBody int checkNoteWhenCategoryDelete(Long seq){
		log.debug("[FileController] checkNoteWhenCategoryDelete()");
		NoteCategoryEntity category = noteService.findNoteCategory(seq);
		List<NoteEntity> noteList = noteService.findByNoteCategory(category);
		return noteList.size();
	}
	
	@Menu(type = MenuTypes.NOTE)
	@Breadcrumb(values = { "note.main" })
	@RequestMapping(value = "/insertNote")
	public String insertNote(NoteForm form) {
		log.debug("[NoteController] insertNote()");

		noteService.insertNote(form);
		return "redirect:/note/main";
	}
	
	@RequestMapping(value = "/imagePopup")
	public ModelAndView imagePopup() {
		log.debug("[NoteController] imagePopup()");

		ModelAndView mav = new ModelAndView("note/image/popup");
		
		return mav;
	}
	
	@RequestMapping(value = "/imageUpload")
	public @ResponseBody HashMap<String, Object> imageUpload(@RequestParam("Filedata") MultipartFile multipartFile, HttpSession httpSession) {
		log.debug("[NoteController] imagePopup()");
		
		HashMap<String, Object> fileInfo = noteService.insertFile(multipartFile);
		return fileInfo; // @ResponseBody 어노테이션을 사용하여 Map을 JSON형태로 반환
	}
	
	@RequestMapping(value = "/search")
	public @ResponseBody Page<NoteEntity> search(String page, String size) {
		log.debug("[NoteController] search()");
		
		PageRequest request = new PageRequest(Integer.parseInt(page), Integer.parseInt(size), new Sort(Direction.DESC, "seq"));
		Page<NoteEntity> noteList = noteService.findNoteAll(request);
		return noteList;
	}
}
