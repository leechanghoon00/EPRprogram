package com.spring.final01.money.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.final01.member.dto.MemberDTO;
import com.spring.final01.money.dto.MoneyDTO;
import com.spring.final01.money.service.MoneyService;

@Controller
@RequestMapping("/money")
public class MoneyControllerImpl implements MoneyController{
	@Autowired
	private MoneyService service;
	
	
	// 전체 급여 리스트 출력 메서드
		@Override
		@RequestMapping("/paystubList.do")
		public ModelAndView allPayList(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
			String viewName = (String) request.getAttribute("viewName");
			String part = (String) session.getAttribute("part");
			String position = (String) session.getAttribute("position");
			String possi_part = "총무";
			List<MoneyDTO> allPayList  = new ArrayList<MoneyDTO>();
			ModelAndView mav = new ModelAndView();

			if (part.equals("총무") || position.equals("대표")) {
				allPayList = service.allPayList();
				mav.setViewName(viewName);
				mav.addObject("allPayList", allPayList);
			} else {
				mav.setViewName("member/errorMain");
				mav.addObject("possi_part", possi_part);
				mav.addObject("possi_position", "");
			}
			

			return mav;
		}
		
		// 개인 급여명세서 조회
		@Override
		@RequestMapping("/viewMyPayList.do")
		public ModelAndView viewMyPayList(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
			// TODO Auto-generated method stub
			String viewName = (String) request.getAttribute("viewName");
			ModelAndView mav = new ModelAndView();
			String position = (String) session.getAttribute("position");
			String pay_id = (String) session.getAttribute("co_id");
			
			if(!position.equals("대표")) {
				List<MoneyDTO> myMoney = service.viewMyPayList(pay_id);
				mav.setViewName(viewName);
				session.setAttribute("myMoney", myMoney);
				mav.addObject("myMoney", myMoney);
			} else {
				mav.setViewName("/member/errorMain3");
			}
			
			
			return mav;

		}


		// 선택한 아이디의 급여명세서 출력
		@Override
		@RequestMapping("/payListDetail.do")
		public ModelAndView payListDetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
			// TODO Auto-generated method stub
			String viewName = (String) request.getAttribute("viewName");
			ModelAndView mav = new ModelAndView(viewName);

			String pay_id = (String) request.getParameter("pay_id");
			String work_period = (String) request.getParameter("work_period");
			
			MoneyDTO mon = new MoneyDTO();
			
			mon.setPay_id(pay_id);
			mon.setWork_period(work_period);
			
			MoneyDTO money = service.payListDetail(mon);

			HttpSession session = request.getSession();
			session.setAttribute("money", money);

			mav.addObject("money", money);

