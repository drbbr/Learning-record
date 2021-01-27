<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
    
    <%
    request.setCharacterEncoding("UTF-8"); 
    int id=Integer.parseInt(request.getParameter("id"));
    String title=request.getParameter("title");
    String url=request.getParameter("url");
    
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn=DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/gd_photo?useSSL=false&serverTimezone=UTC"
			,"root","123456");
	PreparedStatement pstmt=conn.prepareStatement(
			"update photos set photo_title=?,photo_url=? where photo_id=?");
	pstmt.setString(1,title);
	pstmt.setString(2,url);
	pstmt.setInt(3,id);
	int n=pstmt.executeUpdate();

	pstmt.close();
	conn.close();
	response.sendRedirect("list.jsp");
    %>
    
    
