package com.spring.final01.board.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.final01.board.dto.BoardDTO;

public interface BoardController {
	
	// 공지사항 게시판 - 부서 분류
	public ModelAndView partInfo(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception;
	
	// 공지사항 - 디테일 
	public ModelAndView annoDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception;

	// 공지사항 - 디테일(메인에서)
	public ModelAndView partDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception;

	// 공지사항 - 등록페이지
	public ModelAndView annoAdd(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception;

	// 공지사항 - 등록하기
	public void addAnno(@ModelAttribute("dto")BoardDTO dto, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception;
	
	// 공지사항 - 수정
	public @ResponseBody Map<String, Object> modBoard(HttpServletRequest request, HttpServletResponse response, @RequestBody List<BoardDTO> list) throws Exception;

	// 공지사항 - 삭제
	public @ResponseBody Map<String, Object> delBoard(HttpServletRequest request, HttpServletResponse response, @RequestBody BoardDTO list) throws Exception;
}
