<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberinquiryInput.jsp</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
  	'use strict';
  	
  	function askInput()	{
  		let part = $("#part").val();
  		let ask = $("#ask").val();
  		
  		if(part == ""){
  			alert("문의하실 종류를 선택해 주세요.");
  			$("#part").focus();
  			return false;
  		}
  		
  		if(ask.trim() == ""){
  			alert("문의하실 내용을 작성해 주세요.");
  			$("#ask").focus();
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
			<a class="btn btn-secondary mb-4" href="memberInquiryList" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px'></i></a>
		</div>
		<div class="col-6 text-center">
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px">문 의 하 기</span>
		</div>
	</div>
	
	<form name="myform" method="post">
		<table class="table table-borderless">
			<tr>
        <td>
        	<select class="form-control" name="part" id="part">
		        <option selected value="">선택</option>
		        <option>요청</option>
		        <option>질문</option>
		        <option>건의</option>
	      	</select>
        </td>
      </tr>
      <tr>
      	<td>
      		<textarea rows="10" name="ask" id="ask" class="form-control" placeholder="문의하실 종류를 선택 후 작성해 주세요." required></textarea>
      	</td>
      </tr>
      <tr>
   			<td><span style="font-size:0.8em">* 주민번호, 전화번호, 이메일 등 개입정보를 남기면 타인에 의해 도용될 수 있습니다. 개인정보는 상품문의에 남기지 말아주세요.</span></td>
      </tr>
      <tr>
      	<td>
      		<input type="button" value="등록하기" onclick="askInput()" class="btn btn-secondary form-control" />
      	</td>
      </tr>
    </table>
    <input type="hidden" name="askMid" value="${sMid}" />
	</form>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>