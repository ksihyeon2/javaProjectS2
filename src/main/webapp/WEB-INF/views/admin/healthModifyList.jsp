<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>healthModifyList.jsp</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
  <style>
  	a {
    	color:black;
    	text-decoration-line:none;
    }
    
  </style>
  <script>
  	'use strict';
  	
 		// 페이징
  	function pageSizeCheck(){
  		let pageSize = $("#pageSize").val();
  		let state = '${state}';
  		location.href="healthModifyList?pageSize="+pageSize+"&state="+state;
  	}
 		
 		// 상태별 검색
 		function stateCheck(state){
 			location.href="healthModifyList?state="+state;
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
			<a class="btn btn-secondary mb-4" href="adminPage" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px'></i></a>
		</div>
		<div class="col-6 text-center">
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px">수정 요청 내역</span>
		</div>
	</div>
	
	<form name="searchForm">
		<div class="row mb-5">
			<div class="col-7 text-left">
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
		          <option ${search == "" ? "selected" : ""} value="">전체</option>
		          <option ${search == "mid" ? "selected" : ""} value="mid">아이디</option>
		          <option ${search == "hName" ? "selected" : ""} value="hName">운동명</option>
		        </select>
		    	</div>
		      <input type="text" name="searchString" id="searchString" value="${searchString}" class="form-control mr-sm-2" placeholder="검색어를 입력해주세요"/>
		      <div class="input-group-append">
		     		<a href="#" class="btn btn-outline-secondary my-2 my-sm-0" onclick=""><i class='fas fa-search' style='font-size:20px'></i></a>
		     	</div>
	     	</div>
			</div>
		</div>
  </form>
  
  <table class="table table-hover text-center">
  	<tr style="background-color:rgb(213,213,213);height:40px;">
  		<th>No.</th>
  		<th>운동명</th>
  		<th>수정요청</th>
  		<th>수정내용</th>
  		<th>요청 아이디</th>
  		<th>
				<div class="dropdown-toggle" data-toggle="dropdown">상태
  				<div class="dropdown-menu">
			      <a class="dropdown-item" href="#" onclick="stateCheck('')">전체</a>
			      <a class="dropdown-item" href="#" onclick="stateCheck('미완료')">미완료</a>
			      <a class="dropdown-item" href="#" onclick="stateCheck('수정완료')">수정완료</a>
			    </div>
  			</div>
			</th>
			<th>요청 날짜</th>
  	</tr>
  	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
  	<c:if test="${empty vos}">
  		<tr>
  			<td colspan="7">수정 요청 내역이 없습니다.</td>
  		</tr>
  	</c:if>
  	<c:forEach var="vo" items="${vos}" varStatus="st">
	  		<tr>
	  			<td>${curScrStartNo}</td>
	  			<td>${vo.HName}</td>
	  			<td>${vo.modifyPart}</td>
	  			<td><a href="#">내용보기</a></td>
	  			<td>${vo.requestMid}</td>
	  			<td>
	  				<c:if test="${vo.modifyState == '미완료'}"><a href="#" title="답변하러가기">
	  					${vo.modifyState}<i class='fas fa-caret-right'></i></a>
	  				</c:if>
	  				<c:if test="${vo.modifyState != '미완료'}">${vo.modifyState}</c:if>
	  			</td>
	  			<td>
	  				<c:if test="${vo.date_diff < 0}">
			  			${fn:substring(vo.modifyDate,0,10)}
	  				</c:if>
	  				<c:if test="${vo.date_diff == 0 && vo.hour_diff < 24}">
	  					${fn:substring(vo.modifyDate,11,16)} <span class="badge badge-danger" style="font-size:0.5em">N</span>
	  				</c:if>
	  			</td>
	  		</tr> 
  		<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
  	</c:forEach>
  </table>
</div>

<!-- 블록페이지 시작-->
<br/>
<div class="text-center">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="inquiryList?pag=1&pageSize=${pageVO.pageSize}">첫페이지</a></li></c:if>
  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="inquiryList?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">이전블록</a></li></c:if>
  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
	    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="inquiryList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
	    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="inquiryList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
  	</c:forEach>
  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="inquiryList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음블록</a></li></c:if>
  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="inquiryList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li></c:if>
  </ul>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>