<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.sql.*"%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
</head>
<body>
<h1>图片列表</h1>
<table border="1px" width="60%">
    <tr>
        <th>编号</th>
        <th>相片</th>
        <th>标题</th>
        <th>操作<a href="add.jsp">上传</a></th>
    </tr>
    <%
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn=DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/gd_photo?useSSL=false&serverTimezone=UTC"
                ,"root","123456");
        PreparedStatement pstmt=conn.prepareStatement("select * from photos");
        ResultSet rs=pstmt.executeQuery();
        while(rs.next())
        {
    %>
    <tr>
        <td><%=rs.getInt(1)%></td>
        <td><img src="<%=rs.getString(3)%>" width="60px" height="80px" /></td>
        <td><%=rs.getString(2)%></td>
        <td>
            <a href="edit.jsp?id=<%=rs.getInt(1)%>">修改</a>
            <a href="del_do.jsp?id=<%=rs.getInt(1)%>" onclick="return confirm('你确定要删除吗？');">删除</a>

        </td>
    </tr>
    <%
        }
        pstmt.close();
        conn.close();
    %>
</table>
</body>
</html>