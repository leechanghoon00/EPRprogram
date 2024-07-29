package com.spring.final01.member.service;

import java.util.List;
import java.util.Map;

import com.spring.final01.board.dto.BoardDTO;
import com.spring.final01.member.dto.CustomerDTO;
import com.spring.final01.member.dto.MemberDTO;

public interface MemberService {

	MemberDTO coLogin(Map<String, Object> map); // 회사 로그인
	CustomerDTO cusLogin(Map<String, Object> map); // 거래처 로그인
	List<MemberDTO> userprofile(); //회원정보
	int adduser(MemberDTO member); //회원가입

	
	int moduser(MemberDTO member); //수정
	
	
	List<CustomerDTO> customer(); //거래처 정보
	
	int userjoin(MemberDTO member); //직원 회원가입
	int customerjoin(CustomerDTO member); //거래처 회원가입
	
	int moduser1(List<MemberDTO> member); // 개인정보 수정하기
	int moduser(List<MemberDTO> member); // 직원 정보수정하기
	int modcustomer1(List<CustomerDTO> member); // 거래처 개인정보수정하기
	int modcustomer(List<CustomerDTO> member); // 거래처 정보 수정하기
	
	int deluser(String co_id); // 직원 삭제하기
	int delcustomer(String cus_id); // 거래처 삭제하기
	MemberDTO user(String id); // 직원 개인정보 가져오기
	CustomerDTO customerpro(String id); // 거래처 개인정보 가져오기
	int sendMessage(CustomerDTO dto);
	List<CustomerDTO> contact();
	CustomerDTO contactDetail(String message_no);
	int confirm(CustomerDTO dto);
	boolean isUserIdExists(String co_id);
	boolean isUserNameExists(String co_name);
	boolean cusUserIdExists(String cus_id);
	boolean cusUserNameExists(String cus_name);
	List<BoardDTO> annoList(String part);
	List<BoardDTO> annoAllList();
	}	