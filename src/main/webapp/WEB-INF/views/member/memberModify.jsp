<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberModify.jsp</title>
  <meta name='viewport' content='width=device-width, initial-scale=1'>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
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
  	$(function(){
  		$("#upload").hide();
  	});
  	
  	let nickCheckSw = 1;
  	
  	// 닉네임 중복 체크
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
    				if('${sNickName}' == nickName){
    					alert("현재 사용 중인 닉네임과 동일합니다.");
    					nickCheckSw = 1;
    				} else {
	    				alert("이미 사용 중인 닉네임입니다. 다른 닉네임을 입력해 주세요.");
	    				$("#nickName").focus();
	    				nickCheckSw = 0;
    				}
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
  	
  	function fCheck(){
  		let ans = confirm("정보를 수정하시겠습니까?");
  		
  		if(!ans){
  			return false;
  		}
  		
  		// 유효성 검사
  		let regName = /^[가-힣a-zA-Z]+$/;
  		let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
      let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g;
      
      let name = myform.name.value;
      let nickName = myform.nickName.value;
      
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
    	
    	if('${sNickName}' != nickName){
    		nickCheckSw = 0;
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
			
			if(nickCheckSw == 0){
  			alert("변경하실 닉네임의 중복 체크를 해주세요.");
  			document.getElementById("nickNameBtn").focus();
  			return false;
	  	}
			
			myform.email.value = email;
			myform.tel.value = tel;
			myform.address.value = address;
			
			// 파일 이름
  		let fName = document.getElementById("input-file").value;
  		// 확장자
  		let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
  		// 파일 크기 (10Mb)
  		let maxSize = 1024 * 1024 * 10;
  		
  		if(fName.trim() == ""){
  			alert("수정하실 사진을 선택해 주세요.");
  			return false;
  		}
  		
  		let fileSize = document.getElementById("input-file").files[0].size;
  		if(ext != "jpg" && ext != "gif" && ext != "png" && ext != "jepg"){
  			alert("업로드 파일은 'jpg/gif/png/jepg'만 가능합니다.");
  		} else if(fileSize > maxSize) {
  			alert("업로드 가능한 파일의 용량은 10MByte 입니다.");
  		} else {
  			myform.photo.value = fName;
  			myform.submit();
  		}
  	}
  	
  	// 프로필 사진 수정
  	function imgCheck(e){
  		if(e.files && e.files[0]){
  			let reader = new FileReader();
  			reader.onload = function(e){
  				document.getElementById("photo").src = e.target.result;
  				$("#upload").show();
  			}
  			reader.readAsDataURL(e.files[0]);
  		} else {
  			document.getElementById("photo").src = "";
  		}
  	}
  	
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br /></p>
<p><br /></p>
<p><br /></p>
<div class="container" style="height:950px">
  <!-- <form name="myform" method="post" class="was-validated" enctype="multipart/form-data"> -->
	 <form  name="myform" method="post" class="was-validated" style="width:800px" enctype="multipart/form-data">
    <h2 class="text-center">회 원 정 보</h2>
    <br/>
		<div class="form-group">
			<table class="table table-borderless">
				<tr>
					<td class="text-center">
						<img src="${ctp}/member/${vo.photo}" id="photo" class="w3-margin w3-circle" alt="Person" style="width:30%;height:30%" /><br />
						<!-- 사진 업로드 -->
						<label class="input-file-button" for="input-file" style="cursor:point">수정하기<i class='fas fa-pen' style='font-size:24px'></i></label>
						<input type="file" name="fName" id="input-file" style="display:none" onchange="imgCheck(this)" />
						<input type="hidden" name="photo">
						<!-- <input type="button" value="업로드" name="upload" id="upload" onclick="photoUpload()" class="btn btn-secondary" /> -->
					</td>
					<td style="width:400px">
						<label for="mid" class="mt-2 mb-2">아이디</label>
					  <div class="input-group mb-1">
					    <input type="text" name="mid" id="mid" value="${vo.mid}" class="form-control" readonly>
					  </div>
						<label for="mid" class="mt-3">가입일</label>
					  <div class="input-group mb-1">
					    <input type="text" name="mid" id="mid" value="${fn:substring(vo.startDate,0,10)}" class="form-control" readonly>
					  </div>
					</td>
				</tr>
			</table>
		</div>
    <div class="form-group">
		  <label for="nickName">닉네임</label>
		  <div class="input-group mb-1">
		    <input type="text" name="nickName" id="nickName" value="${vo.nickName}" placeholder="사용하실 닉네임을 입력하세요." class="form-control" required>
		    <div class="input-group-append">
		      <input type="button" onclick="nickCheck()" id="nickNameBtn" value="중복체크" class="btn btn-secondary">
		    </div>
		  </div>
		</div>
    <div class="form-group">
      <label for="name">성명</label>
      <input type="text" class="form-control" id="name" value="${vo.name}" placeholder="성명을 입력하세요." name="name" required />
    </div>
    <div class="form-group">
      <label for="email1">Email address</label>
        <div class="input-group mb-3">
        	<c:set var="email" value="${fn:split(vo.email,'@')}"></c:set>
          <input type="text" class="form-control" value="${email[0]}" placeholder="Email을 입력하세요." id="email1" name="email1" required />
          <div class="input-group-append">
            <select name="email2" class="custom-select">
              <option value="naver.com"   ${email[1] == 'naver.com' ? 'selected' : '' }>naver.com</option>
              <option value="hanmail.net" ${email[1] == 'hanmail.net' ? 'selected' : '' }>hanmail.net</option>
              <option value="hotmail.com" ${email[1] == 'hotmail.com' ? 'selected' : '' }>hotmail.com</option>
              <option value="gmail.com"   ${email[1] == 'gmail.com' ? 'selected' : '' }>gmail.com</option>
              <option value="nate.com"    ${email[1] == 'nate.com' ? 'selected' : '' }>nate.com</option>
              <option value="yahoo.com"   ${email[1] == 'yahoo.com' ? 'selected' : '' }>yahoo.com</option>
            </select>
          </div>
        </div>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">성별</span>
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" value="남자" ${vo.gender == '남자' ? 'checked' : ''}>남자
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" value="여자" ${vo.gender == '여자' ? 'checked' : ''}>여자
        </label>
      </div>
    </div>
    <div class="form-group">
      <div class="input-group mb-3">
        <div class="input-group-prepend">
          <span class="input-group-text">전화번호</span> &nbsp;&nbsp;
          	<c:set var="tel" value="${fn:split(vo.tel,'-')}"></c:set>
            <select name="tel1" class="custom-select">
              <option value="010" ${tel[0] == '010' ? 'selected' : ''}>010</option>
              <option value="02" 	${tel[0] == '02' ? 'selected' : ''}>서울</option>
              <option value="031" ${tel[0] == '031' ? 'selected' : ''}>경기</option>
              <option value="032" ${tel[0] == '032' ? 'selected' : ''}>인천</option>
              <option value="041" ${tel[0] == '041' ? 'selected' : ''}>충남</option>
              <option value="042" ${tel[0] == '042' ? 'selected' : ''}>대전</option>
              <option value="043" ${tel[0] == '043' ? 'selected' : ''}>충북</option>
              <option value="051" ${tel[0] == '051' ? 'selected' : ''}>부산</option>
              <option value="052" ${tel[0] == '052' ? 'selected' : ''}>울산</option>
              <option value="061" ${tel[0] == '061' ? 'selected' : ''}>전북</option>
              <option value="062" ${tel[0] == '062' ? 'selected' : ''}>광주</option>
            </select>-
        </div>
        <input type="text" name="tel2" value="${tel[1]}" size=4 maxlength=4 class="form-control"/>-
        <input type="text" name="tel3" value="${tel[2]}" size=4 maxlength=4 class="form-control"/>
      </div>
    </div>
    <div class="form-group">
      <label for="address">주소</label>
      <c:set var="address" value="${fn:split(vo.address,'/')}"></c:set>
      <div class="input-group mb-1">
        <input type="text" name="postcode" id="sample6_postcode" value="${address[0]}" placeholder="우편번호" class="form-control">
        <div class="input-group-append">
          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
        </div>
      </div>
      <input type="text" name="roadAddress" id="sample6_address" value="${address[1]}" size="50" placeholder="주소" class="form-control mb-1">
      <div class="input-group mb-1">
        <input type="text" name="detailAddress" id="sample6_detailAddress" value="${address[2]}" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
        <div class="input-group-append">
          <input type="text" name="extraAddress" id="sample6_extraAddress"value="${address[3]}" placeholder="참고항목" class="form-control">
        </div>
      </div>
    </div>
    <div class="text-center mt-3">
	    <button type="button" class="btn btn-secondary" onclick="fCheck()">수정하기</button> &nbsp;
	    <button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/';">돌아가기</button>
    </div>
    <input type="hidden" name="email" />
    <input type="hidden" name="tel" />
    <input type="hidden" name="address" />
  </form>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>