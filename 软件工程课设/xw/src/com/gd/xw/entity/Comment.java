package com.gd.xw.entity;

import java.util.Date;

public class Comment {
	private int id;
	private int weiboId;
	private int userId;
	private String content;
	private Date createTime;
	private String userNickName;
	
	public String getUserNickName() {
		return userNickName;
	}
	public void setUserNickName(String userNickName) {
		this.userNickName = userNickName;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getWeiboId() {
		return weiboId;
	}
	public void setWeiboId(int weiboId) {
		this.weiboId = weiboId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
}
