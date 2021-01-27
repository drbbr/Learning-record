package com.gd.xw.entity;

public class Attention {
	private int id;
	private int userId;
	private int marstId;
	private String userNickName;
	private String marstNickName;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUserNickName() {
		return userNickName;
	}
	public void setUserNickName(String userNickName) {
		this.userNickName = userNickName;
	}
	public String getMarstNickName() {
		return marstNickName;
	}
	public void setMarstNickName(String marstNickName) {
		this.marstNickName = marstNickName;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getMarstId() {
		return marstId;
	}
	public void setMarstId(int marstId) {
		this.marstId = marstId;
	}
}
