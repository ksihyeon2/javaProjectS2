<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>boardContent.jsp</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
  <style>
  	a {
    	text-decoration-line:none;
    }
  </style>
  <script>
  	'use strict';
  	
  	$(function(){
  		$("#replyOk").hide();
  		$(".replyCloseBtn").hide();
  	});
  	
  	// 신고 접수
  	function reportCheck(){
  		let complaintType = $("#complaintType").val();
  		let complaintText = $("#complaintText").val();
  		let complaintMid = $("#mid").val();
  		
  		if(complaintType == "") {
  			alert("신고 사유를 선택해 주세요.");
  			$("#complaintType").focus();
  			return false;
  		}
  		
  		if(complaintType == "기타" && complaintText.trim() == ""){
  			alert("기타 선택은 사유를 입력해 주세요.");
  			$("#complaintText").focus();
  			return false;
  		}
  		
  		let ans = confirm("해당 게시물을 신고하시겠습니까?");
  		if(!ans){
  			location.reload();
  			return false;
  		}
  		
  		let query = {
  				complaintType:complaintType,
  				complaintText:complaintText,
  				complaintMid:complaintMid
  		};
  		
  		$.ajax({
  			url : "${ctp}/board/boardComplaint?idx="+${vo.idx},
  			type : "post",
  			data : query,
  			success : function(res){
  				if(res == "1"){
  					alert("해당 게시물의 신고 접수가 완료되었습니다.");
  				} else if (res == "2"){
  					alert("이미 신고 완료된 게시물입니다.");
  				}	else {
  					alert("해당 게시물의 신고 접수에 실패하였습니다.");
  				}
  				location.reload();
  			},
  			error : function(){
  				alert("전송 오류");
  			}
  		});
  	}
  	
  	// 게시물 삭제
  	function ContentDelCheck(){
  		let pwd = $("#delPwd").val();
  		let mid = $("#mid").val();
  		
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
  				mid:mid
  		};
  		
  		$.ajax({
  			url : "${ctp}/board/boardContentDel?idx="+${vo.idx},
  			type : "post",
  			data : query,
  			success : function(res){
  				if(res != "0"){
  					alert("해당 게시물이 삭제되었습니다.");
  					location.href="${ctp}/board/boardList";
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
  	
  	// 공감 버튼 
  	function goodOkCheck() {
  		let idx = ${vo.idx};
  		let goodCheck = "OK";
  		
  		let query = {
  				idx:idx,
  				goodCheck:goodCheck
  		};
  		
  		$.ajax({
  			url : "${ctp}/board/boardContentGoodCheck",
  			type : "post",
  			data : query,
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
  	
  	// 공감 버튼 취소
  	function goodNoCheck() {
  		let idx = ${vo.idx};
  		let goodCheck = "NO";
  		
  		let query = {
  				idx:idx,
  				goodCheck:goodCheck
  		};
  		
  		$.ajax({
  			url : "${ctp}/board/boardContentGoodCheck",
  			type : "post",
  			data : query,
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
  	
  	// 댓글창 열기
 		function replyOpen(){
  		$("#replyOk").hide();
  		$("#replyNo").show();
  		$(".replyTable").show();
  	}
  	
  	// 댓글창 닫기
  	function replyClose(){
  		$("#replyOk").show();
  		$("#replyNo").hide();
  		$(".replyTable").hide();
  	} 
  	
  	// 댓글 작성
  	function replyCheck(){
  		let content = $("#content").val();
  		
  		if(content.trim() == ""){
  			alert("댓글을 입력해 주세요.");
  			$("#content").focus();
  			return false;
  		}
  		
  		let query = {
  				boardIdx:${vo.idx},
  				nickName:'${sNickName}',
  				content:content
  		};
  		
  		$.ajax({
  			url : "${ctp}/board/boardReplyInput",
  			type : "post",
  			data : query,
  			success : function(res){
  				if (res != "0"){
  					location.reload();
  				} else {
  					alert("댓글 입력에 실패하셨습니다.");
  				}
  			},
  			error : function(){
  				alert("전송 오류");
  			}
  		});
  	}
  	
  	// 답글 테이블 보여주기
  	function replyShow(idx){
  		$("#replyShowBtn"+idx).hide();
			$("#replyCloseBtn"+idx).show();
			$("#replyDemo"+idx).slideDown(200);
			$("#contentRe"+idx).focus();
  	}  	
  	
  	// 답글 테이블 닫기
  	function replyShowClose(idx){
			$("#replyShowBtn"+idx).show();
			$("#replyCloseBtn"+idx).hide();
			$("#replyDemo"+idx).slideUp(100);
		}
  	
  	// 답글 작성
  	function replyCheckRe(idx,re_step,re_order){
  		let content = $("#contentRe"+idx).val();
  		if(content.trim() == "") {
  			alert("답변글을 입력해 주세요.");
  			$("#contentRe"+idx).focus();
  			return false;
  		}
  		
  		let query = {
  				boardIdx:${vo.idx},
  				re_step:re_step,
  				re_order:re_order,
  				nickName:'${vo.nickName}',
  				content:content
  		};
  		
  		$.ajax({
  			url : "${ctp}/board/boardReplyInputRe",
  			type : "post",
  			data : query,
  			success : function(res){
  				if (res != "0"){
  					location.reload();
  				} else {
  					alert("댓글 입력에 실패하셨습니다.");
  				}
  			},
  			error : function(){
  				alert("전송 오류");
  			}
  		});
  	}
  	
  	// 댓글 삭제
  	function replyDelete(idx){
  		let ans = confirm("해당 댓글을 삭제하시겠습니까?");
  		if(!ans){
  			return false;
  		}
  		
  		$.ajax({
  			url : "${ctp}/board/boardReplyDelete",
  			type : "post",
  			data : {idx:idx},
  			success : function(res){
  				if(res != "0"){
  					location.reload();
  				} else {
  					alert("댓글 삭제에 실패하셨습니다.");
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
<div class="container">
	<div class="row mb-4">
		<div class="col-3 text-left">
			<c:if test="${param.flag != 'search'}"><a class="btn btn-secondary mb-4" href="${ctp}/board/boardList?pag=${param.pag}&pageSize=${param.pageSize}" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px'></i></a></c:if>
			<c:if test="${param.flag == 'search'}"><a class="btn btn-secondary mb-4" href="${ctp}/board/boardSearchList?pag=${param.pag}&pageSize=${param.pageSize}&search=${param.search}&searchString=${param.searchString}" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px'></i></a></c:if>
		</div>
		<div class="col-6 text-center">
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px">커 뮤 니 티</span>
		</div>
	</div>
	
	<table class="table table-bordered text-center">
		<tr>
			<th style="background-color:rgb(213,213,213);">작성자</th>
			<td>${vo.nickName}</td>
			<th style="background-color:rgb(213,213,213);">작성일</th>
			<td>${fn:substring(vo.WDate,0,10)}</td>
		</tr>
		<tr>
			<th style="background-color:rgb(213,213,213);">제 목</th>
			<td>${vo.title}</td>
			<th style="background-color:rgb(213,213,213);">분류</th>
			<td>${vo.part}</td>
		</tr>
		<tr>
			<th style="background-color:rgb(213,213,213);">조회수</th>
			<td>${vo.readNum}</td>
			<th style="background-color:rgb(213,213,213);">공감</th>
			<td>${vo.good}</td>
		</tr>
		<tr>
			<th style="background-color:rgb(213,213,213);">내용</th>
			<td colspan="3" style="height:220px;text-align:left;">
				${fn:replace(vo.content,newLine,"<br />")}
			</td>
		</tr>
		<tr>
			<td colspan="4">
				<table class="table table-borderless m-0">
					<tr>
						<td>
							<c:if test="${empty goodCheckVO}">
								<a href="javascript:goodOkCheck()"><i class='far fa-thumbs-up' style='font-size:30px;color:black;' id="goodOk" title="공감하기"></i></a>
							</c:if>
							<c:if test="${!empty goodCheckVO}">
								<a href="javascript:goodNoCheck()"><i class='fas fa-thumbs-up' style='font-size:30px;color:black;' id="goodNo" title="공감 취소"></i></a>
							</c:if>
						</td>
						<td>
							<a href="javascript:replyOpen()"><i class='far fa-comment-dots' style='font-size:30px;color:black;' id="replyOk" title="댓글창 열기"></i></a>
							<a href="javascript:replyClose()"><i class='fas fa-comment-dots' style='font-size:30px;color:black;' id="replyNo" title="댓글창 닫기"></i></a>
						</td>
						<td>
							<c:if test="${sMid != vo.mid}">
								<a href="#" data-toggle="modal" data-target="#complaintModal" style="margin-right:20px;"><i class="material-icons" style="font-size:35px;color:red" title="신고하기">room_service</i></a>
							</c:if>
							<c:if test="${sMid == vo.mid}">
								<a href="#" data-toggle="modal" data-target="#delModal" style="margin-right:20px;"><i class='far fa-trash-alt' style='font-size:30px;color:black;' title="삭제하기"></i></a>
							</c:if>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<br />
	<hr />
	<br />
	<!-- 댓글창 -->
	<table class="table table-hover replyTable">
		<tr  class="text-center" style="background-color:rgb(213,213,213);">
			<th colspan="4"><h5>댓글 관리</h5></th>
		</tr>
		<c:if test="${empty replyVOS}">
			<tr>
				<td colspan="4" style="text-align:center;">아직 댓글이 없습니다. 댓글을 작성해 보세요.</td>
			</tr>
		</c:if>
		<c:forEach var="replyVO" items="${replyVOS}" varStatus="st">
			<table class="table table-borderless replyTable">
				<tr>
					<td>
						<c:if test="${replyVO.re_step >= 1}">
							<c:forEach var="i" begin="1" end="${replyVO.re_step}">&nbsp;&nbsp;</c:forEach> └
						</c:if>
						<b>${replyVO.nickName}</b>
						<c:if test="${replyVO.hour_diff > 24}">
							<span style="font-size:0.8em">${fn:substring(replyVO.WDate,0,10)}</span>
						</c:if>
						<c:if test="${replyVO.hour_diff <= 24}">
							<span style="font-size:0.8em">${replyVO.date_diff == 0 ? fn:substring(replyVO.WDate,11,16) : fn:substring(replyVO.WDate,0,16)}</span>
							<span class="badge badge-danger" style="font-size:0.5em">N</span>
						</c:if>
					</td>
					<td class="text-right">
						<a href="javascript:replyShow(${replyVO.idx})" id="replyShowBtn${replyVO.idx}" class="badge badge-secondary">답글</a> 
						<a href="javascript:replyShowClose(${replyVO.idx})" id="replyCloseBtn${replyVO.idx}" class="badge badge-secondary replyCloseBtn">닫기</a> 
						<c:if test="${replyVO.nickName == sNickName || sLevel == 0 }">
							<a href="javascript:replyDelete(${replyVO.idx})" class="badge badge-danger">삭제</a> 
						</c:if>
						<c:if test="${replyVO.nickName != sNickName}">
							<a href="javascript:replyComplaint(${replyVO.idx})" class="badge badge-danger">신고</a> 
						</c:if>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						${fn:replace(replyVO.content,newLine,"<br />")}
					</td>
				</tr>
				<tr>
					<td colspan="5" class="m-0 p-0">
						<div id="replyDemo${replyVO.idx}" style="display:none">
							<table class="table table-center">
								<tr>
									<td style="width:85%" class="text-left">
										<textarea rows="4" name="contentRe" id="contentRe${replyVO.idx}" class="form-control" style="background-color:rgb(234,234,234) "></textarea>
									</td>
									<td style="width:15%">
										<br /><br /><br />
										<p><input type="button" value="답글달기" onclick="replyCheckRe(${replyVO.idx},${replyVO.re_step},${replyVO.re_order})" class="btn btn-info btn-sm" /></p>
									</td>
								</tr>
							</table>
						</div>
						<hr />
					</td>
				</tr>
			</table>
			<tr><td colspan="5" class="m-0 p-0"></td></tr>
		</c:forEach>
	</table>
	<!-- 댓글 입력창 -->
		<form name="replyForm">
			<table class="table table-center replyTable">
				<tr style="background-color:rgb(213,213,213);">
					<td style="width:85%" class="text-left">
						댓글 입력
						<textarea rows="4" name="content" id="content" class="form-control"></textarea>
					</td>
					<td style="width:15%">
						<br /><br /><br /><br />
						<p><input type="button" value="댓글작성" onclick="replyCheck()" class="btn btn-info btn-sm" /></p>
					</td>
				</tr>
			</table>
		</form>
</div>

<!-- 신고 Modal -->
<div class="modal fade" id="complaintModal">
	<div class="modal-dialog">
	    <div class="modal-content">
	    <!-- Modal Header -->
	        <div class="modal-header">
	        	<h4 class="modal-title">해당 게시물의 신고 사유를 선택해 주세요.</h4>
	          	<button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
	        <!-- Modal body -->    
	        <div class="modal-body">
	        	<select class="form-control mb-3" style="width:150px;" id="complaintType">
			        <option selected value="">필수 선택</option>
			        <option>폭력물</option>
			        <option>거짓 정보</option>
			        <option>스팸</option>
			        <option>혐오</option>
			        <option>기타</option>
			      </select>
			      <span style="font-size:0.8em">*선택 사항(기타 선택 시 필수 입력 해주세요.)</span>
	         	<textarea rows="3" name="complaintText" id="complaintText" class="form-control"></textarea>
	        	<input type="hidden" name="mid" id="mid" value="${sMid}" />
	        </div>
	        <!-- Modal footer -->
	        <div class="modal-footer">
	          	<button type="button" class="btn btn-primary" onclick="reportCheck()">확인</button>
	          	<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
	        </div>
	    </div>
	</div>
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