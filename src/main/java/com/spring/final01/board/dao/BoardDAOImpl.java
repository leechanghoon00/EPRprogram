package com.spring.final01.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.final01.board.dto.BoardDTO;

@Repository
public class BoardDAOImpl implements BoardDAO{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<BoardDTO> selectAnnoList(String part) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.board.selectAnnoList", part);
	}

	@Override
	public int isTitleExists(BoardDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.board.isTitleExists", dto);
	}

	@Override
	public int isContentExists(BoardDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.board.isContentExists", dto);
	}
	
	@Override
	public void addAnno(BoardDTO dto) {
		// TODO Auto-generated method stub
		sqlSession.insert("mapper.board.addAnno", dto);
	}
	
	@Override
	public int modBoard(BoardDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.update("mapper.board.modBoard", dto);
	}
	
	@Override
	public int delBoard(BoardDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.delete("mapper.board.delBoard", dto);
	}

	@Override
	public BoardDTO annoDetail(String anno_no) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.board.annoDetail", anno_no);
	}

}
