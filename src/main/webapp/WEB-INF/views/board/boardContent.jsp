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
  <script>
  	'use strict';
  	
  	$(function(){
  		$("#goodOk").hide();
  		$("#ReplyOk").hide();
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
  	function goodNoCheck() {
  		$("#goodOk").show();
  		$("#goodNo").hide();
  		
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
  	function goodOkCheck() {
  		$("#goodOk").hide();
  		$("#goodNo").show();
  		
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
  	
  	function replyOpen(){
  		$("#ReplyOk").show();
  		$("#ReplyNo").hide();
  	}
  	
  	function replyClose(){
  		$("#ReplyOk").hide();
  		$("#ReplyNo").show();
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
			<th>작성자</th>
			<td>${vo.nickName}</td>
			<th>작성일</th>
			<td>${fn:substring(vo.WDate,0,10)}</td>
		</tr>
		<tr>
			<th>제 목</th>
			<td colspan="2" class="text-left">${vo.title}</td>
			<td>
				<table class="table table-borderless m-0">
					<tr>
						<th>분류</th>
						<td>${vo.part}</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${vo.readNum}</td>
			<th>공감</th>
			<td>${vo.good}</td>
		</tr>
		<tr>
			<th>내용</th>
			<td colspan="3" style="height:220px;text-align:left;">
				${fn:replace(vo.content,newLine,"<br />")}
			</td>
		</tr>
		<tr>
			<td colspan="4">
				<table class="table table-borderless m-0">
					<tr>
						<td>
							<a href="javascript:goodNoCheck()"><i class='far fa-thumbs-up' style='font-size:30px;color:black;' id="goodNo"></i></a>
							<a href="javascript:goodOkCheck()"><i class='fas fa-thumbs-up' style='font-size:30px;color:black;' id="goodOk"></i></a>
						</td>
						<td>
							<a href="javascript:replyOpen()"><i class='far fa-comment-dots' style='font-size:30px;color:black;' id="ReplyNo"></i></a>
							<a href="javascript:replyClose()"><i class='fas fa-comment-dots' style='font-size:30px;color:black;' id="ReplyOk"></i></a>
						</td>
						<td>
							<c:if test="${sMid != vo.mid}">
								<a href="#" data-toggle="modal" data-target="#complaintModal" style="margin-right:20px;"><i class="material-icons" style="font-size:35px;color:red">room_service</i></a>
							</c:if>
							<c:if test="${sMid == vo.mid}">
								<a href="#" data-toggle="modal" data-target="#delModal" style="margin-right:20px;"><i class='far fa-trash-alt' style='font-size:30px;color:black;'></i></a>
							</c:if>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	
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