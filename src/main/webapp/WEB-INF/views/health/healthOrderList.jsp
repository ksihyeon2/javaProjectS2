<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>healthOrderList.jsp</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
  <style>
  	body {
  		background-color: rgb(76,76,76);
  	}
  	
  	a {
	  	color:black;
	  	text-decoration-line:none;
    }
    
    .option {
	    position: sticky;
	    top: 150px;
	    background-color: gray !important;
    }
  </style>
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
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px; color: white;">당신을 위한 루틴</span>
		</div>
	</div>
	<span style="font-size:1em;color:yellow;">* 기구 사용 시 자신의 몸무게 ( <sapn style="color:white;">${weight}Kg</sapn> ) 의 반 무게로 해주세요.</span>
	<table class="table table-borderless">
			<tr>
				<td >
					<c:forEach var="vo" items="${vos}">
						<table class="table table-hover">
							<tr>
								<td style="width:200px">
				 					<c:if test="${vo.photo == ''}">
				 						<img src="${ctp}/health/준비중.png" width="180px">
				 					</c:if>
				 					<c:if test="${vo.photo != ''}">
				 						<video src="${ctp}/health/${vo.photo}" width="200px"></video>
				 					</c:if>
								</td>
				 				<td >
				 					<h3><b style="color: white;">${vo.HName}</b></h3><br />
				 					<span style="font-size:1em;color:yellow;">
				 						<c:if test="${strGender == '여자' && empty HealthStrLevel && vo.part != '유산소'}">
				 							15회 X 3세트
				 						</c:if>
				 						<c:if test="${strGender == '남자' && empty HealthStrLevel && vo.part != '유산소'}">
				 							15회 X 4세트
				 						</c:if>
				 						<c:if test="${strGender == '여자' && !empty HealthStrLevel && vo.part != '유산소'}">
				 							20회 X 3세트
				 						</c:if>
				 						<c:if test="${strGender == '남자' && !empty HealthStrLevel && vo.part != '유산소'}">
				 							20회 X 4세트
				 						</c:if>
				 						<c:if test="${strGender == '기타' && empty HealthStrLevel && vo.part != '유산소'}">15회 X 3세트</c:if>
				 						<c:if test="${strGender == '기타' && !empty HealthStrLevel && vo.part != '유산소'}">20회 X 3세트</c:if>
				 					</span><br />
				 				</td>
							</tr>
			 				<hr />
						</table>
					</c:forEach>
 				</td>
 				<td>
 					<table class="table table-bordered option">
 						<tr class="text-center" style="height:300px">
 							<td>
 								<div style="padding:10%">
									<span style="margin:0px auto; font-size:30px; font-weight:bold; color:white;">더 많은 운동과<br /> 섬세한 추천을 알아보러<br />가보세요</span>
 								</div>
								<c:if test="${empty sLevel}">
									<input type="button" value="회원가입 후 보러가기" class="btn btn-secondary" onclick="location.href='${ctp}/member/memberJoin';" />
								</c:if>
								<c:if test="${!empty sLevel}">
									<input type="button" value="보러가기" class="btn btn-secondary" onclick="location.href='healthList';" />
								</c:if>
 							</td>
 						</tr>
 					</table>
 				</td>
			</tr>
	</table>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>