<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head>
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    
<title>注册</title>
<style>
    form span{display:inline-block;width:80px;text-align:right}
   #main{margin:100px auto;border:1px solid #ccc;width:350px;padding:0 30px  30px 30px}
   form a{font-size:12px;float:right;margin-right:50px;}
 </style>
</head>
<body>
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
  <div id="main">
        <h2>注册小微系统</h2>
        <hr color="#ccc"><br>
       <form action="reg" method="post">
       		<span>昵称:</span> <input name="nickname" type="text"><br><br>
            <span>用户名:</span> <input name="uname" type="text"><br><br>
            <span>密码:</span> <input name="upwd" type="password"><br><br>
            <span></span><input class="btn btn-primary" value="注册" type="submit">
        
       </form>
    </div>

</body></html>