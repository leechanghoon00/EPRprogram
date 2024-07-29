package com.spring.final01.member.dao;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.spring.final01.board.dto.BoardDTO;
import com.spring.final01.member.dto.CustomerDTO;
import com.spring.final01.member.dto.MemberDTO;

@Repository
public interface MemberDAO {

	int adduser(MemberDTO member);
	MemberDTO coLogin(Map<String, Object> map);
	CustomerDTO cusLogin(Map<String, Object> map);
	
	List<MemberDTO> userprofile();
	List<CustomerDTO> customer();

	int useradd(MemberDTO member);
	int customeradd(CustomerDTO member);

	int moduser1(MemberDTO dto);
	int moduser(MemberDTO dto);
	int modcustomer(CustomerDTO dto);
	int modcustomer1(CustomerDTO dto);

	int deluser(String co_id);
	int delcustomer(String cus_id);
	MemberDTO user(String id);
	CustomerDTO customerpro(String id);
	int sendMessage(CustomerDTO dto);
	List<CustomerDTO> contact();
	CustomerDTO contactDetail(String message_no);
	int confirm(CustomerDTO dto);
	int isUserIdExists(String co_id);
	int isUserNameExists(String co_name);
	int cusUserIdExists(String cus_id);
	int cusUserNameExists(String cus_name);
	List<BoardDTO> annoList(String part);
	List<BoardDTO> annoAllList();

}