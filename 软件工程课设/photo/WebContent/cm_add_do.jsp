<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
<%
    if(session.getAttribute("userid")==null)
    {
        response.sendRedirect("login.html");
        return;
    }

    request.setCharacterEncoding("UTF-8");
    int photoid=Integer.parseInt(request.getParameter("photoid"));
    String cnt=request.getParameter("content");
    int userid=(Integer)session.getAttribute("userid");

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn=DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/gd_photo?useSSL=false&serverTimezone=UTC"
            ,"root","123456");
    PreparedStatement pstmt=conn.prepareStatement(
            "insert into comments values(default,?,?,?)");
    pstmt.setInt(1,photoid);
    pstmt.setString(2,cnt);
    pstmt.setInt(3,userid);
    int n=pstmt.executeUpdate();
    pstmt.close();
    conn.close();

    response.sendRedirect("detail.jsp?pid="+photoid);

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>