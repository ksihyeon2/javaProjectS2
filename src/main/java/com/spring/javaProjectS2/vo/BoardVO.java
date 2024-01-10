package com.spring.javaProjectS2.vo;

import lombok.Data;

@Data
public class BoardVO {
	private int idx;
	private String mid;
	private String nickName;
	private String title;
	private String content;
	private String part;
	private String openSw;
	private int readNum;
	private String wDate;
	private int good;
	private String delCheck;
	private String delDate;
	
	private int hour_diff;
	private int date_diff;
	
	private int replyCnt;
}
