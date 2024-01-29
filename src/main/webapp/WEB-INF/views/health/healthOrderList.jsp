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
		<%-- <c:if test="${sLevel <= 3 && sLevel > 0}">
			<div class="col-3 text-right">
				<a class="btn btn-secondary" href="${ctp}/gym/gymList" style="margin-right:20px;">근처 헬스장 찾기</a>
			</div>
		</c:if> --%>
	</div>
	<table class="table table-hover">
		<c:forEach var="vo" items="${vos}">
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
 					<h3><a href="healthContent?hName=${vo.HName}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&part=${vo.part}"><b style="color: white;">${vo.HName}</b></a></h3><br />
 					<span style="font-size:1em;color:yellow;">${weight}</span>
 				</td>
			</tr>
		</c:forEach>
	</table>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>