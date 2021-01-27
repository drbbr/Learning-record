<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.sql.*" %> 
<%
	request.setCharacterEncoding("UTF-8"); 
	String t=request.getParameter("title"); 
	String u=request.getParameter("url");
	Class.forName("com.mysql.cj.jdbc.Driver"); 
	Connection conn=DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/gd_photo?useSSL=false&serverTimezone=UTC"
			,"root","123456");
	PreparedStatement pstmt=conn.prepareStatement(
			"insert into photos values(default,?,?)");
	pstmt.setString(1,t); 
	pstmt.setString(2,u);
	pstmt.executeUpdate(); 
	pstmt.close(); 
	conn.close();
	System.out.println("插入成功"); 
%>

<html>
  <head></head>
  <body>
    <h1>插入成功</h1>
    <image
      src="https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3563879038,322783869&fm=26&gp=0.jpg"
      height="120px"
    >
    </image>
    <a href="add.jsp">继续添加</a>
    <a href="index.jsp">回到首页</a>
  </body>
</html>
