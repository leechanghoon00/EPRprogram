package com.spring.final01.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.final01.board.dao.BoardDAO;
import com.spring.final01.board.dto.BoardDTO;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	private BoardDAO dao;
	
	@Override
	public List<BoardDTO> selectAnnoList(String part) {
		// TODO Auto-generated method stub
		return dao.selectAnnoList(part);
	}
	
	@Override
	public boolean isTitleExists(BoardDTO dto) {
		// TODO Auto-generated method stub
		int count = dao.isTitleExists(dto);
		return count > 0;
	}

	@Override
	public boolean isContentExists(BoardDTO dto) {
		// TODO Auto-generated method stub
		int count = dao.isContentExists(dto);
		return count > 0;
	}
	
	@Override
	public void addAnno(BoardDTO dto) {
		// TODO Auto-generated method stub
		dao.addAnno(dto);
	}
	
	@Override
	public int modBoard(List<BoardDTO> list) {
		// TODO Auto-generated method stub
		int result = 0;
		for (BoardDTO dto : list) {
			result = dao.modBoard(dto);
		}
		return result;
	}
	
	@Override
	public int delBoard(BoardDTO dto) {
		// TODO Auto-generated method stub
		int result = 0;
		
		result = dao.delBoard(dto);
		return result;
	}

	@Override
	public BoardDTO annoDetail(String anno_no) {
		// TODO Auto-generated method stub
		return dao.annoDetail(anno_no);
	}

}
