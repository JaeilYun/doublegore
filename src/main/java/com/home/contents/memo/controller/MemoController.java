package com.home.contents.memo.controller;

import com.home.common.annotation.breadcrumb.Breadcrumb;
import com.home.common.annotation.menu.Menu;
import com.home.common.types.MenuTypes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/memo")
public class MemoController {
	private static final Logger log = LoggerFactory.getLogger(MemoController.class);

	@Menu(type = MenuTypes.MEMO)
	@Breadcrumb(values = { "memo.main" })
	@RequestMapping(value = "/main")
	public ModelAndView main() {
		log.debug("[MemoController] main()");
		
		ModelAndView mav = new ModelAndView("memo/memoMain");
		
		return mav;
	}
}
