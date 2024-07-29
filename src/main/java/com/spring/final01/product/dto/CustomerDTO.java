package com.spring.final01.product.dto;

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
	private String cus_user_cd;
}
