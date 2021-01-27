<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.sql.*" %> 

<%
	if(session.getAttribute("userid")==null)
	{
		response.sendRedirect("login.html");
		return;
	}
%>


<html>
  <head></head>
  <body>
    <h1>图片墙</h1>
    <div style="background-color:#222222;line-height:40px">
    	<a style="color:white;margin-left:30px" href="add.jsp">我要上传</a>
		<a href="list.jsp" style="color:white;float:right">编辑相册</a>
    	
		<span style="color:white;float:right;margin-right:30px;">欢迎您：<%=session.getAttribute("nickname") %>
    	<a href="logout_do.jsp" style="color:white;">注销</a>
    	</span>
    	
    </div>
    <hr />
    <%
	Class.forName("com.mysql.cj.jdbc.Driver"); 
	Connection conn=DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/gd_photo?useSSL=false&serverTimezone=UTC"
			,"root","123456");
	PreparedStatement pstmt=conn.prepareStatement(
			"select * from photos");
	ResultSet rs=pstmt.executeQuery();
	while(rs.next())
	{
		%>
		
		<a href="detail.jsp?pid=<%=rs.getInt(1)%>">
		<img src="<%=rs.getString(3)%>" height="120px" title="<%=rs.getString(2)%>" />
	</a>
	<%
	}
	rs.close();
	pstmt.close(); 
	conn.close();
%>
  </body>
</html>
