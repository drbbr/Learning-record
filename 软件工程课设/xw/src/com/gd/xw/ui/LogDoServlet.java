package com.gd.xw.ui;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.gd.xw.dao.UserDao;
import com.gd.xw.entity.User;

/**
 * Servlet implementation class LogDoServlet
 */
@WebServlet("/log")
public class LogDoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
	    String name=request.getParameter("uname");
	    String pwd=request.getParameter("upwd");
	    
	    UserDao dao=new UserDao();
	    User u=dao.login(name,pwd);
	    if(u==null)
	    {
	    	response.sendRedirect("login.jsp");
	    }
	    else
	    {
	    	request.getSession().setAttribute("user",u);
	    	response.sendRedirect("list.jsp");
	    }
	}

}
