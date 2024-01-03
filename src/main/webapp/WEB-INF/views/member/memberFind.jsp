<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberFind.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
  <script>
  	'use strict';
  	
  	$(function(){
  		$("#login1").hide();
  		$("#login2").hide();
  		$("#pwdFind").hide();
  	
  	
	  	$("input[name=searchType]:radio").click(function(){
	  		let check = $("input[name=searchType]:checked").val();
	  		
	  		if(check == "mid"){
	  			$(".midSearch").show();
	  			$(".pwdSearch").hide();
	  		} else {
	  			$(".midSearch").hide();
	  			$(".pwdSearch").show();
	  		}
	  		
	  	});
	  });
  	
  	
  	/* 아이디 찾기 */
  	function midSearch(){
  		let name = $("#midName").val().trim();
  		let email1 = $("#midEmail1").val().trim();
  		let email2 = $("#midEmail2").val().trim();
  		let email = email1 + "@" + email2;
  		
  		if(name == ""){
  			alert("성명을 입력해 주세요.");
  			return false;
  		} else if(email1 == ""){
  			alert("이메일을 입력해 주세요.");
  			return false;
  		}
  		
  		let query = {
  				name:name,
  				email:email
  		};
  		
  		$.ajax({
  			url : "${ctp}/member/memberMidSearch",
  			type : "post",
  			data : query,
  			success : function(res){
  				if(res == "") {
  					alert("해당 정보로 가입하신 내역이 없습니다.");
  					location.reload();
  				} else {
  					let str = res.split("/");
  	  				if(str[1] != ""){
  	  					$(".midDemo").show();
  		  				$("#midDemo").html(str[0]);
  		  				$("#dateDemo").html(str[1].substring(0,10));
  		  				
  		  				$("#midFind").hide();
  		  				$("#login1").show();
  		  		  	$("#pwdFind").show();
  	  				}
  				}
  			},
  			error : function(){
  				alert("전송 오류");
  			}
  		});
  	}
  	
  	function pwdFind(){
  		$("#mid").prop("checked", false);
  		$("#pwd").prop("checked", true);
  		$(".midSearch").hide();
			$(".pwdSearch").show();
  	}
  	
  	/* 비밀번호 찾기 */
  	function pwdSearch(){
  		let name = $("#pwdName").val().trim();
  		let mid = $("#pwdId").val().trim();
  		let email1 = $("#pwdEmail1").val().trim();
  		let email2 = $("#pwdEmail2").val().trim();
  		let email = email1 + "@" + email2;
  		
  		if(name == ""){
  			alert("성명을 입력해 주세요.");
  			return false;
  		} else if(mid == "") {
  			alert("아이디를 입력해 주세요.");
  			return false;
  		}	else if(email1 == ""){
  			alert("이메일을 입력해 주세요.");
  			return false;
  		}
  		
  		let query = {
  				name:name,
  				mid:mid,
  				email:email
  		}
  		
  		$.ajax({
  			url : "${ctp}/member/memberPwdSearch",
  			type : "post",
  			data : query,
  			success : function(res){
  				if(res != "1"){
  					alert("가입하신 정보가 없습니다. 다시 확인 후 입력해 주세요.");
  				} else {
  					alert("해당 이메일로 임시 비밀번호를 발급하였습니다.");
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
<div class="container" style="height:600px">
	<h2>아이디 / 비밀번호 찾기</h2>
	<hr />
	<table class="table table-bordered">
		<tr>
			<td style="width:10px; background-color:gray"></td>
			<td>
				<input type="radio" name="searchType" id="mid" value="mid" checked> 아이디 찾기
				<!-- 성명과 이메일을 통해 아이디를 조회하실 수 있습니다. -->
			</td>
		</tr>
		<tr class="midSearch">
			<td colspan="2" class="m-0 p-0">
				<table class="table table-bordered">
					<tr>
						<td class="text-right"><b>성명</b></td>
						<td><input type="text" name="midName" id="midName" class="form-control" placeholder="성명을 입력하세요."></td>
					</tr>
					<tr>
						<td class="text-right"><b>이메일</b></td>
						<td>
							<div class="form-group">
				        <div class="input-group mb-3">
				          <input type="text" class="form-control" placeholder="Email을 입력하세요." id="midEmail1" name="midEmail1" />
				          <div class="input-group-append">
				            <select name="midEmail2" id="midEmail2" class="custom-select">
				              <option value="naver.com" selected>naver.com</option>
				              <option value="hanmail.net">hanmail.net</option>
				              <option value="hotmail.com">hotmail.com</option>
				              <option value="gmail.com">gmail.com</option>
				              <option value="nate.com">nate.com</option>
				              <option value="yahoo.com">yahoo.com</option>
				            </select>
				          </div>
				        </div>
					    </div>
						</td>
					</tr>
					<tr class="midDemo" style="display:none">
						<td colspan="2" class="midDemo m-0 p-0">
							<table class="table table-borderless text-center">
							 <tr>
							 	<td class="text-right">
									<input type="radio" name="midChoice" checked>&nbsp;<b><span id="midDemo"></span></b>
								</td>
								<td class="">
									가입 : <span id="dateDemo"></span>
								</td>
							</tr>
						</table>
					</tr>
				</table>
			</td>
		</tr>
		<tr class="midSearch">
			<td colspan="2" class="text-center">
				<input type="button" id="midFind" value="ID찾기" onclick="midSearch()" class="btn btn-secondary mr-3">
				<input type="button" id="login1" value="로그인하기" onclick="location.href='${ctp}/member/memberLogin';" class="btn btn-success mr-3">
				<input type="button" id="pwdFind" value="비밀번호 찾기" onclick="pwdFind()" class="btn btn-secondary mr-3">
			</td>
		</tr>
	</table>
	<table class="table table-bordered">
		<tr>
			<td style="width:10px; background-color:gray"></td>
			<td>
				<input type="radio" name="searchType" id="pwd" value="pwd"> 비밀번호 찾기
				<!-- 성명과 아이디, 이메일을 통해 비밀번호를 조회하실 수 있습니다. -->
			</td>
		</tr>
		<tr class="pwdSearch" style="display:none">
			<td colspan="2" class="m-0 p-0">
				<table class="table table-bordered">
					<tr>
						<td class="text-right"><b>성명</b></td>
						<td><input type="text" name="pwdName" id="pwdName" class="form-control" placeholder="성명을 입력하세요."></td>
					</tr>
					<tr>
						<td class="text-right"><b>아이디</b></td>
						<td><input type="text" name="pwdId" id="pwdId" class="form-control" placeholder="아이디를 입력하세요."></td>
					</tr>
					<tr>
						<td class="text-right"><b>이메일</b></td>
						<td>
							<div class="form-group">
				        <div class="input-group mb-3">
				          <input type="text" class="form-control" placeholder="Email을 입력하세요." id="pwdEmail1" name="pwdEmail1" />
				          <div class="input-group-append">
				            <select name="pwdEmail2" id="pwdEmail2" class="custom-select">
				              <option value="naver.com" selected>naver.com</option>
				              <option value="hanmail.net">hanmail.net</option>
				              <option value="hotmail.com">hotmail.com</option>
				              <option value="gmail.com">gmail.com</option>
				              <option value="nate.com">nate.com</option>
				              <option value="yahoo.com">yahoo.com</option>
				            </select>
				          </div>
				        </div>
					    </div>
						</td>
					</tr>
					<tr class="pwdSearch">
						<td colspan="2" class="text-center">
							<input type="button" value="비밀번호찾기" onclick="pwdSearch()" class="btn btn-secondary mr-3">
							<input type="button" id="login2" value="로그인하기" onclick="location.href='${ctp}/member/memberLogin';" class="btn btn-success mr-3">
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<br />
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>