			return mav;
		}

		// 등록하기 클릭 시 등록창 출력
		@Override
		@RequestMapping("/addPayView.do")
		public ModelAndView addPayView(HttpServletRequest request, HttpServletResponse response) throws Exception {
			// TODO Auto-generated method stub
			String viewName = (String) request.getAttribute("viewName");
			ModelAndView mav = new ModelAndView(viewName);
			
			List<MemberDTO> memList = new ArrayList<MemberDTO>();
			
			try {
				memList = service.memberInfo();
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
			mav.addObject("memList", memList);
			
			return mav;
		}
		
		// 수정하기 클릭 시 수정창 출력
		@Override
		@RequestMapping("/modPayView.do")
		public ModelAndView modPayView(HttpServletRequest request, HttpServletResponse response) throws Exception {
			// TODO Auto-generated method stub
			String viewName = (String) request.getAttribute("viewName");
			ModelAndView mav = new ModelAndView(viewName);

			HttpSession session = request.getSession();
			MoneyDTO money = (MoneyDTO) session.getAttribute("money");

			mav.addObject("money", money);

			return mav;
		}

		// 등록 기능 메서드
		@Override
		@RequestMapping("/addPay.do")
		public void addPay(MoneyDTO money, HttpServletRequest request, HttpServletResponse response) throws Exception {
			// TODO Auto-generated method stub
			
			response.setContentType("text/html;charset=utf-8");
			
			PrintWriter out = response.getWriter();
			
			int result = 0; 
			
			try {
				result = service.addPay(money);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
			
			if (result != 0) {
				out.println("<script>");
				out.println("alert('등록에 성공했습니다.');");
				out.println("location.href='/final01/money/paystubList.do';");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('등록에 실패했습니다.');");
				out.println("location.href='/final01/money/paystubList.do';");
				out.println("</script>");
			}
			
		}
		
		// 수정 기능 메서드
		@Override
		@RequestMapping("/modPay.do")
		public void modPay(MoneyDTO money, HttpServletRequest request, HttpServletResponse response) throws Exception {
			// TODO Auto-generated method stub
			
			response.setContentType("text/html;charset=utf-8");
			
			PrintWriter out = response.getWriter();
			
			int result = 0; 

			try {
				result = service.modPay(money);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
		
			if (result != 0) {
				out.println("<script>");
				out.println("alert('수정에 성공했습니다.');");
				out.println("location.href='/final01/money/paystubList.do';");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('수정에 실패했습니다.');");
				out.println("location.href='/final01/money/paystubList.do';");
				out.println("</script>");
			}

		}


		// 연차신청서 작성 화면(로그인된 계정의 이름,부서,직급 출력)
		@Override
		@RequestMapping("/requestAnnual.do")
		public ModelAndView requestAnnual(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
			// TODO Auto-generated method stub
			String viewName = (String) request.getAttribute("viewName");
			
			String annual_id = (String) session.getAttribute("co_id");
			String position = (String) session.getAttribute("position");
			ModelAndView mav = new ModelAndView();
			
			if (!position.equals("대표")) {
				MoneyDTO reqAnnual = service.reqAnnual(annual_id);
				mav.setViewName(viewName);
				session.setAttribute("reqAnnual", reqAnnual);
				mav.addObject("reqAnnual", reqAnnual);
			} else {
				mav.setViewName("member/errorMain3");
			}

			return mav;
		}


		// 신청하기 버튼 누르면 전송 - 반차
		@Override
		@RequestMapping(value = "/sendHalfAnnual.do", method = RequestMethod.POST)
		public void sendHalfAnnual(@ModelAttribute("dto") MoneyDTO money,HttpServletRequest request, HttpServletResponse response, HttpSession session)throws Exception {
			// TODO Auto-generated method stub
			response.setContentType("text/html;charset=utf-8");

			PrintWriter out = response.getWriter();

			int result = 0; 

			try {
				result = service.sendHalfAnnual(money);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}

			if (result != 0) {
				out.println("<script>");
				out.println("alert('반차 신청에 성공했습니다.');");
				out.println("location.href='/final01/money/viewMyAnnual.do';");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('반차 신청에 실패했습니다.');");
				out.println("location.href='/final01/money/requestAnnual.do';");
				out.println("</script>");
			}

		}
		
		// 신청하기 버튼 누르면 전송 - 반차 제외
		@Override
		@RequestMapping(value = "/sendAnnual.do", method = RequestMethod.POST)
		public void sendAnnual(MoneyDTO money, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
			response.setContentType("text/html;charset=utf-8");

			PrintWriter out = response.getWriter();

			int result = 0; 

			try {
				result = service.sendAnnual(money);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}

			if (result != 0) {
				out.println("<script>");
				out.println("alert('연차 신청에 성공했습니다.');");
				out.println("location.href='/final01/money/viewMyAnnual.do';");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('연차 신청에 실패했습니다.');");
				out.println("location.href='/final01/money/requestAnnual.do';");
				out.println("</script>");
			}

		}


		// 로그인한 계정의 연차 신청 목록 출력
		@Override
		@RequestMapping("/viewMyAnnual.do")
		public ModelAndView viewMyAnnual(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception {
			// TODO Auto-generated method stub
			String viewName = (String) request.getAttribute("viewName");
			
			String position = (String) session.getAttribute("position");
			String annual_id = (String)session.getAttribute("co_id");
			ModelAndView mav = new ModelAndView();
			
			if(!position.equals("대표")) {
				List<MoneyDTO> viewMyAnnualList = new ArrayList<MoneyDTO>();
				try {
					viewMyAnnualList = service.viewMyAnnualList(annual_id);
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				mav.setViewName(viewName);
				mav.addObject("viewMyAnnualList", viewMyAnnualList);
			} else {
				mav.setViewName("member/errorMain3");
			}

			return mav;
		}
		

		
		
		// 내 연차 삭제 메서드 - 0409 추가
		@Override
		@RequestMapping("/cancelMyAnnual.do")
		public void cancelMyAnnual(int no, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
			// TODO Auto-generated method stub
			response.setContentType("text/html;charset=utf-8");

			PrintWriter out = response.getWriter();
			int result = 0; 
			System.out.println(no);
			try {
				result = service.cancelMyAnnual(no);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}

			if (result != 0) {
				out.println("<script>");
				out.println("alert('연차신청이 취소 되었습니다.');");
				out.println("location.href='/final01/member/main.do';");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('연차신청 취소에 실패했습니다.');");
				out.println("location.href='/final01/money/viewMyAnnual.do';");
				out.println("</script>");
			}

		}
		


		@Override
		@RequestMapping("/chkUserInfo.do")
		public ModelAndView chkUserInfo(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
			String position = (String) session.getAttribute("position");
			String part = (String) session.getAttribute("part");
			ModelAndView mav = new ModelAndView();
			if(part.equals("총무") && position.equals("팀장")) {
				mav.setViewName("redirect:/money/viewGeneralAnnual.do");
			} else if(part.equals("개발") && position.equals("팀장")) {
				mav.setViewName("redirect:/money/viewDevAnnual.do");
			} else if(part.equals("경영") && position.equals("팀장")) {
				mav.setViewName("redirect:/money/viewManageAnnual.do");
			} else {
				mav.addObject("possi_position", position);
				mav.setViewName("redirect:/member/errorMain2.do");
			}


			return mav;
		}

		// 총무부서 연차신청서 목록
		// 로그인 정보(권한코드가 1인지 2인지, 직급코드)와 일치하는 부서원 연차신청서 목록 출력 
		@Override
		@RequestMapping("/viewGeneralAnnual.do")
		public ModelAndView viewGeneralAnnual(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
			// TODO Auto-generated method stub
			String viewName = (String) request.getAttribute("viewName");

			String position = (String) session.getAttribute("position");
			String part = (String) session.getAttribute("part");

			String partNo = service.selectPart(part);

			List<MoneyDTO> viewPartAnnual = service.viewPartAnnual(partNo);

			ModelAndView mav = new ModelAndView(viewName);

			mav.addObject("viewPartAnnual", viewPartAnnual);
			mav.addObject("position", position); // 직급 정보 추가
			mav.addObject("part", part); // 부서 정보 추가

			return mav;

		}

		// 개발부서 연차신청서 목록
		@Override
		@RequestMapping("/viewDevAnnual.do") 
		public ModelAndView viewDevAnnual(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
			// TODO Auto-generated method stub
			String viewName = (String) request.getAttribute("viewName");

			String position = (String) session.getAttribute("position");
			String part = (String) session.getAttribute("part");

			String partNo = service.selectPart(part);


			List<MoneyDTO> viewPartAnnual = service.viewPartAnnual(partNo);
			ModelAndView mav = new ModelAndView(viewName);	


			mav.addObject("viewPartAnnual", viewPartAnnual);
			mav.addObject("position", position); // 직급 정보 추가
			mav.addObject("part", part); // 부서 정보 추가

			return mav;

		}

		// 경영부서 연차신청서 목록
		@Override
		@RequestMapping("/viewManageAnnual.do") 
		public ModelAndView viewManageAnnual(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
			// TODO Auto-generated method stub
			String viewName = (String) request.getAttribute("viewName");

			String position = (String) session.getAttribute("position");
			String part = (String) session.getAttribute("part");

			String partNo = service.selectPart(part);

			List<MoneyDTO> viewPartAnnual = service.viewPartAnnual(partNo);

			ModelAndView mav = new ModelAndView(viewName);

			mav.addObject("viewPartAnnual", viewPartAnnual);
			mav.addObject("position", position); // 직급 정보 추가
			mav.addObject("part", part); // 부서 정보 추가

			return mav;

		}



		// 연차 승인 메뉴에서 리스트 클릭시 해당 연차 정보 출력
		@Override
		@RequestMapping("/viewAnnualDetail.do")
		public ModelAndView viewAnnualDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
			// TODO Auto-generated method stub
			String viewName = (String) request.getAttribute("viewName");
			ModelAndView mav = new ModelAndView(viewName);

			String annual_no =  (String) request.getParameter("no");
			int no = Integer.parseInt(annual_no);
			
			MoneyDTO viewAnnualDetail = service.viewAnnualDetail(no);
			
			session.setAttribute("viewAnnualDetail", viewAnnualDetail);
			mav.addObject("viewAnnualDetail", viewAnnualDetail);
			
			
			return mav;
		}
		
		
		// 연차 승인 기능 메서드
		@Override
		@RequestMapping("/permitAnnual.do")
		public @ResponseBody Map<String, Object> permitAnnual(HttpServletRequest request, HttpServletResponse response,HttpSession session, @RequestBody List<MoneyDTO> dto) throws Exception {
			// TODO Auto-generated method stub
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			int result = 0;
			
			try {
				result = service.permitAnnual(dto);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			resultMap.put("result", result);
			return resultMap;
		}
		
		// 연차 반려 기능 메서드
		@Override
		@RequestMapping("/deniedAnnual.do")
		public @ResponseBody Map<String, Object> deniedAnnual(HttpServletRequest request, HttpServletResponse response,HttpSession session,  @RequestBody List<MoneyDTO> dto) throws Exception {
			// TODO Auto-generated method stub
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			int result = 0;
			
			try {
				result = service.deniedAnnual(dto);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
			resultMap.put("result", result);
			
			return resultMap;
		}
		
		// 엑셀 다운로드 - 급여명세서
		@Override
		@RequestMapping("/excelPayStub.do")
		public ModelAndView excelPayStub(HttpServletRequest request, ModelMap model) throws Exception{
			
			List<MoneyDTO> excelList = service.allPayList();
			
		    String[] columsNm = request.getParameter("columnsNm").split(",");
		    String[] datafield = request.getParameter("datafield").split(",");
		 
		    model.put("columnsNm", columsNm);
		    model.put("datafield", datafield);
		    model.put("excelList", excelList);
		    model.put("excelFileNm", request.getParameter("excelFileNm"));
		 
		    return new ModelAndView("ExcelDownload", "userExcelList", model);
			
		}
	
}
