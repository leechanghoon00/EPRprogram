// MemberControllerImpl class
package com.spring.final01.member.controller;

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
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.final01.board.dto.BoardDTO;
import com.spring.final01.member.dto.CustomerDTO;
import com.spring.final01.member.dto.MemberDTO;
import com.spring.final01.member.service.MemberService;

@Controller
@RequestMapping("/member")
@EnableTransactionManagement
public class MemberControllerImpl implements MemberController {
    
	@Autowired
	private MemberService service;
	
	
	// 회사 메인화면
	@Override
	@RequestMapping(value="/main.do") 
	public ModelAndView main(MemberDTO member, HttpServletRequest request, HttpServletResponse response, HttpSession session)
	        throws Exception {
	    
	    String viewName = (String) request.getAttribute("viewName");
	    
	    String part = (String) session.getAttribute("part");
	    
	    ModelAndView mav = new ModelAndView(viewName);
	    
	    List<BoardDTO> annoList = new ArrayList<BoardDTO>();
	    try {
	    	annoList = service.annoList(part);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	    
	    mav.addObject("annoList", annoList);
		
		return mav;
	}

	// 회사 메인화면 - 대표자
	@Override
	@RequestMapping(value="/mainAdmin.do") 
	public ModelAndView mainAdmin(MemberDTO member, HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		
		String viewName = (String) request.getAttribute("viewName");
		
		ModelAndView mav = new ModelAndView(viewName);
		
		List<BoardDTO> annoAllList = new ArrayList<BoardDTO>();
		List<BoardDTO> genList = new ArrayList<BoardDTO>();
		List<BoardDTO> devList = new ArrayList<BoardDTO>();
		List<BoardDTO> manList = new ArrayList<BoardDTO>();
		
		
		try {
			annoAllList = service.annoAllList();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		String part_cd = "";
		
		for (BoardDTO dto : annoAllList) {
			part_cd = dto.getAnno_part();
			
			if (part_cd.equals("1")) {
				genList.add(dto);
			} else if (part_cd.equals("2")) {
				devList.add(dto);
			} else if (part_cd.equals("3")) {
				manList.add(dto);
			}
		}
		
		mav.addObject("genList", genList);
		mav.addObject("devList", devList);
		mav.addObject("manList", manList);
		
		return mav;
	}

	@Override
	@RequestMapping(value="/login.do") // 로그인 검증
	public void login(
			String co_id, String co_pwd, HttpServletRequest request,
	        HttpServletResponse response) throws Exception {
		
		response.setContentType("text/html;charset=utf-8");
		
		PrintWriter out = response.getWriter();
		MemberDTO coMem = new MemberDTO();
		CustomerDTO cusMem = new CustomerDTO();
		
		Map<String, Object> map = new HashMap<String, Object>();
		
	    map.put("id", co_id);
	    map.put("pwd", co_pwd);

	    coMem = service.coLogin(map);
	    cusMem = service.cusLogin(map);
	    
	    String part = null;
	    String position = null;
	    
	    if(coMem != null && cusMem == null) {
	    	if(coMem != null && coMem.getCo_depar_cd().equals("depar_cd") && coMem.getCo_deuser_cd() == 1) {
		    	part = "총무";
		    } else if(coMem != null && coMem.getCo_depar_cd().equals("depar_cd") && coMem.getCo_deuser_cd() == 2) {
		    	part = "개발";
		    } else if(coMem != null && coMem.getCo_depar_cd().equals("depar_cd") && coMem.getCo_deuser_cd() == 3) {
		    	part = "경영";
		    } else {
		    	return;
		    }
		    
		    if(coMem != null && coMem.getCo_posi_cd().equals("position_cd") && coMem.getCo_user_cd() == 1) {
		    	position = "대표";
		    } else if(coMem != null && coMem.getCo_posi_cd().equals("position_cd") && coMem.getCo_user_cd() == 2) {
		    	position = "팀장";
		    } else if(coMem != null && coMem.getCo_posi_cd().equals("position_cd") && coMem.getCo_user_cd() == 3) {
		    	position = "사원";
		    } else {
		    	return;
		    }
	    }
	    
	    
	    HttpSession session = request.getSession();
	    
	    String name = null;
	    String cus_name = null;

	    if(coMem != null && coMem.getCo_user_cd() != 4 && !position.equals("대표")) {
		    name = coMem.getCo_name();
	        out.println("<script>");
	        out.println("alert('"+ name + "님 환영합니다.');");
	        out.println("location.href='main.do';");
	        out.println("</script>");
	        session.setAttribute("co_id", co_id);
	        session.setAttribute("part", part);
	        session.setAttribute("position", position);
	        session.setAttribute("name", name);
	    } else if(coMem != null && position.equals("대표")) {
		    name = coMem.getCo_name();
	        out.println("<script>");
	        out.println("alert('"+ name + " 대표님 환영합니다.');");
	        out.println("location.href='mainAdmin.do';");
	        out.println("</script>");
	        session.setAttribute("co_id", co_id);
	        session.setAttribute("part", part);
	        session.setAttribute("position", position);
	        session.setAttribute("name", name);
	    } else if (cusMem != null && cusMem.getCus_user_cd() == 4) {
	    	cus_name = cusMem.getCus_name();
	    	out.println("<script>");
	        out.println("alert('거래처 "+ cus_name + "님 환영합니다.');");
	        out.println("location.href='customer.do';");
	        out.println("</script>");
	        session.setAttribute("cus_id", co_id);
	        session.setAttribute("cus_name", cus_name);
	    } else {
	        // 처리할 내용이 없을 경우
	    	out.println("<script>");
	    	out.println("alert('아이디와 비밀번호를 확인하세요.');");
	        out.println("location.href='/final01/';");
	    	out.println("</script>");
	    }

	}
	

	@Override
	@RequestMapping("/logout.do") // 로그아웃
	public void logout(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		// TODO Auto-generated method stub
		
		response.setContentType("text/html;charset=utf-8");
		
		PrintWriter out = response.getWriter();
		
		String name = "";
		String cus_name = "";
		
		if(session != null) {
			if ((String) session.getAttribute("co_id") != null && (String) session.getAttribute("cus_id") == null) {
				name = (String) session.getAttribute("name");
				out.println("<script>");
				out.println("alert('"+name+"님 로그아웃 되었습니다.');");
				out.println("location.href='/final01/login';");
				out.println("</script>");
				session.invalidate();
			} else if ((String) session.getAttribute("cus_id") != null && (String) session.getAttribute("co_id") == null) {
				cus_name = (String) session.getAttribute("cus_name");
				out.println("<script>");
				out.println("alert('"+cus_name+"님 로그아웃 되었습니다.');");
				out.println("location.href='/final01/login';");
				out.println("</script>");
				session.invalidate();
			} 
		} else {
			out.println("<script>");
			out.println("alert('로그아웃 되었습니다.');");
			out.println("location.href='/final01/login';");
			out.println("</script>");
		}
		
	}	
	
	
	@RequestMapping("/timeContinue.do")
	public void timeContinue(HttpServletRequest request) throws Exception {
		// 세션의 만료 시간을 연장합니다.
	    HttpSession session = request.getSession();
	    session.setMaxInactiveInterval(60 * 30); // 30분으로 세션 연장 (초 단위)
	}
	
	// 거래처 메인화면
	@Override
	@RequestMapping(value="/customer.do")
	public ModelAndView customer(MemberDTO member, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		// TODO Auto-generated method stub
		
		String viewName = (String) request.getAttribute("viewName");
		
		String cus_id = (String) session.getAttribute("cus_id");
		
	    ModelAndView mav = new ModelAndView(viewName);
	    
	    mav.addObject("cus_id", cus_id);
	    
		return mav;
	}


	// 권한이 없을 경우 넘어오는 페이지
	@Override
	@RequestMapping("/errorMain.do")
	public ModelAndView errorMain(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		// TODO Auto-generated method stub
		String viewName = (String) request.getAttribute("viewName");
		
		ModelAndView mav = new ModelAndView(viewName);
		
		return mav;
	}

	// 권한이 없을 경우 넘어오는 페이지 - 팀장 연차승인 시
	@Override
	@RequestMapping("/errorMain2.do")
	public ModelAndView errorMain2(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		// TODO Auto-generated method stub
		String viewName = (String) request.getAttribute("viewName");
		
		ModelAndView mav = new ModelAndView(viewName);
		
		return mav;
	}

	// 권한이 없을 경우 넘어오는 페이지 - 대표 (연차관련)
	@Override
	@RequestMapping("/errorMain3.do")
	public ModelAndView errorMain3(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		// TODO Auto-generated method stub
		String viewName = (String) request.getAttribute("viewName");
		
		ModelAndView mav = new ModelAndView(viewName);
		
		return mav;
	}
	
	@Override
	@RequestMapping("/user-profile.do") // 직원 관리창
	   public ModelAndView userprofile(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
	      String viewName = (String) request.getAttribute("viewName");
	      
	      String part = (String) session.getAttribute("part");
	      
	      String position = (String) session.getAttribute("position");
	      
	      String possi_part = "경영";
	      
	      ModelAndView mav = new ModelAndView();
	      
	      
	      if (part.equals("경영") || position.equals("대표")) {
			mav.setViewName(viewName);
			List<MemberDTO> userprofile = service.userprofile();
		    mav.addObject("userprofile", userprofile);
	      } else {
			mav.setViewName("member/errorMain");
			mav.addObject("possi_part", possi_part);
			mav.addObject("possi_position", "");
	      }

	      return mav;
	   }
	
	@Override
	@RequestMapping("/customer-profile.do") // 거래처 관리창
	public ModelAndView customerProfile(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
	    String viewName = (String) request.getAttribute("viewName");
	    
	    String part = (String) session.getAttribute("part");
	    
	    String position = (String) session.getAttribute("position");
	    
	    String possi_part = "경영";
	    
	    ModelAndView mav = new ModelAndView();
	    
	    
	    if (part.equals("경영") || position.equals("대표")) {
			mav.setViewName(viewName);
			List<CustomerDTO> customer = service.customer();
		    mav.addObject("customer", customer);
  		} else {
			mav.setViewName("member/errorMain");
			mav.addObject("possi_part", possi_part);
			mav.addObject("possi_position", "");
  		}
	    
	    

	    return mav;
	}

	
	@Override
	@RequestMapping("/useradd.do") // 직원 계정추가창으로 넘어가기

	public ModelAndView useradd(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
	      
	      List<MemberDTO> userprofile = service.userprofile();
	      
	      ModelAndView mav = new ModelAndView(viewName);
	      mav.addObject("userprofile", userprofile);

	      return mav;
	}
	@Override
	@RequestMapping("/customeradd.do") // 거래처 계정추가창으로 넘어가기
	public ModelAndView customeradd(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
	     
		ModelAndView mav = new ModelAndView(viewName);
	     
  
		List<CustomerDTO> customer = service.customer();
		mav.addObject("customer", customer);

		return mav;
	}
	
	@Override
	@RequestMapping("/user.do") // 개인정보 관리창으로 넘어가기
	public ModelAndView user(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception {
		// TODO Auto-generated method stub
		String viewName = (String) request.getAttribute("viewName");
	      String id = (String) session.getAttribute("co_id");
	      MemberDTO user = service.user(id);
	      
	      ModelAndView mav = new ModelAndView(viewName);
	      mav.addObject("user", user);

	      
	      return mav;
		}
	
	@Override
	@RequestMapping("/customerpro.do") // 개인정보 관리창으로 넘어가기
	public ModelAndView customerpro(HttpServletRequest request, HttpServletResponse response, HttpSession session)throws Exception {
		// TODO Auto-generated method stub
		String viewName = (String) request.getAttribute("viewName");
	      String id = (String) session.getAttribute("cus_id");
	      CustomerDTO user = service.customerpro(id);
	      
	      ModelAndView mav = new ModelAndView(viewName);
	      mav.addObject("user", user);

	      
	      return mav;
	      
	}
	@Override
	@RequestMapping("/userjoin.do") //직원 추가하기
	public void userjoin(MemberDTO dto, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		response.setContentType("text/html;charset=utf-8");
		
		PrintWriter out = response.getWriter();
		
		try {
	        if (service.isUserIdExists(dto.getCo_id()) || service.isUserNameExists(dto.getCo_name())) {
	            out.println("<script>");
	            out.println("alert('중복 아이디 또는 이름이 있습니다.');");
	            out.println("location.href='/final01/member/useradd.do';");
	            out.println("</script>");
	        } else {
	            service.userjoin(dto);
	            out.println("<script>");
	            out.println("alert('직원 등록에 성공했습니다.');");
	            out.println("location.href='/final01/member/user-profile.do';");
	            out.println("</script>");
	        }
	    } catch (Exception e) {
	        out.println("<script>");
	        out.println("alert('직원 등록에 실패했습니다.');");
	        out.println("location.href='/final01/member/useradd.do';");
	        out.println("</script>");
	    }
		
	}

	@Override
	@RequestMapping("/customerjoin.do") //거래처 추가하기
	public void customerjoin(CustomerDTO dto, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub

		response.setContentType("text/html;charset=utf-8");
		
		PrintWriter out = response.getWriter();
		
		try {
	        if (service.cusUserIdExists(dto.getCus_id()) || service.cusUserNameExists(dto.getCus_name())) {
	            out.println("<script>");
	            out.println("alert('중복 아이디 또는 이름이 있습니다.');");
	            out.println("location.href='/final01/member/customeradd.do';");
	            out.println("</script>");
	        } else {
	        	service.customerjoin(dto);
	            out.println("<script>");
	            out.println("alert('거래처 등록에 성공했습니다.');");
	            out.println("location.href='/final01/member/customer-profile.do';");
	            out.println("</script>");
	        }
	    } catch (Exception e) {
	        out.println("<script>");
	        out.println("alert('거래처 등록에 실패했습니다.');");
	        out.println("location.href='/final01/member/customeradd.do';");
	        out.println("</script>");
	    }
	}
	
	@Override
	@RequestMapping("/deluser.do") //직원 정보 삭제하기
	public @ResponseBody Map<String, Object> deluser(@RequestBody Map<String, String> requestBody,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		String co_id = requestBody.get("co_id");
		 
		 
		 int result = 0;
		 try {
			 result = service.deluser(co_id);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		resultMap.put("result", result);
		
	    return resultMap;

	}

	@Override
	@RequestMapping("/delcustomer.do") //거래처 정보 삭제하기
	public @ResponseBody Map<String, Object>  delcustomer(@RequestBody Map<String, String> requestBody, 
			HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		String cus_id = requestBody.get("cus_id");
		int result = 0;

		try {
			result = service.delcustomer(cus_id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		resultMap.put("result", result);

	    return resultMap;	
	}
	
	@Override
	@RequestMapping("/moduser1.do") // 개인정보 수정하기
	public @ResponseBody Map<String, Object> moduser1(@RequestBody List<MemberDTO> member, 
			HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(member);
		int result = 0;
		
		try {
			result = service.moduser1(member);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		resultMap.put("result", result);
		
		return resultMap;

	}
	
	@Override
	@RequestMapping("/modcustomer1.do") // 거래처 정보 수정하기
	public @ResponseBody Map<String, Object> modcustomer1(@RequestBody List<CustomerDTO> member, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(member);
		int result = 0;
		
		try {
			result = service.modcustomer1(member);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		resultMap.put("result", result);
		
		return resultMap;
	}
	@Override
	@RequestMapping("/moduser.do") // 직원정보 수정하기
	public @ResponseBody Map<String, Object> moduser(@RequestBody List<MemberDTO> member,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(member);
		int result = 0;
		
		try {
			result = service.moduser(member);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		resultMap.put("result", result);
		
		return resultMap;

	}
	

	@Override
	@RequestMapping("/modcustomer.do") // 거래처 정보 수정하기
	public @ResponseBody Map<String, Object> modcustomer(@RequestBody List<CustomerDTO> member, 
			HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(member);
		int result = 0;
		
		try {
			result = service.modcustomer(member);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		resultMap.put("result", result);
		
		return resultMap;

	}

	@Override // 거래처 FAQ 화면
	@RequestMapping("/cus-contact.do")
	public ModelAndView cusContact(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) throws Exception {
		// TODO Auto-generated method stub
		String viewName = (String) request.getAttribute("viewName");
		
		ModelAndView mav = new ModelAndView(viewName);
		
		return mav;
	}

	@Override // 거래처 FAQ 메시지 전송
	@RequestMapping("/sendMessage.do")
	public void sendMessage(@ModelAttribute("dto") CustomerDTO dto, HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		// TODO Auto-generated method stub
		
		response.setContentType("text/html;charset=utf-8");
		
		PrintWriter out = response.getWriter();
		
		int result = 0;
		try {
			result = service.sendMessage(dto);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		if (result > 0) {
			out.println("<script>");
			out.println("alert('메시지 전송에 성공했습니다.');");
			out.println("location.href='/final01/member/customer.do';");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('메시지 전송에 실패했습니다.');");
			out.println("</script>");
			
		}
		
	}

	@Override // 경영지원부서 거래처 FAQ 관리
	@RequestMapping("/contact.do")
	public ModelAndView contact(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		// TODO Auto-generated method stub
		String viewName = (String) request.getAttribute("viewName");
		
		ModelAndView mav = new ModelAndView();
		
		String part = (String) session.getAttribute("part");
		
		String position = (String) session.getAttribute("position");
		
		String possi_part = "경영";
		
		if (part.equals("경영") || position.equals("대표")) {
			mav.setViewName(viewName);
			List<CustomerDTO> contactList = service.contact();
			mav.addObject("contactList", contactList);
		} else {
			mav.setViewName("member/errorMain");
			mav.addObject("possi_part", possi_part);
			mav.addObject("possi_position", "");
		}
		
		
		return mav;
	}

	@Override // 경영지원부서 거래처 FAQ 관리 디테일
	@RequestMapping("/contactDetail.do")
	public ModelAndView contactDetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String viewName = (String) request.getAttribute("viewName");
		
		String message_no = request.getParameter("message_no");
		
		ModelAndView mav = new ModelAndView(viewName);
		
		CustomerDTO contact = service.contactDetail(message_no);
		
		mav.addObject("contact", contact);
		
		return mav;
	}

	@Override
	@RequestMapping("/contactConfirm.do")
	public @ResponseBody Map<String, Object> contactConfirm(@RequestBody CustomerDTO dto, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// TODO Auto-generated method stub
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int result = 0;
		
		try {
			result = service.confirm(dto);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		resultMap.put("result", result);
		
		return resultMap;
	}
	
	@Override
	@RequestMapping("/excelUser.do")
	public ModelAndView excelUser(HttpServletRequest request, ModelMap model) throws Exception{
		
		List<MemberDTO> excelList = service.userprofile();
		
	    String[] columsNm = request.getParameter("columnsNm").split(",");
	    String[] datafield = request.getParameter("datafield").split(",");
	 
	    model.put("columnsNm", columsNm);
	    model.put("datafield", datafield);
	    model.put("excelList", excelList);
	    model.put("excelFileNm", request.getParameter("excelFileNm"));
	 
	    return new ModelAndView("ExcelDownload", "userExcelList", model);
		
	}
	
}
