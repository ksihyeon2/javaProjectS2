<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>healthMyModifyList</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<link href="${ctp}/css/styles.css" rel="stylesheet" />
<style>
	a {
		text-decoration-line:none;
		color:black;
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
			<a class="btn btn-secondary mb-4" href="${ctp}/member/memberPage" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px' title="뒤로가기"></i></a>
		</div>
		<div class="col-6 text-center">
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px">나 의 수 정 요 청 건</span>
		</div>
		<div>
			<span style="color:red">*해당 수정건의 상태가 완료인 요청건은 삭제하실 수 없습니다.</span>
		</div>
		<table class="table table-hover text-center">
	  	<tr style="background-color:rgb(213,213,213);height:40px;">
	  		<th>선택</th>
	  		<th>운동명</th>
	  		<th>요청건</th>
	  		<th>날짜</th>
	  		<th>상태</th>
	  		<th>기타</th>
	  	</tr>
	  	<tr><td colspan="5" class="p-0"></td></tr>
	  	<c:if test="${empty vos}">
	  		<tr>
	  			<td colspan="6">수정 요청건이 없습니다.</td>
	  		</tr>
	  	</c:if>
	  	<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr>
					<td><input type="checkbox"></td>
					<td>${vo.HName}</td>
					<td>${vo.modifyPart}</td>
					<td>${fn:substring(vo.modifyDate,0,10)}</td>
					<td>${vo.modifyState}</td>
					<td>
						<a href="${ctp}/health/healthModifyContent?hName=${vo.HName}">자세히보기<i class='fas fa-caret-right'></i></a>
					</td>
				</tr>
	  	</c:forEach>
  	</table>
	</div>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>