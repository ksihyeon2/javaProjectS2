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
<div class="container">
	<div class="sidebar p-3" style="margin-left:20px">
    <nav class="navbar">
      <div class="navbar-nav">
        <h2><b><a href="memberPage">마이페이지</a></b></h2>
        	<div class="nav-item dropdown">
          	<a href="#" class="nav-link dropdown-toggle m-2 red" data-toggle="dropdown" id="nav-product">쇼핑</a>
          	<div class="dropdown-menu bg-transparent border-0">
	            <a href="#" class="dropdown-item">주문내역</a>
	            <a href="#" class="dropdown-item">장바구니</a>
	            <a href="#" class="dropdown-item">찜한상품</a>
	            <a href="#" class="dropdown-item">취소/반품/환불</a>
            </div>
          </div>
          <div class="nav-item dropdown">
            <a href="#" class="nav-link dropdown-toggle m-2 red" data-toggle="dropdown" id="nav-product">포인트</a>
            <div class="dropdown-menu bg-transparent border-0">
	            <a href="#" class="dropdown-item">쿠폰</a>
	            <a href="#" class="dropdown-item">적립금</a>
            </div>
          </div>
          <div class="nav-item dropdown">
	          <a href="#" class="nav-link dropdown-toggle m-2 red" data-toggle="dropdown" id="nav-product">활동</a>
	          <div class="dropdown-menu bg-transparent border-0">
	            <a href="memberInquiryList" class="dropdown-item">1:1 문의</a>
	            <a href="#" class="dropdown-item">상품 후기</a>
	            <a href="${ctp}/board/boardMyList" class="dropdown-item">나의 활동</a>
	            <a href="${ctp}/gym/gymList" class="dropdown-item">지점 검색</a>
	            <a href="${ctp}/gym/gymInterestList" class="dropdown-item">관심 지점</a>
	          </div>
          </div>
          <div class="nav-item d-block">
            <a href="#" class="nav-link dropdown-toggle m-2 red" data-toggle="dropdown" id="nav-product">정보</a>
            <div class="dropdown-menu border-0">
              <a href="#" data-toggle="modal" data-target="#myModal" class="dropdown-item">정보 수정</a>
              <a href="memberPwdChange" class="dropdown-item">비밀번호 수정</a>
              <a href="#" data-toggle="modal" data-target="#delModal" class="dropdown-item">회원 탈퇴</a>
          </div>
        </div>
      </div>
    	<div>
      <div >
        <div class="row g-4 rounded m-0" style="width:1000px;border-color:black;border:2px solid;">
          <div class="col-sm-4 col-xl-4 d-flex">
          	<div class="d-flex align-items-center justify-content-between p-3">
              <div class="d-flex flex-column gmarketSans">
                <span class="text-black" style="font-size:1.5em">${sNickName}님 반갑습니다.</span>
                <span class="text-muted" style="font-size:12pt">[${strLevel}]</span>
              </div>
        		</div>
          </div>
          <div class="col-sm-2 col-xl-3">
            <div class="d-flex flex-column align-items-center justify-content-between p-3">
              <div class="ms-3 mt-3">
              <p	 class="mb-2 text-black" style="font-size:13pt">보유 포인트</p>
              </div>
              <div class="ms-3 mt-2">
                <h3 class="mb-2 text-black">${vo.point} P</h3>
              </div>
            </div>
          </div>
          <div class="col-sm-2 col-xl-2">
	          <div class="d-flex flex-column align-items-center justify-content-between p-3">
              <div class="ms-3 mt-3">
                <p class="mb-2 text-black"  style="font-size:13pt">주문배송</p>
              </div>
              <div class="ms-3 mt-2">
                <h3 class="mb-2 text-black">건</h3>
              </div>
	          </div>
          </div>
          <div class="col-sm-2 col-xl-2">
	          <div class="d-flex flex-column align-items-center justify-content-between p-3">
              <div class="ms-3 mt-3">
                <p class="mb-2 text-black"  style="font-size:13pt">게시물</p>
              </div>
              <div class="ms-3 mt-2">
                <h3 class="mb-2 text-black"><a href="${ctp}/board/boardMyList" class="dropdown-item">${boardCnt}건</a></h3>
              </div>
	          </div>
          </div>
        </div>
    	</div>
      <div class="pt-2 px-2">
        <div>
          <div>
            <div class="text-center rounded p-4">
              <div class="d-flex align-items-center justify-content-between mb-4 mt-2 border-bottom-design">
                <div class="d-flex mb-1">
                	<h3 class="mb-0 pretendard mr-2">주문내역</h3>
                </div>
                <a href="#">전체보기<i class='fas fa-angle-right'></i></a>
              </div>
          		<div >
               <table class="table table-hover mb-0">
               	<c:if test="${empty shopCnt}">
	               	<tr>
	               		<td>구매 상품이 없습니다.</td>
	               	</tr>
               	</c:if>
               </table>
	           </div>
            </div></div>
          </div>
        </div>
			</div>
		</nav>
	</div>
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