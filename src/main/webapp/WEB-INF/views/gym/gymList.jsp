<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>gymList.jsp</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
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
				<a class="btn btn-secondary mb-4" href="${ctp}/" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px'></i></a>
			</div>
			<div class="col-6 text-center">
				<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px">헬스장 검색</span>
			</div>
			<c:if test="${sLevel == 0}">
				<div class="col-3 text-right">
					<a class="btn btn-secondary" href="gymInput" style="margin-right:20px;">등록하기</a>
				</div>
			</c:if>
		</div>
		<table class="table table-borderless m-0 p-0">
	    <tr>
	      <td>
	      	<!-- 검색기 처리 -->
				<div class="container text-center">
					<form name="searchForm" method="post">
						<b>검색 : </b>
						<input type="text" name="searchString" id="searchString" value="${searchString}" />
						<input type="button" value="검색" class="btn btn-secondary btn-sm" onclick="searchCheck()"/>
						<input type="hidden" name="pag" value="${pag}" />
						<input type="hidden" name="pageSize" value="${pageSize}" />
					</form>
				</div>
	      </td>
	      <td class="text-right">
	        <div>
	          <select name="pageSize" id="pageSize" onchange="pageSizeCheck()">
	            <option value="3"  ${pageSize == 3? "selected" : ""}>3</option>
	            <option value="5"  ${pageSize == 5 ? "selected" : ""}>5</option>
	            <option value="10" ${pageSize == 10 ? "selected" : ""}>10</option>
	            <option value="15" ${pageSize == 15 ? "selected" : ""}>15</option>
	            <option value="20" ${pageSize == 20 ? "selected" : ""}>20</option>
	          </select> 건
	        </div>
	      </td>
	    </tr>
	  </table>
	  <table class="table table-hover text-center">
	    <tr class="table-dark text-dark" >
	      <th style="color:white;">번호</th>
	      <th style="color:white;">지점</th>
	      <th style="color:white;">
	      	<select name="area" id="area" onchange="areaCheck()">
		        <option value="" ${area == '' ? 'selected' : ''}>지역</option>
		        <option ${area == '서울' ? 'selected' : ''}>서울</option>
		        <option ${area == '경기' ? 'selected' : ''}>경기</option>
		        <option ${area == '인천' ? 'selected' : ''}>인천</option>
		        <option ${area == '충남' ? 'selected' : ''}>충남</option>
		        <option ${area == '대전' ? 'selected' : ''}>대전</option>
		       	<option ${area == '충북' ? 'selected' : ''}>충북</option>
		       	<option ${area == '부산' ? 'selected' : ''}>부산</option>
	         	<option ${area == '울산' ? 'selected' : ''}>울산</option>
          	<option ${area == '전북' ? 'selected' : ''}>전북</option>
          	<option ${area == '광주' ? 'selected' : ''}>광주</option>
	        </select>
	      </th>
	      <th style="color:white;">상세주소</th>
	      <th style="color:white;">사이트</th>
	    </tr>
	    <c:forEach var="vo" items="${vos}" varStatus="st">
	      <tr>
	        <td>${curScrStartNo}</td>
	        <td>
	        	<a href="${ctp}/gym/gyminfor?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}" title="상세보기">${vo.gymName}</a>
	        </td>
	        <td>${vo.area}</td>
	        <td>
	        	<span title="${vo.address}">${fn:substring(vo.address,0,15)}...</span>
	        </td>
	        <td>
	        	<c:if test="${!empty vo.homePage}">
	        		<a href="${vo.homePage}" title="사이트 바로가기"><font color="blud">사이트 가기</font><i class='fas fa-caret-right'></i></a>
	        	</c:if>
	        	<c:if test="${empty vo.homePage}">
	        		없음
	        	</c:if>
	        </td>
	      </tr>
	      <c:set var="curScrStartNo" value="${curScrStartNo+1}"/>
	    </c:forEach>
	    <tr><td colspan="9" class="m-0 p-0"></td></tr>
	  </table>
	</div>
		
	<!-- 블록페이지 시작-->
	<br/>
	<div class="text-center">
	  <ul class="pagination justify-content-center">
	    <c:if test="${pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="gymList.gym?pag=1&pageSize=${pageSize}">첫페이지</a></li></c:if>
	  	<c:if test="${curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="gymList.gym?pag=${(curBlock-1)*blockSize+1}&pageSize=${pageSize}">이전블록</a></li></c:if>
	  	<c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}" varStatus="st">
		    <c:if test="${i <= totPage && i == pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="gymList.gym?pag=${i}&pageSize=${pageSize}">${i}</a></li></c:if>
		    <c:if test="${i <= totPage && i != pag}"><li class="page-item"><a class="page-link text-secondary" href="gymList.gym?pag=${i}&pageSize=${pageSize}">${i}</a></li></c:if>
	  	</c:forEach>
	  	<c:if test="${curBlock < lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="gymList.gym?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}">다음블록</a></li></c:if>
	  	<c:if test="${pag < totPage}"><li class="page-item"><a class="page-link text-secondary" href="gymList.gym?pag=${totPage}&pageSize=${pageSize}">마지막페이지</a></li></c:if>
	  </ul>
	</div>
	<!-- 블록페이지 끝 -->
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>