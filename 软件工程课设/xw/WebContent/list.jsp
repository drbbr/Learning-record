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
<title>Insert title here</title>
<style>
	.table>tbody>tr>th {text-align: center;vertical-align:baseline;}
	td {border-bottom: 1px solid #ccc;text-align: center}
	h1 {text-align: center}
	.container-fluid {height: 50px;}
	.navbar {background-color: #8ac4c5;	border-color: #348f48;}
	.newactive {background: #9bdcdc;}
	.table-hover > tbody > tr:hover > td,
	.table-hover > tbody > tr:hover > th {
	background-color: #c5e6d8;
	}


</style>
<script>
	
</script>

</head>
<body style="background-color:#e8f9f5;width:70%;margin:0 auto">
	<h1>微博列表</h1>
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="collapse navbar-collapse" style="text-align: center;">
				<ul class="nav navbar-nav"
					style="display: inline-block; float: none;">
					<li class="newactive"><a href="list.jsp">首页</a></li>
					<li><a href="add.jsp">发表</a></li>
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

	<div>
		<table class="table table-bordered table-hover">

			<tbody>
				<tr>

					<th>编号</th>
					<th>发表人</th>
					<th>标题</th>
					<th>发表时间</th>
					<th>阅读人数</th>
					<th>操作 <a href="add.jsp" class="btn btn-info" >发表微博</a></th>
				</tr>
				<%
					WeiBoDao dao = new WeiBoDao();
				List<WeiBo> wbs = null;
				if (request.getParameter("marstid") == null)
					wbs = dao.selectList();
				else {
					int marstId = Integer.parseInt(request.getParameter("marstid"));
					wbs = dao.selectListByMarst(marstId);
				}
				for (WeiBo w : wbs) {
				%>
				<tr>

					<td><%=w.getId()%></td>
					<td><%=w.getNickName()%></td>
					<td><%=w.getTitle()%></td>
					<td><%=w.getCreateTime()%></td>
					<td><%=w.getReadCount()%></td>
					<td><a href="detail.jsp?id=<%=w.getId()%>">查看详细</a></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</div>

</body>
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script
	src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
</html>