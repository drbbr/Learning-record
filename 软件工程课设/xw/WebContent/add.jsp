<%@ page language="java" import="java.util.*,com.gd.xw.entity.User" pageEncoding="UTF-8"%>
<%
	User u = (User) session.getAttribute("user");
	if (u == null) {
	response.sendRedirect("login.jsp");
	return;
	}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css"
	rel="stylesheet">
<title>发表微博</title>
<style>
	 table{width:100%;border-spacing: 10px 30px;border-top:1px solid #ccc;border-bottom:1px solid #ccc}
	 th{border-bottom:2px solid #ccc;}
	 td{text-align:left;width:50%}
	 tr td:first-child{text-align:right;}
	 tr:last-child td:last-child{padding-left:20px}
	 h1{text-align:center}
	 input[type=text]{border-width:0px 0px 2px 0px;border-color:black}
	 input:focus{border-color:red}
	 .container-fluid{height:50px;}
	 .navbar{background-color: #8ac4c5;border-color: #348f48;}
	 .newactive{background:#9bdcdc;}
	 .cl{background-color: rgba(255,255,255,.1);}
</style>
<script>
    
</script>
</head>
<body style="background-color:#e8f9f5;width:70%;margin:0 auto">
     
      <h1>发表微博</h1>
      	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="collapse navbar-collapse" style="text-align: center;">
				<ul class="nav navbar-nav"
					style="display: inline-block; float: none;">
					<li><a href="list.jsp">首页</a></li>
					<li class="newactive"><a href="add.jsp">发表</a></li>
					<li><a href="list.jsp?marstid=<%=u.getId()%>">管理博文</a></li>
					<li><a href="att_list.jsp">我的关注</a></li>
					<li><a href="fan_list.jsp">我的粉丝</a></li>
					<li><a href="#">热门排行</a></li>
					<li><a href="#">小游戏</a></li>
					<li><a href="logout">注销</a></li>
				</ul>

			</div>
		</div>
	</nav>
      <form action="add_do" method="post">
		   <table  class="table">
		     <tbody>			  
			  <tr>
   			   <td>标题</td>
			   <td><input class="cl" name="title" type="text"></td>
			  </tr>
			  <tr>
			    <td>内容</td>
				<td>
				   <textarea class="cl" name="content" cols="50" rows="5"></textarea>
				</td>
			  </tr>
			  <tr>
			  	<td>图片</td>
			  	<td><input class="cl" name="img" type="text" size="100"></input></td>
			  	</tr>
			   <tr>
			    <td><input class="btn btn-primary" type="submit" value="发表"></td>
				<td><input class="btn btn-default" type="reset" value="重置"></td>
			   </tr>
			</tbody>
		   </table>
      </form>
     

</body></html>