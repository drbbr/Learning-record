package com.gd.xw.ui;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.gd.xw.dao.*;
import com.gd.xw.entity.User;
/**
 * Servlet implementation class AttAddServlet
 */
@WebServlet("/att_do")
public class AttAddServlet extends HttpServlet {
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
        AttentionDao dao=new AttentionDao();
        int marstid=Integer.parseInt(request.getParameter("marstid"));
        //已经关注过他
        if(dao.attOrNot(u.getId(),marstid))
        {
        	response.sendRedirect("att_list.jsp");
        	return;
        }
        
        //文章作者不是我
        if(marstid!=u.getId())
        {    
    	    dao.insert(u.getId(),marstid);
    	    response.sendRedirect("att_list.jsp");
    		return;
    	}
	}

}
