package com.spring.final01.money.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.final01.member.dto.MemberDTO;
import com.spring.final01.money.dto.MoneyDTO;

@Repository
public class MoneyDAOImpl implements MoneyDAO{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<MoneyDTO> allPayList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.money.allPayList");
	}
	
	
	@Override
	public List<MoneyDTO> viewMyPayList(String pay_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.money.viewMyPayList", pay_id);
	}
	
	@Override
	public MoneyDTO payListDetail(MoneyDTO mon) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.money.payListDetail", mon);
	}

	
	@Override
	public MoneyDTO modPayView(String pay_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.money.modPayView", pay_id);
	}


	@Override
	public int addPay(MoneyDTO money) {
		// TODO Auto-generated method stub
		return sqlSession.update("mapper.money.addPay", money);
	}

	@Override
	public int modPay(MoneyDTO money) {
		// TODO Auto-generated method stub
		return sqlSession.update("mapper.money.modPay", money);
	}


	@Override
	public MoneyDTO reqAnnual(String annual_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.money.reqAnnual",annual_id);
	}


	@Override
	public int sendHalfAnnual(MoneyDTO money) {
		// TODO Auto-generated method stub
		return sqlSession.insert("mapper.money.sendHalfAnnual", money);
	}

	@Override
	public int sendAnnual(MoneyDTO money) {
		// TODO Auto-generated method stub
		return sqlSession.insert("mapper.money.sendAnnual", money);
	}


	@Override
	public List<MoneyDTO> viewMyAnnual(String annual_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.money.viewMyAnnualList", annual_id);
	}
	
	// 0409 추가
	@Override 
	public int cancelMyAnnual(int no) {
		// TODO Auto-generated method stub
		return sqlSession.delete("mapper.money.cancelMyAnnual", no);
	}
	

	@Override
	public List<MoneyDTO> viewPartAnnual(String partNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.money.viewPartAnnual", partNo);
	}


	@Override
	public String selectPart(String part) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.money.selectPart", part);
	}


	@Override
	public MoneyDTO viewAnnualDetail(int annual_no) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.money.viewAnnualDetail", annual_no);
	}

	
	@Override
	public int permitAnnual(MoneyDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.update("mapper.money.permitAnnual", dto);
	}


	@Override
	public int permitCode(MoneyDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.update("mapper.money.permitCode", dto);
	}


	@Override
	public int deniedAnnual(MoneyDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.update("mapper.money.deniedAnnual", dto);
	}


	@Override
	public List<MemberDTO> memberInfo() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.member.userprofile");
	}

}
