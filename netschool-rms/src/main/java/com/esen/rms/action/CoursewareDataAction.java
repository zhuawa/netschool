package com.esen.rms.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.esen.rms.entity.Courseware;


@RestController
@RequestMapping(value="/coursemanager")
public class CoursewareDataAction {
	
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String list(@RequestParam(name="keyword",required = false) String keyword, @RequestParam(name="pageNum",required = false) String pageNum, 
				@RequestParam(name="pageSize",required = false) String pageSize, HttpServletRequest req, HttpServletResponse res) throws JSONException {
		JSONObject jsonObject = new JSONObject();
		Courseware gg = null;
		int pNum = 0;
		if(pageNum!=null && !"".equals(pageNum)) {
			pNum = Integer.parseInt(pageNum);
		}
		int pSize = 10;
		if(pageSize!=null && !"".equals(pageSize)) {
			pSize = Integer.parseInt(pageSize);
		}
		List<Courseware> list = new ArrayList<Courseware>();
		for(int i=(pNum-1)*pSize; i<pNum*pSize; i++) {
			gg = new Courseware();
			gg.setId(i+"");
			gg.setNumber("20181121A"+i);
			gg.setName("课件"+i);
			gg.setTime("50分钟");
			gg.setType("ppt");
			gg.setKeyword("课件");
			list.add(gg);
		}
		JSONArray ja = new JSONArray(list);
		jsonObject.put("data", ja);
		jsonObject.put("total", 20);
		jsonObject.put("currentPage", 1);
		jsonObject.put("pageSize", 2);
		jsonObject.put("checked", false);
		return jsonObject.toString();
	}
}
