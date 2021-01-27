<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
    
    <%
	if(session.getAttribute("userid")==null)
	{
		response.sendRedirect("login.html");
		return;
	}

		request.setCharacterEncoding("utf-8");

		int photoid=Integer.parseInt(request.getParameter("photoid"));
		int userid=(Integer)session.getAttribute("userid");

		Class.forName("com.mysql.jdbc.Driver");
		Connection conn=DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/gd_photo?useSSL=false&serverTimezone=UTC"
				,"root","123456");
		PreparedStatement pstmt=conn.prepareStatement("insert into favs values(default,?,?)");
		pstmt.setInt(1,photoid);
		pstmt.setInt(2,userid);
		int n = pstmt.executeUpdate();
		pstmt.close();
		conn.close();

		response.sendRedirect("fav_list.jsp");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>

</body>
</html>