<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if(session.getAttribute("userid")==null)
{
	response.sendRedirect("login.html");
	return;
}
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>添加图片</title>
  </head>
  <body>
   <h1 style="color:blue">添加图片</h1>
   
   <%@include file="common/nav.jsp" %>
   <hr/>
    <form action="add_do.jsp" method="post">
    	<p>标题：<input type="text" name="title"/></p>
      <p>网址：<input type="text" size="100" name="url" /></p>
      <hr />
      <input type="submit" value="新增" />
    </form>
  </body>
</html>
