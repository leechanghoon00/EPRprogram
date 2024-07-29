package com.spring.final01.product.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.final01.product.dto.ProductDTO;


@Repository
public class ProductDAOImpl implements ProductDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<ProductDTO> salesList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.product.salesList");
	}

	@Override
	public List<ProductDTO> stockList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.product.stockList");
	}

	@Override
	public List<ProductDTO> offersList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.product.stockList");
	}
	
	@Override
	public int addStock(ProductDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.insert("mapper.product.addStock", dto);
	}
	
	@Override
	public int updateAllStock(ProductDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.update("mapper.product.updateAllStock", dto);
	}
	
	@Override
	public int deleteStock(String name) {
		// TODO Auto-generated method stub
		return sqlSession.delete("mapper.product.deleteStock", name);
	}

	@Override
	public int insertOffer(ProductDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.insert("mapper.product.insertOffer", dto);
	}

	@Override
	public List<ProductDTO> offersInfo(String cus_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.product.offersInfo", cus_id);
	}

	@Override
	public void updateStock(ProductDTO dto) {
		// TODO Auto-generated method stub
		sqlSession.update("mapper.product.updateStock", dto);
	}

	@Override
	public List<ProductDTO> customerStock(String cus_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.product.customerStock", cus_id);
	}

	@Override
	public int updateOffer(ProductDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.update("mapper.product.updateOffer", dto);
	}

	@Override
	public int deleteOffer(int no) {
		// TODO Auto-generated method stub
		return sqlSession.delete("mapper.product.deleteOffer", no);
	}

	@Override
	public List<ProductDTO> selectDeletedRecords(int no) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.product.selectDeletedRecords", no);
	}

	@Override
	public void updateStockAmount(ProductDTO dto) {
		// TODO Auto-generated method stub
		sqlSession.update("mapper.product.updateStockAmount", dto);
	}

}
