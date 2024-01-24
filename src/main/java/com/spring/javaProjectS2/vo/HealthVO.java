package com.spring.javaProjectS2.vo;

import lombok.Data;

@Data
public class HealthVO {
	private int idx;
	private String hName;
	private String part;
	private String detailPart;
	private int level;
	private String position;
	private String motion;
	private String breath;
	private String caution;
	private String comment;
	private String photo;
}
