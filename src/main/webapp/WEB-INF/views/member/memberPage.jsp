<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberPage.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
  <style>
  	a {
  		color:black;
  		text-decoration-line:none;
  	}
  </style>
  <script>
  	'use strict';
  	
  	// 정보 수정을 위한 비밀번호 확인
  	function pwdCheck(){
  		let pwd = $("#pwd").val();
  		let mid = $("#mid").val();
  		
  		location.href="memberModify?pwd="+pwd+"&mid="+mid;
  	}
  	
  	function memberDelOk(){
  		let pwd = $("#delPwd").val();
  		let mid = $("#delMid").val();
  		
  		let query = {
  				pwd:pwd,
  				mid:mid
  		}
  		
  		$.ajax({
  			url : "${ctp}/member/memberDelOk",
  			type : "post",
  			data : query,
  			success : function(res){
  				if(res != "0"){
  					alert("회원 탈퇴되셨습니다.");
  					location.href="${ctp}/member/memberLogout?del=ok";
  				} else {
  					alert("회원 탈퇴에 실패하셨습니다.");
  				}
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
<div class="container" style="margin-left:27%">
	<table class="table table-borderless" style="width:800px">
		<tr>
			<td colspan="2"><h2>프로필</h2><br /></td>
		</tr>
		<tr>
			<th><img src="${ctp}/member/${vo.photo}" style="width:70%;border-radius:70%;"></th>
			<th style="width:600px;vertical-align:bottom;">
				<h2>${vo.nickName}</h2>
				<span style="font:12pt;color:gray">${strLevel} / ${vo.point}p</span>
			</th>
		</tr>
		<tr>
			<td colspan="2">
				<table class="table table-bordered text-center">
					<tr>
						<td class="p-3"><i class='fas fa-user-cog' style='font-size:40px'></i><br /><br /><a href="#" data-toggle="modal" data-target="#myModal">나의 정보</a></td>
						<td class="p-3"><i class='fas fa-unlock' style='font-size:40px'></i><br /><br /><a href="memberPwdChange" >비밀번호 변경</a></td>
						<td class="p-3"><i class='fas fa-power-off' style='font-size:40px'></i><br /><br /><a href="memberLogout">로그아웃</a></td>
						<td class="p-3"><i class='fas fa-user-alt-slash' style='font-size:40px'></i><br /><br /><a href="#" style="color:red" data-toggle="modal" data-target="#delModal">탈퇴하기</a></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="padding-left:50px;padding-right:50px">
				<i class='fas fa-list-ul' style='font-size:36px'></i>&nbsp;&nbsp;&nbsp;<span style="font-size:24px"><a href="#">나의 게시물 확인</a></span><hr />
			</td>
		</tr>
		<tr>
			<td colspan="2" style="padding-left:50px;padding-right:50px">
				<i class='fas fa-list-ul' style='font-size:36px'></i>&nbsp;&nbsp;&nbsp;<span style="font-size:24px"><a href="#">최근 내역</a></span><hr />
			</td>
		</tr>
		<tr>
			<td colspan="2" style="padding-left:50px;padding-right:50px">
				<i class='fas fa-list-ul' style='font-size:36px'></i>&nbsp;&nbsp;&nbsp;<span style="font-size:24px"><a href="#">관심 목록</a></span><hr />
			</td>
		</tr>
		<tr>
			<td colspan="2" style="padding-left:50px;padding-right:50px">
				<i class='fas fa-list-ul' style='font-size:36px'></i>&nbsp;&nbsp;&nbsp;<span style="font-size:24px"><a href="#">주문 목록</a></span><hr />
			</td>
		</tr>
		<tr>
			<td colspan="2" style="padding-left:50px;padding-right:50px">
				<i class='fas fa-list-ul' style='font-size:36px'></i>&nbsp;&nbsp;&nbsp;<span style="font-size:24px"><a href="#">나의 리뷰 & 댓글</a></span><hr />
			</td>
		</tr>
		<tr>
			<td colspan="2" style="padding-left:50px;padding-right:50px">
				<i class='fas fa-list-ul' style='font-size:36px'></i>&nbsp;&nbsp;&nbsp;<span style="font-size:24px"><a href="#">문의</a></span><hr />
			</td>
		</tr>
	</table>
</div>

<!-- The Modal -->
<div class="modal fade" id="myModal">
	<div class="modal-dialog">
	    <div class="modal-content">
	    <!-- Modal Header -->
	        <div class="modal-header">
	        	<h4 class="modal-title"><b>${vo.name}</b>님의 정보를 확인하시려면<br /> 비밀번호를 입력해 주세요.</h4>
	          	<button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
	        <!-- Modal body -->    
	        <div class="modal-body">
	         	<input type="password" name="pwd" id="pwd" class="form-control" />
	        	<input type="hidden" name="mid" id="mid" value="${sMid}" />
	        </div>
	        <!-- Modal footer -->
	        <div class="modal-footer">
	          	<button type="button" class="btn btn-primary" onclick="pwdCheck()">확인</button>
	          	<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
	        </div>
	    </div>
	</div>
</div>

<!-- The Modal -->
<div class="modal fade" id="delModal">
	<div class="modal-dialog">
	    <div class="modal-content">
	    <!-- Modal Header -->
	        <div class="modal-header">
	        	<h4 class="modal-title"><b>${vo.name}</b>님 탈퇴를 원하시면 비밀번호를 입력해 주세요.<br /><span style="color:red;font-size:10pt">탈퇴 후 같은 아이디로 1개월간 재가입 하실 수 없습니다.</span></h4>
	          	<button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
	        <!-- Modal body -->    
	        <div class="modal-body">
	         	<input type="password" name="delPwd" id="delPwd" class="form-control" />
	        	<input type="hidden" name="delMid" id="delMid" value="${sMid}" />
	        </div>
	        <!-- Modal footer -->
	        <div class="modal-footer">
	          	<button type="button" class="btn btn-primary" onclick="memberDelOk()">탈퇴</button>
	          	<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
	        </div>
	    </div>
	</div>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>