package com.esen.rms.action;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/page")
public class CoursewareAction {

	@RequestMapping("/coursewarelist")
	public String coursewareList() {
		return "index";
	}
	
	@RequestMapping("/coursemanager")
	public String coursewareManager() {
		return "pages/coursemanager/coursemanager";
	}
}
