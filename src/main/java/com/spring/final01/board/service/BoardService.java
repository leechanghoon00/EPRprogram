package com.spring.final01.board.service;

import java.util.List;

import com.spring.final01.board.dto.BoardDTO;

public interface BoardService {

	List<BoardDTO> selectAnnoList(String part);

	boolean isTitleExists(BoardDTO dto);
	
	boolean isContentExists(BoardDTO dto);

	void addAnno(BoardDTO dto);
	
	int modBoard(List<BoardDTO> list);

	int delBoard(BoardDTO dto);

	BoardDTO annoDetail(String anno_no);

}
