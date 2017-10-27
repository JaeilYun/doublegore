package com.home.contents.note.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.home.common.annotation.breadcrumb.Breadcrumb;
import com.home.common.annotation.menu.Menu;
import com.home.common.types.MenuTypes;
import com.home.contents.note.entity.NoteCategoryEntity;
import com.home.contents.note.service.NoteService;

@Controller
@RequestMapping(value = "/note")
public class NoteController {
	private static final Logger log = LoggerFactory.getLogger(NoteController.class);

	@Autowired
	NoteService noteService;

	@Menu(type = MenuTypes.NOTE)
	@Breadcrumb(values = { "note.main" })
	@RequestMapping(value = "/main")
	public ModelAndView main() {
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
	public @ResponseBody List<NoteCategoryEntity> selectNoteCategory() {
		log.debug("[NoteController] selectNoteCategory()");
		
		List<NoteCategoryEntity> categoryList = noteService.findNoteCategoryList();
		
		return categoryList;
	}
	
	@RequestMapping(value = "/updateCategory")
	public @ResponseBody List<NoteCategoryEntity> updateCategory(@RequestParam(value="categoryArr[]") String[] categoryArr){
		log.debug("[FileController] updateCategory()");
		List<String> strList = Arrays.asList(categoryArr);
		List<NoteCategoryEntity> noteCategoryEntityList = noteService.updateCategory(strList);
		return noteCategoryEntityList;
	}

	//게시글 작성 중 이미지 업로드
	@RequestMapping(value = "/noteImageUpload", method = RequestMethod.POST)
	public void uploadImage(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload){
		log.debug("[NoteController] save note.");
		OutputStream out = null;
        PrintWriter printWriter = null;
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
 
        try{
 
            String fileName = upload.getOriginalFilename();
            byte[] bytes = upload.getBytes();
            String uploadPath = "d:/home/doublegore/files/note/image/" + fileName;//저장경로
 
            out = new FileOutputStream(new File(uploadPath));
            out.write(bytes);
            String callback = request.getParameter("CKEditorFuncNum");
 
            printWriter = response.getWriter();
            String fileUrl = "/files/note/image/" + fileName;//url경로
 
            printWriter.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("
                    + callback
                    + ",'"
                    + fileUrl
                    + "','이미지를 업로드 하였습니다.'"
                    + ")</script>");
            printWriter.flush();
 
        }catch(IOException e){
            e.printStackTrace();
        } finally {
            try {
                if (out != null) {
                    out.close();
                }
                if (printWriter != null) {
                    printWriter.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
 
        return;
		
		//	NoteFileEntity uploadedFile = noteService.insertFile(multipartFile);
	
	}
}
