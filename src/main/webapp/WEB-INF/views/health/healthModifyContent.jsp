<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>healthModifyContent</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<link href="${ctp}/css/styles.css" rel="stylesheet" />
<style>
	a {
		text-decoration-line:none;
		color:black;
	}
	
	#title{
		font-size: 1.5em;
	}
</style>
<script>
	'use strict';
	
	$(function(){
		$("#modifyCheck").hide();
	});
	
	function textModify(){
		$("#modifyText").attr("readonly",false);
		$("#modifyCheck").show();
		$("#modifyChange").hide();
	}
	
	function textModifyChange(){
		let text = $("#modifyText").val();
		
		if(text.trim() == ""){
			alert("수정을 원하시는 내용을 작성해 주세요.");
			return false;
		}
		
		let query = {
				modifyPart:'${vo.modifyPart}',
				modifyText:text,
				hName:'${vo.HName}',
				requestMid:'${vo.requestMid}'
		}
		
		$.ajax({
			url : "${ctp}/member/healthModifyChange",
			type : "post",
			data : query,
			success : function(res){
				if(res != 0){
					alert("내용이 수정되었습니다.");
					location.reload();
				}
			},
			error : function(){
				alert("전송 오류");
			}
		});
	}
	
	function contentDel(idx){
		let ans = confirm("해당 수정 요청건을 삭제하시겠습니까?");
		
		if(!ans){
			return false;
		}
		
		location.href="modifyDel?idx="+idx;
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
			<a class="btn btn-secondary mb-4" href="${ctp}/health/healthMyModifyList" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px' title="뒤로가기"></i></a>
		</div>
		<div class="col-6 text-center">
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px">수 정 문 의 건</span>
		</div>
	</div>
	<div>
		<label><span id="title">운동명 : ${vo.HName}</span></label>&nbsp;&nbsp; / &nbsp;&nbsp;
		<label><span id="title">수정요청 : ${vo.modifyPart}</span></label>
		<textarea rows="10" class="form-control" id="modifyText" readonly>${vo.modifyText}</textarea>
	</div>
	<br />
	<div class="text-right">
		<c:if test="${vo.modifyState == '미완료'}">
			<input type="button" value="내용수정" id="modifyChange" class="btn btn-secondary" onclick="textModify()">
			<input type="button" value="수정완료" id="modifyCheck" class="btn btn-secondary" onclick="textModifyChange()">
		</c:if>
		<c:if test="${vo.modifyState == '완료'}">
			<input type="button" value="확인하기" class="btn btn-secondary"  onclick="location.href='${ctp}/health/healthContent?hName=${vo.HName}'">
		</c:if>
		<input type="button" value="삭제하기" onclick="contentDel(${vo.idx})" class="btn btn-danger">
	</div>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>