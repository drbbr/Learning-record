<%@ page language="java" pageEncoding="UTF-8"%>

	<div style="background-color:#222222;line-height:40px">
		<a style="color:white;margin-left:30px;" href="index.jsp">首页</a>
    	<a style="color:white;margin-left:30px" href="add.jsp">我要上传</a>
    	<span style="color:white;float:right;margin-right:30px;">欢迎您：<%=session.getAttribute("nickname") %>
    	<a href="logout_do.jsp" style="color:white;">注销</a>
    	</span>
    </div>
