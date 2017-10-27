package com.home.config.core;

import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.DispatcherServlet;

import javax.servlet.*;
import java.util.EnumSet;

public class WebContextInitializer implements WebApplicationInitializer {
    private static final String CONFIG_LOCATION = "com.home.config";
    private static final String MAPPING_URL = "/";

    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {

        registerDispatcherServlet(servletContext);
        registerCharacterEncodingFilter(servletContext);

    }

    /**
     * 인코딩 설정
     * @param servletContext
     */
    private void registerCharacterEncodingFilter(ServletContext servletContext) {
        FilterRegistration.Dynamic characterEncodingFilter = servletContext.addFilter("characterEncodingFilter", new CharacterEncodingFilter());
        characterEncodingFilter.addMappingForUrlPatterns(EnumSet.allOf(DispatcherType.class), true, "/*");
        characterEncodingFilter.setInitParameter("encoding", "UTF-8");
        characterEncodingFilter.setInitParameter("forceEncoding", "true");
    }

    /**
     * Servlet Dispatcher 설정
     * @param servletContext
     */
    private void registerDispatcherServlet(ServletContext servletContext) {
        AnnotationConfigWebApplicationContext context = new AnnotationConfigWebApplicationContext();
        context.setDisplayName("doublegore");
        context.setConfigLocation(CONFIG_LOCATION);
        servletContext.addListener(new ContextLoaderListener(context));

        ServletRegistration.Dynamic dispatcher = servletContext.addServlet("dispatcher", new DispatcherServlet(context));
        dispatcher.setLoadOnStartup(1);
        dispatcher.addMapping(MAPPING_URL);
    }
}
