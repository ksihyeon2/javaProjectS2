<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>admininquiryContent.jsp</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
  <script>
  	'use strict';
  	
  	function answerCheck(){
  		let answer = $("#answer").val();
  		
  		if(answer.trim() == ""){
  			alert("답변 내용을 입력해 주세요.");
  			$("#answer").focus();
  			return false;
  		}
  		
  		myform.submit();
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
			<a class="btn btn-secondary mb-4" href="inquiryList?pag=${pag}&pageSize=${pageSize}" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px'></i></a>
		</div>
		<div class="col-6 text-center">
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px">문 의 답 변</span>
		</div>
	</div>
	
	<form name="myform" method="post">
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
      		<textarea rows="5" class="form-control" name="answer" id="answer" placeholder="답변을 입력해 주세요."></textarea>
      	</td>
      </tr>
      <tr>
      	<td>
      		<input type="hidden" name="answerMid" value="${strLevel}">
      		<input type="hidden" name="idx" value="${vo.idx}">
      		<input type="button" value="답변하기" onclick="answerCheck()" class="btn btn-secondary form-control">
      	</td>
      </tr>
    </table>
   </form>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>