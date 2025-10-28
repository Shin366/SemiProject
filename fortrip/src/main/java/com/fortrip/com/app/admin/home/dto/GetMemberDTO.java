package com.fortrip.com.app.admin.home.dto;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class GetMemberDTO {
	private int memberNo;
	private String memberName;
	private String email;
	private String gender;
	private Date enrollDate;
	private String phone;
	private String statusYsn;
}
