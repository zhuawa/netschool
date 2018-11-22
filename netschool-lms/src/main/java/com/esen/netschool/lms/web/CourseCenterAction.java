package com.esen.netschool.lms.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/page/coursecenter")
public class CourseCenterAction {

	@RequestMapping("/courselist")
	public String coursewareManager() {
		return "pages/course/courselist";
	}
}
