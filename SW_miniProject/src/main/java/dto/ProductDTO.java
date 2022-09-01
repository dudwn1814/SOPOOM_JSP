package dto;

public class ProductDTO {
	private String p_id; // 상품 아이디
	private String p_name; // 상품 이름
	private int p_price; //가격
	private int p_amount; //재고
	private String p_fileName; //파일 네임

	public ProductDTO() {
		
	}
	
	public ProductDTO(String p_id, String p_name, int p_price, int p_amount, String p_fileName) {
		super();
		this.p_id = p_id;
		this.p_name = p_name;
		this.p_price = p_price;
		this.p_amount = p_amount;
		this.p_fileName = p_fileName;
	}
	
	public String getp_id() {
		return p_id;
	}
	public void setp_id(String p_id) {
		this.p_id = p_id;
	}
	public String getp_name() {
		return p_name;
	}
	public void setp_name(String p_name) {
		this.p_name = p_name;
	}
	public int getp_price() {
		return p_price;
	}
	public void setp_price(int p_price) {
		this.p_price = p_price;
	}
	public int getp_amount() {
		return p_amount;
	}
	public void setp_amount(int p_amount) {
		this.p_amount = p_amount;
	}
	
	public String getP_fileName() {
		return p_fileName;
	}

	public void setP_fileName(String p_fileName) {
		this.p_fileName = p_fileName;
	}

	
}

