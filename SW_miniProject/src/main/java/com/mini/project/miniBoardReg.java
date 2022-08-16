package com.mini.project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@MultipartConfig(maxFileSize = 1024 * 1024 * 1024)
@WebServlet(name = "/board/mWrite", urlPatterns = {"/board/mWrite"})
public class miniBoardReg extends HttpServlet {
  private static final long serialVersionUID = 1L;

  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    RequestDispatcher dispatcher = req.getRequestDispatcher("/board/mWrite.jsp");
    dispatcher.forward(req, resp);
  }

  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    final Logger logger = LoggerFactory.getLogger(miniBoardReg.class);

    logger.info("===== mWriter start =====");

    req.setCharacterEncoding("UTF-8");

    Connection con = null;
    String uri = "jdbc:mariadb://127.0.0.1:3306/inventory";
    String userid = "webmaster";
    String userpw = "1234";

    String p_name = req.getParameter("p_name");
    String mtitle = req.getParameter("mtitle");
    String mcontent = req.getParameter("mcontent");

    /*
     * String filepath = "c:\\Repository\\file\\"; String filename = ""; int filesize = 0; Part part
     * = req.getPart("uploadFile");
     * 
     * if (part.getSize() != 0) {
     * 
     * filename = part.getSubmittedFileName(); filesize = (int) part.getSize(); part.write(filepath
     * + filename); part.delete();
     * 
     * }
     */
    LocalDateTime now = LocalDateTime.now();
    String mregdate = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

    String query = "insert into inventory_management (p_name, p_price, p_amount) values " + "('"
        + p_name + "', '" + mtitle + "', '" + mcontent + "')";

    logger.info("게시물 등록 쿼리문 : {}", query);

    try {
      // DataSource ds = (DataSource) this.getServletContext().getAttribute("dataSource");
      // Connection con = ds.getConnection();

      Class.forName("org.mariadb.jdbc.Driver");
      con = DriverManager.getConnection(uri, userid, userpw);

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
