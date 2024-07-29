// MemberController interface
package com.spring.final01.member.controller;

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

import com.spring.final01.member.dto.CustomerDTO;
import com.spring.final01.member.dto.MemberDTO;

public interface MemberController {

	
	
    public ModelAndView main( //로그인 성공후 넘어가는 메인화면 (회사)
        MemberDTO member,
        HttpServletRequest request,
        HttpServletResponse response, HttpSession session) throws Exception;

    public ModelAndView mainAdmin( //로그인 성공후 넘어가는 메인화면 (회사-대표자)
    		MemberDTO member,
    		HttpServletRequest request,
    		HttpServletResponse response, HttpSession session) throws Exception;

   
    public void login( // 메인화면,로그인화면
			@RequestParam("co_id") String co_id,
			@RequestParam("co_pwd") String co_pwd,
    		HttpServletRequest request,
    		HttpServletResponse response) throws Exception;
    
    public void logout( //로그아웃
            HttpServletRequest request,
            HttpServletResponse response, HttpSession session) throws Exception;
    
    public ModelAndView customer( // 로그인 성공후 넘어가는 메인화면 (거래처)
    		MemberDTO member,
    		HttpServletRequest request,
    		HttpServletResponse response, HttpSession session) throws Exception;

    public ModelAndView errorMain( // 권한이 없을 경우 넘어오는 페이지
            HttpServletRequest request,
            HttpServletResponse response, HttpSession session) throws Exception;

    public ModelAndView errorMain2( // 권한이 없을 경우 넘어오는 페이지 - 팀장 연차승인 시
    		HttpServletRequest request,
    		HttpServletResponse response, HttpSession session) throws Exception;

    public ModelAndView errorMain3( // 권한이 없을 경우 넘어오는 페이지 - 대표 (연차 관련)
    		HttpServletRequest request,
    		HttpServletResponse response, HttpSession session) throws Exception;

        
        public ModelAndView userprofile( //인사 관리 창 띄우기
        		HttpServletRequest request,
        		HttpServletResponse response,
        		HttpSession session) throws Exception;
        
        public ModelAndView customerProfile( //거래처 관리 창 띄우기
        		HttpServletRequest request,
        		HttpServletResponse response,
        		HttpSession session) throws Exception;
        
        
        public ModelAndView useradd( // 직원 추가 창 띄우기
        		HttpServletRequest request,
        		HttpServletResponse response) throws Exception;
        
        public ModelAndView customeradd( // 거래처 추가 창 띄우기
        		HttpServletRequest request,
        		HttpServletResponse response,
        		HttpSession session) throws Exception;
        
        public ModelAndView user( // 개인정보 관리창 띄우기
        		HttpServletRequest request,
        		HttpServletResponse response,
        		HttpSession session) throws Exception;
        
        public ModelAndView customerpro( // 거래처정보 관리창 띄우기
        		HttpServletRequest request,
        		HttpServletResponse response,
        		HttpSession session) throws Exception;
        
        public void userjoin( //직원추가
        		@ModelAttribute("dto") MemberDTO dto,
    			HttpServletRequest request, 
    			HttpServletResponse response
    			) throws Exception;
        
        public void customerjoin( //거래처 추가
        		@ModelAttribute("dto") CustomerDTO dto,
        		HttpServletRequest request, 
        		HttpServletResponse response
        		) throws Exception;
        
        public @ResponseBody Map<String, Object> moduser1( //개인정보수정
        		@RequestBody List<MemberDTO> member,
        		HttpServletRequest request, 
        		HttpServletResponse response
        		) throws Exception;
       
        public @ResponseBody Map<String, Object> moduser( //직원정보수정
        		@RequestBody List<MemberDTO> member,
        		HttpServletRequest request, 
        		HttpServletResponse response
        		) throws Exception;
        
        public @ResponseBody Map<String, Object> modcustomer( //거래처정보수정
        		@RequestBody List<CustomerDTO> member,
        		HttpServletRequest request, 
        		HttpServletResponse response
        		) throws Exception;
        
        public @ResponseBody Map<String, Object> modcustomer1( //거래처 개인정보수정
        		@RequestBody List<CustomerDTO> member,
        		HttpServletRequest request, 
        		HttpServletResponse response
        		) throws Exception;
       
        public @ResponseBody Map<String, Object> deluser( //직원삭제
        		Map<String, String> requestBody,
    			HttpServletRequest request, 
    			HttpServletResponse response
    			) throws Exception;
        
        public @ResponseBody Map<String, Object> delcustomer( //거래처삭제
        		Map<String, String> requestBody,
        		HttpServletRequest request, 
        		HttpServletResponse response
        		) throws Exception;
        
        public ModelAndView cusContact( // 거래처 FAQ 화면
        		HttpServletRequest request,
        		HttpServletResponse response, HttpSession session) throws Exception;

        public void sendMessage( // 거래처 FAQ 메시지 전송
        		@ModelAttribute("dto") CustomerDTO dto,
        		HttpServletRequest request,
        		HttpServletResponse response, HttpSession session) throws Exception;
        
        public ModelAndView contact( // 경영지원부서 거래처 FAQ 관리
        		HttpServletRequest request,
        		HttpServletResponse response,
        		HttpSession session) throws Exception;

        public  ModelAndView contactDetail( // 경영지원부서 거래처 FAQ 관리 디테일
        		HttpServletRequest request,
        		HttpServletResponse response) throws Exception;
       
        public @ResponseBody Map<String, Object> contactConfirm( // 경영지원부서 거래처 FAQ 관리 디테일 확인
        		@RequestBody CustomerDTO dto,
        		HttpServletRequest request, 
        		HttpServletResponse response
        		) throws Exception;
        
        public ModelAndView excelUser(HttpServletRequest request, ModelMap model) throws Exception;
}
	