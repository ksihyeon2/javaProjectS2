<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberList.jsp</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
  <style>
  	a{
  		text-decoration-line:none;
  		color:black;
  	}
  </style>
  <script>
  	'use strict';
  	
  	function pageSizeCheck(){
  		let pageSize = $("#pageSize").val();
  		location.href = "memberList?pageSize="+pageSize;
  	}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br /></p>
<p><br /></p>
<p><br /></p>
<div class="container">
	<div class="row mb-4">
		<div class="col-3 text-left">
			<a class="btn btn-secondary mb-4" href="adminPage" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px' title="뒤로가기"></i></a>
		</div>
		<div class="col-6 text-center">
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px">회 원 관 리</span>
		</div>
	</div>
	<form name="searchForm">
		<div class="row mb-5">
			<div class="col-7 text-left">
				<select class="form-control mb-3" style="width:150px;" onchange="searchCheck()">
	        <option selected>전체</option>
	        <option>운동</option>
	        <option>식단</option>
	        <option>기타</option>
	      </select>
				<select name="pageSize" id="pageSize" onchange="pageSizeCheck()">
          <option ${pageVO.pageSize==3 ? "selected" : ""}>3</option>
          <option ${pageVO.pageSize==5 ? "selected" : ""}>5</option>
          <option ${pageVO.pageSize==10 ? "selected" : ""}>10</option>
          <option ${pageVO.pageSize==15 ? "selected" : ""}>15</option>
          <option ${pageVO.pageSize==20 ? "selected" : ""}>20</option>
        </select> 건
			</div>
			<div class="col-5 text-right">
	    	<div class="input-group">
		    	<div class="mr-3">
		        <select name="search" id="search" class="form-control">
		          <option selected value="">선택</option>
		          <option value="title">제목</option>
		          <option value="member">작성자</option>
		          <option value="content">내용</option>
		        </select>
		    	</div>
		      <input type="text" name="searchString" id="searchString" value="${searchString}" class="form-control mr-sm-2" placeholder="검색어를 입력해주세요"/>
		      <div class="input-group-append">
		     		<a href="#" class="btn btn-outline-secondary my-2 my-sm-0" onclick="javascript:searchCheck()"><i class='fas fa-search' style='font-size:20px'></i></a>
		     	</div>
	     	</div>
			</div>
		</div>
  </form>
  
  <table class="table table-hover text-center">
  	<tr style="background-color:rgb(213,213,213);height:40px;">
  		<th>No.</th>
  		<th>아이디</th>
  		<th>닉네임</th>
  		<th>성명</th>
  		<th>이메일</th>
  		<th>탈퇴여부</th>
  		<th>상세보기</th>
  	</tr>
  	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
  	<c:forEach var="vo" items="${vos}" varStatus="st">
  		<tr>
  			<td>${curScrStartNo}</td>
  			<td>${vo.mid}</td>
  			<td>${vo.nickName}</td>
  			<td>${vo.name}</td>
  			<td>${vo.email}</td>
  			<td>
  				<c:if test="${vo.userDel == 'NO' }">미탈퇴</c:if>
  				<c:if test="${vo.userDel != 'NO' }">
  					<a href="#" title="탈퇴관리"><span style="color:red">탈퇴신청</span></a>
  				</c:if>
  			</td>
  			<td><a href="#" title="상세보기"><i class='fas fa-info-circle'></i></a></td>
  		</tr>  
  		<c:set var="curScrStartNo" value="${curScrStartNo -1}"/>
  	</c:forEach>
  </table>
</div>
<!-- 블록페이지 시작(1블록의 크기를 3개(3Page)로 한다. 한페이지 기본은 10개 -->
<br/>
<div class="text-center">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="memberList?pag=1&pageSize=${pageVO.pageSize}">첫페이지</a></li></c:if>
  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="memberList?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">이전블록</a></li></c:if>
  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
	    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="memberList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
	    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="memberList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
  	</c:forEach>
  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="memberList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음블록</a></li></c:if>
  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="memberList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li></c:if>
  </ul>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>