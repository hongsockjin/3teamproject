<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>회원가입하기</h1>
	<form action="LoginController.do" method="post">
		<input type="hidden" name="command" value="regist"/>
		<div class="table">
			<div class="tr">
				<div class="td">아이디</div>
				<div class="td">
					<input type="text" name="id" title="n" required="required" autocomplete="off"/>
				</div>
			</div>
			<div class="tr">
				<div class="td">비밀번호</div>
				<div class="td">
					<input type="password" name="password" required="required"/>
				</div>
			</div>
			<div class="tr">
				<div class="td">이름</div>
				<div class="td">
					<input type="text" name="name" required="required"/>
				</div>
			</div>
			<div class="tr">
				<div class="td">주소</div>
				<div class="td">
					<input type="text" name="address" required="required"/>
				</div>
			</div>
			<div class="tr">
				<div class="td">전화번호</div>
				<div class="td">
					<input type="tel" name="phone" required="required"/>
				</div>
			</div>
			<div class="tr">
				<div class="td">이메일</div>
				<div class="td">
					<input type="email" name="email" required="required"/>
				</div>
			</div>
			<div class="tr">
				<div class="td">
					<input type="submit" value="가입">
					<input type="button" value="취소" onclick="location.href='index.jsp'"/>
				</div>
			</div>
		</div>
	</form>
</body>
</html>






