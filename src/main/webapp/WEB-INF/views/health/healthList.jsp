<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>healthList.jsp</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
  <style>
  	body {
  		background-color: rgb(76,76,76);
  	}
  	
  	hr {
  		color: white;
  	}
  	
  	a {
    	color:black;
    	text-decoration-line:none;
    }
  </style>
  <script>
  	'use strict';
  	
  	function searchCheck(){
  		let healthSearch = $("#healthSearch").val();
  		if(healthSearch == ""){
  			alert("검색하실 운동의 이름을 입력해 주세요.");
  			return false;
  		}
  		
  		location.href="healthList?searchString="+healthSearch;
  	}
  	
  	function partCheck(part){
  		location.href="${ctp}/health/healthList?part="+part;
  	}
  	
  	// 관심 체크
  	function heartCheck(idx){
  		
  		let query = {
  				idx:idx,
  		}
  		$.ajax({
  			url : "${ctp}/health/healthInterest",
  			type : "post",
  			data : {idx:idx},
  			success : function(res){
  				if(res != 0){
  					location.reload();
  				}
  			},
  			error : function(){
  				alert("전송 오류");
  			}
  		});
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
	<div class="row mb-4">
		<div class="col-3 text-left">
			<a class="btn btn-secondary mb-4" href="${ctp}/" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px'></i></a>
		</div>
		<div class="col-6 text-center">
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px; color: white;">운동 목록</span>
		</div>
		<c:if test="${sLevel == 0}">
			<div class="col-3 text-right">
				<a class="btn btn-secondary" href="${ctp}/health/healthInput" style="margin-right:20px;">운동 추가</a>
			</div>
		</c:if>
	</div>
	
	<!-- 검색기 -->
  <div class="input-group mb-4">
    <input type="text" name="healthSearch" id="healthSearch" value="${searchString}" class="form-control mr-sm-2" placeholder="운동 이름으로 검색해 보세요."/>
    <div class="input-group-append">
   		<a href="#" onclick="searchCheck()" class="btn btn-outline-secondary my-2 my-sm-0"><i class='fas fa-search' style='font-size:20px'></i></a>
   	</div>
 	</div>
 	
 	<!-- 부위별 검색 button -->
 	<table class="table table-borderless">
 		<tr>
 			<td>
 				<a class="btn btn-secondary mb-4" href="#" onclick="partCheck('')" style="margin-left:100px;width:80px"><i class='fas fa-heart' style='font-size:20px'></i></a>
 				<a class="btn btn-secondary mb-4" href="#" onclick="partCheck('가슴')" style="margin-left:20px;width:80px">가슴</a>
 				<a class="btn btn-secondary mb-4" href="#" onclick="partCheck('등')" style="margin-left:20px;width:80px">등</a>
 				<a class="btn btn-secondary mb-4" href="#" onclick="partCheck('하체')" style="margin-left:20px;width:80px">하체</a>
 				<a class="btn btn-secondary mb-4" href="#" onclick="partCheck('어깨')" style="margin-left:20px;width:80px">어깨</a>
 				<a class="btn btn-secondary mb-4" href="#" onclick="partCheck('삼두')" style="margin-left:20px;width:80px">삼두</a>
 				<a class="btn btn-secondary mb-4" href="#" onclick="partCheck('이두')" style="margin-left:20px;width:80px">이두</a>
 				<a class="btn btn-secondary mb-4" href="#" onclick="partCheck('코어')" style="margin-left:20px;width:80px">코어</a>
 				<a class="btn btn-secondary mb-4" href="#" onclick="partCheck('전완근')" style="margin-left:20px;width:80px">전완근</a>
 				<a class="btn btn-secondary mb-4" href="#" onclick="partCheck('유산소')" style="margin-left:20px;width:80px">유산소</a>
 			</td>
 		</tr>
 	</table>
 	<br />
 	<table class="table table-borderless" style="width:1000px;margin-left:10%">
 		<tr>
 			<td colspan="3">
 				<c:if test="${empty part}">
	 				<h3 style="color:white;">즐겨찾기</h3>
 				</c:if>
 				<c:if test="${!empty part}">
	 				<h3 style="color:white;">${part}</h3>
 				</c:if>
 			<hr /></td>
 		</tr>
 		<c:if test="${!empty vos}">
	 		<c:forEach var="vo" items="${vos}">
		 			<tr style="height:200px">
		 				<td style="width:200px">
		 					<c:if test="${vo.photo == ''}">
		 						<img src="${ctp}/health/준비중.png" width="180px">
		 					</c:if>
		 					<c:if test="${vo.photo != ''}">
		 						<video src="${ctp}/health/${vo.photo}" width="200px"></video>
		 					</c:if>
		 				</td>
		 				<td >
		 					<h3><a href="healthContent?hName=${vo.HName}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&part=${vo.part}"><b style="color: white;">${vo.HName}</b></a></h3><br />
		 					<span style="font-size:1em;color:yellow;">${vo.detailPart}</span>
		 				</td>
						<td style="width:100px;text-align:center;">
							<c:set var="cnt" value="0" />
							<c:forEach var="interestVO" items="${interestVOS}">
								<c:if test="${interestVO.partIdx == vo.idx}">
				 					<a href="javascript:heartCheck('${vo.idx}')"><i class='fas fa-heart' style='font-size:20px'></i></a>
				 					<c:set var="cnt" value="1"/>
								</c:if>
							</c:forEach>
							<c:if test="${cnt != 1}">
								<a href="javascript:heartCheck('${vo.idx}')"><i class='far fa-heart' style='font-size:20px'></i></a>
							</c:if>
						</td>
		 			</tr>
	 		</c:forEach>
	 	</c:if>
 		<c:if test="${empty vos}">
	 		<c:forEach var="vo" items="${vos}">
		 			<tr style="height:200px">
		 				<td style="width:200px">
		 					<c:if test="${vo.photo == ''}">
		 						<img src="${ctp}/health/준비중.png" width="180px">
		 					</c:if>
		 					<c:if test="${vo.photo != ''}">
		 						<video src="${ctp}/health/${vo.photo}" width="200px"></video>
		 					</c:if>
		 				</td>
		 				<td >
		 					<h3><a href="healthContent?hName=${vo.HName}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&part=${vo.part}"><b style="color: white;">${vo.HName}</b></a></h3><br />
		 					<span style="font-size:1em;color:yellow;">${vo.detailPart}</span>
		 				</td>
						<td style="width:100px;text-align:center;">
							<c:set var="cnt" value="0" />
							<c:forEach var="interestVO" items="${interestVOS}">
								<c:if test="${interestVO.partIdx == vo.idx}">
				 					<a href="javascript:heartCheck('${vo.idx}')"><i class='fas fa-heart' style='font-size:36px'></i></a>
				 					<c:set var="cnt" value="1"/>
								</c:if>
							</c:forEach>
							<c:if test="${cnt != 1}">
								<a href="javascript:heartCheck('${vo.idx}')"><i class='far fa-heart' style='font-size:36px'></i></a>
							</c:if>
						</td>
		 			</tr>
	 		</c:forEach>
 		</c:if>
 	</table>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>