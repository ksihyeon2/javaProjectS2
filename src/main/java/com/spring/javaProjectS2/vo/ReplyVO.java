package com.spring.javaProjectS2.vo;

import lombok.Data;

@Data
public class ReplyVO {
	private int idx;
	private int boardIdx;
	private int re_step;
	private int re_order;
	private String nickName;
	private String wDate;
	private String content;
	
	private int hour_diff;
	private int date_diff;
}
