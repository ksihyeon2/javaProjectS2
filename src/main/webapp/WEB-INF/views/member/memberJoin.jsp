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
  <title>memberJoin.jsp</title>
  <link rel="icon" type="image/x-icon" href="${ctp}/assets/favicon.ico" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
  <style>
  	.was-validated {
		  position: absolute;
		  left: 50%;
		  transform: translate(-50%);
		  margin-top: 60px;
		  margin-bottom: 60px;
		  background: #ffffff;
		  border: 1px solid #aacdff;
		  box-shadow: 7px 7px 39px rgba(0, 104, 255, 0.25);
		  border-radius: 20px;
		  padding: 50px;
		}
  </style>
  <script>
    'use strict';
    
    let idCheckSw = 0;
    let nickCheckSw = 0;
    
    /* 아이디 중복 체크 */
    function idCheck(){
    	let mid = myform.mid.value;
    	
    	if(mid.trim() == "" || mid.length < 5 || mid.length > 20) {
    		alert("아이디를 확인 후 다시 입력하세요.(5~20자 이내)");
    		myform.mid.focus();
    		return false;
    	}
    	
    	$.ajax({
    		url : "${ctp}/member/memberIdCheck",
    		type : "post",
    		data : {mid:mid},
    		success : function(res){
    			if(res == "1"){
    				alert("이미 사용 중인 아이디입니다. 다른 아이디를 입력해 주세요.");
    				$("#mid").focus();
    			} else {
    				alert("사용 가능한 아이디입니다.");
    				idCheckSw = 1;
    				myform.mid.readOnly = true;
    			}
    		},
    		error : function(){
    			alert("전송 오류");
    		}
    	});
    }
    
    /* 닉네임 중복 체크 */
    function nickCheck(){
    	let nickName = myform.nickName.value;
    	
    	if(nickName.trim() == "" || nickName.length < 2 || nickName.length > 20) {
    		alert("닉네임을 확인하세요.(2~20자 이내)");
    		myform.nickName.focus();
    		return false;
    	}
    	
    	$.ajax({
    		url : "${ctp}/member/memberNickCheck",
    		type : "post",
    		data  : {nickName : nickName},
    		success : function(res){
    			if(res == "1"){
    				alert("이미 사용 중인 닉네임입니다. 다른 닉네임을 입력해 주세요.");
    				$("#nickName").focus();
    			}	else {
    				alert("사용 가능한 닉네임입니다.");
    				nickCheckSw = 1;
  	    		myform.nickName.readOnly = true;
    			}
    		},
    		error : function(){
    			alert("전송 오류");
    		}
    	});
    }
    
    /* 로그인 체크 */
    function fCheck(){
    	/* 정규식 */
    	let regMid = /^[a-zA-Z0-9]{5,20}$/;
    	let regPwd = /(?=.*[0-9a-zA-Z]).{4,15}$/;
      let regNickName = /^[가-힣]+$/;
      let regName = /^[가-힣a-zA-Z]+$/;
      let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
      let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g;
      
      /* 변수값 담기 */
      let mid = myform.mid.value.trim();
	  	let pwd = myform.pwd.value;
	  	let nickName = myform.nickName.value;
	  	let name = myform.name.value;
	  	
	  	let email1 = myform.email1.value.trim();
	  	let email2 = myform.email2.value;
	  	let email = email1 + "@" + email2;
	  	
	  	let tel1 = myform.tel1.value;
    	let tel2 = myform.tel2.value.trim();
    	let tel3 = myform.tel3.value.trim();
    	let tel = tel1 + "-" + tel2 + "-" + tel3;
    	
    	let postcode = myform.postcode.value + "";
    	let roadAddress = myform.roadAddress.value + "";
    	let detailAddress = myform.detailAddress.value + "";
    	let extraAddress = myform.extraAddress.value + "";
    	let address = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress + "/";
    	
    	/* 정규식으로 유효성 체크 */
    	if(!regMid.test(mid)) {
    		alert("아이디는 5~20자리의 영문 소/대문자와 숫자만 사용 가능합니다.");
    		myform.mid.focus();
    		return false;
    	}
    	if(!regPwd.test(pwd)) {
        alert("비밀번호는 특수문자 포함 4~15자리로 작성해 주세요.");
        myform.pwd.focus();
        return false;
      } 
    	if(!regNickName.test(nickName)) {
        alert("닉네임은 한글만 사용 가능합니다.");
        myform.nickName.focus();
        return false;
    	}
    	if(!regName.test(name)) {
        alert("성명은 한글과 영문 대/소문자만 사용 가능합니다.");
        myform.name.focus();
        return false;
      } 
			if(!regEmail.test(email)) {
        alert("이메일 형식에 맞지 않습니다.");
        myform.email1.focus();
        return false;
      }
			if(tel2 != "" && tel3 != "") {
    	  if(!regTel.test(tel)) {
	    		alert("전화번호 형식을 확인하세요.(000-0000-0000)");
	    		myform.tel2.focus();
  	  	} 
  	  }	else {
  	  	tel2 = "";
				tel3 = "";
				tel = tel1 + "-" + tel2 + "-" + tel3;
			} 
			
			if(idCheckSw == 0) {
				alert("아이디 중복체크 버튼을 눌러주세요.");
  			document.getElementById("midBtn").focus();
  			return false;
  		} else if (nickCheckSw == 0){
  			alert("닉네임 중복체크 버튼을 눌러주세요.");
  			document.getElementById("nickNameBtn").focus();
  			return false;
  		}
			myform.email.value = email;
			myform.tel.value = tel;
			myform.address.value = address;
			
			myform.submit();

    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<p><br/></p>
<div class="container" style="height:950px">
  <!-- <form name="myform" method="post" class="was-validated" enctype="multipart/form-data"> -->
  <form name="myform" method="post" class="was-validated" style="width:800px">
    <h2 class="text-center">회 원 가 입</h2>
    <br/>
		<div class="form-group">
		  <label for="mid">아이디</label>
		  <div class="input-group mb-1">
		    <input type="text" name="mid" id="mid" placeholder="아이디를 입력하세요." class="form-control" required>
		    <div class="input-group-append">
		      <input type="button" onclick="idCheck()" id="midBtn" value="중복체크" class="btn btn-secondary">
		    </div>
		  </div>
		</div>
    <div class="form-group">
      <label for="pwd">비밀번호</label>
      <input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요." name="pwd" required />
    </div>
    <div class="form-group">
		  <label for="nickName">닉네임</label>
		  <div class="input-group mb-1">
		    <input type="text" name="nickName" id="nickName" placeholder="사용하실 닉네임을 입력하세요." class="form-control" required>
		    <div class="input-group-append">
		      <input type="button" onclick="nickCheck()" id="nickNameBtn" value="중복체크" class="btn btn-secondary">
		    </div>
		  </div>
		</div>
    <div class="form-group">
      <label for="name">성명</label>
      <input type="text" class="form-control" id="name" placeholder="성명을 입력하세요." name="name" required />
    </div>
    <div class="form-group">
      <label for="email1">Email address</label>
        <div class="input-group mb-3">
          <input type="text" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1" required />
          <div class="input-group-append">
            <select name="email2" class="custom-select">
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
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">성별</span>
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" value="남자" checked>남자
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" value="여자">여자
        </label>
      </div>
    </div>
    <div class="form-group">
      <div class="input-group mb-3">
        <div class="input-group-prepend">
          <span class="input-group-text">전화번호</span> &nbsp;&nbsp;
            <select name="tel1" class="custom-select">
              <option value="010" selected>010</option>
              <option value="02">서울</option>
              <option value="031">경기</option>
              <option value="032">인천</option>
              <option value="041">충남</option>
              <option value="042">대전</option>
              <option value="043">충북</option>
              <option value="051">부산</option>
              <option value="052">울산</option>
              <option value="061">전북</option>
              <option value="062">광주</option>
            </select>-
        </div>
        <input type="text" name="tel2" size=4 maxlength=4 class="form-control"/>-
        <input type="text" name="tel3" size=4 maxlength=4 class="form-control"/>
      </div>
    </div>
    <div class="form-group">
      <label for="address">주소</label>
      <div class="input-group mb-1">
        <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control">
        <div class="input-group-append">
          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
        </div>
      </div>
      <input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1">
      <div class="input-group mb-1">
        <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
        <div class="input-group-append">
          <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
        </div>
      </div>
    </div>
    <div class="text-center mt-3">
	    <button type="button" class="btn btn-secondary" onclick="fCheck()">회원가입</button> &nbsp;
	    <button type="button" class="btn btn-secondary" onclick="location.href='memberLogin';">돌아가기</button>
    </div>
    <input type="hidden" name="email" />
    <input type="hidden" name="tel" />
    <input type="hidden" name="address" />
  </form>
</div>
<p><br /></p>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>