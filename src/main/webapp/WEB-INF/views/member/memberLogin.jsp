<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <title>memberLogin.jsp</title>
  <link rel="icon" type="image/x-icon" href="${ctp}/assets/favicon.ico" />
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
  <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
  <style>
  	*{
	    padding: 0;
	    margin: 0;
	    border: none;
		}
		body{
	    font-size: 15px;
	    font-family: 'Roboto', sans-serif;
		}
		.login-wrapper{
	    width: 500px;
	    height: 490px;
	    padding: 30px;
	    box-sizing: border-box;
		}
		.login-wrapper > h2{
	    font-size: 24px;
	    color: #6A24FE;
	    margin-bottom: 20px;
		}
		#login-form > input{
	    width: 100%;
	    height: 48px;
	    padding: 0 10px;
	    box-sizing: border-box;
	    margin-bottom: 16px;
	    border-radius: 6px;
	    background-color: rgb(217,229,255);
		}
		
		#login-form > div > input{
	    width: 50%;
	    height: 48px;
	    padding: 0 10px;
	    box-sizing: border-box;
	    margin-bottom: 16px;
	    border-radius: 6px;
	    background-color: rgb(217,229,255);
		}
		
		#login-form > input::placeholder{
	    color: #D2D2D2;
		}
		#login-form > div > input[type="button"]{
	    color: #fff;
	    font-size: 16px;
	    background-color: #6A24FE;
	    margin-top: 20px;
		}
		#login-form > input[type="checkbox"]{
    	display: none;
		}
		#login-form > label{
	    color: #999999;
		}
		#login-form input[type="checkbox"] + label{
	    cursor: pointer;
	    padding-left: 26px;
	    background-image: url("checkbox.png");
	    background-repeat: no-repeat;
	    background-size: contain;
		}
		#login-form input[type="checkbox"]:checked + label{
	    background-image: url("checkbox-active.png");
	    background-repeat: no-repeat;
	    background-size: contain;
		}
		
		#login-form {
		  position: absolute;
		  padding: 20px;
		  border-radius: 5px;
		  top: 35%;
		  left: 50%;
		  transform: translate(-50%, -16%);
		}
  </style>  
  <script>
  	'use strict';
  	
  	function loginCheck(){
    	let mid = myform.mid.value.trim();
	  	let pwd = myform.pwd.value;
    	
	  	/* 정규식으로 유효성 체크 */
    	if(mid.trim() == "") {
    		alert("아이디를 입력하세요.");
    		myform.mid.focus();
    		return false;
    	}
    	if(pwd.trim() == "") {
        alert("비밀번호를 입력하세요.");
        myform.pwd.focus();
        return false;
      }
    	
    	myform.submit();
  	} 
  	
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br /></p>
<div class="container" style="height:750px">
	<div class="login-wrapper text-center">
		<form name="myform" method="post" id="login-form">
			<h2 class="mb-4">Login</h2>
			<input type="text" name="mid" id="mid" value="${mid}" placeholder="ID" class="mt-4">
			<input type="password" name="pwd" id="pwd" placeholder="Password">
			<label for="remember-check">
				<input type="checkbox" name="idSave" id="idSave" class="mb-4" checked>아이디 저장하기<br />
				<a href="memberFind">[아이디/비밀번호 찾기]</a> &nbsp|&nbsp
				<a href="memberJoin">[회원가입]</a>
			</label>
			<div class="form-group text-center">
				<input type="button" value="Login" onclick="loginCheck()">
			</div>
		</form>
	</div>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>