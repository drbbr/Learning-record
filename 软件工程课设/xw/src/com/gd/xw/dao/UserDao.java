package com.gd.xw.dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.gd.xw.entity.*;

public class UserDao {

	public User login(String name,String pwd)
	{
		User u=null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			Connection conn=DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/gd_weibo?useSSL=false&serverTimezone=UTC"
					,"root","123456");
			PreparedStatement pstmt=conn.prepareStatement(
					"select * from users where user_loginname=? and user_loginpwd=?");
			
			pstmt.setString(1, name);
			pstmt.setString(2, pwd);
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()) {
				u=new User();
				u.setId(rs.getInt(1));
				u.setNickName(rs.getString(2));
				u.setLoginName(rs.getString(3));
				u.setLoginPwd(rs.getString(4));
				u.setPhoto(rs.getString(5));
				u.setScore(rs.getInt(6));
				u.setAttionCount(rs.getInt(7));
				
			}
			rs.close();
			pstmt.close(); 
			conn.close();
			return u;
		}
		catch(Exception e)
		{
			throw new RuntimeException("查询有问题",e);
		}
	}

	public boolean reg(String nickname, String name, String pwd) {
		// TODO Auto-generated method stub
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			Connection conn=DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/gd_weibo?useSSL=false&serverTimezone=UTC"
					,"root","123456");
			PreparedStatement pstmt=conn.prepareStatement(
					"insert into users values(default,?,?,?,default,default,default)");
			pstmt.setString(1, nickname);
			pstmt.setString(2, name);
			pstmt.setString(3, pwd);
			pstmt.executeUpdate(); 
			pstmt.close(); 
			conn.close();
			return true;
		}
		catch(Exception e)
		{
			throw new RuntimeException("注册失败",e);
		}
		
	}
}
