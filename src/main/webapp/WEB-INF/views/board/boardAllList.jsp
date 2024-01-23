<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>boardAllList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
  <style>
  	th {
      text-align: center;
    }
    
    a {
    	color:black;
    	text-decoration-line:none;
    }
    
    body {
  		background-color: rgb(76,76,76);
  	}
  	
		table{
			background-color: rgb(246,246,246);
		}
  </style>
  
  <script>
  	'use strict';
  	
  	function pageSizeCheck(){
  		let pageSize = $("#pageSize").val();
  		location.href = "boardAllList?pageSize="+pageSize;
  	}
  	
  	function partCheck(){
  		let part = $("#part").val();
  		location.href="boardAllList?part="+part;
  	}
  	
  	function searchCheck(){
  		let search = $("#search").val();
  		let searchString = $("#searchString").val();
  		
  		if(searchString.trim() == ""){
  			alert("검색하실 단어를 입력해 주세요.");
  			return false;
  		}
  		
  		location.href="boardAllList?search="+search+"&searchString="+searchString;
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
			<a class="btn btn-secondary mb-4" href="boardList" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px'></i></a>
		</div>
		<div class="col-6 text-center">
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px; color: white;">전 체 게 시 글</span>
		</div>
		<div class="col-3 text-right">
			<a class="btn btn-secondary" href="${ctp}/board/boardInput" style="margin-right:20px;">글작성</a>
		</div>
	</div>
	<form name="searchForm">
		<div class="row mb-5">
			<div class="col-7 text-left">
				<select class="form-control mb-3" style="width:150px;" name="part" id="part" onchange="partCheck()">
	        <option ${part == "" ? "selected" : ""} value="">전체</option>
	        <option ${part == "운동" ? "selected" : ""}>운동</option>
	        <option ${part == "식단" ? "selected" : ""}>식단</option>
	        <option ${part == "기타" ? "selected" : ""}>기타</option>
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
		          <option ${search == "" ? "selected" : ""} value="">선택</option>
		          <option ${search == "title" ? "selected" : ""} value="title">제목</option>
		          <option ${search == "nickName" ? "selected" : ""} value="nickName">작성자</option>
		          <option ${search == "content" ? "selected" : ""} value="content">내용</option>
		        </select>
		    	</div>
		      <input type="text" name="searchString" id="searchString" value="${searchString}" class="form-control mr-sm-2" placeholder="검색어를 입력해주세요"/>
		      <div class="input-group-append">
		     		<a href="#" onclick="searchCheck()" class="btn btn-outline-secondary my-2 my-sm-0"><i class='fas fa-search' style='font-size:20px'></i></a>
		     	</div>
	     	</div>
			</div>
		</div>
  </form>
  <table class="table table-hover text-center">
  	<tr style="background-color:rgb(213,213,213);height:40px;">
  		<th>No.</th>
  		<th>작성자</th>
  		<th>제목</th>
  		<th>분류</th>
  		<th>작성일</th>
  		<th>조회수</th>
  	</tr>
  	<tr><td colspan="6" class="p-0"></td></tr>
		<c:if test="${empty vos}">
			<tr>
				<td colspan="6">해당 조건에 대한 게시물이 없습니다.</td>
			</tr>
		</c:if>
  	<c:forEach var="vo" items="${vos}" varStatus="st">
	  	<c:if test="${vo.delCheck != 'OK'}">
	  		<tr>
	  			<td>${st.count}</td>
	  			<td>${vo.nickName}</td>
	  			<td><a href="boardContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}">${vo.title} </a> (${vo.replyCnt})</td>
	  			<td>${vo.part}</td>
	  			<td>
	  				<c:if test="${vo.hour_diff > 24}">${fn:substring(vo.WDate,0,10)}</c:if>
	  				<c:if test="${vo.hour_diff <= 24}">${vo.date_diff == 0 ? fn:substring(vo.WDate,11,16) : fn:substring(vo.WDate,0,16)}
	  				<span class="badge badge-danger" style="font-size:0.5em">N</span>
						</c:if>
	  			</td>
	  			<td>${vo.readNum}</td>
	  		</tr>
	  	</c:if>
  	</c:forEach>
  </table>
</div>

<div class="text-center">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="boardAllList?pag=1&pageSize=${pageVO.pageSize}">첫페이지</a></li></c:if>
  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="boardAllList?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">이전블록</a></li></c:if>
  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
	    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="boardAllList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
	    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="boardAllList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
  	</c:forEach>
  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="boardAllList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음블록</a></li></c:if>
  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="boardAllList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li></c:if>
  </ul>
</div>
<br/>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>