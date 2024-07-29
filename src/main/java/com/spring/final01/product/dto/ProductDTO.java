package com.spring.final01.product.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ProductDTO {
	private int no;
	private String cus_id;
	private String cus_name;
	private String item_name;
	private String item_code;
	private Date item_orderDate;
	private String item_price;
	private String item_amount;
	private String item_orderAmount;
	private int sum_item_orderAmount;
	private String item_totalPrice;
	private int sum_item_totalPrice;
	
}
