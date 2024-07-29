package com.spring.final01.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.final01.product.dao.ProductDAO;
import com.spring.final01.product.dto.ProductDTO;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ProductDAO dao;
	
	@Override
	public List<ProductDTO> salesList() {
		// TODO Auto-generated method stub
		return dao.salesList();
	}

	@Override
	public List<ProductDTO> stockList() {
		// TODO Auto-generated method stub
		return dao.stockList();
	}

	@Override
	public List<ProductDTO> offersList() {
		// TODO Auto-generated method stub
		return dao.offersList();
	}
	
	@Override
	public int addStock(List<ProductDTO> list) {
		// TODO Auto-generated method stub
		int result = 0;
		
		for(ProductDTO dto : list) {
			result = dao.addStock(dto);
		}
		
		return result;
	}
	
	@Override
	public int updateAllStock(List<ProductDTO> list) {
		// TODO Auto-generated method stub
		int result = 0;
		
		for (ProductDTO dto : list) {
			result = dao.updateAllStock(dto);
		}
		
		return result;
	}
	
	@Override
	public int deleteStock(List<String> list) {
		// TODO Auto-generated method stub
		int result = 0;
		
		for(String name : list) {
			result = dao.deleteStock(name);
		}
		
		return result;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public int insertOffer(List<ProductDTO> list) {
		// TODO Auto-generated method stub
		int result = 0;
		for(ProductDTO dto : list) {
			result = dao.insertOffer(dto);	
			dao.updateStock(dto);
		}
		return result;
	}

	@Override
	public List<ProductDTO> offersInfo(String cus_id) {
		// TODO Auto-generated method stub
		return dao.offersInfo(cus_id);
	}

	@Override
	public List<ProductDTO> customerStock(String cus_id) {
		// TODO Auto-generated method stub
		return dao.customerStock(cus_id);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public int updateOffer(List<ProductDTO> list) {
		// TODO Auto-generated method stub
		int result = 0;
		for (ProductDTO dto : list) {
			result = dao.updateOffer(dto);
			dao.updateStock(dto);
		}
		return result;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public int deleteOffer(List<Integer> list) {
		// TODO Auto-generated method stub
		int result = 0;
		for (int no : list) {
			// 삭제된 레코드의 정보를 가져옴
			List<ProductDTO> deletedRecords = dao.selectDeletedRecords(no);
			for (ProductDTO dto : deletedRecords) {
				// 해당 제품의 수량을 업데이트
				dao.updateStockAmount(dto);
			}
			// 구매 신청 레코드 삭제
			result = dao.deleteOffer(no);
	        
	        
		}
		
		return result;
	}

}
