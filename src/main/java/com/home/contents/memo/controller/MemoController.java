package com.home.contents.memo.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.home.common.annotation.breadcrumb.Breadcrumb;
import com.home.common.annotation.menu.Menu;
import com.home.common.types.MenuTypes;
import com.home.contents.memo.entity.MemoEntity;
import com.home.contents.memo.service.MemoService;

@Controller
@RequestMapping(value = "/memo")
public class MemoController {
	private static final Logger log = LoggerFactory.getLogger(MemoController.class);
	@Autowired
	MemoService memoService;

	@Menu(type = MenuTypes.MEMO)
	@Breadcrumb(values = { "memo.main" })
	@RequestMapping(value = "/main")
	public ModelAndView main() {
		log.debug("[MemoController] main()");
		
		ModelAndView mav = new ModelAndView("memo/memoMain");
		return mav;
	}
	
	//메모 저장
	@RequestMapping(value = "/insertMemo")
	public @ResponseBody MemoEntity insertMemo(String contents) {
		log.debug("[MemoController] insertMemo()");
		
		MemoEntity memo = memoService.insertMemo(contents);
		return memo;
	}
	
	//메모 삭제
	@RequestMapping(value = "/deleteMemo")
	public @ResponseBody String deleteMemo(String seq) {
		log.debug("[MemoController] deleteMemo()");
		
		memoService.deleteMemo(Long.parseLong(seq));
		return seq;
	}
	
	//메모 불러오기
	@RequestMapping(value = "/selectMemo")
	public @ResponseBody Page<MemoEntity> selectMemo(String page, String size) {
		log.debug("[MemoController] selectMemo()");
		
		PageRequest request = new PageRequest(Integer.parseInt(page), Integer.parseInt(size), new Sort(Direction.DESC, "createdDate"));
		Page<MemoEntity> noteList = memoService.findMemoAll(request);
		return noteList;
	}
}
