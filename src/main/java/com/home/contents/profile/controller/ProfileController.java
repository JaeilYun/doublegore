package com.home.contents.profile.controller;

import com.home.common.annotation.breadcrumb.Breadcrumb;
import com.home.common.annotation.menu.Menu;
import com.home.common.types.MenuTypes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/profile")
public class ProfileController {
	private static final Logger log = LoggerFactory.getLogger(ProfileController.class);

	@Menu(type = MenuTypes.PROFILE)
	@Breadcrumb(values = { "profile.main" })
	@RequestMapping(value = "/main")
	public ModelAndView main() {
		log.debug("[ProfileController] main()");
		
		ModelAndView mav = new ModelAndView("profile/profileMain");
		
		return mav;
	}
}
