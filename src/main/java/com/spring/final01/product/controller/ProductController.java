package com.spring.final01.product.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.final01.product.dto.ProductDTO;

public interface ProductController {

	// 총무부서
	//	-제품출하량
	public ModelAndView productOut(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception;
	
	//	-재고관리
	public ModelAndView productStock(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception;
	
	// 개발생산부서
	//	-상품관리 - 페이지
	public ModelAndView manageStock(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception;
	
	//	-제품등록
	public @ResponseBody Map<String, Object> addStock(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestBody List<ProductDTO> list) throws Exception;

	//	-재고수정
	public @ResponseBody Map<String, Object> modStock(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestBody List<ProductDTO> list) throws Exception;

	//	-재고삭제
	public @ResponseBody Map<String, Object> delStock(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestBody List<String> list) throws Exception;

	// 거래처
	//	-주문등록 - 페이지
	public ModelAndView offerMain(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception;
	//	-주문등록
	public @ResponseBody Map<String, Object> offer(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestBody List<ProductDTO> list) throws Exception;
	// 	-주문조회
	public ModelAndView offerInfo(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception;
	//	-주문수정
	public @ResponseBody Map<String, Object> modOffer(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestBody List<ProductDTO> list) throws Exception;
	//	-주문삭제
	public @ResponseBody Map<String, Object> delOffer(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestBody List<Integer> list) throws Exception;
	//	-재고관리
	public ModelAndView customerStock(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception;
	// 엑셀 다운로드 - 제품출하량
	public ModelAndView excelProductOut(HttpServletRequest request, ModelMap model) throws Exception;

	// 엑셀 다운로드 - 재고관리(회사)
	public ModelAndView excelManageStock(HttpServletRequest request, ModelMap model) throws Exception;

	// 엑셀 다운로드 - 주문조회(거래처)
	public ModelAndView excelOfferInfo(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception;

	// 엑셀 다운로드 - 재고관리(거래처)
	public ModelAndView excelCusStock(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception;

}
