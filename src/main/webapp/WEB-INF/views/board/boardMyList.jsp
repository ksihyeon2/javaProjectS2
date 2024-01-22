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
  	
  	function boardidx(idx){
  		$("#idx").val(idx);
  	}
  	
  	function ContentDelCheck(){
  		let pwd = $("#delPwd").val();
  		let mid = $("#delMid").val();
  		let delidx = $("#idx").val();
  		
  		if(pwd.trim() == ""){
  			alert("비밀번호를 입력해 주세요.");
				$("#delPwd").focus();
  			return false;
  		}
  		
  		let ans = confirm("해당 게시물을 삭제하시겠습니까?");
  		if(!ans){
  			return false;
  		}
  		
  		let query = {
  				pwd:pwd,
  				mid:mid,
  				delidx:delidx
  		};
  		
  		$.ajax({
  			url : "${ctp}/board/boardContentDel",
  			type : "post",
  			data : query,
  			success : function(res){
  				if(res != "0"){
  					let ans = confirm("해당 게시물이 삭제되었습니다. \n 휴지통으로 이동하시겠습니까?");
  					if(!ans){
  						location.reload();
  					} else {
	  					location.href="${ctp}/board/boardDelBox";
  					}
  				} else {
  					alert("비밀번호를 다시 확인해 주세요.");
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
			<a class="btn btn-secondary" href="${ctp}/board/boardInput?user=${sMid}" style="margin-right:10px;"><i class='far fa-edit' style='font-size:25px' title="글작성"></i></a>
			<a class="btn btn-danger" href="${ctp}/board/boardDelBox" style="margin-right:20px;"><i class='far fa-trash-alt' style='font-size:25px;color:white;' title="휴지통"></i></a>
		</div>
	</div>
	
	<%-- <form name="searchForm">
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
  </form> --%>
  <table class="table table-hover text-center">
  	<tr style="background-color:rgb(213,213,213);height:40px;">
  		<th>No.</th>
  		<th>제목</th>
  		<th>분류</th>
  		<th>작성일</th>
  		<th>조회수</th>
  		<th></th>
  	</tr>
  	<tr><td colspan="6" class="p-0"></td></tr>
  	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
	  	<c:forEach var="vo" items="${vos}" varStatus="st">
	  		<c:if test="${vo.delCheck != 'OK'}">
		  		<tr>
		  			<td>${curScrStartNo}</td>
		  			<td><a href="boardContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&mid=${vo.mid}">${vo.title} </a> (${vo.replyCnt})</td>
		  			<td>${vo.part}</td>
		  			<td>${fn:substring(vo.WDate,0,10)}</td>
		  			<td>${vo.readNum}</td>
		  			<td><a href="#" onclick="boardidx('${vo.idx}')" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#delModal" style="margin-right:20px;" title="삭제하기">삭제</a></td>
		  			<!-- <td><input type="button" value="삭제" class="btn btn-danger btn-sm" onclick="" title="삭제하기"/></td> -->
		  		</tr>
	  			<c:set var="cnt" value="${cnt+1}"/>
		  		<c:set var="curScrStartNo" value="${curScrStartNo-1}"></c:set>
		  	</c:if>
	  	</c:forEach>
	  	<c:if test="${empty cnt}">
	  		<tr>
	  			<td colspan="6" ><i class='fas fa-search mt-3' style='font-size:36px'></i><br />작성된 게시물이 없습니다.</td>
	  		</tr>
	  	</c:if>
  </table>
</div>

<!-- 삭제 Modal -->
<div class="modal fade" id="delModal">
	<div class="modal-dialog">
	    <div class="modal-content">
	    <!-- Modal Header -->
	        <div class="modal-header">
	        	<h4 class="modal-title">${sNickName}님 해당 게시물을 삭제하시려면<br />비밀번호를 입력해 주세요.</h4>
	          	<button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
	        <!-- Modal body -->    
	        <div class="modal-body">
	         	<input type="password" name="delPwd" id="delPwd" class="form-control" />
	        	<input type="hidden" name="delMid" id="delMid" value="${sMid}" />
	        	<input type="hidden" name="idx" id="idx" />
	        </div>
	        <!-- Modal footer -->
	        <div class="modal-footer">
	          	<button type="button" class="btn btn-primary" onclick="ContentDelCheck()">삭제</button>
	          	<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
	        </div>
	    </div>
	</div>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>