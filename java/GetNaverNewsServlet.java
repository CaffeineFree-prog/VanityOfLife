package naver.api.servlet;

import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import naver.api.util.*;


@WebServlet("/getnews")
public class GetNewsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//request info
		response.setCharacterEncoding("utf-8");
		
		String keyword 		= request.getParameter("keyword");
		String currentPage  = request.getParameter("currentPage");
		int display 	= 10;
		int start 		= Integer.parseInt(currentPage);               
		
		GetNaverNews getNaverNews = new GetNaverNews();

		String data = getNaverNews.searchNews(keyword, display, start);

		//text/html, application/xml, application/json
		response.setContentType("application/json;charset=utf-8");

		
		PrintWriter out = response.getWriter();
		out.print(data);
		out.flush();
		out.close();
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
