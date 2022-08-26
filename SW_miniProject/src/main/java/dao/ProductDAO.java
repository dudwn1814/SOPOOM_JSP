package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dto.ProductDTO;

public class ProductDAO {
	private static ProductDAO _dao;
	
	public ProductDAO() {
		
	}
	
	static {
		_dao = new ProductDAO();
	}
	
	public static ProductDAO getDAO() {
		return _dao;
	}
	
	String url = "jdbc:mariadb://127.0.0.1:3306/sw_miniProject";
	String user = "root";
	String pwd = "0000";
	
	
	public ProductDTO selectProduct(String p_id) {	
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductDTO product = null;
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			con = DriverManager.getConnection(url, user, pwd);
			
			String sql = "select * from inventory_management where p_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, p_id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				product = new ProductDTO();
				product.setp_id(rs.getString("p_id"));
				product.setp_name(rs.getString("p_name"));
				product.setp_price(rs.getInt("p_price"));
				product.setp_amount(rs.getInt("p_amount"));
				//product.setExplanatino(rs.getString("Explanation"));
			}
			
			pstmt.close();
			con.close();
			
			
		} catch (Exception e) {
			System.out.println("product 테이블 insert 오류 => " + e.getMessage());
		}
		return product;
		
	}
	

}
