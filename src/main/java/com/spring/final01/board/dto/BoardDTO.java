package com.spring.final01.board.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class BoardDTO {
	private int anno_no;
	private String co_id;
	private String co_name;
	private String anno_part;
	private String anno_part_nm;
	private String anno_title;
	private String anno_content;
	private Date anno_date; 
}
