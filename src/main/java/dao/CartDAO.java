package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.CartDTO;

public class CartDAO {
	private static CartDAO _dao;
	
	public CartDAO(){
		
	}
	
	static {
		_dao= new CartDAO();
	}
	
	public static CartDAO getDAO() {
		return _dao;
	}
	
	String url = "jdbc:mariadb://127.0.0.1:3306/inventory";
	String user = "root";
	String pwd = "1234";
	
	public int insertCart(CartDTO cart) { //장바구니에서 수정된 최종 값 db에 올리는 역할
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			con = DriverManager.getConnection(url, user, pwd);
			
			String sql = "insert into cart(CartID, p_id, UserID, QUANTITY) VALUES((UUID_short(),?,?,?)";
			pstmt = con.prepareStatement(sql);
			//pstmt.setString(1, cart.getCartid());
			pstmt.setInt(1, cart.getp_id());
			pstmt.setString(2, cart.getUserid());
			pstmt.setInt(3, cart.getQuantitiy());
			
			rows= pstmt.executeUpdate();
			
			pstmt.close();
			con.close();
			
			
		} catch (Exception e) {
			System.out.println("Cart 테이블 insert 오류 => " + e.getMessage());
		}
		return rows;

		
	}
	
	public int updateCart(CartDTO cart) { 
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			con = DriverManager.getConnection(url, user, pwd);
			
			String sql = "update cart set userid= ?,p_id = ?, quantity = ? where cartid = ?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, cart.getUserid());
			pstmt.setInt(2, cart.getp_id());
			pstmt.setInt(3, cart.getQuantitiy());
			pstmt.setString(4, cart.getCartid());
			
			rows= pstmt.executeUpdate(); 
			
			pstmt.close();
			con.close();
			
			
		} catch (Exception e) {
			System.out.println("Cart 테이블 insert 오류 => " + e.getMessage());
		}
		return rows; 
	}
	
	public int deleteCart(String cartid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			con = DriverManager.getConnection(url, user, pwd);
			
			String sql = "delete from cart where cartid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cartid);
			
			rows= pstmt.executeUpdate();
			
			pstmt.close();
			con.close();
			
			
		} catch (Exception e) {
			System.out.println("Cart 테이블 insert 오류 => " + e.getMessage());
		}
		return rows;
	}
	
	public int clearCart(String userid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			con = DriverManager.getConnection(url, user, pwd);
			
			String sql = "delete from cart where userid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rows= pstmt.executeUpdate();
			
			pstmt.close();
			con.close();
			
			
		} catch (Exception e) {
			System.out.println("Cart 테이블 insert 오류 => " + e.getMessage());
		}
		return rows;
		
	}
	
	public CartDTO selectCart(String cartid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CartDTO cart = null;
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			con = DriverManager.getConnection(url, user, pwd);
			
			String sql = "select * from cart where cartid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cartid);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cart = new CartDTO();
				cart.setCartid(rs.getString("cartid"));
				cart.setUserid(rs.getString("userid"));
				cart.setp_id(rs.getInt("p_id"));
				cart.setQuantitiy(rs.getInt("quantity"));
			}
			
			pstmt.close();
			con.close();
			
			
		} catch (Exception e) {
			System.out.println("Cart 테이블 insert 오류 => " + e.getMessage());
		}
		return cart;
	}
	
	public List<CartDTO> selectAllCartList(String userid){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		List<CartDTO> list = new ArrayList<CartDTO>();
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			con = DriverManager.getConnection(url, user, pwd);
			
			String sql = "select * from Cart where userID = ? order by p_id";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CartDTO cart = new CartDTO();
				cart.setCartid(rs.getString("cartid"));
				cart.setp_id(rs.getInt("p_id"));
				cart.setUserid(rs.getString("userid"));
				cart.setQuantitiy(rs.getInt("quantity"));
				list.add(cart);
			}
			
			pstmt.close();
			con.close();
			
			
		} catch (Exception e) {
			System.out.println("Cart 테이블 insert 오류 => " + e.getMessage());
		}
		
		return list;
	}
	
}




