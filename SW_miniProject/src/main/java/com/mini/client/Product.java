package com.mini.client;

import java.io.Serializable;

public class Product implements Serializable {

	private static final long serialVersionUID = -4274700572038677000L;

	private String p_id; // 상품 아이디
	private String p_name; // 상품명
	private Integer p_price; // 상품 가격
	private int p_amount; // 재고 수
	private String filename; // 이미지 파일 이름
	private Integer filesize; // 이미지 파일 사이즈
	private String description; // 상품 설명
	private String manufacturer; // 제조사
	private String category; // 분류
	private String condition; // 신상품 or 중고품 or 재생품
	
	

	public Product() {
		super();
	}

	public Product(String p_id, String p_name, Integer p_price) {
		this.p_id = p_id;
		this.p_name = p_name;
		this.p_price = p_price;
	}

	public String getP_id() {
		return p_id;
	}

	public void setP_id(String p_id) {
		this.p_id = p_id;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public Integer getP_price() {
		return p_price;
	}

	public void setP_price(Integer p_price) {
		this.p_price = p_price;
	}

	public int getP_amount() {
		return p_amount;
	}

	public void setP_amount(int p_amount) {
		this.p_amount = p_amount;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public Integer getFilesize() {
		return filesize;
	}

	public void setFilesize(Integer filesize) {
		this.filesize = filesize;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getManufacturer() {
		return manufacturer;
	}

	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}		
	
}
