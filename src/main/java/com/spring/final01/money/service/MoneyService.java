package com.spring.final01.money.service;

import java.util.List;

import com.spring.final01.member.dto.MemberDTO;
import com.spring.final01.money.dto.MoneyDTO;

public interface MoneyService {
	
	// 전체 급여명세서
		List<MoneyDTO> allPayList();
		
		// 내(로그인 한 계정) 급여명세서 출력
		List<MoneyDTO> viewMyPayList(String pay_id);
		
		// 급여명세서 출력
		MoneyDTO payListDetail(MoneyDTO mon);
		
		// 급여명세서 수정화면 출력
		MoneyDTO modPayView(String pay_id);
		
		// 등록 기능 
		int addPay(MoneyDTO money);

		// 수정 기능 
		int modPay(MoneyDTO money);
		
		// 연가신청서 작성
		MoneyDTO reqAnnual(String annual_id);
		
		// 반차신청 기능
		int sendHalfAnnual(MoneyDTO money);

		// 연가신청 기능
		int sendAnnual(MoneyDTO money);
		
		// 내(로그인 한 계정) 연차목록 조회
		List<MoneyDTO> viewMyAnnualList(String annual_id);
		
		// 내 연차 삭제 0409 추가
		int cancelMyAnnual(int no);
		
		// 연차 승인 페이지 부서원들 연차신청서 출력
		List<MoneyDTO> viewPartAnnual(String partNo);
		
		// 부서 확인
		String selectPart(String part);
		
		// 승인 페이지에서 눌렀을 때 시퀀스 번호를 이용해서 출력
		MoneyDTO viewAnnualDetail(int annual_no);
		
		// 연차 승인 시, 잔여연차 수정
		int permitAnnual(List<MoneyDTO> dto);
		
		// 연차 반려 시, 승인 여부 반려로 수정
		int deniedAnnual(List<MoneyDTO> dto);
		
		// 직원 목록 조회
		List<MemberDTO> memberInfo();

	

}
