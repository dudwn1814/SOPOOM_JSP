package com.mini.project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


@WebServlet("/Admin/Inventory/inventory")
public class InventoryList extends HttpServlet {
  private static final long serialVersionUID = 1L;

  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    final Logger logger = LoggerFactory.getLogger(InventoryList.class);

    logger.info("===== inventoryList start =====");
    resp.setContentType("text/html; charset=UTF-8");

    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;

<<<<<<< HEAD:SW_miniProject/src/main/java/com/mini/project/InventoryList.java
    String uri = "jdbc:mariadb://127.0.0.1:3306/SW_miniProject";
    String userid = "root";
    String userpw = "0000";
=======
    String uri = "jdbc:mariadb://127.0.0.1:3306/inventory";
    String userid = "root";
    String userpw = "1234";
>>>>>>> b3fedd22fbba6d0ed3fddc75570f9461d1f05f94:src/main/java/com/mini/project/InventoryList.java

    List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
    Map<String, Object> map = null;

    String query =
        "select p_id, p_name, FORMAT(p_price, 0) as p_price, p_amount from inventory_management";

    logger.info("재고 목록 보기 실행 쿼리문 : {}", query);

    try {
      Class.forName("org.mariadb.jdbc.Driver");
      con = DriverManager.getConnection(uri, userid, userpw);

      stmt = con.createStatement();
      rs = stmt.executeQuery(query);

      while (rs.next()) {
        map = new HashMap<String, Object>();
        map.put("p_id", rs.getInt("p_id"));
        map.put("p_name", rs.getString("p_name"));
        map.put("p_price", rs.getString("p_price"));
        map.put("p_amount", rs.getInt("p_amount"));
        list.add(map);
      }

      rs.close();
      stmt.close();
      con.close();

      logger.info("list : {}", list);
      req.setAttribute("list", list);
      RequestDispatcher dispatcher = req.getRequestDispatcher("/Admin/Inventory/inventory.jsp");
      dispatcher.forward(req, resp);

    } catch (Exception e) {
      e.printStackTrace();
    }
  }
}
