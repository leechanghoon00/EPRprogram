package com.spring.final01.money.dao;

import java.util.List;

import com.spring.final01.member.dto.MemberDTO;
import com.spring.final01.money.dto.MoneyDTO;

public interface MoneyDAO {
	
	// 전체 급여 명세서 출력
		List<MoneyDTO> allPayList();
		
		// 내(로그인한 계정) 급여명세서 조회
		List<MoneyDTO> viewMyPayList(String pay_id);
		
		// 수정할 상세명세서 출력
		MoneyDTO payListDetail(MoneyDTO mon);

		// 급여명세서 수정
		MoneyDTO modPayView(String pay_id);
		
		// 급여명세서 등록 기능
		int addPay(MoneyDTO money);

		// 급여명세서 수정 기능
		int modPay(MoneyDTO money);
		
		// 연가신청서 화면 출력
		MoneyDTO reqAnnual(String annual_id);
		
		// 반차 신청 기능
		int sendHalfAnnual(MoneyDTO money);

		// 연가 신청 기능
		int sendAnnual(MoneyDTO money);
		
		// 내 연차 조회
		List<MoneyDTO> viewMyAnnual(String annual_id);
		
		// 내 연차 삭제 0409 추가
		int cancelMyAnnual(int no);
		
		// 부서장(팀장) 부서원 연차신청 부분 조회
		List<MoneyDTO> viewPartAnnual(String partNo);
		
		// 부서 확인
		String selectPart(String part);
		
		// 연차신청서 상세정보 출력
		MoneyDTO viewAnnualDetail(int annual_no);
		
		// 연차 승인 시, 잔여연차 수정
		int permitAnnual(MoneyDTO dto);
		
		// 연차 승인 시, 승인상태 승인으로 수정
		int permitCode(MoneyDTO dto);
		
		// 연차 반려 시, 승인상태 반려로 수정
		int deniedAnnual(MoneyDTO dto);
		
		// 직원 목록 조회
		List<MemberDTO> memberInfo();


}
