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


@WebServlet("/Admin/Member/memberInfo")
public class MemberInfoList extends HttpServlet {

  private static final long serialVersionUID = 1L;

  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    final Logger logger = LoggerFactory.getLogger(MemberInfoList.class);

    logger.info("===== memberInfo-detail start =====");
    resp.setContentType("text/html; charset=UTF-8");

    Connection con = null;
    Statement stmt1 = null;
    ResultSet rs1 = null;

    String uri = "jdbc:mariadb://127.0.0.1:3306/inventory";
    String uid = "root";
    String userpw = "1234";

    List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
    Map<String, Object> map = null;

    String userid = req.getParameter("userid");

    logger.info("userid : {}", userid);

    String query1 = "select * from user where userID = '" + userid + "'";


    try {
      Class.forName("org.mariadb.jdbc.Driver");
      con = DriverManager.getConnection(uri, uid, userpw);

      stmt1 = con.createStatement();
      rs1 = stmt1.executeQuery(query1);

      while (rs1.next()) {

        map = new HashMap<String, Object>();
        map.put("userid", rs1.getString("userID"));
        map.put("username", rs1.getString("username"));
        map.put("password", rs1.getString("password"));
        map.put("telno", rs1.getString("telno"));
        map.put("address", rs1.getString("address"));
        map.put("detailAddress", rs1.getString("detailAddress"));
        list.add(map);
      }

      rs1.close();
      stmt1.close();
      con.close();

      logger.info("list : {}", list);
      req.setAttribute("list", list);
      RequestDispatcher dispatcher = req.getRequestDispatcher("/Admin/Member/memberInfo.jsp");
      dispatcher.forward(req, resp);


    } catch (Exception e) {
      e.printStackTrace();
    }
  }


}
