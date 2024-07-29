package com.spring.final01.member.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class CustomerDTO {
	private String cus_id;
	private String cus_pwd;
	private String cus_name;
	private String cus_address;
	private String cus_phone;
	private Date cus_joinDate;
	private String cus_common_cd;
	private int cus_user_cd;
	private String cus_email;
	private String subject;
	private String contents;
	private Date sendDate;
	private int message_no;
	private String confirm;
}
