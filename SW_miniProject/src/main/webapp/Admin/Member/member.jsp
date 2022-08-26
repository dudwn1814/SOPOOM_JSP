<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<head>

<title>회원 목록</title>
<link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
<link rel="stylesheet" href="member.css">
</head>

<body>

   <%@include file="/top.jsp"%>
   <%
   request.setCharacterEncoding("utf-8");
   
   String url = "jdbc:mariadb://127.0.0.1:3306/inventory";
   String uid = "root";
   String pwd = "1234";

   int idx = 1;
   %>

   <div class="tableDiv">
      <h1>회원 목록</h1>
      <hr>
      <table class="InfoTable">
         <tr>
            <th>INDEX</th>
            <th>USER ID</th>
            <th>USER NAME</th>
            <th>E-MAIL</th>
         </tr>

         <tbody>

            <%
            String query = "select * from user";

            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {

               Class.forName("org.mariadb.jdbc.Driver");
               con = DriverManager.getConnection(url, uid, pwd);

               stmt = con.createStatement();
               rs = stmt.executeQuery(query);

               while (rs.next()) {
            %>
            <tr>
               <td class="tdIndex"><%=idx++%></td>
               <td class="tdId"><a id="hypertext"
                  href="/Admin/Member/memberInfo.jsp?userID=<%=rs.getString("userID")%>"
                  onMouseover='this.style.textDecoration="underline"'
                  onmouseout="this.style.textDecoration='none';"><%=rs.getString("userID")%></a></td>
               <td class="tdName"><%=rs.getString("username")%></td>
               <td class="tdEmail"><%=rs.getString("email")%></td>
            </tr>

            <%
            }
            } catch (Exception e) {
            e.printStackTrace();
            }

            if (stmt != null)
            stmt.close();
            if (rs != null)
            rs.close();
            if (con != null)
            con.close();
            %>
         </tbody>

      </table>
      <br>

   </div>
   <%@include file="/footer.jsp"%>
</body>
</html>