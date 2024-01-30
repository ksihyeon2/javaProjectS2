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
  <script>
  	'use strict';
  	
  	function modifyCheck(){
  		let modifyPart = $("#modifyPart").val();
  		let modifyText = $("#modifyText").val();
  		
  		if(modifyPart == ""){
  			alert("수정을 원하시는 정보를 선택해 주세요.");
  			$("#modifyPart").focus();
  			return false;
  		}
  		
  		if(modifyText.trim() == ""){
  			alert("수정을 원하시는 정보를 간단하게 입력해 주세요.");
  			$("#modifyText").focus();
  			return false;
  		}
  		
  		let ans = confirm("정보 수정 요청을 하시겠습니까?");
  		if(!ans){
  			return false;
  		}
  		
  		let query = {
  				modifyPart:modifyPart,
  				modifyText:modifyText,
  				hName:'${vo.HName}'
  		}
  		
  		$.ajax({
  			url : "${ctp}/member/healthModify",
  			type : "post",
  			data : query,
  			success : function(res){
  				if(res == 1){
  					alert("정보 수정 요청을 하였습니다. \n수정 확인 대기중입니다.");
  					location.reload();
  				} else if(res == -1) {
  					alert("이미 수정 요청을 하셨습니다.");
  					location.reload();
  				}	else {
  					alert("정보 수정 요청에 실패하였습니다.");
  				}
  			},
  			error : function(){
  				alert("전송 오류");
  			}
  		});
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
			<a class="btn btn-secondary mb-4" href="healthList?pag=${pag}&pageSize=${pageSize}&part=${part}" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px'></i></a>
		</div>
		<div class="col-6 text-center">
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px; color: white;">${vo.HName}</span><br />
			<span style="font-size:1em;color:yellow;">${vo.detailPart}</span>
		</div>
		<div class="col-3 text-right">
			<c:if test="${sLevel == 0}">
				<a class="btn btn-secondary" href="${ctp}/health/healthInputChange?hName=${vo.HName}&pag=${pag}&pageSize=${pageSize}&part=${part}" style="margin-right:20px;">수정하기</a>
			</c:if>
			<c:if test="${sLevel < 4 && sLevel != 0}">
				<a href="#" data-toggle="modal" data-target="#delModal" class="btn btn-secondary">정보수정제안</a>
			</c:if>
		</div>
	</div>
	<table class="table table-borderless" style="margin-left:10%;width:1000px">
		<tr>
			<td class="text-center">
				<c:if test="${vo.photo == ''}">
					<img src="${ctp}/health/준비중.png" width="250px">
				</c:if>
				<c:if test="${vo.photo != ''}">
					<video src="${ctp}/health/${vo.photo}" width="500px" muted autoplay></video>
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

<!-- The Modal -->
<div class="modal fade" id="delModal">
	<div class="modal-dialog">
	    <div class="modal-content">
	    <!-- Modal Header -->
	        <div class="modal-header">
	        	<h4 class="modal-title">알고 계신 정보와 다른 정보가 있나요?<br />간단하게 제보해 주세요.</h4>
	          	<button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
	        <!-- Modal body -->    
	        <div class="modal-body">
	         	<select class="form-control mb-3" style="width:150px;" name="modifyPart" id="modifyPart">
			        <option value="">선택</option>
			        <option>시작 자세</option>
			        <option>운동 동작</option>
			        <option>호흡법</option>
			        <option>주의사항</option>
			        <option>기타</option>
			      </select>
			      <input type="text" class="form-control" placeholder="수정을 원하시는 정보를 간단하게 입력해 주세요." name="modifyText" id="modifyText" />
	        </div>
	        <!-- Modal footer -->
	        <div class="modal-footer">
	          	<button type="button" class="btn btn-primary" onclick="modifyCheck()">요청</button>
	          	<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
	        </div>
	    </div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>