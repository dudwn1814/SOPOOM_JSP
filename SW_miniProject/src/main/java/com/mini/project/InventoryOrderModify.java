package com.mini.project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@WebServlet("/Admin/Inventory/inventoryOrder")
public class InventoryOrderModify extends HttpServlet {
  private static final long serialVersionUID = 1L;

  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    final Logger logger = LoggerFactory.getLogger(InventoryOrderModify.class);

    logger.info("===== inventoryOrder select Start =====");
    resp.setContentType("text/html; charset=UTF-8");

    String uri = "jdbc:mariadb://127.0.0.1:3306/SW_miniProject";
    String userid = "root";
    String userpw = "0000";

    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;

    Map<String, Object> map = new HashMap<String, Object>();

    String p_id = req.getParameter("p_id");

    String query = "select * from inventory_management where p_id = " + p_id;

    logger.info("재고 발주 페이지 내용 보기 실행 쿼리문 : {}", query);

    try {
      Class.forName("org.mariadb.jdbc.Driver");
      con = DriverManager.getConnection(uri, userid, userpw);

      stmt = con.createStatement();
      rs = stmt.executeQuery(query);

      if (rs.next()) {
        map.put("p_id", p_id);
        map.put("p_name", rs.getString("p_name"));
        map.put("p_price", rs.getInt("p_price"));
        map.put("p_amount", rs.getInt("p_amount"));
        map.put("filename", rs.getString("filename"));
      }

      req.setAttribute("list", map);
      logger.info("list : {}", map);

      RequestDispatcher dispatcher =
          req.getRequestDispatcher("/Admin/Inventory/inventoryOrder.jsp");
      dispatcher.forward(req, resp);

      rs.close();
      stmt.close();
      con.close();

    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    final Logger logger = LoggerFactory.getLogger(InventoryOrderModify.class);

    logger.info("===== inventoryOrder update start =====");

    req.setCharacterEncoding("UTF-8");

    String p_id = req.getParameter("p_id");
    String p_amount = req.getParameter("p_amount");

    String uri = "jdbc:mariadb://127.0.0.1:3306/SW_miniProject";
    String userid = "root";
    String userpw = "0000";

    String query =
        "update inventory_management set p_amount = '" + p_amount + "' where p_id = " + p_id;

    logger.info("재고 발주 수정 쿼리문 : {}", query);

    try {
      Class.forName("org.mariadb.jdbc.Driver");
      Connection con = DriverManager.getConnection(uri, userid, userpw);

      Statement stmt = con.createStatement();
      stmt.executeUpdate(query);
      con.commit();

      stmt.close();
      con.close();

      resp.sendRedirect("/Admin/Inventory/inventory");

    } catch (SQLException | ClassNotFoundException e) {
      e.printStackTrace();
    }
  }
}
