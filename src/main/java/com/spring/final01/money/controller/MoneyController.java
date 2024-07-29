package com.spring.final01.money.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.final01.money.dto.MoneyDTO;


public interface MoneyController {
	
	// 전체 급여명세서 출력
		public ModelAndView allPayList(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception;
		
		// 개인 급여명세서 조회
		public ModelAndView viewMyPayList(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception;
		
		// 수정할 리스트 디테일 출력
		public ModelAndView payListDetail(HttpServletRequest request, HttpServletResponse response) throws Exception;
		
		// 급여명세서 등록 화면
		public ModelAndView addPayView(HttpServletRequest request, HttpServletResponse response) throws Exception;

		// 급여명세서 수정 화면
		public ModelAndView modPayView(HttpServletRequest request, HttpServletResponse response) throws Exception;
		
		// 등록 기능 메서드
		public void addPay(@ModelAttribute("dto") MoneyDTO money,HttpServletRequest request, HttpServletResponse response) throws Exception;

		// 수정 기능 메서드
		public void modPay(@ModelAttribute("dto") MoneyDTO money,HttpServletRequest request, HttpServletResponse response) throws Exception;
		
		// 개인 연차 신청서
		public ModelAndView requestAnnual(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception;
		
		// 연차 신청 기능
		public void sendAnnual(@ModelAttribute("dto") MoneyDTO money,HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception;
		
		// 반차 신청 기능
		public void sendHalfAnnual(@ModelAttribute("dto") MoneyDTO money, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception;
		
		// 개인 연차 조회/관리
		public ModelAndView viewMyAnnual(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception;
		
		// 개인 연차 삭제 (0409추가) 
		public void cancelMyAnnual(@RequestParam("no") int no,HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception;
		
		// 부서장 연차승인 페이지 검증 메서드
		public ModelAndView chkUserInfo(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception;

		// 총무부서원 연차 리스트 출력
		public ModelAndView viewGeneralAnnual(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception;
		
		// 개발부서원 연차 리스트 출력
		public ModelAndView viewDevAnnual(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception;
		
		// 경영부서원 연차 리스트 출력
		public ModelAndView viewManageAnnual(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception;
		
		// 부서원 이름 클릭 시 시퀀스 번호로 해당하는 연차신청서 상세정보 출력
		public ModelAndView viewAnnualDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception;
		
		// 연차 승인 여부 기능 메서드
		public @ResponseBody Map<String, Object> permitAnnual(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestBody List<MoneyDTO> dto) throws Exception;

		// 연차 반려 여부 기능 메서드
		public @ResponseBody Map<String, Object> deniedAnnual(HttpServletRequest request, HttpServletResponse response, HttpSession session,  @RequestBody List<MoneyDTO> dto) throws Exception;
		
		// 엑셀 다운로드 - 급여명세서 조회
		public ModelAndView excelPayStub(HttpServletRequest request, ModelMap model) throws Exception;

}
