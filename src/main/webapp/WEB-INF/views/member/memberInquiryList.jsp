<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberInquiryList.jsp</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
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
			<a class="btn btn-secondary mb-4" href="memberPage" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px'></i></a>
		</div>
		<div class="col-6 text-center">
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px">문 의 & 요 청 건</span>
		</div>
		<div class="col-3 text-right">
			<a class="btn btn-secondary" href="memberinquiryInput" style="margin-right:20px;">작성하기</a>
		</div>
	</div>
	<table class="table table-hover text-center">
  	<tr style="background-color:rgb(213,213,213);height:40px;">
  		<th>No.</th>
  		<th>제목</th>
  		<th>종류</th>
  		<th>문의날짜</th>
  		<th>상태</th>
  	</tr>
  	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
  	<c:if test="${empty vos}">
  		<tr>
  			<td colspan="5">문의 내역이 없습니다.</td>
  		</tr>
  	</c:if>
  	<c:forEach var="vo" items="${vos}" varStatus="st">
  		<tr>
  			<td>${st.count}</td>
  			<td>${vo.ask}</td>
  			<td>${vo.part}</td>
  			<td>
  				<c:if test="${vo.date_diff <= -1}">
		  			${fn:substring(vo.asktime,0,10)}
  				</c:if>
  				<c:if test="${vo.date_diff > -1 && vo.hour_diff < 24}">
  					${fn:substring(vo.asktime,11,16)} <span class="badge badge-danger" style="font-size:0.5em">N</span>
  				</c:if>
  			</td>
  			<td>
  				<a href="memberinquiryContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}" class="내용보기">${vo.inquirystate}<i class='fas fa-caret-right'></i>
  				<c:if test="${vo.inquirystate == '답변완료'}"><i class='fas fa-caret-right' title="확인하러가기"></i></c:if>
  				</a>
  			</td>
  		</tr> 
  	</c:forEach>
  </table>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>