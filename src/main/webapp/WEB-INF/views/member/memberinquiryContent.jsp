<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberinquiryContent.jsp</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<script>
		'use strict';
		
		function inquiryDelCheck(idx){
			let ans = confirm("해당 문의건을 삭제하시겠습니까?");
			
			if(!ans){
				return false;
			}
			
			location.href="memberinquiryDel?idx="+idx;
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
			<c:if test="${empty admin}">
				<a class="btn btn-secondary mb-4" href="memberInquiryList" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px'></i></a>
			</c:if>
			<c:if test="${!empty admin}">
				<a class="btn btn-secondary mb-4" href="${ctp}/admin/inquiryList" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px'></i></a>
			</c:if>
		</div>
		<div class="col-6 text-center">
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px">문 의 내 용</span>
		</div>
		<div class="col-3 text-right">
			<c:if test="${vo.inquirystate == '미완료'}">
				<a class="btn btn-secondary" href="javascript:inquiryDelCheck(${vo.idx})" style="margin-right:20px;">삭제하기</a>
			</c:if>
		</div>
	</div>
	
	<table class="table table-borderless">
			<tr>
        <td>
        	<select class="form-control" name="part" id="part">
		        <option>${vo.part}</option>
	      	</select>
        </td>
      </tr>
      <tr>
      	<td>
      		<b>Q</b> : ${vo.ask}
      	</td>
      </tr>
      <tr>
      <tr>
      	<td>
      		<textarea rows="5" class="form-control" readonly><c:if test="${!empty vo.answer}">A : ${vo.answer}</c:if><c:if test="${empty vo.answer}">아직 답변이 작성되지 않았습니다.</c:if></textarea>
      		<span style="color:gray;">
      			<c:if test="${vo.inquirystate == '답변완료'}">
      			[답변:${vo.answerMid}] |
      			<c:if test="${vo.date_diff >= 1}">${fn:substring(vo.answertime,0,10)}</c:if>
      			<c:if test="${vo.date_diff == 0 && vo.hour_diff < 24 }"> ${fn:substring(vo.answertime,11,16)}</c:if>
      			</c:if>
      		</span>
      	</td>
      </tr>
      
    </table>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>