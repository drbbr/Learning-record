<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.sql.*" %> 
<%
	request.setCharacterEncoding("UTF-8"); 
	String name=request.getParameter("loginname");
	String pwd=request.getParameter("loginpwd");
	
	Class.forName("com.mysql.cj.jdbc.Driver"); 
	Connection conn=DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/gd_photo?useSSL=false&serverTimezone=UTC"
			,"root","123456");
	PreparedStatement pstmt=conn.prepareStatement(
			"select * from users where user_loginname=? and user_loginpwd=?");
	pstmt.setString(1,name); 
	pstmt.setString(2,pwd);
	ResultSet rs=pstmt.executeQuery();
	boolean y=false;
	while(rs.next())
	{
		y=true;
		session.setAttribute("userid",rs.getInt(1));
		session.setAttribute("nickname",rs.getString(2));
	}
	rs.close();
	pstmt.close(); 
	conn.close();
	
	if(y)
		response.sendRedirect("index.jsp");
	else
		response.sendRedirect("login.html");


%>
    
    
    
    
