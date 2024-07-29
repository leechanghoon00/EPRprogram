package com.spring.final01.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.final01.board.dto.BoardDTO;
import com.spring.final01.member.dto.CustomerDTO;
import com.spring.final01.member.dto.MemberDTO;

@Repository
public class MemberDAOImpl implements MemberDAO{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int adduser(MemberDTO member) {
		// TODO Auto-generated method stub
		return sqlSession.insert("mapper.member.adduser", member);
	}

	@Override
	public MemberDTO coLogin(Map<String, Object> map) {

	    return sqlSession.selectOne("mapper.member.coLogin", map);
	}

	@Override
	public CustomerDTO cusLogin(Map<String, Object> map) {
		
		return sqlSession.selectOne("mapper.member.cusLogin", map);
	}

	@Override
	public List<MemberDTO> userprofile() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.member.userprofile");
	}
	@Override
	public int moduser(MemberDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.update("mapper.member.moduser", dto);
	}

	@Override
	public int deluser(String co_id) {
		// TODO Auto-generated method stub
		return sqlSession.delete("mapper.member.deluser", co_id);
	}

	@Override
	public List<CustomerDTO> customer() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.member.customer");
	}

	@Override
	public int customeradd(CustomerDTO member) {
		// TODO Auto-generated method stub
		return sqlSession.insert("mapper.member.customeradd", member);
	}

	@Override
	public int useradd(MemberDTO member) {
		// TODO Auto-generated method stub
		return sqlSession.insert("mapper.member.useradd", member);
	}

	@Override
	public int delcustomer(String cus_id) {
		// TODO Auto-generated method stub
		return sqlSession.delete("mapper.member.delcustomer", cus_id);
	}

	@Override
	public int modcustomer(CustomerDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.update("mapper.member.modcustomer", dto);
	}

	@Override
	public MemberDTO user(String id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.member.user", id);
	}

	@Override
	public int moduser1(MemberDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.update("mapper.member.moduser1", dto);
	}

	@Override
	public int modcustomer1(CustomerDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.update("mapper.member.modcustomer1", dto);
	}

	@Override
	public CustomerDTO customerpro(String id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.member.customerpro", id);
	}

	@Override
	public int sendMessage(CustomerDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.insert("mapper.member.sendMessage", dto);
	}

	@Override
	public List<CustomerDTO> contact() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.member.contact");
	}

	@Override
	public CustomerDTO contactDetail(String message_no) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.member.contactDetail", message_no);
	}

	@Override
	public int confirm(CustomerDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.update("mapper.member.confirm", dto);
	}

	@Override
	public int isUserIdExists(String co_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.member.isUserIdExists", co_id);
	}

	@Override
	public int isUserNameExists(String co_name) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.member.isUserNameExists", co_name);
	}

	@Override
	public int cusUserIdExists(String cus_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.member.cusUserIdExists", cus_id);
	}

	@Override
	public int cusUserNameExists(String cus_name) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.member.cusUserNameExists", cus_name);
	}

	@Override
	public List<BoardDTO> annoList(String part) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.board.selectAnnoList", part);
	}

	@Override
	public List<BoardDTO> annoAllList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.board.selectAnnoAllList");
	}

}
