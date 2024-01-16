<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<script>
  function userDelCheck() {
	  let ans = confirm("회원 탈퇴하시겠습니까?");
	  if(ans) {
		  ans = confirm("탈퇴하시면 1개월간 같은 아이디로 다시 가입하실수 없습니다.\n그래도 탈퇴 하시겠습니까?");
		  if(ans) {
			  $.ajax({
				  type : "post",
				  url  : "${ctp}/member/userDel",
				  success:function(res) {
					  if(res == "1") {
						  alert("회원에서 탈퇴 되셨습니다.");
						  location.href = '${ctp}/member/memberLogin';
					  }
					  else {
						  alert("회원 탈퇴신청 실패~~");
					  }
				  },
				  error : function() {
					  alert("전송오류!");
				  }
			  });
		  }
	  }
  }
</script>
<nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
    <div class="container">
        <a class="navbar-brand" href="http://192.168.50.62:9090/javaProjectS2">HEALTH</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            Menu
            <i class="fas fa-bars ms-1"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
            		<c:if test="${sLevel <= 3}">
                	<li class="nav-item nav-link">[${sNickName}님 로그인중]</li>
                </c:if>
                <li class="nav-item"><a class="nav-link" href="${ctp}/#services">SERVICES</a></li>
                <li class="nav-item"><a class="nav-link" href="${ctp}/#portfolio">추천</a></li>
                <li class="nav-item"><a class="nav-link" href="${ctp}/#about">About</a></li>
                <c:if test="${sLevel <= 3 && sLevel > 0 }">
	                <li class="nav-item"><a class="nav-link" href="${ctp}/member/memberPage">mypage</a></li>
                </c:if>
                <c:if test="${sLevel == 0}">
	                <li class="nav-item"><a class="nav-link" href="${ctp}/admin/adminPage">관리자창</a></li>
                </c:if>
                <c:if test="${empty sLevel}">
	                <li class="nav-item"><a class="nav-link" href="${ctp}/member/memberLogin">LOGIN</a></li>
                </c:if>
                <c:if test="${sLevel <= 3 }">
	                <li class="nav-item"><a class="nav-link" href="${ctp}/member/memberLogout">LOGOUT</a></li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>