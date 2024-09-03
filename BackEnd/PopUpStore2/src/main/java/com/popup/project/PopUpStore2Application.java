package com.popup.project;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableAsync;

@SpringBootApplication
@EnableAsync
public class PopUpStore2Application {

	public static void main(String[] args) {
		SpringApplication.run(PopUpStore2Application.class, args);
	}
	
}
