<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>gymorder.jsp</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
  <style>
    	body {
    		background-color: rgb(76,76,76);
    	}
  </style>
  <script>
  	'use strict';
  	
  	function gymorderStep1(){
  		$.ajax({
	  		url : "${ctp}/gym/gymorderStep1",
	  		type : "post",
	  		error : function(){
	  			alert("전송 오류");
	  		}
  		});
	  	location.reload();
  	}
  	
  	function gymorderStep2(gender){
  		$.ajax({
	  		url : "${ctp}/gym/gymorderStep2",
	  		type : "post",
	  		data : {gender:gender},
	  		error : function(){
	  			alert("전송 오류");
	  		}
  		});
  		
	  	location.reload();
  	}
  	
  	function gymorderStep3(i){
  		$.ajax({
	  		url : "${ctp}/gym/gymorderStep3",
	  		type : "post",
	  		data : {gymLevel:i},
	  		error : function(){
	  			alert("전송 오류");
	  		}
  		});
  		
	  	location.reload();
  	}
  	
  	function gymorderStep4(){
  		let weight = $("#weight").val();
  		if(weight == ""){
  			return false;
  		}
  		
  		$.ajax({
  			url : "${ctp}/gym/gymorderStep4",
  			type : "post",
  			data : {weight:weight},
  			error : function() {
				 alert("전송 오류");
				}
  		});
  		location.reload();
  	}
  </script> 
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br /></p>
<p><br /></p>
<p><br /></p>
<div class="container">
	<div class="progress" style="height:10px">
    <div class="progress-bar" style="width:${sStep}%;height:10px"></div>
  </div>
	<c:if test="${sStep == 0}">
		<div class="container page-section" id="portfolio">
	  	<div class="text-center">
		    <h2 class="section-heading text-uppercase" style="color:white;">AI 운동 루팅 생성기</h2>
		  	<h3 class="section-subheading" style="color:white;">1분만에 개인 맞춤 운동 루틴을 받아보세요.</h3>
			 	<input type="button" value="무료 루틴 추천받기" onclick="gymorderStep1()" class="btn btn-success">
	  	</div>
		</div>
	</c:if>
	<c:if test="${sStep == 20}">
		<div class="container page-section" id="portfolio">
	  	<div class="text-center">
		    <h2 class="section-heading text-uppercase" style="color:white;">성별이 어떻게 되시나요?</h2>
		  	<h3 class="section-subheading" style="color:white;">적절한 운동 추천에 필요해요! 외부에 공개되지 않아요.</h3>
		  	<div>
				  <button type="button" class="btn btn-success mb-4" onclick="gymorderStep2('male')" style="width:500px">남자</button>
		  	</div>
		  	<div>
				  <button type="button" class="btn btn-success mb-4" onclick="gymorderStep2('female')" style="width:500px" >여자</button>
		  	</div>
		  	<div>
				  <button type="button" class="btn btn-success" onclick="gymorderStep2('gender')" style="width:500px" >기타</button>
		  	</div>
	  	</div>
	 	</div>
 	</c:if>
	<c:if test="${sStep == 40}">
		<div class="container page-section" id="portfolio">
	  	<div class="text-center">
		    <h2 class="section-heading text-uppercase" style="color:white;">운동 수준이 어떻게 되시나요?</h2>
		  	<h3 class="section-subheading" style="color:white;">적절한 운동 추천에 필요해요! 외부에 공개되지 않아요.</h3>
		  	<div>
				  <button type="button" class="btn btn-success mb-4" onclick="gymorderStep3(0)" style="width:500px">
				  	입문<br /><span style="font-size:0.7em">어떤 자세, 운동 루틴 등 아무것도 몰라요.</span>
				  </button>
		  	</div>
		  	<div>
				  <button type="button" class="btn btn-success mb-4" onclick="gymorderStep3(1)" style="width:500px">
				  	초급<br /><span style="font-size:0.7em">자세는 조금 알지만, 무슨 운동을 해야 할지 몰라요.</span>
				  </button>
		  	</div>
		  	<div>
				  <button type="button" class="btn btn-success mb-4" onclick="gymorderStep3(2)" style="width:500px">
				  	중급<br /><span style="font-size:0.7em">운동 자세를 잘 알고, 나만의 루틴이 있어요.</span>
				  </button>
		  	</div>
		  	<div>
				  <button type="button" class="btn btn-success mb-4" onclick="gymorderStep3(3)" style="width:500px">
				  	고급<br /><span style="font-size:0.7em">운동을 직업으로 삼을 만큼의 지식이 있어요.</span>
				  </button>
		  	</div>
		  	<div>
				  <button type="button" class="btn btn-success mb-4" onclick="gymorderStep3(4)" style="width:500px">
				  	전문가<br /><span style="font-size:0.7em">운동 선수급의 지식과 경험을 갖고 있어요.</span>
				  </button>
		  	</div>
	  	</div>
	 	</div>
 	</c:if>
	<c:if test="${sStep == 60}">
		<div class="container page-section" id="portfolio">
	  	<div class="text-center">
		    <h2 class="section-heading text-uppercase" style="color:white;">몸무게가 어떻게 되시나요?</h2>
		  	<h3 class="section-subheading" style="color:white;">적절한 운동 추천에 필요해요! 외부에 공개되지 않아요.</h3>
	  		<input type="number" placeholder="70" style="width:500px;height:50px;text-align:center;" id="weight"><span style="color:white;font-size:2em"> Kg</span>
	  		<div><input type="button" value="다음" class="btn btn-success mt-4" style="width:500px;height:50px;" onclick="gymorderStep4()"></div>
	  	</div>
	 	</div>
 	</c:if>
	<c:if test="${sStep == 80}">
		<div class="container page-section" id="portfolio">
	  	<div class="text-center">
		    <h2 class="section-heading text-uppercase" style="color:white;">운동하고 싶은 부위가 어디인가요?</h2>
		  	<h3 class="section-subheading" style="color:white;">적절한 운동 추천에 필요해요! 외부에 공개되지 않아요.</h3>
	  		<div>
				  <button type="button" class="btn btn-success mb-4" onclick="gymorderStep3(0)" style="width:500px">등</button>
		  	</div>
		  	<div>
				  <button type="button" class="btn btn-success mb-4" onclick="gymorderStep3(1)" style="width:500px">가슴</button>
		  	</div>
		  	<div>
				  <button type="button" class="btn btn-success mb-4" onclick="gymorderStep3(2)" style="width:500px">어깨</button>
		  	</div>
		  	<div>
				  <button type="button" class="btn btn-success mb-4" onclick="gymorderStep3(3)" style="width:500px">하체</button>
		  	</div>
		  	<div>
				  <button type="button" class="btn btn-success mb-4" onclick="gymorderStep3(4)" style="width:500px">코어</button>
		  	</div>
		  	<div>
				  <button type="button" class="btn btn-success mb-4" onclick="gymorderStep3(4)" style="width:500px">삼두</button>
		  	</div>
		  	<div>
				  <button type="button" class="btn btn-success mb-4" onclick="gymorderStep3(4)" style="width:500px">이두</button>
		  	</div>
		  	<div>
				  <button type="button" class="btn btn-success mb-4" onclick="gymorderStep3(4)" style="width:500px">전완근</button>
		  	</div>
		  	<div>
				  <button type="button" class="btn btn-success mb-4" onclick="gymorderStep3(4)" style="width:500px">유산소</button>
		  	</div>
	  	</div>
	 	</div>
 	</c:if>
</div>
<p><br /></p>
</body>
</html>