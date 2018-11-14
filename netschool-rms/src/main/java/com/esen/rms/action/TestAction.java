package com.esen.rms.action;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestAction {

	@Value("${server.port}")
    String port;

	@GetMapping(value = "/hi",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public String home(@RequestParam(value="name", required=false) String name) {
//        return "hi " + name + " ,i am from port:" + port;
		return "index";
    }
}
