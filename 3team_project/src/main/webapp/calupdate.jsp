<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>일정 수정하기</h1>
<form action="CalController.do" method="post">
   <input type="hidden" name="command" value="calupdate">
    <input type="hidden" name="seq" value="${dto.seq}">
   <table border="1">
      <tr>
        <th>이름</th>
			<td>${dto.loginDto.name}</td>
      </tr>
      <tr>
         <th>일정</th>  
         <td>

				<select name="year" >
					<c:set var="yearP"  value="${fn:substring(dto.mdate,0,4)}"/>
					<c:forEach var="i" begin="${yearP-5}" end="${yearP+5}" step="1">
						<option ${yearP==i?"selected":""} value="${i}">${i}</option>						
					</c:forEach>
				</select>년
				<select name="month">
					<c:set var="monthP"  value="${fn:substring(dto.mdate,4,6)}"/>
					<c:forEach var="i" begin="1" end="12" step="1" >
					<option ${monthP==i?"selected":""} value="${i}">${i}</option>						
					</c:forEach>
				</select>월
				<select name="date">
					<c:set var="dateP"  value="${fn:substring(dto.mdate,6,8)}"/>
					<c:forEach var="i" begin="1" end="31" step="1" >
					<option ${dateP==i?"selected":""} value="${i}">${i}</option>						
					</c:forEach>
				</select>일
				<select name="hour">
					<c:set var="hourP"  value="${fn:substring(dto.mdate,8,10)}"/>
					<c:forEach var="i" begin="0" end="23" step="1" >
					<option ${hourP==i?"selected":""} value="${i}">${i}</option>						
					</c:forEach>
				</select>시
				<select name="min">
					<c:set var="minP"  value="${fn:substring(dto.mdate,10,12)}"/>
					<c:forEach var="i" begin="0" end="59" step="1" >
					<option ${minP==i?"selected":""} value="${i}">${i}</option>						
					</c:forEach>
				</select>분
         </td>
      </tr>
      <tr>
         <th>제목</th>
         <td><input type="text" name="title" required="required" value="${dto.title}"></td>
      </tr>
      <tr>
         <th>내용</th>
         <td><textarea rows="10" cols="60" required="required" name="content">${dto.content}</textarea></td>
      </tr>
      <tr>
         <td colspan="2">
            <input type="submit" value="수정완료">
            <input type="button" value="back" onclick="location.href='CalController.do?command=caldetail&seq=${dto.seq}&year=${param.year}&month=${param.month}&date=${param.date}'" />
         </td>
      </tr>
   </table>
</form>
</body>
</html>






