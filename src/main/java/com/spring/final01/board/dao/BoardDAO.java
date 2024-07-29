package com.spring.final01.board.dao;

import java.util.List;

import com.spring.final01.board.dto.BoardDTO;

public interface BoardDAO {

	List<BoardDTO> selectAnnoList(String part);

	int isTitleExists(BoardDTO dto);
	
	int isContentExists(BoardDTO dto);

	void addAnno(BoardDTO dto);
	
	int modBoard(BoardDTO dto);
	
	int delBoard(BoardDTO dto);

	BoardDTO annoDetail(String anno_no);

}
