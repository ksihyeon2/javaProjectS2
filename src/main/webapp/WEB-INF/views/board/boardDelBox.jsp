<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>boardDelBox.jsp</title>
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
  	
  	// 게시물 영구 삭제
  	function boardDelOk(idx){
  		//$("#del"+idx).checked = true;
  		let ans = confirm("해당 게시물을 완전 삭제하시겠습니까? \n(삭제 후 복구 불가능합니다.)");
  		if(!ans){
  			return false;
  		}
  		
  		$.ajax({
  			url : "${ctp}/board/boardContentDel",
  			type : "post",
  			data : {idx:idx},
  			success : function(res){
  				if(res != 0){
  					alert("해당 게시물이 영구 삭제되었습니다.");
  				}else {
  					alert("해당 게시물의 영구 삭제에 실패하였습니다.");
  				}
  				location.reload();
  			},
  			error : function(){
  				alert("전송 오류");
  			}
  		});
  	}
  	
  	// 게시물 복구
  	function boardDelNo(idx){
  		let ans = confirm("해당 게시물을 복구하시겠습니까? \n(복구 시 게시물은 비공개로 전환됩니다.)");
  		if(!ans){
  			return false;
  		}
  		
  		$.ajax({
  			url : "${ctp}/board/boardContentDelNo",
  			type : "post",
  			data : {idx:idx},
  			success : function(res){
  				if(res != 0){
  					alert("해당 게시물이 복구되었습니다.");
  				}else {
  					alert("해당 게시물 복구에 실패하였습니다.")
  				}
  				location.reload();
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
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px">글 삭 제 목 록</span>
		</div>
		<div class="col-3 text-right">
			<a class="btn btn-danger" href="${ctp}/board/boardDelBox" style="margin-right:20px;"><i class='far fa-trash-alt' style='font-size:25px;color:white;' title="휴지통"></i></a>
		</div>
	</div>
	
	<table class="table table-hover text-center">
  	<tr style="background-color:rgb(213,213,213);height:40px;">
  		<th>선택</th>
  		<th>제목</th>
  		<th>분류</th>
  		<th>삭제일</th>
  		<th>기타</th>
  	</tr>
  	<tr><td colspan="6" class="p-0"></td></tr>
		<c:if test="${empty vos}">
			<tr>
				<td colspan="6">삭제된 게시물이 없습니다.</td>
			</tr>
		</c:if>
  	<c:forEach var="vo" items="${vos}" varStatus="st">
  		<tr>
  			<td><input type="checkbox" name="del" id="del${vo.idx}" value="${vo.idx}"></td>
  			<td><a href="boardContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&del=${vo.delCheck}">${vo.title} </a> (${vo.replyCnt})</td>
  			<td>${vo.part}</td>
  			<td>${fn:substring(vo.delDate,0,10)}</td>
  			<td>
	  			<a href="javascript:boardDelOk(${vo.idx})" class="btn btn-danger btn-sm" style="margin-right:5px;" title="완전삭제">삭제</a>
	  			<a href="javascript:boardDelNo(${vo.idx})" class="btn btn-success btn-sm" title="복구하기">복구</a>
  			</td>
  		</tr>
  	</c:forEach>
  </table>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>