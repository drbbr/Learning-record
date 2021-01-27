<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
    
    <%
    request.setCharacterEncoding("UTF-8"); 
    int id=Integer.parseInt(request.getParameter("id"));
    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection conn=DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/gd_photo?useSSL=false&serverTimezone=UTC"
			,"root","123456");
	PreparedStatement pstmt=conn.prepareStatement(
			"delete from photos where photo_id=?");
	pstmt.setInt(1,id);
	
	int n=pstmt.executeUpdate();
	pstmt.close();
	conn.close();
	response.sendRedirect("list.jsp");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>