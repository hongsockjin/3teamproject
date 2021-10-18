package com.hk.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hk.daos.BoardDao;
import com.hk.dtos.BoardDto;


@WebServlet("/BoardController.do")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
	    response.setContentType("text/html;charset=utf-8");
	    
	    String command=request.getParameter("command");
	    
	    BoardDao dao = new BoardDao();
	    
	    if(command.equals("main")) {
	    	response.sendRedirect("userMain.jsp");
	    }else if(command.equals("boardlist")) {
	    	 List<BoardDto> list=dao.getBoardList();
	         
	         request.setAttribute("list", list);
	    	
	    	RequestDispatcher dispatch = request.getRequestDispatcher("boardlist.jsp");
	    	dispatch.forward(request, response);
	    }else if(command.equals("insertform")) {
	    	response.sendRedirect("insertboard.jsp");
	    }else if(command.equals("insertboard")) {
	    	String id=request.getParameter("id");
	        String title=request.getParameter("title");
	        String content=request.getParameter("content");
	        
	        boolean isS = dao.insertBoard(new BoardDto(id,title,content));
	        if(isS) {
	        	response.sendRedirect("BoardController.do?command=boardlist");
	        }else {
	        	request.setAttribute("msg", "글추가실패");
	            RequestDispatcher dispatch=request.getRequestDispatcher("error.jsp");
	            dispatch.forward(request, response);
	        }
	    }else if(command.equals("detailboard")) {
	    	String seq = request.getParameter("seq");
	    	int sseq = Integer.parseInt(seq);
	    	BoardDto dto = dao.getBoard(sseq);
	    	
	    	request.setAttribute("dto", dto);
	    	RequestDispatcher dispatch=request.getRequestDispatcher("detailboard.jsp");
	        dispatch.forward(request, response);
	    }else if(command.equals("muldel")) {
	    	String[] seqs = request.getParameterValues("chk");
	    	
	    	boolean isS = dao.mulDel(seqs);
	    	
	    	if(isS) {
	    		String alram = "<script type='text/javascript'>"
	    				+ "alert('글이 삭제 됩니다~.');"
	    				+ "location.href='BoardController.do?command=boardlist';"
	    				+ "</script>";
	    	PrintWriter pw = response.getWriter();
	    	pw.print(alram);
	    	}else {
	    		request.setAttribute("msg", "글삭제에 실패 하였습니다..");
	    		RequestDispatcher dispatch=request.getRequestDispatcher("error.jsp");
	            dispatch.forward(request, response);
	    	}
	    }else if(command.equals("updateform")) {
	    	String seq = request.getParameter("seq");
	    	BoardDto dto = dao.getBoard(Integer.parseInt(seq));
	    	
	    	request.setAttribute("dto", dto);
	    	RequestDispatcher dispatch=request.getRequestDispatcher("updatboard.jsp");
	        dispatch.forward(request, response);
	    }else if(command.equals("updateboard")) {
	    	String seq=request.getParameter("seq");
	        String title=request.getParameter("title");
	        String content=request.getParameter("content");
	        int sseq = Integer.parseInt(seq);
	        
	        boolean isS = dao.updateBoard(new BoardDto(sseq,title,content));
	        
	        if(isS) {
	        	response.sendRedirect("BoardController.do?command=detailboard&seq="+seq);
	        }else {
	        	request.setAttribute("msg", "글수정에 실패하였습니다..");
	        	RequestDispatcher dispatch=request.getRequestDispatcher("erorr.jsp");
	            dispatch.forward(request, response);
	        }
	    }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
