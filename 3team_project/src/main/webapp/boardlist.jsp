<%@page import="com.hk.dtos.BoardDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript">
	function allSel(bool) {
		var chks = document.getElementsByName("chk");
		for (var i = 0; i < chks.length; i++) {
			chks[i].checked = bool;
		}
	}
</script>
</head>
<%
	
	List<BoardDto> list =(List<BoardDto>)request.getAttribute("list");

	if(list==null){
		request.setAttribute("msg", "요청글에 대한 정보가 없습니다.");
		pageContext.forward("error.jsp");
	}
%>
<body>
	<h1>게시판 글목록</h1>
	<form action="BoardController.do" method="post">
	<input type="hidden" name="command" value="muldel"/>
	<table border="1">
		<col width="30px">
		<col width="50px">
		<col width="100px">
		<col width="300px">
		<col width="200px">
		<tr>
			<th><input type="checkbox" name="all" onclick="allSel(this.checked)"/></th>
			<th>번호</th><th>작성자</th><th>제목</th><th>작성일</th>
		</tr>
		<%
			for(int i=0; i<list.size();i++){
				BoardDto dto = list.get(i);
				%>
				<tr>
					<td><input type="checkbox" name="chk" value="<%=dto.getSeq()%>"></td>
					<td><%=dto.getSeq()%></td>
					<td><%=dto.getId()%></td>
					<td><a href="BoardController.do?command=detailboard&seq=<%=dto.getSeq()%>"><%=dto.getTitle()%></a></td>
					<td><%=dto.getRegdate()%></td>
				</tr>
				<%
			}
		%>
		<tr>
			<td colspan="5">
				<a href="BoardController.do?command=insertform"><button type="button">글쓰기</button></a>
				<input type="submit" value="글삭제"/>
				<a href="BoardController.do?command=main"><button type="button">메인</button></a>
			</td>
		</tr>
	</table>
	</form>
</body>
</html>






