package com.spring.final01.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.final01.board.dto.BoardDTO;
import com.spring.final01.member.dao.MemberDAO;
import com.spring.final01.member.dto.CustomerDTO;
import com.spring.final01.member.dto.MemberDTO;

@Service
public class MemberServiceImpl implements MemberService{

    @Autowired
    private MemberDAO dao;

    @Override
    public MemberDTO coLogin(Map<String, Object> map) {
        // TODO Auto-generated method stub
    	return dao.coLogin(map);
    }

    @Override
    public CustomerDTO cusLogin(Map<String, Object> map) {
    	// TODO Auto-generated method stub
    	return dao.cusLogin(map);
    }
    
	@Override
	public int adduser(MemberDTO member) {
		// TODO Auto-generated method stub
		return dao.adduser(member);
	}

	@Override
	public int moduser(MemberDTO member) {
		// TODO Auto-generated method stub
		return dao.moduser(member);
	}


	@Override
	public List<MemberDTO> userprofile() {
		// TODO Auto-generated method stub
		return dao.userprofile();
	}

	@Override
	public List<CustomerDTO> customer() {
		// TODO Auto-generated method stub
		return dao.customer();
	}
	@Override
	public int deluser(String co_id) {
		// TODO Auto-generated method stub
		return dao.deluser(co_id);
	}

	@Override
	public int moduser(List<MemberDTO> member) {
		// TODO Auto-generated method stub
		int result = 0;
		for(MemberDTO dto : member) {
			result = dao.moduser(dto);
		}
		return result;
	}
	
	@Override
	public int moduser1(List<MemberDTO> member) {
		// TODO Auto-generated method stub
		int result = 0;
		for(MemberDTO dto : member) {
			result = dao.moduser1(dto);
		}
		return result;
	}

	@Override
	public int modcustomer(List<CustomerDTO> member) {
		// TODO Auto-generated method stub
		int result = 0;
		for(CustomerDTO dto : member) {
			result = dao.modcustomer(dto);
		}
		return result;
	}

	@Override
	public int modcustomer1(List<CustomerDTO> member) {
		// TODO Auto-generated method stub
		int result = 0;
		for(CustomerDTO dto : member) {
			result = dao.modcustomer1(dto);
		}
		return result;
	}
	@Override
	public int customerjoin(CustomerDTO member) {
		// TODO Auto-generated method stub
		return dao.customeradd(member);
	}
	
	@Override
	public int userjoin(MemberDTO member) {
		// TODO Auto-generated method stub
		return dao.useradd(member);
	}

	@Override
	public int delcustomer(String cus_id) {
		// TODO Auto-generated method stub
		return dao.delcustomer(cus_id);
	}

	@Override
	public MemberDTO user(String id) {
		// TODO Auto-generated method stub
		return dao.user(id);
	}

	@Override
	public CustomerDTO customerpro(String id) {
		// TODO Auto-generated method stub
		return dao.customerpro(id);
	}

	@Override
	public int sendMessage(CustomerDTO dto) {
		// TODO Auto-generated method stub
		return dao.sendMessage(dto);
	}

	@Override
	public List<CustomerDTO> contact() {
		// TODO Auto-generated method stub
		return dao.contact();
	}

	@Override
	public CustomerDTO contactDetail(String message_no) {
		// TODO Auto-generated method stub
		return dao.contactDetail(message_no);
	}

	@Override
	public int confirm(CustomerDTO dto) {
		// TODO Auto-generated method stub
		return dao.confirm(dto);
	}

	@Override
	public boolean isUserIdExists(String co_id) {
		// TODO Auto-generated method stub
		int count = dao.isUserIdExists(co_id);
		return count > 0;
	}

	@Override
	public boolean isUserNameExists(String co_name) {
		// TODO Auto-generated method stub
		int count = dao.isUserNameExists(co_name);
		return count > 0;
	}

	@Override
	public boolean cusUserIdExists(String cus_id) {
		// TODO Auto-generated method stub
		int count = dao.cusUserIdExists(cus_id);
		return count > 0;
	}

	@Override
	public boolean cusUserNameExists(String cus_name) {
		// TODO Auto-generated method stub
		int count = dao.cusUserNameExists(cus_name);
		return count > 0;
	}

	@Override
	public List<BoardDTO> annoList(String part) {
		// TODO Auto-generated method stub
		return dao.annoList(part);
	}

	@Override
	public List<BoardDTO> annoAllList() {
		// TODO Auto-generated method stub
		return dao.annoAllList();
	}

	
	
}
