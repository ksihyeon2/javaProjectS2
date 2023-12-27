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
    <!-- Font Awesome icons (free version)-->
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <!-- Google fonts-->
  <!-- Core theme CSS (includes Bootstrap)-->
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
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
	    background-color: #F8F8F8;
		}
		#login-form > input::placeholder{
	    color: #D2D2D2;
		}
		#login-form > input[type="submit"]{
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
  </style>  
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br /></p>
<p><br /></p>
<p><br /></p>
<p><br /></p>
<p><br /></p>
<p><br /></p>
<p><br /></p>
<div class="container">
	<div class="login-wrapper text-center">
        <h2>Login</h2>
        <form method="post" action="서버의url" id="login-form">
            <input type="text" name="userName" placeholder="ID">
            <input type="password" name="userPassword" placeholder="Password">
            <label for="remember-check">
                <input type="checkbox" id="remember-check">아이디 저장하기<br />
                <a href="">[아이디/비밀번호 찾기]</a> &nbsp|&nbsp
                <a href="memberJoin">[회원가입]</a>
            </label>
            <input type="submit" value="Login">
        </form>
    </div>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>