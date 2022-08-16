<%

    String uri ="jdbc:mariadb://127.0.0.1:3306/webdev"; 

    String userid = "root"; 

    String userpw = "1234";

	String query = "select userid, username, password, age, telno, address from member";

    

    Connection con;

    Statement stmt; 

    ResultSet rs;

    

%>

 

<html>

<head>

<title></title>

</head>

<body>

 

<h1>JSP Maria DB 연동 테스트</h1>

<table border="1">

    <tr><td>아이디</td><td>이름</td><td>나이</td></tr>

 

<% 

     try{

        Class.forName("org.mariadb.jdbc.Driver");

	    con = DriverManager.getConnection(uri,userid,userpw);

	    stmt = con.createStatement();

	    rs = stmt.executeQuery(query);

     

        while(rs.next()) {

    

    %>

        <tr>

            <td><%=rs.getString("userid") %></td>

            <td><%=rs.getString("name") %></td>

            <td><%=rs.getString("age") %></td>

        </tr>

 

    <%   

        }

    }catch(Exception e){ e.printStackTrace();  }  

 

    %>

 

</table>

 

</body>

</html> 