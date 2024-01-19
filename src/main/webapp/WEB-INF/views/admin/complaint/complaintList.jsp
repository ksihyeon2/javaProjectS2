<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>complaintList.jsp</title>
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
  	
  	function complaintNO(complaintidx){
  		let ans = confirm("해당 신고물의 상태를 '보류'로 변경하시겠습니까?");
  		
  		if(!ans){
  			return false;
  		}
  		
  		$.ajax({
  			url : "${ctp}/admin/complaintNO",
  			type : "post",
  			data : {idx:complaintidx},
  			success : function(res){
  				if(res != 0){
  					location.reload();
  				}
  			},
  			error : function(){
  				alert("전송 오류");
  			}
  		});
  	}
  	
  	/* 
  	function partCheck(part){
  		let part = part;
  		
  		$.ajax({
  			url : "${ctp}/admin/complaintPartCheck",
  			type : "post",
  			data : {part:part},
  			success : function()
  		});
  	}
  	 */
  	 
  	// 신고 사유 보기
  	function complaintText(idx){
  		 $.ajax({
  			 url : "${ctp}/admin/complaintText",
  			 type : "post",
  			 data : {idx:idx},
  			 success : function(res){
  				 $(".modal-body").html(res);
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
			<a class="btn btn-secondary mb-4" href="${ctp}/admin/adminPage" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px' title="뒤로가기"></i></a>
		</div>
		<div class="col-6 text-center">
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px">신 고 관 리</span>
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
		          <option selected value="">선택</option>
		          <option value="title">아이디</option>
		          <option value="member">닉네임</option>
		          <option value="content">성명</option>
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
  		<th>
  			<div class="dropdown-toggle" data-toggle="dropdown">분류
  				<div class="dropdown-menu">
			      <a class="dropdown-item" href="#" onclick="partCheck('')">전체</a>
			      <a class="dropdown-item" href="#" onclick="partCheck('board')">게시물</a>
			      <a class="dropdown-item" href="#" onclick="partCheck('reply')">댓글</a>
			    </div>
  			</div>
  		</th>
  		<th>신고자</th>
  		<th>제목</th>
  		<th>
				<div class="dropdown-toggle" data-toggle="dropdown">사유
  				<div class="dropdown-menu">
			      <a class="dropdown-item" href="#">전체</a>
			      <a class="dropdown-item" href="#">폭력</a>
			      <a class="dropdown-item" href="#">거짓정보</a>
			      <a class="dropdown-item" href="#">스팸</a>
			      <a class="dropdown-item" href="#">혐오</a>
			      <a class="dropdown-item" href="#">기타</a>
			    </div>
  			</div>
			</th>
  		<th>신고일</th>
  		<th>
				<div class="dropdown-toggle" data-toggle="dropdown">상태
  				<div class="dropdown-menu">
			      <a class="dropdown-item" href="#">전체</a>
			      <a class="dropdown-item" href="#">대기중</a>
			      <a class="dropdown-item" href="#">보류</a>
			      <a class="dropdown-item" href="#">완료</a>
			    </div>
  			</div>
			</th>
  		<th>관리</th>
  	</tr>
  	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
  	<c:forEach var="vo" items="${vos}" varStatus="st">
  		<tr>
  			<td>${curScrStartNo}</td>
  			<td>
  				<c:if test="${vo.complaintPart == 'board'}">
  					게시물
  				</c:if>
  				<c:if test="${vo.complaintPart == 'reply'}">
  					댓글
  				</c:if>
  			</td>
  			<td>${vo.complaintMid}</td>
  			<td>
  				<c:if test="${vo.complaintState == '삭제완료' }">
  					<span style="font-size:0.8em">삭제된 게시물</span>
  				</c:if>
  				<c:forEach var="boardVO" items="${boardVOS}" varStatus="st">
  					<c:if test="${vo.complaintidx == boardVO.idx}">
  						<b>${boardVO.title}</b>
  					</c:if>
  				</c:forEach>
  			</td>
  			<td>
  				<c:if test="${vo.complaintType == '기타' && vo.complaintState == '삭제완료'}">${vo.complaintType}</c:if>
  				<c:if test="${vo.complaintType == '기타' && vo.complaintState != '삭제완료'}"><a href="#" onclick="complaintText(${vo.idx})" data-toggle="modal" data-target="#myModal">${vo.complaintType} <i class='fas fa-caret-right'></i></a></c:if>
  				<c:if test="${vo.complaintType != '기타' && !empty vo.complaintText}"><a href="" data-toggle="modal" data-target="#myModal">${vo.complaintType} <i class='fas fa-caret-right'></i></a></c:if>
  				<c:if test="${vo.complaintType != '기타' && empty vo.complaintText}">${vo.complaintType}</c:if>
  			</td>
  			<td>${fn:substring(vo.complaintDate,0,10)}</td>
  			<td>
  				<c:if test="${vo.complaintState == '대기중'}">
	  				<div class="dropdown-toggle" data-toggle="dropdown">${vo.complaintState}
		  				<div class="dropdown-menu">
					      <a class="dropdown-item" href="#" onclick="complaintNO(${vo.complaintidx})">보류</a>
					    </div>
		  			</div>
  				</c:if>
  				<c:if test="${vo.complaintState != '대기중'}">
	  				${vo.complaintState}
  				</c:if>
  			</td>
  			<td>
  				<c:if test="${vo.complaintPart == 'board'}">
  					<c:if test="${vo.complaintState == '삭제완료'}">
  						검토완료
  					</c:if>
  					<c:if test="${vo.complaintState == '보류'}">
  						<a href="complaintCheck?complaintidx=${vo.complaintidx}">검토완료</a>
  					</c:if>
  					<c:if test="${vo.complaintState != '삭제완료' && vo.complaintState != '보류'}">
  						<a href="complaintCheck?complaintidx=${vo.complaintidx}">검토하기 <i class='fas fa-caret-right'></i></a>
  					</c:if>
  				</c:if>
  				<c:if test="${vo.complaintPart == 'reply'}">
  					<a href="#">확인하기 <i class='fas fa-caret-right'></i></a>
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
    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="complaintList?pag=1&pageSize=${pageVO.pageSize}">첫페이지</a></li></c:if>
  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="complaintList?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">이전블록</a></li></c:if>
  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
	    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="complaintList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
	    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="complaintList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
  	</c:forEach>
  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="complaintList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음블록</a></li></c:if>
  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="complaintList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li></c:if>
  </ul>
</div>


 <!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title"></h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body"></div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        </div>
        
      </div>
    </div>
  </div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>