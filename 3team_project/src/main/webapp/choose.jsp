<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src='http://code.jquery.com/jquery-3.3.1.js'></script>
<title>Insert title here</title>
<style type="text/css">	
	.wrapper{
		margin: 0 auto; /*가운데정렬용*/
		width: 1024px;
		background-color: ghostwhite;
		position: relative;
		left: 0;
		padding: 0;
		width: 100%;
		height: 35px;
		padding-top: 7px;
	}
	.topMenu:hover{
		color:gray;
	}
	.topMenu p{
		font-size: 12px;
		line-height: 20px;
	}
	.topMenu{
		display: inline;
	}
	.topMenu li{
		display: inline-block;
	}
	.topMenu a p{
		float: right;
		color: black;
	}
	.topMenu .a {
		float: right;
		padding-right: 20px;
	}
	.searhbox{	
		margin: 0 auto; /*가운데정렬용*/
		height: 40px;
		width: 400px;
		border: 1px solid #382f2f;
		background: #ffffff;
	}
	.searhbox > input{
		font-size: 16px;
		width: 315px;
		padding: 10px;
		border: 0px;
		outline: none;
		float: left;
	}
	.searhbox > button{
		width: 60px;
		height: 100%;
		border: 0px;
		background: #382f2f;
		outline: none;
		float: right;
		color: #ffffff;
	}
	.wrapper1{
		margin: 0 auto; /*가운데정렬용*/
		width: 1024px;
		position: relative;
		left: 0;
		padding: 0;
		width: 100%;
		height: 55px;
		padding-top: 30px;
	}
	.machineMenu{
		list-style: none;
		text-align: center;
		border-top: 1px solid black;
		border-bottom: 1px solid black;
		padding: 10px 0;
	}
	.machineMenu a{
		text-decoration: none;
	}
	.machineMenu .b{
		display: inline-block;
		position: relative;
		text-transform: uppercase;
		padding: 0 40px;
		letter-spacing: 10px;
	}
	.b{
		cursor: pointer;		
	}
	.b:hover{
		background-color: antiquewhite;
	}
	.clicked_b{
		background-color: antiquewhite;
	}
	.wrapper3{
		position: relative;
		display: flex;
  		justify-content: center;
	}
	#machinepic1{
		display: none;
		margin: 10px;
		height: 500px;
		float: left; 
		background-color: gray;
	}
	#machinepic2{
		display: none;
		margin: 10px;
		height: 500px;
		float: left; 
		background-color: gray;
	}
	.slectWrapper{	
		position: relative;
		display: flex;
  		justify-content: center;
	}
	.brandLeft{
		display: inline-block;
	}	
	.brandRight{
		display: inline-block;
	}
	#jump{
		display: inline-block;
		width: 360px;
	}
	.text{
		position: relative;
		display: flex;
  		justify-content: center;
  		height: 80px;
  		font-size: 15px;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$(".b").each(function(index){
			$(this).attr("b-index", index);
		}).click(function(){
			var index = $(this).attr("b-index");
			
			$(".b[b-index=" + index + "]").addClass("clicked_b");
			$(".b[b-index!=" + index + "]").removeClass("clicked_b");
		});	
	});
	function brandLeft(v){
		var menu = new Array("machinepic1", "machinepic2"); 
		
		for(var i=0;i < menu.length;i++){
			   if("machinepic"+v==menu[i]){
			    document.all[menu[i]].style.display="block";
			   }else{
			    document.all[menu[i]].style.display="none";
			   }
			  }
	}
	function brandRight(v){
		var menu = new Array("machinepic1", "machinepic2"); 
		
		for(var i=0;i < menu.length;i++){
			   if("machinepic"+v==menu[i]){
			    document.all[menu[i]].style.display="block";
			   }else{
			    document.all[menu[i]].style.display="none";
			   }
			  }
	}
	
</script>
</head>
<header>
	<div>
		<div class="wrapper">
			<ul class="topMenu">
				<li class="a"><a href="index.jsp">방문예약</a></li>
				<li class="a"><p>|</p></li>
				<li class="a"><a href="regist.jsp">회원가입</a></li>
				<li class="a"><p>|</p></li>
				<li class="a"><a href="index.jsp">로그인</a></li>
			</ul>
		</div>
	</div>
	<div class="wrapper1">
		
		<div class="searhbox">
			<input type="text" placeholder="검색어 입력">
			<button style="cursor:pointer">검색</button>
		</div>
	</div>
	<div class="wrapper2">
		<ul class="machineMenu">
			<li class="b"><a href="#" >청소기</a></li>
			<li class="b"><a href="#">세탁기</a></li>
			<li class="b"><a href="#">냉장고</a></li>
			<li class="b"><a href="#">티비</a></li>
		</ul>
	</div>
</header>
<body>
	<div class="text">
		<p>비교를 원하는 브랜드를 선택하세요</p>
	</div>
	<div class="slectWrapper">
		<select onchange="brandLeft(this.value);" class="brandLeft" style="width:70px; size: 17px; font-size:17px;">
			<option value="1">삼성</option>
			<option value="2">LG</option>
		</select>
		<div id="jump">
		
		</div>
		<select onchange="brandRight(this.value);" class="brandRight" style="width:70px; size: 17px; font-size:17px;">
			<option value="1">삼성</option>
			  <option value="2">LG</option>
		</select>
	</div>
	<div class="wrapper3" style="overflow: auto">
		<div id="machinepic1" style="border: 1px solid gold; width: 30%; ">
			
		</div>
		<div id="machinepic2" style="border: 1px solid red; width: 30%;">
			
		</div>	
		
	</div>
	
</body>
<footer>

</footer>
</html>





