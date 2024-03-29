package com.spring.javaProjectS2.vo;

import lombok.Data;

@Data
public class MemberVO {
	public int idx;
	public String name;
	public String mid;
	public String pwd;
	public String nickName;
	public String gender;
	public String tel;
	public String address;
	public String email;
	public String userDel;
	public int point;
	public int level;
	public String photo;
	public int visitcnt;
	public int totalCnt;
	public int todayCnt;
	public String startDate;
	public String lastDate;
	public String modifyDate;
	
	private int hour_diff;
	private int date_diff;
	
	private int memberCnt;
}
