package com.hk.controller;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hk.daos.LoginDao;
import com.hk.dtos.LoginDto;


@WebServlet("/LoginController.do")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String command=request.getParameter("command");
	      
	      LoginDao dao=new LoginDao();
	      
	      if(command.equals("login")) {
	         String id=request.getParameter("id");
	         String password=request.getParameter("pw");
	         
	         LoginDto ldto=dao.getLogin(id, password);
	         
	         if(ldto==null||ldto.getId()==null) {
	            String msg="회원정보를 확인하세요";
	            response.sendRedirect("error.jsp?msg="+URLEncoder.encode(msg, "utf-8"));
	         } else {
	            //session 스코프에 로그인 정보 담기
	            request.getSession().setAttribute("ldto", ldto);
	            request.getSession().setMaxInactiveInterval(10*60);//10분 지나면 세션 날리기
	            
	            if(ldto.getRole().toUpperCase().equals("ADMIN")) {
	               response.sendRedirect("error.jsp");
	            } else if(ldto.getRole().toUpperCase().equals("MANAGER")) {
	               response.sendRedirect("userMain.jsp");
	            } else if(ldto.getRole().toUpperCase().equals("USER")) {
	               response.sendRedirect("userMain.jsp");
	            }
	         }
	      } else if(command.equals("logout")) {//로그아웃을 눌렀을때
	         request.getSession().invalidate();
	         response.sendRedirect("index.jsp");
	      }else if(command.equals("regist")) {
	    	  	String id=request.getParameter("id");
		        String password=request.getParameter("password");
		        String name=request.getParameter("name");
		        String address=request.getParameter("address");
		        String phone=request.getParameter("phone");
		        String email=request.getParameter("email");
		        
		        boolean isS = dao.insertUser(new LoginDto(id,password,name,address,phone,email,null,null));
		       
		        if(isS) {	
		        	response.sendRedirect("index.jsp");
		        }else {
		        	response.sendRedirect("error.jsp");
		        }
	      }
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
