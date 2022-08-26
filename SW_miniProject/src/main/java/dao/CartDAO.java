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

	String url = "jdbc:mariadb://127.0.0.1:3306/sw_miniproject";
	String user = "root";
	String pwd = "0000";

	//ordereditem , order table에 값 넣는 기능
	//order 값 넣은 이후, orderitem에 값을 넣는다.
	//orderid가 order table PK이기 때문.

	public int insertCart(CartDTO cart) {
		System.out.println("====insertCart====");
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			String sql = "insert into CART(userid, productid, Quantity) VALUES(?,?,?)";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, cart.getUserid());
			pstmt.setString(2, cart.getp_id());
			pstmt.setInt(3, cart.getQuantitiy());

			rows = pstmt.executeUpdate();

			pstmt.close();
			con.close();

		} catch (Exception e) {
			System.out.println("Cart 테이블 insert 오류 => " + e.getMessage());
		}

		return rows;

	}


	public int updateCart(CartDTO cart) {
		System.out.println("====updateCart====");
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			Class.forName("org.mariadb.jdbc.Driver");
			con = DriverManager.getConnection(url, user, pwd);

			String sql = "update cart set userid= ?, quantity = ? where p_id = ?";
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, cart.getUserid());
			pstmt.setInt(2, cart.getQuantitiy());
			pstmt.setString(3, cart.getp_id());

			rows= pstmt.executeUpdate();

			pstmt.close();
			con.close();


		} catch (Exception e) {
			System.out.println("Cart 테이블 update 오류 => " + e.getMessage());
		}
		return rows;
	}

	public int deleteCart(String p_id) {
		System.out.println("====deleteCart====");
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			Class.forName("org.mariadb.jdbc.Driver");
			con = DriverManager.getConnection(url, user, pwd);

			String sql = "delete from cart where p_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, p_id);

			rows= pstmt.executeUpdate();

			pstmt.close();
			con.close();


		} catch (Exception e) {
			System.out.println("Cart 테이블 delete 오류 => " + e.getMessage());
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
			System.out.println("Cart 테이블 delete 오류 => " + e.getMessage());
		}
		return rows;

	}

	/*
	 * public CartDTO selectCart(int p_id) { Connection con = null;
	 * PreparedStatement pstmt = null; ResultSet rs = null; CartDTO cart = null;
	 *
	 * try { Class.forName("org.mariadb.jdbc.Driver"); con =
	 * DriverManager.getConnection(url, user, pwd);
	 *
	 * String sql = "select * from cart where p_id = ?"; pstmt =
	 * con.prepareStatement(sql); rs = pstmt.executeQuery();
	 *
	 * if(rs.next()) { cart = new CartDTO(); pstmt.setInt(1, p_id);
	 * cart.setUserid(rs.getString("userid")); cart.setp_id(rs.getString("p_id"));
	 * cart.setQuantitiy(rs.getInt("quantity")); }
	 *
	 * pstmt.close(); con.close();
	 *
	 *
	 * } catch (Exception e) { System.out.println("Cart 테이블 select 오류 => " +
	 * e.getMessage()); } return cart; }
	 */

	public List<CartDTO> selectAllCartList(String userid){

		System.out.println("====selectAllCartList====");

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		List<CartDTO> list = new ArrayList<CartDTO>();


		try {
			Class.forName("org.mariadb.jdbc.Driver");
			con = DriverManager.getConnection(url, user, pwd);
			String sql = "select * from Cart where userid = ? order by p_id";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();

			while(rs.next()){

				CartDTO cart = new CartDTO();
				cart.setUserid(userid);
				cart.setp_id(rs.getString("p_id"));
				cart.setQuantitiy(rs.getInt("quantity"));

				list.add(cart);
				pstmt.close();
				con.close();
			}


		} catch (Exception e) {
			System.out.println("Cart 테이블 select 오류 => " + e.getMessage());
		}

		return list;
	}

}




