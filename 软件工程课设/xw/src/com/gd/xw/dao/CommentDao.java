package com.gd.xw.dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.gd.xw.entity.*;

public class CommentDao {
	public List<Comment> selectListByWeibo(int wbid)
	{
		List<Comment> list=new ArrayList<Comment>();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			Connection conn=DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/gd_weibo?useSSL=false&serverTimezone=UTC"
				,"root","123456");
			PreparedStatement pstmt=conn.prepareStatement(
				"select c.*,u.user_nickname from comments c" + 
				" join users u on u.user_id=c.cm_userid" +  
				" where c.cm_weiboid=? "+
				" order by cm_createTime desc");
			pstmt.setInt(1, wbid);
			ResultSet rs=pstmt.executeQuery();
			while(rs.next())
			{
				Comment cm=new Comment();
				cm.setId(rs.getInt(1));
				cm.setWeiboId(rs.getInt(2));
				cm.setUserId(rs.getInt(3));
				cm.setContent(rs.getString(4));
				cm.setCreateTime(rs.getTimestamp(5));
				cm.setUserNickName(rs.getString(6));
				
				list.add(cm);
			}
			rs.close();
			pstmt.close(); 
			conn.close();
			return list;
		}
		catch(Exception e)
		{
			throw new RuntimeException("查询不成功",e);
		}
	}
	
	public void insert(int wbid,String content,int userid)
	{
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			Connection conn=DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/gd_weibo?useSSL=false&serverTimezone=UTC"
				,"root","123456");
			PreparedStatement pstmt=conn.prepareStatement(
				"insert into comments values(default,?,?,?,now())");
			pstmt.setInt(1,wbid);
			pstmt.setInt(2, userid);
			pstmt.setString(3,content);
			pstmt.executeUpdate(); 
			pstmt.close(); 
			conn.close();
		}
		catch(Exception e)
		{
			throw new RuntimeException("插入不成功",e);
		}
	}
	
}
