<%@page import="com.hk.dtos.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<%
   LoginDto ldto=(LoginDto)session.getAttribute("ldto");

   if(ldto==null){
      pageContext.forward("index.jsp");
   }
%>
<body>
	<h1>마이페이지</h1>
	<div>
		<span><%=ldto.getId()%></span>님 환영합니다.
		(등급:<%=ldto.getRole().equals("USER")?"일반회원":"노예회원"%>)
 		<a href="LoginController.do?command=logout">로그아웃</a>
	</div>
	<div>
		<ul>
			<li>
				<a href="BoardController.do?command=boardlist">제품 소통방</a>
			</li>
			<li>
				<a href="CalController.do?command=calendar">제품 상담일정 예정하기</a>
			</li>
			<li>
				<a href="#">제품 비교하러 가기</a>
			</li>
		</ul>
	</div>
</body>
</html>






