package com.home.config;

import com.fasterxml.jackson.databind.SerializationFeature;
import com.home.common.interceptor.PageMetaInitializingInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.http.MediaType;
import org.springframework.http.converter.*;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter;
import org.springframework.web.servlet.view.BeanNameViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;
import org.springframework.web.servlet.view.UrlBasedViewResolver;
import org.springframework.web.servlet.view.tiles3.SpringBeanPreparerFactory;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;

import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Configuration
@EnableWebMvc
@ComponentScan(
        basePackages = "com.home",
        includeFilters = {@ComponentScan.Filter(Controller.class),@ComponentScan.Filter(Service.class)},
        excludeFilters = {@ComponentScan.Filter(Repository.class)})
public class SpringMVCConfig extends WebMvcConfigurerAdapter {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry){
        registry.addResourceHandler("/resources/**").addResourceLocations("/resources/").setCachePeriod(31550522);
    }

    @Bean
    public TilesConfigurer tilesConfigurer(){
        TilesConfigurer configure = new TilesConfigurer();
        configure.setDefinitions(new String[] {"classpath:tiles/tiles.xml"});
        configure.setPreparerFactoryClass(SpringBeanPreparerFactory.class);
        configure.setCheckRefresh(true);
        return configure;
    }

    @Bean
    public UrlBasedViewResolver tilesViewResolver(){
        UrlBasedViewResolver urlBasedViewResolver = new UrlBasedViewResolver();
        urlBasedViewResolver.setOrder(1);
        urlBasedViewResolver.setViewClass(TilesView.class);
        return urlBasedViewResolver;
    }

    @Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer){
        configurer.enable();
    }

    @Bean
    public InternalResourceViewResolver internalResourceViewResolver(){
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setViewClass(JstlView.class);
        resolver.setPrefix("/WEB-INF/views/");
        resolver.setSuffix(".jsp");
        resolver.setOrder(2);
        return resolver;
    }

    @Bean
    public ReloadableResourceBundleMessageSource messageSource(){
        ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
        messageSource.setBasenames("classpath:/messages/messages");
        return messageSource;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        PageMetaInitializingInterceptor sidebarIntercepter = new PageMetaInitializingInterceptor(messageSource());
        registry.addInterceptor(sidebarIntercepter);
    }

    @Bean(name = "downloadResolver")
    public BeanNameViewResolver beanNameViewResolver(){
        BeanNameViewResolver resolver = new BeanNameViewResolver();
        resolver.setOrder(0);
        return resolver;
    }

    @Bean(name = "multipartResolver")
    public CommonsMultipartResolver multipartResoler(){
        CommonsMultipartResolver multipart = new CommonsMultipartResolver();
        multipart.setMaxUploadSize(1000000000);
        multipart.setMaxInMemorySize(1000000000);
        return multipart;
    }

    //@ResponseBody 한글깨짐 해결
    @Bean
    public RequestMappingHandlerAdapter requestMappingHandlerAdapter(){
        StringHttpMessageConverter stringHttpMessageconverter = new StringHttpMessageConverter();
        stringHttpMessageconverter.setSupportedMediaTypes(Arrays.asList(new MediaType("text", "html", Charset.forName("UTF-8"))));

        //json 리턴시 오류 해결
        Jackson2ObjectMapperBuilder builder = new Jackson2ObjectMapperBuilder();
        builder.dateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm"));
        builder.featuresToDisable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
        builder.featuresToDisable(SerializationFeature.FAIL_ON_EMPTY_BEANS);

        List<HttpMessageConverter<?>> converter = new ArrayList<HttpMessageConverter<?>>();
        converter.add(stringHttpMessageconverter);
        converter.add(new MappingJackson2HttpMessageConverter(builder.build()));

        RequestMappingHandlerAdapter rmha = new RequestMappingHandlerAdapter();
        rmha.setMessageConverters(converter);

        return rmha;
    }
}
