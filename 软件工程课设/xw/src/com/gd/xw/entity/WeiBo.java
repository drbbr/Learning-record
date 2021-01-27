package com.gd.xw.entity;

import java.sql.Date;

public class WeiBo {
	private int id;
	private int userId;
	private String title;
	private String content;
	private Date createTime;
	private int readCount;
	private String img;
	private String nickName;
	
	public String getNickName(){
		return nickName;
	}
	
	public void setNickName(String nickName) {
		this.nickName=nickName;
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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

	public void setCreateTime(Date date) {
		this.createTime = date;
	}

	public int getReadCount() {
		return readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}
}
