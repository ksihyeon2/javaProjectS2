package com.spring.javaProjectS2.vo;

import lombok.Data;

@Data
public class HealthWriteVO {
	private int idx;
	private String mid;
	private String part;
	private String healthDate;
	private int healthTime;
	private int weight;
	private String healthDetailText;
	
	private int date_diff;
}
