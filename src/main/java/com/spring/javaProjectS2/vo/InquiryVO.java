package com.spring.javaProjectS2.vo;

import lombok.Data;

@Data
public class InquiryVO {
	private int idx;
	private String askMid;
	private String answerMid;
	private String ask;
	private String answer;
	private String asktime;
	private String answertime;
	private String inquirystate;
	private String part;
	
	private int hour_diff;
	private int date_diff;
}
