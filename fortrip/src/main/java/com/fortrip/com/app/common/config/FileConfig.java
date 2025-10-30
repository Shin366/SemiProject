package com.fortrip.com.app.common.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.fortrip.com.app.common.interceptor.CheckAdminInterceptor;

@Configuration
public class FileConfig implements WebMvcConfigurer{
	
	
	public void addInterceptors(InterceptorRegistry registry) {
		
		
		registry.addInterceptor(new CheckAdminInterceptor())
		.addPathPatterns("/admin/**");
	}
}
