<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
  </head>
  <body>
    <h1>注册用户</h1>
    <%@include file="common/nav.jsp" %>
    <hr />
    <form action="reg_do.jsp" method="post">
      <p>
        昵&nbsp;&nbsp;&nbsp;称：
        <input type="text" name="nickname" />
      </p>
      <p>
        登录名：
        <input type="text" name="loginname" />
      </p>
      <p>
        密&nbsp;&nbsp;&nbsp;码：
        <input type="password" name="loginpwd" />
      </p>
      <input type="submit" value="提交" />
    </form>
  </body>
</html>
