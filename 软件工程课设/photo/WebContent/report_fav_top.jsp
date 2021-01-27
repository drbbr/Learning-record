<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.column{background-color:red;height: 20px;margin: 20px;}
th{border-bottom: 2px solid #ccc;}
td{border-bottom: 1px solid #ccc;text-align: center;}
</style>
</head>
<body>
    <h1>最受欢迎图片Top5</h1>
    <div>
        <table width="60%">
            <tr>
                <th>相片</th>
                <th>标题</th>
                <th>收藏量</th>
                <th>图形</th>
            </tr>
            <%
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn=DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/gd_photo?useSSL=false&serverTimezone=UTC"
                        ,"root","123456");
                PreparedStatement pstmt=conn.prepareStatement(
                        "select p.photo_id,p.photo_title,p.photo_url,count(f.fav_id) total from favs f"
                        +" join photos p on f.fav_photo_id=p.photo_id "
                        +" group by f.fav_photo_id "
                        +" order by total desc limit 5");
                ResultSet rs=pstmt.executeQuery();
                while(rs.next())
                {
            %>
            <tr>
                <td><a href="detail.jsp?pid=<%=rs.getInt(1)%>"><img src="<%=rs.getString(3)%>" width="60px" height="80px" /></a></td>

                <td><%=rs.getString(2)%></td>
                <td><%=rs.getInt(4)%>
                </td>
                <td><div class="column" style="width: <%=rs.getInt(4)*10%>px"></div></td>
            </tr>
            <%
                }
                pstmt.close();
                conn.close();
            %>
        </table>
    </div>
</body>
</html>