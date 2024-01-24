<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>healthContent.jsp</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
  <style>
  	body {
  		background-color: rgb(76,76,76);
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
			<a class="btn btn-secondary mb-4" href="healthList?pag=${pag}&pageSize=${pageSize}&part=${part}" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px'></i></a>
		</div>
		<div class="col-6 text-center">
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px; color: white;">${vo.HName}</span><br />
			<span style="font-size:1em;color:yellow;">${vo.detailPart}</span>
		</div>
		<c:if test="${sLevel == 0}">
			<div class="col-3 text-right">
				<a class="btn btn-secondary" href="${ctp}/health/healthInputChange?hName=${vo.HName}&pag=${pag}&pageSize=${pageSize}&part=${part}" style="margin-right:20px;">수정하기</a>
			</div>
		</c:if>
	</div>
	<table class="table table-borderless" style="margin-left:10%;width:1000px">
		<tr>
			<td class="text-center">
				<c:if test="${vo.photo == ''}">
					<img src="${ctp}/health/준비중.png" width="250px">
				</c:if>
				<c:if test="${vo.photo != ''}">
					<img src="${ctp}/health/${vo.photo}" width="250px" />
				</c:if>
				<hr />
			</td>
		</tr>
		<tr>
			<td class="text-center">
				<a class="btn btn-secondary mb-4" href="#comment" style="margin-left:20px;width:100px">코멘트</a>
 				<a class="btn btn-secondary mb-4" href="#guide" style="margin-left:20px;width:120px">운동 가이드</a>
 				<a class="btn btn-danger mb-4" href="#caution" style="margin-left:20px;width:100px">주의사항</a>
			</td>
		</tr>
		<tr>
			<th class="page-section" id="comment">
				<span style="color:white;font-size:1.4em;">코멘트<br /></span>
			</th>
		</tr>
		<tr>
			<td><span style="color:white;font-size:1em;">${vo.comment}<br /></span><hr /></td>
		</tr>
		<tr>
			<th class="page-section" id="guide">
				<span style="color:white;font-size:1.4em;">운동 가이드<br /></span>
			</th>
		</tr>
		<tr>
			<td>
				<span style="color:white;font-size:1.1em;color:yellow;"><b>시작 자세</b><br /></span>
				<span style="color:white;font-size:1em;">${fn:replace(vo.position,newLine,"<br />")}<br /></span>
			</td>
		</tr>
		<tr>
			<td>
				<span style="color:white;font-size:1.1em;color:yellow;"><b>운동 동작</b><br /></span>
				<span style="color:white;font-size:1em;">${fn:replace(vo.motion,newLine,"<br />")}<br /></span>
			</td>
		</tr>
		<tr>
			<td>
				<span style="color:white;font-size:1.1em;color:yellow;"><b>호흡법</b><br /></span>
				<span style="color:white;font-size:1em;">${vo.breath}<br /></span><br /><hr />
			</td>
		</tr>
		<tr>
			<th class="page-section" id="caution">
				<span style="color:white;font-size:1.4em;">주의사항<br /></span>
			</th>
		</tr>
		<tr>
			<td><span style="color:white;font-size:1em;">${fn:replace(vo.caution,newLine,"<br />")}<br /></span><br /><hr /></td>
		</tr>
	</table>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>