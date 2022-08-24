package com.mini.project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@WebServlet("/Admin/Inventory/inventoryDelete")
public class InventoryOrderDelete extends HttpServlet {
  private static final long serialVersionUID = 1L;

  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    RequestDispatcher dispatcher = req.getRequestDispatcher("/Admin/Inventory/inventoryDelete.jsp");
    dispatcher.forward(req, resp);
  }

  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    final Logger logger = LoggerFactory.getLogger(InventoryOrderDelete.class);

    logger.info("===== inventoryOrder Delete start =====");

    req.setCharacterEncoding("UTF-8");

    String p_id = req.getParameter("p_id");

    String uri = "jdbc:mariadb://127.0.0.1:3306/SW_miniProject";
    String userid = "root";
    String userpw = "0000";

    String query = "delete from inventory_management where p_id = " + p_id;

    logger.info("상품 삭제 쿼리문 : {}", query);

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
