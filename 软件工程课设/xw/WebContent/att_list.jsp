<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*,com.gd.xw.dao.*,com.gd.xw.entity.*"%>

<%
		User u = (User) session.getAttribute("user");
		if (u == null) {
		response.sendRedirect("login.jsp");
		return;
	}
		

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css"
	rel="stylesheet">
<title>关注列表</title>
<style>
th {
	border-bottom: 2px solid #ccc;
	text-align: center
}

td {
	border-bottom: 1px solid #ccc;
	text-align: center
}

h1 {
	text-align: center
}
	.container-fluid {height: 50px;}
	.navbar {background-color: #8ac4c5;	border-color: #348f48;}
	.newactive {background: #9bdcdc;}
	.table-hover > tbody > tr:hover > td,
	.table-hover > tbody > tr:hover > th {
	background-color: #c5e6d8;
	}
</style>
</head>
<body style="background-color:#e8f9f5;width:70%;margin:0 auto">
	<h1>微博列表</h1>
<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="collapse navbar-collapse" style="text-align: center;">
				<ul class="nav navbar-nav"
					style="display: inline-block; float: none;">
					<li><a href="list.jsp">首页</a></li>
					<li><a href="add.jsp">发表</a></li>
					<li><a href="list.jsp?marstid=<%=u.getId()%>">管理博文</a></li>
					<li class="newactive"><a href="att_list.jsp">我的关注</a></li>
					<li><a href="fan_list.jsp">我的粉丝</a></li>
					<li><a href="#">热门排行</a></li>
					<li><a href="#">小游戏</a></li>
					<li><a href="logout">注销</a></li>
				</ul>

			</div>
		</div>
	</nav>
	<table align="center" width="60%" cellspacing="0px" class="table table-bordered table-hover">

		<tbody>
			<tr>

				<th>编号</th>
				<th>博主</th>
				<th>粉丝</th>
				<th>操作</th>
			</tr>
			<%

			AttentionDao dao = new AttentionDao();
			List<Attention> atts = dao.selectList(u.getId());
			for (Attention att : atts) {
			%>
			<tr>

				<td><%=att.getId()%></td>
				<td><%=att.getMarstNickName()%></td>
				<td><%=att.getUserNickName()%></td>
				<td><a href="list.jsp?marstid=<%=att.getMarstId()%>">看博主</a> <a
					href="att_del_do.jsp?id=<%=att.getId()%>">取消关注</a></td>
			</tr>
			<%
				}
			%>
		</tbody>
	</table>
</body>
</html>