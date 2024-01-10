<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>boardList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
  <style>
  	th {
      text-align: center;
      background-color:gray;
    }
    
    a {
    	color:black;
    	text-decoration-line:none;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br /></p>
<p><br /></p>
<p><br /></p>
<div class="container">
	<div class="row mb-4">
		<div class="col-3 text-left">
			<a class="btn btn-secondary mb-4" href="${ctp}/" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px'></i></a>
		</div>
		<div class="col-6 text-center">
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px">커 뮤 니 티</span>
		</div>
		<div class="col-3 text-right">
			<a class="btn btn-secondary" href="${ctp}/board/boardInput" style="margin-right:20px;">글작성</a>
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
  	<tr style="background-color:gray;height:40px;">
  		<th>No.</th>
  		<th>작성자</th>
  		<th>제목</th>
  		<th>분류</th>
  		<th>작성일</th>
  		<th>조회수</th>
  	</tr>
  	<tr><td colspan="6" class="p-0"></td></tr>
  	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
	  	<c:forEach var="vo" items="${vos}" varStatus="st">
		  	<c:if test="${vo.delCheck != 'OK'}">
		  		<tr>
		  			<td>${curScrStartNo}</td>
		  			<td>${vo.nickName}</td>
		  			<td><a href="boardContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}">${vo.title}</a></td>
		  			<td>${vo.part}</td>
		  			<td>${fn:substring(vo.WDate,0,10)}</td>
		  			<td>${vo.readNum}</td>
		  		</tr>
		  		<c:set var="curScrStartNo" value="${curScrStartNo-1}"></c:set>
		  	</c:if>
	  	</c:forEach>
  </table>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>