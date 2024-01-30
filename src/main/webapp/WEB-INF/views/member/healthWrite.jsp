<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>healthWrite.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
  <style>
  	a {
  		color:black;
  		text-decoration-line:none;
  	}
  	
  	body {
  		background-color: rgb(76,76,76);
  	}
  	
  	.sidebar > nav {
  		background-color: rgb(189,189,189);
  		border-radius:30px;
  		padding: 20px;
  	}
  	
  	table th {
  		width:150px;
  	}
  </style>
  <script>
  	'use strict';
  	
  	$(function(){
  		document.getElementById('datetime').value= new Date().toISOString().slice(0, 16);
  		
  		$("#text").hide();
  		$("#minus").hide();
  	});
  	
  	function textBoxPlus(){
  		$("#text").show();
  		$("#minus").show();
  		$("#plus").hide();
  	}
  	
  	function textBoxMinus(){
  		$("#text").hide();
  		$("#minus").hide();
  		$("#plus").show();
  	}
  	
  	function healthWriteCheck(){
  		let regweight = /^[0-9]/;
  		
  		let part = $("#part").val();
  		let datetime = $("#datetime").val();
  		let HH = $("#HH").val();
  		let MM = $("#MM").val();
  		let weight = $("#weight").val();
  		
  		if(part == ""){
  			alert("운동 종류를 선택해 주세요.");
  			$("#part").focus();
  			return false;
  		}
  		
  		if(datetime == ""){
  			alert("날짜 및 시간을 선택해 주세요.");
  			$("#datetime").focus();
  			return false;
  		}
  		
  		if(HH == 0 && MM == 0){
  			alert("운동하신 시간을 선택해 주세요.");
  			$("#HH").focus();
  			return false;
  		}
  		
  		if(weight != ""){
	  		if(!regweight.test(weight)) {
	    		alert("몸무게는 숫자로만 입력해 주세요.");
	    		$("#weight").focus();
	    		return false;
	    	}
  		}
  		
  		healthWriteForm.submit();
  	}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br /></p>
<p><br /></p>
<p><br /></p>
<p><br /></p>
<div class="container">
	<div class="sidebar p-3" style="margin-left:20px; ">
	<div class="row mb-4">
		<div class="col-3 text-left">
			<a class="btn btn-secondary mb-4" href="memberPage" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px'></i></a>
		</div>
		<div class="col-6 text-center">
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px; color: white;">운동 기록</span><br />
		</div>
		<div class="col-3 text-right">
			<a class="btn btn-secondary mb-4" href="javascript:healthWriteCheck()" style="margin-left:20px;">추가하기</a>
		</div>
	</div>
    <nav class="navbar">
			<form name="healthWriteForm" method="post">
	    	<div>
		    	<table class="table table-hover" style="width: 1000px;text-align: center; margin-left: 10%">
				 		<tr>
				 			<th>종류 선택</th>
				 			<td class="text-center">
				 				<select name="part" id="part" class="form-control">
						        <option value="">선택</option>
						        <option>헬스</option>
						        <option>홈트</option>
						        <option>러닝</option>
						        <option>등산</option>
						        <option>야외 싸이클</option>
						       	<option>필라테스</option>
						       	<option>수영</option>
					         	<option>산책</option>
				          	<option>유산소</option>
				          	<option>기타 스포츠</option>
					        </select>
				 			</td>
				 		</tr>
				 		<tr>
				 			<th>날짜 및 시간</th>
				 			<td><input type="datetime-local" name="healthDate" id="datetime" class="form-control"></td>
				 		</tr>
				 		<tr>
				 			<th>운동한 시간</th>
				 			<td class="m-0 p-0">
				 				<table class="table table-borderless" style="width: 200px">
				 					<tr>
				 						<td style="width:70px">
							 				<select name="HH" id="HH" class="form-control" >
							 					<c:forEach var="HH" begin ="0" end ="24">
							 						<option>${HH}</option>
							 					</c:forEach>
							 				</select>
				 						</td>
				 						<td style="width:20px">:</td>
				 						<td style="width:70px">
				 							<select name="MM" id="MM" class="form-control" >
							 					<c:forEach var="MM" begin ="0" end ="60">
							 						<option>${MM}</option>
							 					</c:forEach>
							 				</select>
				 						</td>
				 					</tr>
				 				</table>
				 			</td>
				 		</tr>
				 		<tr>
				 			<th>몸무게 기록(Kg)</th>
				 			<td><input type="number" class="form-control" style="width:100px" min="0" name="weight" id="weight"></td>
				 		</tr>
				 		<tr>
				 			<th>상세 기록<span style="font-size:0.8em">(선택)</span></th>
				 			<td style="text-align:left;" id="plus"><button type="button" class="btn btn-secondary" title="추가하기" onclick="textBoxPlus()"><i class='fas fa-plus' style='font-size:15px'></i></button></td>
				 			<td style="text-align:left;" id="minus"><button type="button" class="btn btn-secondary" title="취소하기" onclick="textBoxMinus()"><i class='fas fa-minus' style='font-size:15px'></i></button></td>
				 		</tr>
				 		<tr id="text">
				 			<td colspan="2">
				 				<textarea rows="5" class="form-control" name="healthDetailText" id="healthDetailText"></textarea>
				 			</td>
				 		</tr>
				 	</table>
				</div>
			</form>
		</nav>
	</div>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>