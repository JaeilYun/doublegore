package com.home.contents.dashboard.controller;

import com.home.common.annotation.breadcrumb.Breadcrumb;
import com.home.common.annotation.menu.Menu;
import com.home.common.types.MenuTypes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/dashboard")
public class DashboardController {
    private static final Logger log = LoggerFactory.getLogger(DashboardController.class);

    @Menu(type = MenuTypes.DASHBOARD)
    @Breadcrumb(values = { "dashboard.main" })
    @RequestMapping(value = "/main")
    public ModelAndView main() {
        log.debug("[DashboardController] main().");

        ModelAndView mav = new ModelAndView("dashboard/dashboardMain");
        return mav;
    }
}
