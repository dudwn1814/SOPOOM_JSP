package com.mini.project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@MultipartConfig(maxFileSize = 1024 * 1024 * 1024)
@WebServlet("/Admin/Product/productReg")
public class productRegistration extends HttpServlet {
  private static final long serialVersionUID = 1L;

  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    RequestDispatcher dispatcher = req.getRequestDispatcher("/Admin/Product/productReg.jsp");
    dispatcher.forward(req, resp);
  }

  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    final Logger logger = LoggerFactory.getLogger(productRegistration.class);

    logger.info("===== product registration start =====");

    System.out.println("test");

    req.setCharacterEncoding("UTF-8");

    Connection con = null;
<<<<<<< HEAD:SW_miniProject/src/main/java/com/mini/project/productRegistration.java
    String uri = "jdbc:mariadb://127.0.0.1:3306/SW_miniProject";
    String userid = "root";
    String userpw = "0000";
=======
    String uri = "jdbc:mariadb://127.0.0.1:3306/inventory";
    String userid = "root";
    String userpw = "1234";
>>>>>>> b3fedd22fbba6d0ed3fddc75570f9461d1f05f94:src/main/java/com/mini/project/productRegistration.java

    String p_name = req.getParameter("p_name");
    int p_price = Integer.parseInt(req.getParameter("p_price"));
    int p_amount = Integer.parseInt(req.getParameter("p_amount"));

    String filepath = "c:\\Repository\\file\\";
    String filename = "";
    int filesize = 0;
    Part part = req.getPart("uploadFile");

    if (part.getSize() != 0) {

      filename = part.getSubmittedFileName();
      filesize = (int) part.getSize();
      part.write(filepath + filename);
      part.delete();

    }

    String query =
        "insert into inventory_management (p_name, p_price, p_amount, filename, filesize) values "
<<<<<<< HEAD:SW_miniProject/src/main/java/com/mini/project/productRegistration.java
            + "('" + p_name + "', '" + p_price + "', '" + p_amount + "', '" + filename + "', '"
=======
            + "('"+ p_name + "', '" + p_price + "', '" + p_amount + "', '" + filename + "', '"
>>>>>>> b3fedd22fbba6d0ed3fddc75570f9461d1f05f94:src/main/java/com/mini/project/productRegistration.java
            + filesize + "')";

    logger.info("게시물 등록 쿼리문 : {}", query);

    try {
      Class.forName("org.mariadb.jdbc.Driver");
      con = DriverManager.getConnection(uri, userid, userpw);

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
