package com.spring.final01.product.dao;

import java.util.List;

import com.spring.final01.product.dto.ProductDTO;

public interface ProductDAO {
	
	List<ProductDTO> salesList();
	
	List<ProductDTO> stockList();

	List<ProductDTO> offersList();
	
	int addStock(ProductDTO dto);

	int updateAllStock(ProductDTO dto);
	
	int deleteStock(String name);

	int insertOffer(ProductDTO dto);

	List<ProductDTO> offersInfo(String cus_id);

	void updateStock(ProductDTO dto);

	List<ProductDTO> customerStock(String cus_id);

	int updateOffer(ProductDTO dto);

	int deleteOffer(int no);

	List<ProductDTO> selectDeletedRecords(int no);

	void updateStockAmount(ProductDTO dto);


}