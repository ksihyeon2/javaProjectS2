<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberComplaintList</title>
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
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px">나 의 신 고 건</span>
		</div>
	</div>
	
	<table class="table table-hover text-center">
  	<tr style="background-color:rgb(213,213,213);height:40px;">
  		<th>번호</th>
  		<th>신고물</th>
  		<th>종류</th>
  		<th>날짜</th>
  		<th>상태</th>
  	</tr>
  	<tr><td colspan="6" class="p-0"></td></tr>
  	<c:forEach var="vo" items="${vos}" varStatus="st">
  		<tr>
  			<td>${st.count}</td>
				<c:if test="${vo.complaintPart == 'board'}">
  				<td>
  					<a href="${ctp}/board/boardContent?idx=${vo.complaintidx}">보러가기<i class='fas fa-caret-right'></i></a>
	  			</td>
	  			<td>게시물</td>
				</c:if>
				<!-- 신고물 part 추가되면 수정 -->
				<c:if test=""></c:if>
  			
  			<td>
  				<c:if test="${vo.date_diff <= -1}">
  					${fn:substring(vo.complaintDate,0,10)}
  				</c:if>
  				<c:if test="${vo.date_diff == 0 && vo.hour_diff < 24}">
  					${fn:substring(vo.complaintDate,11,16)}<span class="badge badge-danger" style="font-size:0.5em">N</span>
  				</c:if>
  			</td>
  			<td>${vo.complaintState}</td>
  		</tr>
  	</c:forEach>
  </table>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>