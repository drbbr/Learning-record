package com.gd.xw.dao;
import com.gd.xw.entity.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class WeiBoDao {
	
	public void insertWeibo(String title,String content,String img,int userId) {
	
		try {
		Class.forName("com.mysql.cj.jdbc.Driver"); 
		Connection conn=DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/gd_weibo?useSSL=false&serverTimezone=UTC"
			,"root","123456");
		PreparedStatement pstmt=conn.prepareStatement(
			"insert into weibos values(default,?,?,?,now(),0,?)");
		pstmt.setInt(1,userId);
		pstmt.setString(2,title); 
		pstmt.setString(3,content);
		pstmt.setString(4,img);
		pstmt.executeUpdate(); 
		pstmt.close(); 
		conn.close();
	}
	catch(Exception e)
	{
		throw new RuntimeException("插入不成功",e);
	}
}
	
	public List<WeiBo> selectList()
	{
		List<WeiBo> list=new ArrayList();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			Connection conn=DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/gd_weibo?useSSL=false&serverTimezone=UTC"
					,"root","123456");
			PreparedStatement pstmt=conn.prepareStatement(
					"select wb.*,u.user_nickname from weibos wb join users u on wb.wb_userid=u.user_id  order by wb_createTime desc");
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()) {
				WeiBo wb=new WeiBo();
				wb.setId(rs.getInt(1));
				wb.setUserId(rs.getInt(2));
				wb.setTitle(rs.getString(3));
				wb.setContent(rs.getString(4));
				wb.setCreateTime(rs.getDate(5));
				wb.setReadCount(rs.getInt(6));
				wb.setImg(rs.getString(7));
				wb.setNickName(rs.getString(8));
				list.add(wb);
			}
			rs.close();
			pstmt.close(); 
			conn.close();
			return list;
		}
		catch(Exception e)
		{
			throw new RuntimeException("查询有问题",e);
		}
		
	}

	public WeiBo selectOne(int id)
	{
		WeiBo wb=null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			Connection conn=DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/gd_weibo?useSSL=false&serverTimezone=UTC"
					,"root","123456");
			PreparedStatement pstmt=conn.prepareStatement(
					"select wb.*,u.user_nickname from weibos wb join users u on wb.wb_userid=u.user_id where wb_id=?");
			
			pstmt.setInt(1, id);
			ResultSet rs=pstmt.executeQuery();
			
			while(rs.next()) {
				wb=new WeiBo();
				wb.setId(rs.getInt(1));
				wb.setUserId(rs.getInt(2));
				wb.setTitle(rs.getString(3));
				wb.setContent(rs.getString(4));
				wb.setCreateTime(rs.getDate(5));
				wb.setReadCount(rs.getInt(6));
				wb.setImg(rs.getString(7));
				wb.setNickName(rs.getString(8));
				
			}
			rs.close();
			pstmt.close(); 
			conn.close();
			return wb;
		}
		catch(Exception e)
		{
			throw new RuntimeException("查询有问题",e);
		}
	}

	public List<WeiBo> selectListByMarst(int marstid)
	{
		List<WeiBo> list=new ArrayList<WeiBo>();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			Connection conn=DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/gd_weibo?useSSL=false&serverTimezone=UTC"
					,"root","123456");
			PreparedStatement pstmt=conn.prepareStatement(
					"select wb.*,u.user_nickname from weibos wb join users u on wb.wb_userid=u.user_id where wb.wb_userid=? order by wb_createTime desc");
			pstmt.setInt(1, marstid);
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()) {
				WeiBo wb=new WeiBo();
				wb.setId(rs.getInt(1));
				wb.setUserId(rs.getInt(2));
				wb.setTitle(rs.getString(3));
				wb.setContent(rs.getString(4));
				wb.setCreateTime(rs.getDate(5));
				wb.setReadCount(rs.getInt(6));
				wb.setImg(rs.getString(7));
				wb.setNickName(rs.getString(8));
				list.add(wb);
			}
			rs.close();
			pstmt.close(); 
			conn.close();
			return list;
		}
		catch(Exception e)
		{
			throw new RuntimeException("查询有问题",e);
		}
	}

}
