package com.spring.final01.money.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.final01.member.dto.MemberDTO;
import com.spring.final01.money.dao.MoneyDAO;
import com.spring.final01.money.dto.MoneyDTO;


@Service
public class MoneyServiceImpl implements MoneyService{
	
	@Autowired
	private MoneyDAO dao;
	
	
	@Override
	public List<MoneyDTO> allPayList() {
		// TODO Auto-generated method stub
		return dao.allPayList();
	}
	
	@Override
	public List<MoneyDTO> viewMyPayList(String pay_id) {
		// TODO Auto-generated method stub
		return dao.viewMyPayList(pay_id);
	}


	@Override
	public MoneyDTO payListDetail(MoneyDTO mon) {
		// TODO Auto-generated method stub
		return dao.payListDetail(mon);
	}

	@Override
	public MoneyDTO modPayView(String pay_id) {
		// TODO Auto-generated method stub
		return dao.modPayView(pay_id);
	}
	

	@Override
	public int addPay(MoneyDTO money) {
		// TODO Auto-generated method stub
		return dao.addPay(money);
	}

	@Override
	public int modPay(MoneyDTO money) {
		// TODO Auto-generated method stub
		return dao.modPay(money);
	}

	
	@Override
	public MoneyDTO reqAnnual(String annual_id) {
		// TODO Auto-generated method stub
		return dao.reqAnnual(annual_id);
	}

	@Override
	public int sendHalfAnnual(MoneyDTO money) {
		// TODO Auto-generated method stub
		return dao.sendHalfAnnual(money);
	}

	@Override
	public int sendAnnual(MoneyDTO money) {
		// TODO Auto-generated method stub
		return dao.sendAnnual(money);
	}

	@Override
	public List<MoneyDTO> viewMyAnnualList(String annual_id) {
		// TODO Auto-generated method stub
		return dao.viewMyAnnual(annual_id);
	}
	
	// 0409 추가
	@Override
	public int cancelMyAnnual(int no) {
		// TODO Auto-generated method stub
		return dao.cancelMyAnnual(no);
	}
	
	
	@Override
	public List<MoneyDTO> viewPartAnnual(String partNo) {
		// TODO Auto-generated method stub
		return dao.viewPartAnnual(partNo);
	}

	@Override
	public String selectPart(String part) {
		// TODO Auto-generated method stub
		return dao.selectPart(part);
	}

	@Override
	public MoneyDTO viewAnnualDetail(int annual_no) {
		// TODO Auto-generated method stub
		return dao.viewAnnualDetail(annual_no);
	}


	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public int permitAnnual(List<MoneyDTO> list) {
		// TODO Auto-generated method stub
		int result = 0;
		int result1 = 0;
		int result2 = 0;
		
		for (MoneyDTO dto : list) {
			
			// 첫 번째 DAO 메서드 실행 후 결과 저장
			result1 = dao.permitAnnual(dto);
			
			// 두 번째 DAO 메서드 실행 후 결과 저장
			result2 = dao.permitCode(dto);
		}
		
		// 두 DAO 메서드의 결과를 합쳐서 최종 결과로 정의
		// 예시: 두 DAO 메서드 중 하나라도 실패하면 전체적으로 실패로 간주
		if (result1 > 0 && result2 > 0) {
			result = 1; // 성공적으로 실행됨을 나타냄
		} else {
			result = 0; // 실패함을 나타냄
		}
		return result;
	}


	@Override
	public int deniedAnnual(List<MoneyDTO> list) {
		// TODO Auto-generated method stub
		int result = 0;
		
		for(MoneyDTO dto : list) {
			result = dao.deniedAnnual(dto); 
		}
		return result;
	}

	@Override
	public List<MemberDTO> memberInfo() {
		// TODO Auto-generated method stub
		return dao.memberInfo();
	}


}
