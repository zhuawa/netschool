package com.esen.netschool.lms.entity;

import lombok.Data;

@Data
public class Course {
	private String id;
	private String number;
	private String name;
	private String time;
	private String type;
	private String keyword;
}
