package com.spring.final01.product.service;

import java.util.List;

import com.spring.final01.product.dto.ProductDTO;

public interface ProductService {

	List<ProductDTO> salesList();
	
	List<ProductDTO> stockList();

	List<ProductDTO> offersList();
	
	int addStock(List<ProductDTO> list);
	
	int updateAllStock(List<ProductDTO> list);
	
	int deleteStock(List<String> list);
	
	int insertOffer(List<ProductDTO> list);

	List<ProductDTO> offersInfo(String cus_id);

	List<ProductDTO> customerStock(String cus_id);

	int updateOffer(List<ProductDTO> list);

	int deleteOffer(List<Integer> list);

}
