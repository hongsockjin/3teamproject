<%@page import="com.hk.utils.Util"%>
<%@page import="com.hk.dtos.CalDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
	th{
		width: 80px;
	}
	td{
		position: relative;
		height: 80px;
		vertical-align: top;
		overflow: auto;
	}
	a{
		text-decoration: none;
	}
	a > img{
		width: 20px;
		height: 20px;
	}
	img:hover {
		background-color: pink;
	}
	.ctitle{
		background-color: pink;
	}
	/*일정 개수를 출력하느 div*/
	.count{
		position: absolute;
		top: -20px;
		left: 10px;
		background-color: yellow;
		width: 30px;
		height: 30px;
		display: none;
		text-align: center;
		line-height: 30px;
		border-radius: 15px 15px 15px 0px;
	}
</style>
<script type="text/javascript">
$(function(){
	var countA;
	$(".countA").hover(function() {
		console.log("일정 개수 보여 주세요!");

		var year = $("caption > span").eq(0).text().trim();
		var month = $("caption > span").eq(1).text().trim();
		var date = $(this).text().trim();
		countA = $(this);
		$.ajax({
			url:"CalController.do",
			method:"post",
			async:false,
			data:{"command":"calCount",
				  "year":year,
				  "month":month,
				  "date":date
				},
			dataType:"text", 
			success:function(obj){

				countA.parent().find(".count").text(obj).show();
			},
			error:function(){
				console.log("통신실패!!");
			}
		});
	}, function() {
		countA.parent().find(".count").text("").hide();
	});
});
</script>
</head>
<%
	String pYear = request.getParameter("year");
	String pMonth = request.getParameter("month");
	
	Calendar cal = Calendar.getInstance();
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH)+1;

	if(pYear!=null){
		year = Integer.parseInt(pYear);
	}
	if(pMonth!=null){
		month = Integer.parseInt(pMonth);
	}

	if(month>=13){
		year++;
		month= 1;
	}else if(month <=0){
		year--;
		month = 12;
	}

	cal.set(year, month-1, 1);
	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);

	int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

	List<CalDto>list = (List<CalDto>)request.getAttribute("list");
%>
<body>
	<h1>${sessionScope.ldto.name}님의 일정보기</h1>
	<table border="1">
		<caption>
			<a href="CalController.do?command=calendar&year=<%=year-1%>&month=<%=month%>">←</a>
			<a href="CalController.do?command=calendar&year=<%=year%>&month=<%=month-1%>">◀</a>
			<span><%=year%></span>년<span><%=month%></span>월
			<a href="CalController.do?command=calendar&year=<%=year%>&month=<%=month+1%>">▶</a>
			<a href="CalController.do?command=calendar&year=<%=year+1%>&month=<%=month%>">→</a>
		</caption>
		<tr>
			<th style="color:orange;">일</th>
			<th>월</th>
			<th>화</th>
			<th>수</th>
			<th>목</th>
			<th>금</th>
			<th style="color: red">토</th>
		</tr>
		<tr>
			<%
			for(int i=0; i<dayOfWeek-1; i++){
				out.print("<td>&nbsp;</td>");
			}
			for(int i=1; i<=lastDay; i++){
				
				%>
				<td>
				
				<% 
					if((i+dayOfWeek-1)%7 == 0){
						%>
						<a class="countA" style="color: red;" href="CalController.do?command=callist&year=<%=year%>&month=<%=month%>&date=<%=i%>"><%=i%></a>
						<%
					}else if((i+dayOfWeek-1)%7 == 1){
						%>
						<a class="countA" style="color: orange;" href="CalController.do?command=callist&year=<%=year%>&month=<%=month%>&date=<%=i%>"><%=i%></a>
						<%
					}
					else{
				%>
				<a class="countA" style="color: black;" href="CalController.do?command=callist&year=<%=year%>&month=<%=month%>&date=<%=i%>"><%=i%></a>
				<%
					}
				%>
					<a href="CalController.do?command=calinsertform&year=<%=year%>&month=<%=month%>&date=<%=i%>">
						<img alt="일정추가하기" src="img/pen.png">
					</a>
					
					
					<div style="font-size: 3px;">
						<%=getCalView(list, i) %>
					</div>
					<div class="count"></div>
				</td>
				<%
				if((i+dayOfWeek-1)%7 == 0){
					out.print("</tr><tr>");
					
				}
				
			}

				int a = (7-(dayOfWeek-1+lastDay)%7)%7;
				for(int i = 0; i<a;i++){
					out.println("<td>&nbsp;</td>");
				}
			%>
		</tr>
	</table>
	<%!  //자바 메서드 선언부
		public String getCalView(List<CalDto> list,int i){ 
			String d = Util.isTwo(i+""); 
			String titleList = "";
			
			for(CalDto dto:list){
				
				if(dto.getMdate().substring(6,8).equals(d)){
					titleList += "<p class='ctitle'>"
								+(dto.getTitle())
								+"</p>";
							
				}else{
					titleList += "<p></p>";
				}
			}
		
			return titleList;
		}
	%>
</body>
</html>






