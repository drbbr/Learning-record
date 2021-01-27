<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.sql.*" %> 
<%
	request.setCharacterEncoding("UTF-8"); 
	String nn=request.getParameter("nickname"); 
	String ln=request.getParameter("loginname");
	String p=request.getParameter("loginpwd");
	Class.forName("com.mysql.cj.jdbc.Driver"); 
	Connection conn=DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/gd_photo?useSSL=false&serverTimezone=UTC"
			,"root","123456");
	PreparedStatement pstmt=conn.prepareStatement(
			"insert into users values(default,?,?,?)");
	pstmt.setString(1,nn); 
	pstmt.setString(2,ln);
	pstmt.setString(3,p);
	pstmt.executeUpdate(); 
	pstmt.close(); 
	conn.close();
	System.out.println("注册成功"); 
%>
    
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>注册成功</title>
</head>
<body>
    <h1>注册成功</h1>
    <a href="index.jsp">回到首页</a>
  </body>
</html>