package com.home.contents.calendar.controller;

import com.home.common.annotation.breadcrumb.Breadcrumb;
import com.home.common.annotation.menu.Menu;
import com.home.common.types.MenuTypes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/calendar")
public class CalendarController {
	private static final Logger log = LoggerFactory.getLogger(CalendarController.class);

	@Menu(type = MenuTypes.CALENDAR)
	@Breadcrumb(values = { "calendar.main" })
	@RequestMapping(value = "/main")
	public ModelAndView main() {
		log.debug("[CalendarController] main()");
		
		ModelAndView mav = new ModelAndView("calendar/calendarMain");
		
		return mav;
	}
}
