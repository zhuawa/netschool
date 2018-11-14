package com.esen.rms.action;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/page")
public class LearnResourcesAction {

	@RequestMapping("/leanresourceslist")
	public String coursewareList() {
		return "index";
	}
	
	@RequestMapping("/leanresourcesmgr")
	public String coursewareManager() {
		return "pages/leanresourcesmgr/leanresourcesmgr";
	}
}
