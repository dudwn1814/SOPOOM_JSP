package dto;

public class CartDTO {
	private String userid; //유저 아이디
	private int p_id; //제품 아이디
	private int quantitiy; //수량

	
	public CartDTO(){ //생성자
		
	}
	
	public CartDTO(String userid, int p_id,  int quantitiy) {
		super();
		this.userid = userid;
		this.p_id = p_id;
		this.quantitiy = quantitiy;
	}


	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	
	public int getQuantitiy() {
		return quantitiy;
	}

	public void setQuantitiy(int quantitiy) {
		this.quantitiy = quantitiy;
	}

	public int getp_id() {
		return p_id;
	}

	public void setp_id(int p_id) {		
		this.p_id = p_id;
	}
	
	
}
