<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberModify.jsp</title>
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
  	
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br /></p>
<p><br /></p>
<p><br /></p>
<div class="container" style="height:950px">
  <!-- <form name="myform" method="post" class="was-validated" enctype="multipart/form-data"> -->
  <form name="myform" method="post" class="was-validated" style="width:800px">
    <h2 class="text-center">회 원 정 보 수 정</h2>
    <br/>
		<div class="form-group">
		  <label for="mid">아이디</label>
		  <div class="input-group mb-1">
		    <input type="text" name="mid" id="mid" value="${vo.mid}" class="form-control" readonly>
		  </div>
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
	    <button type="button" class="btn btn-secondary" onclick="location.href='memberPage';">돌아가기</button>
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