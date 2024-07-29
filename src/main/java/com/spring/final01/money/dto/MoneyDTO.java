package com.spring.final01.money.dto;


import java.sql.Date;

import lombok.Data;

@Data
public class MoneyDTO {
	// pay_tbl 테이블 컬럼
	private String work_period; // 기간
	private String pay; // 월급
	private double remain_annual; // 잔여 연차
	private String pay_id; // 외래키값 아이디(coMember_tbl에 co_id)

	// coMember_tbl 테이블 컬럼
	private int co_user_cd; // 사원 직급번호
	private String co_name; // 사원 이름
	private int co_deuser_cd; // 사원 부서번호
	
	// annual 테이블 컬럼
	private String annual_id;
	private double annual_period;
	private String annual_startDay;
	private String annual_endDay;
	private String annual_cd;
	private int annual_annu_cd;
	private String annual_reason;
	private String annual_permit;
	private int annual_permit_cd;
	private Date annual_submit_time;
	private int no; // 시퀀스 컬럼
	
	// code 테이블
	private String user_cd;
	private String user_type;

}