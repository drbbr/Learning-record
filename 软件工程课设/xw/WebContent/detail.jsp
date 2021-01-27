<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="java.util.*,com.gd.xw.dao.*,com.gd.xw.entity.*"
    pageEncoding="UTF-8" %>
   <%
	  	int id=Integer.parseInt(request.getParameter("id"));
	  	WeiBoDao dao=new WeiBoDao();
	  	WeiBo wb=dao.selectOne(id);
	  	User u=(User)session.getAttribute("user");
	  %>  
<!DOCTYPE html>
<html><head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<title>微博详情</title>
<style>
    #main{margin:0 auto;width:50%}
	 table{width:100%;border-spacing: 10px 30px;border-top:1px solid #ccc;border-bottom:1px solid #ccc}
	 th{border-bottom:2px solid #ccc;}
	 td{text-align:left}
	 tr td:first-child{text-align:right;width:30%}
	 tr:last-child td:last-child{padding-left:20px}
	 h1{text-align:center}
	 input[type=text]{border-width:0px 0px 2px 0px;border-color:black}
	 input:focus{border-color:red}
	 ul{margin-left:80px}
	 form{margin-left:100px}
	 	.container-fluid {height: 50px;}
	.navbar {background-color: #8ac4c5;	border-color: #348f48;}
	.newactive {background: #9bdcdc;}
	.cl{background-color: rgba(255,255,255,.1);}
	.table-hover > tbody > tr:hover > td,
	.table-hover > tbody > tr:hover > th {
	background-color: #c5e6d8;
	}
</style>
<script>
    
</script>
</head>
<body style="background-color:#e8f9f5;width:70%;margin:0 auto">
      <h1>微博详情</h1>
<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="collapse navbar-collapse" style="text-align: center;">
				<ul class="nav navbar-nav"
					style="display: inline-block; float: none;">
					<li><a href="list.jsp">首页</a></li>
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
	 
		   <table class="table table-bordered table-hover">
		     <tbody>
			 <tr>
   			   <td>发表人</td>
			   <td><%=wb.getNickName() %></td>
			  </tr>
			  <tr>
   			   <td>标题</td>
			   <td><%=wb.getTitle() %></td>
			  </tr>
			  <tr>
			    <td>微博内容</td>
				<td>
					<%=wb.getContent() %>
				</td>
			  </tr>
			  <tr>
   			   <td>阅读人数</td>
			   <td><%=wb.getReadCount() %></td>
			  </tr>
			  <tr>
   			   <td>创建日期</td>
			   <td><%=wb.getCreateTime() %></td>
			  </tr>
			  <tr>
			    <td>
			    <% if(wb.getUserId()!=u.getId()){%>
				<a href="att_do?marstid=<%=wb.getUserId()%>">关注博主</a><br/>
				<%
					}
				%>
				<a href="list.jsp?marstid=<%=wb.getUserId()%>">他的博文</a>
				<td>
					<a href="list.jsp">返回主页</a>
				</td>
			  </tr>
			</tbody>
		   </table>
	  <ul>
	  <%
	  CommentDao cmdao=new CommentDao();
	  List<Comment> cmlist=cmdao.selectListByWeibo(wb.getId());
	  for(Comment cm:cmlist){
	  %>
	    <li><%=cm.getUserNickName()%>说：<%=cm.getContent() %></li>
		<%} %>
	  </ul>
	  <form action="cm_add_do" method="post" >
	    <span class="lead">我要评论:</span><br/>
	    <input type="hidden" name="wbid" value="<%=wb.getId() %>"/>
	    <textarea class="cl" name="content" cols="30" rows="3"></textarea><br>
		<input class="btn btn-primary" type="submit" value="发表"/>
      </form>

	  

</body></html>