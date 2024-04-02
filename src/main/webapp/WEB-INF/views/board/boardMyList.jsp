<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>boardMyList.jsp</title>
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
  <script>
  	'use strcit';
  	 
  	function DelCheck(idx){
  		 let ans = confirm("해당 게시물을 삭제하시겠습니까?");
  		 if(!ans){
  			 return false;
  		 }
  		 
  		 $.ajax({
  			 url : "${ctp}/board/boardContentDel",
  			 type : "post",
  			 data : {idx:idx},
  			 success : function(res){
  				 if(res != "0"){
  					 alert("해당 게시물이 휴지통으로 이동되었습니다. \n7일 이후에 자동으로 삭제 됩니다.(7일 이전 복구 가능)");
  					 location.reload();
  				 }
  			 },
  			 error : function(){
  				 alert("전송 오류");
  			 }
  		 });
  	 }
  	 
  	 function openSwChange(idx,openSw){
  		 let ans = confirm("해당 게시물의 공개 상태를 변경하시겠습니까?");
  		 if(!ans){
  			 return false;
  		 }
  		 
  		 let query = {
  				 idx:idx,
  				 openSw:openSw
  		 }
  		 
  		 $.ajax({
  			 url : "${ctp}/board/boardOpenSwChange",
  			 type : "post",
  			 data : query,
  			 success : function(res){
  				 if(res != "0"){
  					 alert("해당 게시물의 공개 상태를 변경하였습니다.");
  					 location.reload();
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
			<a class="btn btn-secondary mb-4" href="${ctp}/member/memberPage" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px' title="뒤로가기"></i></a>
		</div>
		<div class="col-6 text-center">
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px">게 시 물 관 리</span>
		</div>
		<div class="col-3 text-right">
			<a class="btn btn-danger" href="#" style="margin-right:18px;"><i class='far fa-trash-alt' style='font-size:25px;color:white;' title="선택삭제"></i></a>
		</div>
	</div>
	
  <table class="table table-hover text-center">
  	<tr style="background-color:rgb(213,213,213);height:40px;">
  		<th>선택</th>
  		<th>제목</th>
  		<th>분류</th>
  		<th>작성일</th>
  		<th>조회수</th>
  		<th>상태</th>
  	</tr>
  	<tr><td colspan="6" class="p-0"></td></tr>
	  	<c:forEach var="vo" items="${vos}" varStatus="st">
	  		<c:if test="${vo.delCheck != 'OK'}">
		  		<tr>
		  			<td><input type="checkbox"></td>
		  			<td><a href="boardContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&mid=${vo.mid}">${vo.title} </a> (${vo.replyCnt})</td>
		  			<td>${vo.part}</td>
		  			<td>${fn:substring(vo.WDate,0,10)}</td>
		  			<td>${vo.readNum}</td>
		  			<c:if test="${vo.openSw == 'OK'}">
		  				<td>
		  					<div class="dropdown-toggle" data-toggle="dropdown">공개중
				  				<div class="dropdown-menu">
							      <a class="dropdown-item" href="#" onclick="openSwChange(${vo.idx},'OK')">비공개전환</a>
							      <a class="dropdown-item" href="#" onclick="DelCheck(${vo.idx})"><font color="red">글삭제</font></a>
							    </div>
  							</div>
		  				</td>
		  			</c:if>
		  			<c:if test="${vo.openSw == 'NO'}">
		  				<td>
		  					<div class="dropdown-toggle" data-toggle="dropdown">비공개중
				  				<div class="dropdown-menu">
							      <a class="dropdown-item" href="#" onclick="openSwChange(${vo.idx},'NO')">공개전환</a>
							      <a class="dropdown-item" href="#" onclick="DelCheck(${vo.idx})"><font color="red">글삭제</font></a>
							    </div>
  							</div>
		  				</td>
		  			</c:if>
		  		</tr>
	  			<c:set var="cnt" value="${cnt+1}"/>
		  	</c:if>
	  	</c:forEach>
	  	<c:if test="${empty cnt}">
	  		<tr>
	  			<td colspan="6" ><i class='fas fa-search mt-3' style='font-size:36px'></i><br />작성된 게시물이 없습니다.</td>
	  		</tr>
	  	</c:if>
  </table>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>