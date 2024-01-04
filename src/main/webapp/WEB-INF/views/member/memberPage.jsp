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
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
  <style>
  	a {
  		color:black;
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
<div class="container" style="margin-left:20%">
	<table class="table table-borderless">
		<tr>
			<td colspan="2"><h2>프로필</h2><br /></td>
		</tr>
		<tr>
			<td>
			<table style="width:100%">
				<tr>
					<td>
					  	<div class="card" style="width:400px">
					    	<img class="card-img-top" src="${ctp}/member/${vo.photo}" alt="Card image" style="width:100%">
					    	<div class="card-body">
				      		<br />
				      		<h4 class="card-title">닉네임 : ${vo.nickName}</h4>
				      		<br />
				      		<h4 class="card-title">등급 : ${strLevel}</h4>
				      		<br />
				      		<hr />
				      		<ul>
				      			<li>
					      			<a href="memberPwdChange" >비밀번호 변경</a><br /><br />
					      		</li>
					      		<li>
					      			<a href="memberModify" data-toggle="modal" data-target="#myModal">나의 정보</a><br /><br />
					      		</li>
					      		<li>
					      			<a href="#">내게시물 보기</a><br /><br />
					      		</li>
					      		<li>
					      			<a href="memberLogout">로그아웃</a><br /><br />
					      		</li>
					      		<li>
					      			<a href="memberDelOk" style="color:red" data-toggle="modal" data-target="#delModal">탈퇴하기</a>
					      		</li>
				      		</ul>
					    	</div>
					  	</div>
			  		</td>
		  		</tr>
		  	</table>
		  </td>
		  
		  
		  
		  
		  
		  
		  <td>
		  	<table class="table table-borderless" style="width:400px;margin-top:100px">
					<tr>
						<td>
							<table class="table table-bordered">
								<tr>
									<td><b>포인트</b><br /><a href="#" style="color:gray">${vo.point} point</a></td>
								</tr>
							</table>
						</td>
						<td>
							<table class="table table-bordered">
								<tr>
									<td><b>관심</b><br /><a href="#" style="color:gray">바로가기</a></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<table class="table table-borderless">
								<tr>
									<td>
										<table class="table table-bordered" style="width:150px;height:100px">
											<tr>
												<td>주문내역</td>
											</tr>
										</table>
									</td>
									<td>
										<table class="table table-bordered" style="width:150px;height:100px">
											<tr>
												<td>나의 리뷰 & 댓글</td>
											</tr>
										</table>
									</td>
									<td>
										<table class="table table-bordered" style="width:150px;height:100px">
											<tr>
												<td>작성글</td>
											</tr>
										</table>
									</td>
									<td>
										<table class="table table-bordered" style="width:150px;height:100px">
											<tr>
												<td>문의</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
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