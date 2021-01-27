<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
    <%
    int pid=Integer.parseInt(request.getParameter("pid"));
    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection conn=DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/gd_photo?useSSL=false&serverTimezone=UTC"
			,"root","123456");
	PreparedStatement pstmt=conn.prepareStatement(
			"select * from photos where photo_id=?");
	pstmt.setInt(1,pid);
	ResultSet rs=pstmt.executeQuery();
	String title=null;
	String url=null;
	if(rs.next())
	{
		title=rs.getString(2);
		url=rs.getString(3);
	}
	rs.close();
	pstmt.close();
	conn.close();
    %>
<html>
  <head>
  <meta http-equiv="Content-Type" content="text/html"; charset="UTF-8" />
  <title>大图欣赏</title>
  </head>
  <body style="background-color:#0099CC">
  <h1>大图欣赏</h1>
  <%@include file="common/nav.jsp" %>
  <hr/>
  <div style="width:600px;margin:20px auto">
    <h3><%=title %>【<a href="fav_add_do.jsp?photoid=<%=pid %>">收藏</a>】</h3>
    <img src="<%=url %>" width="600px"/>
    <br/>
    <h4>相片的评论</h4>
      <hr/>
      <ul>
          <%
              Class.forName("com.mysql.cj.jdbc.Driver");
              Connection conn2=DriverManager.getConnection(
                      "jdbc:mysql://localhost:3306/gd_photo?useSSL=false&serverTimezone=UTC"
                      ,"root","123456");
              PreparedStatement pstmt2=conn2.prepareStatement(
                      "select c.*,u.user_nickname from comments c join users u on c.cm_user_id=u.user_id where c.cm_photo_id=?");
              pstmt2.setInt(1,pid);
              ResultSet rs2=pstmt2.executeQuery();
              while(rs2.next())
              {
                  %>
          <li><span style="color:red"><%=rs2.getString(5)%>说：</span><%=rs2.getString(3)%></li>
          <%
          }
              rs2.close();
              pstmt2.close();
              conn2.close();
          %>
      </ul>
      <form action="cm_add_do.jsp" method="post">
          <input type="hidden" name="photoid" value="<%=pid%>"/>
          <textarea name="content" cols="50" rows="3"></textarea>
            <input type="submit" value="我要发表"/>
      </form>
</div>
  </body>
</html>
    
