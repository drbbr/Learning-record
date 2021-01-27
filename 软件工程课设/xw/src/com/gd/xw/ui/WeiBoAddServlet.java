package com.gd.xw.ui;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.gd.xw.dao.*;
import com.gd.xw.entity.*;

/**
 * Servlet implementation class WeiBoAddServlet
 */
@WebServlet("/add_do")
public class WeiBoAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		request.setCharacterEncoding("UTF-8"); 
		String t=request.getParameter("title"); 
		String c=request.getParameter("content");
		String img=request.getParameter("img");
		
		User u=(User)request.getSession().getAttribute("user");
		WeiBoDao dao=new WeiBoDao();
		dao.insertWeibo(t,c,img,u.getId());
		
		
		response.sendRedirect("list.jsp");
	}

}
