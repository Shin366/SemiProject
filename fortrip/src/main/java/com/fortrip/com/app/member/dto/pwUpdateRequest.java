package com.fortrip.com.app.member.dto;

import lombok.Data;

@Data
public class pwUpdateRequest {
	private String currentPw;
	private String newPw;
	private String confirmPw;
}
