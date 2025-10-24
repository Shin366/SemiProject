package com.fortrip.com.app.member.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class JoinRequest {
	private int memberNo;
	private String memberId;
	private String memberPw;
	private String memberName;
	private String nickName;
	private String phone;
	private String birthDateYear;
	private String birthDateMon;
	private String birthDateDay;
	private String email;
	private String gender;
	private Date enrollDate;
	private String adminYN;
	private String tripStyle;
	private String tendency;
	private String stausYSN;
}
