package com.mini.project;

import java.io.IOException;
// import java.io.PrintWriter;
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


@WebServlet(name = "inventoryManagement", urlPatterns = {"/board/memberManagement"})
public class miniBoardMemberList extends HttpServlet {

  private static final long serialVersionUID = 1L;

  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    final Logger logger = LoggerFactory.getLogger(miniBoardList.class);

    logger.info("===== memberManagement start =====");
    resp.setContentType("text/html; charset=UTF-8");

    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;

    String uri = "jdbc:mariadb://127.0.0.1:3306/inventory";
    String userid = "root";
    String userpw = "1234";

    List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
    Map<String, Object> map = null;

    String query = "select * from member";

    logger.info("게시물 목록 보기 실행 쿼리문 : {}", query);

    try {
      // DataSource ds = (DataSource) this.getServletContext().getAttribute("dataSource");
      // con = ds.getConnection();

      Class.forName("org.mariadb.jdbc.Driver");
      con = DriverManager.getConnection(uri, userid, userpw);

      stmt = con.createStatement();
      rs = stmt.executeQuery(query);

      while (rs.next()) {

        map = new HashMap<String, Object>();
        map.put("userid", rs.getInt("userid"));
        map.put("username", rs.getString("username"));
        map.put("password", rs.getInt("password"));
        map.put("telno", rs.getInt("telno"));
        map.put("age", rs.getInt("age"));
        map.put("address", rs.getInt("address"));
        list.add(map);

      }

      rs.close();
      stmt.close();
      con.close();

      logger.info("list : {}", list);
      req.setAttribute("list", list);
      RequestDispatcher dispatcher = req.getRequestDispatcher("/board/memberManagement.jsp");
      dispatcher.forward(req, resp);


    } catch (Exception e) {
      e.printStackTrace();
    }
  }


}
