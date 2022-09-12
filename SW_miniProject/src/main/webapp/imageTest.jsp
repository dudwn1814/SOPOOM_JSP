<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="org.apache.tomcat.util.codec.binary.Base64"%>
<%@page import="java.io.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
//strBase64를 db에 저장 후 img의 src로 사용하면 될듯합니다.
String filePath = "C:\\inventory\\inventory\\src\\main\\webapp\\img\\sample.png";
String strBase64 = "data:image/";
File f = new File(filePath);
if (f.exists() && f.isFile() && f.length() > 0) {
	String fileType = FilenameUtils.getExtension(filePath);
	strBase64 += fileType+";base64,";
    byte[] bt = new byte[(int) f.length()];
    FileInputStream fis = null;
    try {
        fis = new FileInputStream(f);
        fis.read(bt);
        strBase64 += new String(Base64.encodeBase64(bt));
        fis.close();
    } catch (Exception e) {
        throw e;
    }
}
%>
</body>
<img id="img" src=<%=strBase64 %> />
</html>