package com.hk.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hk.daos.CalDao;
import com.hk.dtos.CalDto;
import com.hk.dtos.LoginDto;
import com.hk.utils.Util;


@WebServlet("/CalController.do")
public class CalController extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String command=request.getParameter("command");
		CalDao dao=new CalDao();
		HttpSession session=request.getSession();
		
		if(command.equals("calendar")) {
			if(session.getAttribute("ldto")==null) {
				response.sendRedirect("index.jsp?msg="+URLEncoder.encode("로그인이 필요합니다..","utf-8"));
			}else {
				LoginDto dto = (LoginDto)session.getAttribute("ldto");
				String year = request.getParameter("year");
				String month = request.getParameter("month");
				
				if(year == null) {
					Calendar cal = Calendar.getInstance();
					year = cal.get(Calendar.YEAR)+"";
					month = cal.get(Calendar.MONTH)+1+"";
				}
				
				String id = dto.getId();
				String yyyyMM = year+Util.isTwo(month);
				
				List<CalDto> list = dao.calBoardListView(id, yyyyMM);
				request.setAttribute("list", list);
				dispatch("calendar.jsp", request, response);
			}
		}else if(command.equals("calinsertform")) {
			if(session.getAttribute("ldto")==null) {
				response.sendRedirect("index.jsp?msg="+URLEncoder.encode("로그인이 필요합니다..","utf-8"));
			}else {
				dispatch("calinsert.jsp", request, response);
			}
		}else if(command.equals("calinsert")) {
			String year=request.getParameter("year");
			String month=request.getParameter("month");
			String date=request.getParameter("date");
			String hour=request.getParameter("hour");
			String min=request.getParameter("min");
			
			String mdate=year+Util.isTwo(month)+Util.isTwo(date)+Util.isTwo(hour)+Util.isTwo(min);
			String id=request.getParameter("id");
			String title=request.getParameter("title");
			String content=request.getParameter("content");
			
			boolean isS=dao.calInsert(new CalDto(0,id,title,content,mdate,null));
			if(isS) {
				response.sendRedirect("CalController.do?command=calendar&year="+year+"&month="+month);
			}else {
				response.sendRedirect("error.jsp?msg="+URLEncoder.encode("일정추가실패", "utf-8"));
			}
		}else if(command.equals("callist")) {
			if(session.getAttribute("ldto")==null) {
				response.sendRedirect("index.jsp");
			}else {
				LoginDto ldto = (LoginDto)session.getAttribute("ldto");
				
				String year = request.getParameter("year");
				String month=request.getParameter("month");
				String date=request.getParameter("date");
				
				String id=ldto.getId();
				String ymd=year+Util.isTwo(month)+Util.isTwo(date);
				
				List<CalDto>list = dao.getCalBoardList(id, ymd);
				request.setAttribute("list", list);
				dispatch("calboardlist.jsp", request, response);
			}
		}else if(command.equals("muldel")) {
			String[] seqs=request.getParameterValues("seq");
			
			String year=request.getParameter("year");
			String month=request.getParameter("month");
			String date=request.getParameter("date");
			boolean isS=dao.mulDel(seqs);
			if(isS) {
				response.sendRedirect("CalController.do?command=callist"
						+"&year="+year+"&month="+month+"&date="+date);
			}else {
				response.sendRedirect("error.jsp?msg="
									+URLEncoder.encode("글삭제실패", "utf-8"));
			}
		}else if(command.equals("caldetail")) {
			int seq=Integer.parseInt(request.getParameter("seq"));
			CalDto dto=dao.calDetail(seq);
			
			request.setAttribute("dto", dto);
			dispatch("caldetail.jsp", request, response);
		}else if(command.equals("calupdateform")) {//일정수정폼이동
			int seq=Integer.parseInt(request.getParameter("seq"));
			CalDto dto=dao.calDetail(seq);
			
			request.setAttribute("dto", dto);
			dispatch("calupdate.jsp", request, response);
		}else if(command.equals("calupdate")) {//일정수정하기
			int seq=Integer.parseInt(request.getParameter("seq"));
			String year=request.getParameter("year");
			String month=request.getParameter("month");
			String date=request.getParameter("date");
			String hour=request.getParameter("hour");
			String min=request.getParameter("min");
			
			String mdate=year+Util.isTwo(month)+Util.isTwo(date)+Util.isTwo(hour)+Util.isTwo(min);
			
			String title=request.getParameter("title");
			String content=request.getParameter("content");
			
			boolean isS=dao.calUpdate(new CalDto(seq, null, title, content, mdate, null));
			if(isS) {
				response.sendRedirect("CalController.do?command=caldetail"
						+"&seq="+seq+"&year="+year+"&month="+month+"&date="+date);
			}else {
				response.sendRedirect("error.jsp?msg="
									+URLEncoder.encode("글수정실패", "utf-8"));
			}
		}else if(command.equals("calCount")) {
			String year=request.getParameter("year");
			String month=request.getParameter("month");
			String date=request.getParameter("date");
			
			String yyyyMMdd=year+Util.isTwo(month)+Util.isTwo(date);
			String id=((LoginDto)session.getAttribute("ldto")).getId();
			
			int count=dao.calListCount(id, yyyyMMdd);
			PrintWriter pw=response.getWriter();
			pw.print(count);
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}
	
	public void dispatch(String url, HttpServletRequest request,HttpServletResponse response) 
			throws ServletException, IOException{
		RequestDispatcher dispatch=request.getRequestDispatcher(url);
		dispatch.forward(request, response);
	}
	
	

}
