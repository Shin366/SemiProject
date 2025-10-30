package com.fortrip.com.app.member.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModifyRequest {
	private String memberId;
	private String nickName;
	private String phone;
	private String email;
	
}
