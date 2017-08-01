package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/portal")
@Controller
public class ProtalController {

	@RequestMapping("/index")
	public String index(){
		return "portal/index";
	}
	
	@RequestMapping("/about")
	public String about(){
		return "portal/about";
	}
	
	@RequestMapping("/component")
	public String repair(){
		return "portal/component";
	}
}
