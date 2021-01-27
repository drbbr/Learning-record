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
 * Servlet implementation class RegServlet
 */
@WebServlet("/reg")
public class RegServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		String nickname=request.getParameter("nickname");
	    String name=request.getParameter("uname");
	    String pwd=request.getParameter("upwd");
	    
	    UserDao dao=new UserDao();
	    boolean y=dao.reg(nickname,name,pwd);
	    if(y)
	    {
	    	response.sendRedirect("login.jsp");
	    }
	    else
	    {
	    	
	    	response.sendRedirect("reg.jsp");
	    	
	    }
	
	}

}
