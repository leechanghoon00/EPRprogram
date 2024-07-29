package com.spring.final01;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	
	// 메인화면 - 로그인
	@RequestMapping(value= {"/", "/login"})
	public String login() {
		
		return "login";
	}
	
	
}
