package com.spring.javaProjectS2.vo;

import lombok.Data;

@Data
public class ComplaintVO {
	private int idx;
	private int complaintidx;
	private String complaintMid;
	private String complaintType;
	private String complaintPart;
	private String complaintText;
	private String complaintDate;
	private String complaintState;
}
