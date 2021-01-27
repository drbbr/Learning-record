<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.sql.*"%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>收藏夹</title>
</head>
<body>
    <h1><%=(String)session.getAttribute("nickname")%></h1>
    <table border="1px" width="60%">
        <tr>
            <th>编号</th>
            <th>相片</th>
            <th>标题</th>
            <th>操作</th>
        </tr>
        <%
            int userid=(Integer)session.getAttribute("userid");
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn=DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/gd_photo?useSSL=false&serverTimezone=UTC"
                ,"root","123456");
        PreparedStatement pstmt=conn.prepareStatement("select * from photos where photo_id in(select fav_photo_id from favs where fav_user_id=?)");
        pstmt.setInt(1,userid);
        ResultSet rs=pstmt.executeQuery();
        while(rs.next())
        {
            %>
        <tr>
            <td><%=rs.getInt(1)%></td>
            <td><img src="<%=rs.getString(3)%>" width="60px" height="80px" /></td>
            <td><%=rs.getString(2) %></td>
            <td>
            <a href="favs_del_do.jsp?photoid=<%=rs.getInt(1)%>" onclick="return confirm('你确定要取消吗？');">取消收藏</a>
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