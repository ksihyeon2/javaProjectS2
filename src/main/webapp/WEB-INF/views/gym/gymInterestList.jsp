<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>gymInterestList.jsp</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
  <script>
  	'use strict';
  	
  	function starNO(idx){
  		let ans = confirm("관심 등록을 해제하시겠습니까?");
  		
  		if(!ans){
  			return false;
  		}
  		
  		$.ajax({
  			url : "${ctp}/gym/gymInterest?interest=NO",
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
			<a class="btn btn-secondary mb-4" href="${ctp}/member/memberPage" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px'></i></a>
		</div>
		<div class="col-6 text-center">
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px">관 심 지 점</span>
		</div>
		<div class="col-3 text-right">
			<a class="btn btn-secondary" href="gymList" style="margin-right:20px;">전체지점</a>
		</div>
	</div>
	
	<table class="table table-hover">
		<c:if test="${empty gymVOS}">
			<tr class="text-center">
				<td colspan="3">현재 관심 등록된 지점이 없습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="vo" items="${gymVOS}" varStatus="st">
			<tr>
				<td style="width:50px;text-align:center;">
					<a href="javascript:starNO(${vo.idx})"><i class='fas fa-star' style="font-size:24px"></i></a>
				</td>
				<td style="width:150px"><img src="${vo.photo}" style="height:200px;width:200px;margin-left:100px"></td>
				<td>
					<table class="table table-borderless">
						<tr>
							<td><h3 class="mt-4">지점 : ${vo.gymName}</h3></td>
						</tr>
						<tr>
							<td>${vo.area} / (상세주소) ${vo.address}</td>
						</tr>
						<tr>
							<td>${vo.tel}</td>
						</tr>
						<tr>
							<td><a href="gyminfor?idx=${vo.idx}" style="color:black;">자세히 보기</a></td>
						</tr>
					</table>
				</td>
			</tr>
		</c:forEach>
	</table>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>