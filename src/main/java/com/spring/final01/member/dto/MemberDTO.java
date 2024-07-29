package com.spring.final01.member.dto;

import lombok.Data;

@Data
public class MemberDTO {
	private String co_id;
	private String co_pwd;
	private String co_name;
	private String co_email;
	private String co_address;
	private String co_joinDate;	
	private String co_phone;
	private String co_posi_cd;
	private int co_user_cd;
	private String co_depar_cd;
	private int co_deuser_cd;
	private String co_user_nm;
	private String co_deuser_nm;

}
