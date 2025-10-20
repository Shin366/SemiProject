package com.fortrip.com;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

@SpringBootApplication(exclude = {SecurityAutoConfiguration.class})
public class ForTripApplication {

	public static void main(String[] args) {
		SpringApplication.run(ForTripApplication.class, args);
	}

}
