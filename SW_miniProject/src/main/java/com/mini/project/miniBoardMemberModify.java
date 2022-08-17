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

@WebServlet("/board/memberModify")
public class miniBoardMemberModify extends HttpServlet {
  private static final long serialVersionUID = 1L;

  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    final Logger logger = LoggerFactory.getLogger(miniBoardMemberModify.class);

    logger.info("===== mModify Start =====");
    resp.setContentType("text/html; charset=UTF-8");

    String uri = "jdbc:mariadb://127.0.0.1:3306/inventory";
    String uid = "root";
    String userpw = "1234";

    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;

    Map<String, Object> map = new HashMap<String, Object>();

    String userid = req.getParameter("userid");

    String query = "select userid, username, password, telno, age, address from member "
        + "where userid = " + userid;

    logger.info("게시물 수정 내용 보기 실행 쿼리문 : {}", query);

    try {
      // DataSource ds = (DataSource) this.getServletContext().getAttribute("dataSource");
      // con = ds.getConnection();

      Class.forName("org.mariadb.jdbc.Driver");
      con = DriverManager.getConnection(uri, uid, userpw);

      stmt = con.createStatement();
      rs = stmt.executeQuery(query);

      if (rs.next()) {
        map.put("userid", userid);
        map.put("username", rs.getString("username"));
        map.put("password", rs.getString("password"));
        map.put("telno", rs.getString("telno"));
        map.put("age", rs.getInt("age"));
        map.put("address", rs.getString("address"));
      }

      req.setAttribute("list", map);
      logger.info("list : {}", map);

      RequestDispatcher dispatcher = req.getRequestDispatcher("/board/memberModify.jsp");
      dispatcher.forward(req, resp);

      if (rs != null) {
        rs.close();
      }
      if (stmt != null) {
        stmt.close();
      }
      if (con != null) {
        con.close();
      }

    } catch (Exception e) {
      e.printStackTrace();
    }

  }

  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    final Logger logger = LoggerFactory.getLogger(miniBoardMemberModify.class);

    logger.info("===== memberModify start =====");

    req.setCharacterEncoding("UTF-8");

    String userid = req.getParameter("userid");
    String username = req.getParameter("username");

    String uri = "jdbc:mariadb://127.0.0.1:3306/inventory";
    String uid = "root";
    String userpw = "1234";

    String query =
        "update member set userid = '" + userid + "' where username = " + username;

    logger.info("게시물 수정 쿼리문 : {}", query);

    try {
      // DataSource ds = (DataSource) this.getServletContext().getAttribute("dataSource");
      // Connection con = ds.getConnection();
      Class.forName("org.mariadb.jdbc.Driver");
      Connection con = DriverManager.getConnection(uri, uid, userpw);

      Statement stmt = con.createStatement();
      stmt.executeUpdate(query);
      con.commit();

      if (stmt != null)
        stmt.close();
      if (con != null)
        con.close();

      resp.sendRedirect("/board/inventoryManagement");

    } catch (SQLException | ClassNotFoundException e) {
      e.printStackTrace();
    }

  }

}
