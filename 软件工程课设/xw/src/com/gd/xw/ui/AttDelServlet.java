package com.gd.xw.ui;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gd.xw.entity.User;
import com.gd.xw.dao.*;
/**
 * Servlet implementation class AttDelServlet
 */
@WebServlet("/att_del_do")
public class AttDelServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		User u=(User)request.getSession().getAttribute("user");
        if(u==null)
        {
        	response.sendRedirect("login.jsp");
        	return;
        }
        int id=Integer.parseInt(request.getParameter("id"));
        AttentionDao dao=new AttentionDao();
        dao.delete(id);
        response.sendRedirect("att_list.jsp");
	}

}
