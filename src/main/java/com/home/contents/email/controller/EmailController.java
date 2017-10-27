package com.home.contents.email.controller;

import com.home.common.annotation.breadcrumb.Breadcrumb;
import com.home.common.annotation.menu.Menu;
import com.home.common.types.MenuTypes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/email")
public class EmailController {
	private static final Logger log = LoggerFactory.getLogger(EmailController.class);

	@Menu(type = MenuTypes.EMAIL)
	@Breadcrumb(values = { "email.main" })
	@RequestMapping(value = "/main")
	public ModelAndView main() {
		log.debug("[EmailController] main()");
		
		ModelAndView mav = new ModelAndView("email/emailMain");
		
		return mav;
	}
}
