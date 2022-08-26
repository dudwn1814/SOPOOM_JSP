package dto;

public class CartDTO {
	private String cartid; //카트 아이디
	private String userid; //유저 아이디
	private int p_id; //제품 아이디
	private int quantitiy; //수량

	
	public CartDTO(){ //생성자
		
	}
	
	public CartDTO(String cartid, String userid, int p_id,  int quantitiy) {
		super();
		this.cartid = cartid;
		this.p_id = p_id;
		this.userid = userid;
		this.quantitiy = quantitiy;
	}

	public String getCartid() {
		return cartid;
	}

	public void setCartid(String cartid) {
		this.cartid = cartid;
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
