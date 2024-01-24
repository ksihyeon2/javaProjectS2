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
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px; color: white;">커 뮤 니 티</span>
		</div>
		<div class="col-3 text-right">
			<a class="btn btn-secondary" href="${ctp}/board/boardInput" style="margin-right:20px;">글작성</a>
		</div>
	</div>
  <table class="table table-hover text-center">
  	<tr>
  		<td>
  			<table class="table table-hover text-center">
  				<tr style="background-color:rgb(213,213,213);height:40px;">
  					<th colspan="3">인기 게시글</th>
  					<c:forEach var="vo" items="${vos}" varStatus="st">
	  					<tr>
	  						<c:if test="${vo.delCheck != 'OK'}">
		  						<c:if test="${vo.readNum >= 20}">
		  							<td>${st.count}</td>
		  							<td><a href="boardContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}">${vo.title} </a> (${vo.replyCnt})</td>
		  							<td>
											<c:if test="${vo.hour_diff > 24}">${fn:substring(vo.WDate,0,10)}</c:if>
						  				<c:if test="${vo.hour_diff <= 24}">
						  					${vo.date_diff == 0 ? fn:substring(vo.WDate,11,16) : fn:substring(vo.WDate,0,16)}
						  					<span class="badge badge-danger" style="font-size:0.5em">N</span>
											</c:if>
										</td>
		  						</c:if>
	  						</c:if>
	  					</tr>
  					</c:forEach>
  				</tr>
  			</table>
  		</td>
  		<td>
  			<table class="table table-hover text-center">
  				<tr style="background-color:rgb(213,213,213);height:40px;">
  					<th colspan="3"><a href="boardMyList">나의 게시글 보기 ></a></th>
  				</tr>
  				<c:forEach var="vo" items="${vos}" varStatus="st">
  					<tr>
  						<c:if test="${vo.mid == sMid}">
  							<td>${st.count}</td>
  							<td><a href="boardContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}">${vo.title} </a> (${vo.replyCnt})</td>
  							<td>
									<c:if test="${vo.hour_diff > 24}">${fn:substring(vo.WDate,0,10)}</c:if>
				  				<c:if test="${vo.hour_diff <= 24}">
				  					${vo.date_diff == 0 ? fn:substring(vo.WDate,11,16) : fn:substring(vo.WDate,0,16)}
				  					<span class="badge badge-danger" style="font-size:0.5em">N</span>
									</c:if>
								</td>
  						</c:if>
  					</tr>
  				</c:forEach>
  			</table>
  		</td>
  	</tr>
  </table>
  <table class="table table-hover text-center">
  	<tr style="background-color:rgb(213,213,213);height:40px;">
  		<th colspan="6">전체 게시글</th>
  		<td><a href="boardAllList"><i class='fas fa-angle-right' style='font-size:24px;'></i></a></td>
  	</tr>
  	<tr style="background-color:rgb(213,213,213);height:40px;">
  		<th>No.</th>
  		<th>작성자</th>
  		<th>제목</th>
  		<th>분류</th>
  		<th>작성일</th>
  		<th>조회수</th>
  		<th></th>
  	</tr>
  	<tr><td colspan="6" class="p-0"></td></tr>
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
	  			<td></td>
	  		</tr>
	  	</c:if>
  	</c:forEach>
  </table>
</div>
<br/>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>