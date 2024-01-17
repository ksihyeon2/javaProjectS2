<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberInfor.jsp</title>
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
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br /></p>
<p><br /></p>
<p><br /></p>
<div class="container" style="height:950px">
	<form  class="was-validated">
		<div class="col-6 text-center">
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px">상 세 정 보</span>
		</div>
		<div class="form-group">
			<table class="table table-borderless">
				<tr>
					<td class="text-center">
						<img src="${ctp}/member/${vo.photo}" id="photo" class="w3-margin w3-circle" alt="Person" style="width:30%;height:30%" /><br />
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
		    <input type="text" value="${vo.nickName}" class="form-control" readonly>
		  </div>
		</div>
    <div class="form-group">
      <label for="name">성명</label>
      <input type="text" class="form-control" value="${vo.name}" readonly />
    </div>
    <div class="form-group">
      <label for="email1">Email address</label>
        <div class="input-group mb-3">
          <input type="text" class="form-control" value="${vo.email}" placeholder="Email을 입력하세요." id="email1" name="email1" readonly />
        </div>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <div class="input-group-prepend">
        	<div class="input-group-text mr-3">성별</div>
		        <label class="form-check-inline mt-2">
	            <input type="radio" class="form-check-input" ${vo.gender == '남자' ? 'checked' : ''}>남자
	          </label>
		        <div class="form-check-inline mt-2">
		        <label class="form-check-inline">
		          <input type="radio" class="form-check-input" ${vo.gender == '여자' ? 'checked' : ''}>여자
		        </label>
		      </div>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="input-group mb-3">
        <div class="input-group-prepend">
          <span class="input-group-text">전화번호</span> &nbsp;&nbsp;
          	<c:set var="tel" value="${fn:split(vo.tel,'-')}"></c:set>
            <select name="tel1" class="custom-select">
              <option>${tel[0]}</option>
            </select>-
        </div>
        <input type="text" value="${tel[1]}" class="form-control" readonly />-
        <input type="text" value="${tel[2]}" class="form-control" readonly />
      </div>
    </div>
    <div class="form-group">
      <label for="address">주소</label>
      <c:set var="address" value="${fn:split(vo.address,'/')}"></c:set>
      <div class="input-group mb-1">
        <input type="text" value="${address[0]}" placeholder="우편번호" class="form-control" readonly>
      </div>
      <input type="text" value="${address[1]}" size="50" placeholder="주소" class="form-control mb-1" readonly>
      <div class="input-group mb-1">
        <input type="text" value="${address[2]}" placeholder="상세주소" class="form-control" readonly> &nbsp;&nbsp;
        <div class="input-group-append">
          <input type="text" value="${address[3]}" placeholder="참고항목" class="form-control" readonly>
        </div>
      </div>
    </div>
    <div class="text-center mt-3">
	    <button type="button" class="btn btn-secondary" onclick="location.href='memberList?pag=${pag}&pageSize=${pageSize}';">돌아가기</button>
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