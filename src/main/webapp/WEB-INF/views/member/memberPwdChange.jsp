<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberPwdChange.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
  <script>
  	'use strcit';
  	
  	function pwdCheckOk(){
  		let pwd = $("#pwd").val();
  		
  		if(pwd.trim() == ""){
  			alert("현재 비밀번호를 입력해 주세요.");
  			return false;
  		}
  		$.ajax({
  			url : "${ctp}/member/memberPwdCheck",
  			type : "post",
  			data : {pwd:pwd},
  			success : function(res){
  				if(res == ""){
  					alert("비밀번호가 일치하지 않습니다.");
  				} else {
  					location.reload();
  				}
  			},
  			error : function(){
  				alert("전송 오류");
  			}
  		});
  	}
  	
  	function pwdChangeOk(){
  		let pwd1 = $("#pwd1").val();
  		let pwd2 = $("#pwd2").val();
  		
  		if(pwd1.trim() == ""){
  			alert("변경하실 비밀번호를 입력 주세요.");
  			return false;
  		}
  		if(pwd2.trim() == ""){
  			alert("변경하실 비밀번호를 한 번 더 입력해 주세요.");
  			return false;
  		}
  		
  		if(pwd1 != pwd2){
  			alert("비밀번호가 일치하지 않습니다. 다시 입력해 주세요.");
  			$("#pwd2").focus();
  			return false;
  		}
  		
  		location.href = "memberPwdChangeOk?pwd="+pwd1;
  	}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br /></p>
<p><br /></p>
<p><br /></p>
<div class="container" style="height:600px">
	<form name="myform" method="post">
		<div class="text-center">
			<table class="table table-borderless">
				<tr>
					<th><h2>비밀번호 변경</h2><hr /></th>
				</tr>
				<c:if test="${empty sw && empty pwdCheck || pwdCheck == 'No'}">
					<tr>
						<td><span style="font-size:1em;color:red">비밀번호 변경을 위해 현재 비밀번호를 입력해 주세요.</span></td>
					</tr>
					<tr>
						<td>
							<input type="password" name="pwd" id="pwd" class="form-control" style="width:500px;margin-left:31%" placeholder="현재 비밀번호" required />
						</td>
					</tr>
					<tr>
						<td>
							<input type="button" value="확인" name="pwdCheck" id="pwdCheck" onclick="pwdCheckOk()" class="btn btn-secondary" />
						</td>
					</tr>
				</c:if>
				<c:if test="${!empty sw || pwdCheck == 'Ok'}">
					<tr>
						<td><span style="font-size:1em;color:red">변경하실 비밀번호를 입력해 주세요.</span></td>
					</tr>
					<tr>
						<td>
							<input type="password" name="pwd1" id="pwd1" class="form-control" style="width:500px;margin-left:31%" placeholder="새 비밀번호" required />
						</td>
					</tr>
					<tr>
						<td>
							<input type="password" name="pwd2" id="pwd2" class="form-control" style="width:500px;margin-left:31%" placeholder="새 비밀번호 확인" required />
						</td>
					</tr>
					<!-- 캡차 -->
					<tr>
						<td>
							<input type="button" value="변경하기" name="pwdChange" id="pwdChage" onclick="pwdChangeOk()" class="btn btn-secondary" />
						</td>
					</tr>
				</c:if>
			</table>
		</div>
	</form>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>