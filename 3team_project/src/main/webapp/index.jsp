<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인화면</title>
<script type="text/javascript">
	function registForm() {
		location.href = "regist.jsp";
	}
</script>
</head>
<body>
	<h1>로그인</h1>
	<form action="LoginController.do" method="post">
	 <input type="hidden" name="command" value="login"/>
		<div class="table">
         <div class="tr">
            <div class="td">아이디</div>
            <div class="td"><input type="text" name="id"/></div>
         </div>
         <div class="tr">
            <div class="td">비밀번호</div>
            <div class="td"><input type="password" name="pw"/></div>
         </div>
         <div class="tr">
            <div class="td colspan">
               <input type="submit" value="로그인"/>
               <input type="button" value="회원가입" onclick="registForm()"/>
            </div>
         </div>
      </div>
	</form>
</body>
</html>






