package com.gd.xw.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.gd.xw.entity.*;

public class AttentionDao {
	public void insert(int userId, int marstId) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/gd_weibo?useSSL=false&serverTimezone=UTC", "root", "123456");
			PreparedStatement pstmt = conn.prepareStatement("insert into attentions values(default,?,?)");
			pstmt.setInt(1, userId);
			pstmt.setInt(2, marstId);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			throw new RuntimeException("插入不成功", e);
		}
	}

	public List<Attention> selectList(int userid) {
		List<Attention> list = new ArrayList<Attention>();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/gd_weibo?useSSL=false&serverTimezone=UTC", "root", "123456");
			PreparedStatement pstmt = conn
					.prepareStatement("select a.*,u.user_nickname,u2.user_nickname from attentions a"
							+ " join users u on a.att_userid=u.user_id" + " join users u2 on a.att_marstid=u2.user_id"
							+ " where att_userid=?");
			pstmt.setInt(1, userid);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Attention att = new Attention();
				att.setId(rs.getInt(1));
				att.setUserId(rs.getInt(2));
				att.setMarstId(rs.getInt(3));
				att.setUserNickName(rs.getString(4));
				att.setMarstNickName(rs.getString(5));

				list.add(att);
			}
			rs.close();
			pstmt.close();
			conn.close();
			return list;
		} catch (Exception e) {
			throw new RuntimeException("查询不成功", e);
		}
	}

	public void delete(int id) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/gd_weibo?useSSL=false&serverTimezone=UTC", "root", "123456");
			PreparedStatement pstmt = conn.prepareStatement("delete from attentions where att_id=?");
			pstmt.setInt(1, id);

			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			throw new RuntimeException("删除不成功", e);
		}
	}

	public boolean attOrNot(int userId, int marstId) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/gd_weibo?useSSL=false&serverTimezone=UTC", "root", "123456");
			PreparedStatement pstmt = conn
					.prepareStatement("select * from attentions where att_userid=? and att_marstid=?");
			pstmt.setInt(1, userId);
			pstmt.setInt(2, marstId);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				pstmt.close();
				conn.close();
				return true;
			} else {
				pstmt.close();
				conn.close();
				return false;
			}
		} catch (Exception e) {
			throw new RuntimeException("插入不成功", e);
		}
	}

	public List<Attention> selectFansList(int userid) {
		List<Attention> list = new ArrayList<Attention>();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/gd_weibo?useSSL=false&serverTimezone=UTC", "root", "123456");
			PreparedStatement pstmt = conn
					.prepareStatement("select a.*,u.user_nickname,u2.user_nickname from attentions a"
							+ " join users u on a.att_userid=u.user_id" 
							+ " join users u2 on a.att_marstid=u2.user_id"
							+ " where att_marstid=?");
			pstmt.setInt(1, userid);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Attention att = new Attention();
				att.setId(rs.getInt(1));
				att.setUserId(rs.getInt(2));
				att.setMarstId(rs.getInt(3));
				att.setUserNickName(rs.getString(4));
				att.setMarstNickName(rs.getString(5));

				list.add(att);
			}
			rs.close();
			pstmt.close();
			conn.close();
			return list;
		} catch (Exception e) {
			throw new RuntimeException("查询不成功", e);
		}
	}
}
