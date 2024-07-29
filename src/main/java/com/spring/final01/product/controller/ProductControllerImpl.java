package com.spring.final01.product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.final01.product.dto.ProductDTO;
import com.spring.final01.product.service.ProductService;

// product - 패키지 컨트롤러(총무부- 제품출하량, 재고관리, 개발부서 - 상품관리, 거래처 - 주문등록, 조회, 재고관리)
@Controller
@EnableTransactionManagement
@RequestMapping("/product")
public class ProductControllerImpl implements ProductController{
	
	@Autowired
	private ProductService service;
	
	
//	제품출하량 - 총무부서
	@Override
	@RequestMapping("/productOut.do")
	public ModelAndView productOut(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		// TODO Auto-generated method stub
		String part = (String) session.getAttribute("part");
		String position = (String) session.getAttribute("position");
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		String possi_part = "총무";
		
		if (part.equals("총무") || position.equals("대표")) {
			mav.setViewName(viewName);
			List<ProductDTO> salesList = service.salesList();
			mav.addObject("salesList", salesList);
		} else {
			mav.setViewName("member/errorMain");
			mav.addObject("possi_part", possi_part);
			mav.addObject("possi_position", "");
		}
		
		return mav;
	}
	
//	재고관리 - 총무부서
	@Override
	@RequestMapping("/productStock.do")
	public ModelAndView productStock(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		// TODO Auto-generated method stub
		String part = (String) session.getAttribute("part");
		String position = (String) session.getAttribute("position");
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		String possi_part = "총무";
		
		if (part.equals("총무") || position.equals("대표")) {
			mav.setViewName(viewName);
			List<ProductDTO> stockList = service.stockList();
			mav.addObject("stockList", stockList);
		} else {
			mav.setViewName("member/errorMain");
			mav.addObject("possi_part", possi_part);
			mav.addObject("possi_position", "");
		}
		return mav;
	}
	
//	상품관리 - 개발생산부서
	@Override
	@RequestMapping("/manageStock.do")
	public ModelAndView manageStock(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		// TODO Auto-generated method stub
		String part = (String) session.getAttribute("part");
		String position = (String) session.getAttribute("position");
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		String possi_part = "개발";
		
		if (part.equals("개발") || position.equals("대표")) {
			mav.setViewName(viewName);
			List<ProductDTO> stockList = service.stockList();
			mav.addObject("stockList", stockList);
		} else {
			mav.setViewName("member/errorMain");
			mav.addObject("possi_part", possi_part);
			mav.addObject("possi_position", "");
		}
		return mav;
	}
//	제품등록
	@Override
	@RequestMapping("/addStock.do")
	public @ResponseBody Map<String, Object> addStock(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@RequestBody List<ProductDTO> list) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int result = 0;
		
		try {
			result = service.addStock(list);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		resultMap.put("result", result);
		return resultMap;
	}
	
//	재고수정
	@Override
	@RequestMapping("/modStock.do")
	public @ResponseBody Map<String, Object> modStock(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@RequestBody List<ProductDTO> list) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int result = 0;
		
		try {
			result = service.updateAllStock(list);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		resultMap.put("result", result);
		return resultMap;
	}
//	재고삭제
	@Override
	@RequestMapping("/delStock.do")
	public @ResponseBody Map<String, Object> delStock(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@RequestBody List<String> list) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int result = 0;
		
		try {
			result = service.deleteStock(list);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		resultMap.put("result", result);
		
		return resultMap;
	}
	
//	주문등록 - 페이지
	@Override
	@RequestMapping("/offerMain.do")
	public ModelAndView offerMain(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		// TODO Auto-generated method stub
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		String cus_id = (String) session.getAttribute("cus_id");
		
		List<ProductDTO> offersList = service.offersList();
		
		mav.addObject("offersList", offersList);
		mav.addObject("cus_id", cus_id);
		return mav;
	}
//  주문등록
	@Override
	@RequestMapping("/offer.do")
	public @ResponseBody Map<String, Object> offer(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestBody List<ProductDTO> list) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int result = 0;
		
