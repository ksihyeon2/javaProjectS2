package com.spring.javaProjectS2.vo;

import lombok.Data;

@Data
public class ModifyVO {
	private int idx;
	private String hName;
	private String requestMid;
	private String modifyPart;
	private String modifyText;
	private String modifyState;
	private String modifyDate;
	
	private int hour_diff;
	private int date_diff;
}
