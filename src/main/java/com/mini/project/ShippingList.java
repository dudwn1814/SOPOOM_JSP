package com.mini.project;

import java.io.IOException;
// import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
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

@WebServlet("/Admin/Shipping/shipping")
public class ShippingList extends HttpServlet {
  private static final long serialVersionUID = 1L;

  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    final Logger logger = LoggerFactory.getLogger(ShippingList.class);

    logger.info("===== shippin gManagement start =====");
    resp.setContentType("text/html; charset=UTF-8");

    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;

<<<<<<< HEAD:SW_miniProject/src/main/java/com/mini/project/ShippingList.java
    String uri = "jdbc:mariadb://127.0.0.1:3306/SW_miniProject";
    String userid = "root";
    String userpw = "0000";
=======
    String uri = "jdbc:mariadb://127.0.0.1:3306/inventory";
    String userid = "root";
    String userpw = "1234";
>>>>>>> b3fedd22fbba6d0ed3fddc75570f9461d1f05f94:src/main/java/com/mini/project/ShippingList.java

    List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
    Map<String, Object> map = null;

    String query =
        "select s.shipID, o.orderID, u.userID, u.username, u.telno, s.address, s.status from shipping s, `order` o, user u "
            + "where s.orderID = o.orderID AND u.userID = o.userID";

    logger.info("배송 관리 실행 쿼리문 : {}", query);

    try {
      Class.forName("org.mariadb.jdbc.Driver");
      con = DriverManager.getConnection(uri, userid, userpw);

      stmt = con.createStatement();
      rs = stmt.executeQuery(query);

      while (rs.next()) {

        map = new HashMap<String, Object>();
        map.put("shipID", rs.getString("shipID"));
        map.put("orderID", rs.getString("orderID"));
        map.put("userID", rs.getString("userID"));
        map.put("username", rs.getString("username"));
        map.put("telno", rs.getString("telno"));
        map.put("address", rs.getString("address"));
        map.put("status", rs.getString("status"));
        list.add(map);
      }

      rs.close();
      stmt.close();
      con.close();

      logger.info("list : {}", list);
      req.setAttribute("list", list);
      RequestDispatcher dispatcher = req.getRequestDispatcher("/Admin/Shipping/shipping.jsp");
      dispatcher.forward(req, resp);


    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    final Logger logger = LoggerFactory.getLogger(ShippingList.class);

    logger.info("===== shipping status update start =====");

    req.setCharacterEncoding("UTF-8");

    String ship_id = req.getParameter("ship_id");
    logger.info("===== ship_id ===== : " + ship_id);
    String status = req.getParameter("statusSelect");

<<<<<<< HEAD:SW_miniProject/src/main/java/com/mini/project/ShippingList.java
    String uri = "jdbc:mariadb://127.0.0.1:3306/SW_miniProject";
    String userid = "root";
    String userpw = "0000";
=======
    String uri = "jdbc:mariadb://127.0.0.1:3306/inventory";
    String userid = "root";
    String userpw = "1234";
>>>>>>> b3fedd22fbba6d0ed3fddc75570f9461d1f05f94:src/main/java/com/mini/project/ShippingList.java

    String query = "update shipping set status = '" + status + "' where shipID = " + ship_id;

    logger.info("배송상태 수정 쿼리문 : {}", query);

    try {
      Class.forName("org.mariadb.jdbc.Driver");
      Connection con = DriverManager.getConnection(uri, userid, userpw);

      Statement stmt = con.createStatement();
      stmt.executeUpdate(query);
      con.commit();

      stmt.close();
      con.close();

      resp.sendRedirect("/Admin/Shipping/shipping");

    } catch (SQLException | ClassNotFoundException e) {
      e.printStackTrace();
    }
  }
}