		try {
			result = service.insertOffer(list);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		resultMap.put("result", result);
		return resultMap;
	}
//	주문조회
	@Override
	@RequestMapping("/offerInfo.do")
	public ModelAndView offerInfo(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		// TODO Auto-generated method stub
		
		String cus_id = (String) session.getAttribute("cus_id");
		
		String viewName = (String) request.getAttribute("viewName");
		
		ModelAndView mav = new ModelAndView(viewName);
		
		List<ProductDTO> offersInfo = service.offersInfo(cus_id);
		
		mav.addObject("offersInfo", offersInfo);
		
		mav.addObject("cus_id", cus_id);
		
		return mav;
	}
//  주문수정
	@Override
	@RequestMapping("/modOffer.do")
	public @ResponseBody Map<String, Object> modOffer(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestBody List<ProductDTO> list) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int result = 0;
		
		try {
			result = service.updateOffer(list);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		resultMap.put("result", result);
		return resultMap;
	}
//	주문삭제
	@Override
	@RequestMapping("/delOffer.do")
	public @ResponseBody Map<String, Object> delOffer(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@RequestBody List<Integer> list) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int result = 0;
		
		try {
			result = service.deleteOffer(list);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		resultMap.put("result", result);
		
		return resultMap;
	}
	
//	재고관리 - 거래처
	@Override
	@RequestMapping("/customerStock.do")
	public ModelAndView customerStock(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		// TODO Auto-generated method stub
		
		String cus_id = (String) session.getAttribute("cus_id");
		
		String viewName = (String) request.getAttribute("viewName");
		
		ModelAndView mav = new ModelAndView(viewName);
		
		List<ProductDTO> cus_StockList = service.customerStock(cus_id);
		
		mav.addObject("cus_StockList", cus_StockList);
		mav.addObject("cus_id", cus_id);
		
		return mav;
	}
	
	// 엑셀 다운로드 - 제품출하량
	@Override
	@RequestMapping("/excelProductOut.do")
	public ModelAndView excelProductOut(HttpServletRequest request, ModelMap model) throws Exception{
		
		List<ProductDTO> excelList = service.salesList();
		
	    String[] columsNm = request.getParameter("columnsNm").split(",");
	    String[] datafield = request.getParameter("datafield").split(",");
	 
	    model.put("columnsNm", columsNm);
	    model.put("datafield", datafield);
	    model.put("excelList", excelList);
	    model.put("excelFileNm", request.getParameter("excelFileNm"));
	 
	    return new ModelAndView("ExcelDownload", "userExcelList", model);
		
	}

	// 엑셀 다운로드 - 재고관리(회사)
	@Override
	@RequestMapping("/excelManageStock.do")
	public ModelAndView excelManageStock(HttpServletRequest request, ModelMap model) throws Exception{
		
		List<ProductDTO> excelList = service.stockList();
		
		String[] columsNm = request.getParameter("columnsNm").split(",");
		String[] datafield = request.getParameter("datafield").split(",");
		
		model.put("columnsNm", columsNm);
		model.put("datafield", datafield);
		model.put("excelList", excelList);
		model.put("excelFileNm", request.getParameter("excelFileNm"));
		
		return new ModelAndView("ExcelDownload", "userExcelList", model);
		
	}
	
	// 엑셀 다운로드 - 주문조회(거래처)	
	@Override
	@RequestMapping("/excelOfferInfo.do")
	public ModelAndView excelOfferInfo(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception{
		String cus_id = (String) session.getAttribute("cus_id");
		
		List<ProductDTO> excelList = service.offersInfo(cus_id);
		
		String[] columsNm = request.getParameter("columnsNm").split(",");
		String[] datafield = request.getParameter("datafield").split(",");
		
		model.put("columnsNm", columsNm);
		model.put("datafield", datafield);
		model.put("excelList", excelList);
		model.put("excelFileNm", request.getParameter("excelFileNm"));
		
		return new ModelAndView("ExcelDownload", "userExcelList", model);
		
	}
	
	// 엑셀 다운로드 - 재고관리(거래처)
	@Override
	@RequestMapping("/excelCusStock.do")
	public ModelAndView excelCusStock(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception{
		String cus_id = (String) session.getAttribute("cus_id");
		
		List<ProductDTO> excelList = service.customerStock(cus_id);
		
		String[] columsNm = request.getParameter("columnsNm").split(",");
		String[] datafield = request.getParameter("datafield").split(",");
		
		model.put("columnsNm", columsNm);
		model.put("datafield", datafield);
		model.put("excelList", excelList);
		model.put("excelFileNm", request.getParameter("excelFileNm"));
		
		return new ModelAndView("ExcelDownload", "userExcelList", model);
		
	}

}
