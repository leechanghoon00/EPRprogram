package com.spring.final01.board.controller;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.final01.board.dto.BoardDTO;
import com.spring.final01.board.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardControllerImpl implements BoardController{
	
	@Autowired
	private BoardService service;
	
	// 공지사항 - 부서에 맞는 내용 출력
	@Override
	@RequestMapping("/partInfo.do")
	public ModelAndView partInfo(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		// TODO Auto-generated method stub
		
		String viewName = (String) request.getAttribute("viewName");
		
		ModelAndView mav = new ModelAndView(viewName);
		
		String part = (String) session.getAttribute("part");
		
		String position = (String) session.getAttribute("position");
		
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		
		
			try {
				if (position.equals("팀장")) {
					list = service.selectAnnoList(part);
					mav.setViewName(viewName);
					mav.addObject("annoList", list);
				} else {
					mav.setViewName("member/errorMain2");
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		
		return mav;
	}
	
	// 공지사항 상세 페이지
		@Override
		@RequestMapping("/annoDetail.do")
		public ModelAndView annoDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session)
				throws Exception {
			// TODO Auto-generated method stub
			
			String viewName = (String) request.getAttribute("viewName");
			
			String position = (String) session.getAttribute("position");
			
			String anno_no = (String) request.getParameter("anno_no");
			
			ModelAndView mav = new ModelAndView();
			
			BoardDTO annoDetail = new BoardDTO();
			
			if(position.equals("팀장")) {
				mav.setViewName(viewName);
				try {
					annoDetail = service.annoDetail(anno_no);
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				mav.addObject("annoDetail", annoDetail);
			} else {
				mav.setViewName("board/partDetail");
			}
			
			return mav;
		}

		// 공지사항 상세 페이지(메인에서)
		@Override
		@RequestMapping("/partDetail.do")
		public ModelAndView partDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session)
				throws Exception {
			// TODO Auto-generated method stub
			
			String viewName = (String) request.getAttribute("viewName");
			
			String anno_no = (String) request.getParameter("anno_no");
			
			ModelAndView mav = new ModelAndView(viewName);
			BoardDTO annoDetail = new BoardDTO();
			try {
				annoDetail = service.annoDetail(anno_no);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
			mav.addObject("annoDetail", annoDetail);
			
			return mav;
		}
	
	// 공지사항 - 등록하기 페이지
	@Override
	@RequestMapping("/annoAdd.do")
	public ModelAndView annoAdd(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		// TODO Auto-generated method stub
		String viewName = (String) request.getAttribute("viewName");
		
		String position = (String) session.getAttribute("position");

		ModelAndView mav = new ModelAndView();
		
		if (position.equals("팀장")) {
			mav.setViewName(viewName);
		} else {
			mav.setViewName("member/errorMain2");
		}
		
		
		return mav;
	}
	
	// 공지사항 - 등록
	@Override
	@RequestMapping("/addAnno.do")
	public void addAnno(BoardDTO dto, HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		// TODO Auto-generated method stub
		
		response.setContentType("text/html;charset=utf-8");
		
		PrintWriter out = response.getWriter();
		
		try {
	        if (service.isTitleExists(dto)) {
	            out.println("<script>");
	            out.println("alert('중복된 공지가 있습니다.');");
	            out.println("location.href='/final01/board/annoAdd.do';");
	            out.println("</script>");
	        } else {
	            service.addAnno(dto);
	            out.println("<script>");
	            out.println("alert('공지 등록에 성공했습니다.');");
	            out.println("location.href='/final01/board/partInfo.do';");
	            out.println("</script>");
	        }
	    } catch (Exception e) {
	        out.println("<script>");
	        out.println("alert('공지 등록에 실패했습니다.');");
	        out.println("location.href='/final01/board/annoAdd.do';");
	        out.println("</script>");
	    }
		
	}

	// 공지사항 수정
	@Override
	@RequestMapping("/modBoard.do")
	public @ResponseBody Map<String, Object> modBoard(HttpServletRequest request, HttpServletResponse response, @RequestBody List<BoardDTO> list)
			throws Exception {
		// TODO Auto-generated method stub
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int result = 0;
		int result1 = 0;
		
		
		for (BoardDTO dto : list) {
		    
		    try {
		    	if (service.isTitleExists(dto)) {
		    		if (!service.isContentExists(dto)) {
		    			result = service.modBoard(list);
		    			result1 = 1;
		    		} else {
		    			result1 = 0;
		    		}
		    	} else {
		    		result = service.modBoard(list);
		    		result1 = 1;
		    	}
		    } catch (Exception e) {
		    	e.printStackTrace();
		    }
		}
		
		
		resultMap.put("result", result);
		resultMap.put("result1", result1);
		
		return resultMap;
	}
	
	// 공지사항 삭제
	@Override
	@RequestMapping("/delBoard.do")
	public @ResponseBody Map<String, Object> delBoard(HttpServletRequest request, HttpServletResponse response, @RequestBody BoardDTO list)
			throws Exception {
		// TODO Auto-generated method stub
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int result = 0;
		try {
			result = service.delBoard(list);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		resultMap.put("result", result);
		return resultMap;
	}

	


}
