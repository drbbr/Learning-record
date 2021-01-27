package com.gd.xw.ui;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gd.xw.dao.CommentDao;
import com.gd.xw.entity.User;

/**
 * Servlet implementation class CmAddServlet
 */
@WebServlet("/cm_add_do")
public class CmAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		User u = (User) request.getSession().getAttribute("user");
		if (u == null) {
			response.sendRedirect("login.jsp");
			return;
		}
		request.setCharacterEncoding("utf-8");
		int wbid = Integer.parseInt(request.getParameter("wbid"));
		String content = request.getParameter("content");
		CommentDao dao = new CommentDao();
		dao.insert(wbid, content, u.getId());
		response.sendRedirect("detail.jsp?id=" + wbid);
	}

}
