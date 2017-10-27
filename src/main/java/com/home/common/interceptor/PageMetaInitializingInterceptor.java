package com.home.common.interceptor;

import com.home.common.annotation.breadcrumb.Breadcrumb;
import com.home.common.annotation.menu.Menu;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.support.RequestContextUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Locale;

@Component
public class PageMetaInitializingInterceptor extends HandlerInterceptorAdapter {
	
	private static final Logger log = LoggerFactory.getLogger(PageMetaInitializingInterceptor.class);
	
	private ReloadableResourceBundleMessageSource messageSource;
	
	@Autowired
	public PageMetaInitializingInterceptor(ReloadableResourceBundleMessageSource messageSource) {
		this.messageSource = messageSource;
	}
	
	public static final String MENU_TYPE_ATTR_NAME = "currentMenu";
	public static final String BREADCRUMB_ATTR_NAME = "currentBreadcrumb";
	
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		Annotation[] declaredAnnotations = getDeclaredAnnotationsForHandler(handler);
		HttpSession session = request.getSession();
		clearCurrentMenu(session);
		clearCurrentBreadcrumb(session);
		
		for (Annotation annotation : declaredAnnotations) {
			if (annotation.annotationType().equals(Menu.class)) {
				processMenuAnnotation(request, session, annotation);
			} else if (annotation.annotationType().equals(Breadcrumb.class)) {
				processBreadcrumbAnnotation(request, session, annotation);
			}
		}
		
		return true;
    }
     
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        
    }
    
    private void clearCurrentMenu(HttpSession session) {
		session.setAttribute(MENU_TYPE_ATTR_NAME, "");
	}

	private void clearCurrentBreadcrumb(HttpSession session) {
		session.setAttribute(BREADCRUMB_ATTR_NAME, "");
	}
	
	private void processMenuAnnotation(HttpServletRequest request, HttpSession session, Annotation annotation) {
		Menu menuAnnotation = (Menu) annotation;
		session.setAttribute(MENU_TYPE_ATTR_NAME, menuAnnotation.type());
	}

	private void processBreadcrumbAnnotation(HttpServletRequest request, HttpSession session, Annotation annotation) {
		Breadcrumb breadcrumbAnnotation = (Breadcrumb) annotation;

		String[] values = breadcrumbAnnotation.values();
		Locale locale = RequestContextUtils.getLocale(request);
		for (int idx = 0; idx < values.length; idx++) {
			try {
				values[idx] = messageSource.getMessage(values[idx], null, locale);
			} catch (Exception e) {
				values[idx] = values[idx];
			}
		}
		session.setAttribute(BREADCRUMB_ATTR_NAME, values);
	}

	private Annotation[] getDeclaredAnnotationsForHandler(Object handler) {
		Annotation[] declaredAnnotations = null;

		if (handler.getClass().equals(HandlerMethod.class)) {
			HandlerMethod handlerMethod = (HandlerMethod) handler;
			Method method = handlerMethod.getMethod();
			declaredAnnotations = method.getDeclaredAnnotations();
		} else {
			declaredAnnotations = new Annotation[] {};
		}

		return declaredAnnotations;
	}
}
