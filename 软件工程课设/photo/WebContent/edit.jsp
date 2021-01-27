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
			"select * from photos where photo_id=?");
	pstmt.setInt(1,id);
	ResultSet rs=pstmt.executeQuery();
	int pid=0;
	String title=null;
	String url=null;
	while(rs.next())
	{
		pid=rs.getInt(1);
		title=rs.getString(2);
		url=rs.getString(3);
	}
	
	pstmt.close();
	conn.close();
	
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>编辑图片</title>
</head>
<body>
	<form action="edit_do.jsp" method="post">
		编号：<input type="text" name="id" value="<%=pid%>"/><br>
		标题：<input type="text" name="title" value="<%=title%>"/><br>
		网址：<input type="text" name="url" value="<%=url%>" size="200"/><br>
		<input type="submit"  value="修改"/>
	</form>
</body>
</html>