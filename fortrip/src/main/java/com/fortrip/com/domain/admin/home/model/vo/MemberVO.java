package com.fortrip.com.domain.admin.home.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class MemberVO {
	private int memberNo;
	private String memberId;        // 회원 아이디
	private String memberPw;        // 회원 비밀번호
    private String memberName;      // 회원 이름
    private String nickName;        // 닉네임
    private String phone;           // 전화번호
    private String birthDateYear;   // 생년월일 - 년
    private String birthDateMon;    // 생년월일 - 월
    private String birthDateDay;    // 생년월일 - 일
    private String email;           // 이메일
    private String gender;          // 성별 (M/F)
    private String adminYn;         // 관리자 여부 (Y/N)
    private Date enrollDate;
    private String tripStyle;
    private String tendency;
    private String statusYsn;
}
