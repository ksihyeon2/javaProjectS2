 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>noticeList.jsp</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
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
		
		.notice{
			font-weight: bolder;	
			font-size:1.1em;
		}
  </style>
  <script>
  	'use strict';
  	
  	function noticeDown(idx){
  		let ans = confirm("해당 공지를 내리시겠습니까?");
  		if(!ans){
  			return false;
  		}
  		
  		let query = {
  				idx:idx,
  				state:'down'
  		};
  		
  		
  		$.ajax({
  			url : "noticeStateChange",
  			type : "post",
  			data : query,
  			success : function(res){
  				if(res == "1"){
  					alert("해당 공지 사항의 등록을 취소했습니다.");
  				} else {
  					alert("다시 시도해 주세요.")
  				}
					location.reload();
  			},
  			error : function(){
  				alert("전송 오류");
  			}
  		});
  	}
  	
  	function noticeUp(idx){
  		let ans = confirm("해당 공지를 재등록 하시겠습니까?");
  		
  		if(!ans){
  			return false;
  		}
  		
  		let query = {
  				idx:idx,
  				state:'up'
  		};
  		
  		$.ajax({
  			url : "noticeStateChange",
  			type : "post",
  			data : query,
  			success : function(res){
  				if(res == "1"){
  					alert("해당 공지 사항을 등록하였습니다.");
  				} else {
  					alert("다시 시도해 주세요.")
  				}
					location.reload();
  			},
  			error : function(){
  				alert("전송 오류");
  			}
  		});
  	}
  	
  	// checkbox 이용하여 검색
  	function stateCheck(){
  		let state = $("#state").val();
  		location.href="noticeList?state="+state;
  	}
  	
  	
  	// 검색기
  	function searchCheck(){
  		let search = $("#search").val();
  		let searchString = $("#searchString").val();
  		
  		if(searchString.trim() == ""){
  			alert("검색하실 단어를 입력해 주세요.");
  			return false;
  		}
  		
  		location.href="noticeList?search="+search+"&searchString="+searchString;
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
			<a class="btn btn-secondary mb-4" href="${ctp}/admin/adminPage" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px'></i></a>
		</div>
		<div class="col-6 text-center">
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px; color: white;">공 지 관 리 창</span>
		</div>
		<div class="col-3 text-right">
			<a class="btn btn-secondary" href="${ctp}/board/boardInput?notice=공지" style="margin-right:20px;">공지작성</a>
		</div>
	</div>
	<form name="searchForm">
		<div class="row mb-5">
			<div class="col-7 text-left">
				<select class="form-control mb-3" style="width:150px;" name="state" id="state" onchange="stateCheck()">
	        <option ${state == "" ? "selected" : ""} value="">전체</option>
	        <c:if test="${empty main}">
	        	<option ${state == "등록" ? "selected" : ""}>등록</option>
	        </c:if>
	        <c:if test="${!empty main}">
		        <option selected>등록</option>
	        </c:if>
	        <option ${state == "미등록" ? "selected" : ""}>미등록</option>
	      </select>
			</div>
			<div class="col-5 text-right">
	    	<div class="input-group">
		    	<div class="mr-3">
		        <select name="search" id="search" class="form-control">
		          <option ${search == "" ? "selected" : ""} value="">선택</option>
		          <option ${search == "title" ? "selected" : ""} value="title">제목</option>
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
  		<th>제목</th>
  		<th>작성일</th>
  		<th>조회수</th>
  		<th>상태</th>
  		<th>등록</th>
  	</tr>
		<c:forEach var="vo" items="${vos}" varStatus="st">
	  	<tr>
  			<td>${st.count}</td>
  			<td><a href="${ctp}/board/boardContent?idx=${vo.idx}">${vo.title}</a></td>
  			<td>
  				<c:if test="${vo.hour_diff > 24}">${fn:substring(vo.WDate,0,10)}</c:if>
  				<c:if test="${vo.hour_diff <= 24}">${vo.date_diff == 0 ? fn:substring(vo.WDate,11,16) : fn:substring(vo.WDate,0,16)}
  				<span class="badge badge-danger" style="font-size:0.5em">N</span>
					</c:if>
  			</td>
  			<td>${vo.readNum}</td>
					<c:if test="${vo.openSw == 'OK'}">
		  			<td>등록중</td>
		  			<td><input type="button" value="내리기" onclick="noticeDown(${vo.idx})" class="btn btn-secondary"></td>
					</c:if>
					<c:if test="${vo.openSw != 'OK'}">
		  			<td>미등록</td>
		  			<td><input type="button" value="등록" onclick="noticeUp(${vo.idx})" class="btn btn-secondary"></td>
	  			</c:if>
  		</tr>
		</c:forEach>
  	<tr><td colspan="6" class="p-0"></td></tr>
		<c:if test="${empty vos}">
			<tr>
				<td colspan="6">해당 조건에 공지 사항이 없습니다.</td>
			</tr>
		</c:if>
  	<c:forEach var="vo" items="${vos}" varStatus="st">
  		<c:if test="${vo.part != '공지'}">
		  	<c:if test="${vo.delCheck != 'OK'}">
		  		<tr>
		  			<td>${st.count}</td>
		  			<td>${vo.nickName}</td>
		  			<td><a href="boardContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&user=${user}">${vo.title} </a> (${vo.replyCnt})</td>
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
	  	</c:if>
  	</c:forEach>
  </table>

</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>