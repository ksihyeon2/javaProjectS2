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
  	
  	$("input[name='serachType']").change(function(){
  		if($("input[name='serachType']:checked").val() == 'id'){
  			
  		}
  	});
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
				<input type="radio" name="serachType" value="id" checked> 아이디 찾기
				<!-- 성명과 이메일을 통해 아이디를 조회하실 수 있습니다. -->
			</td>
		</tr>
		<tr>
			<td colspan="2" class="m-0 p-0">
				<table class="table table-bordered">
					<tr>
						<td class="text-right"><b>성명</b></td>
						<td><input type="text" name="name" id="name" class="form-control" placeholder="성명을 입력하세요."></td>
					</tr>
					<tr>
						<td class="text-right"><b>이메일</b></td>
						<td>
							<div class="form-group">
				        <div class="input-group mb-3">
				          <input type="text" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1" />
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
						</td>
					</tr>
					<tr>
						<td colspan="2" class="text-center">
							<input type="button" value="찾기" onclick="" class="btn btn-secondary mr-3">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td style="width:10px; background-color:gray"></td>
			<td>
				<input type="radio" name="serachType" value="pwd"> 비밀번호 찾기
				<!-- 성명과 아이디, 이메일을 통해 비밀번호를 조회하실 수 있습니다. -->
			</td>
		</tr>
		<tr>
			<td colspan="2" class="m-0 p-0">
				<table class="table table-bordered">
					<tr>
						<td class="text-right"><b>성명</b></td>
						<td><input type="text" name="name" id="name" class="form-control" placeholder="성명을 입력하세요."></td>
					</tr>
					<tr>
						<td class="text-right"><b>아이디</b></td>
						<td><input type="text" name="mid" id="mid" class="form-control" placeholder="아이디를 입력하세요."></td>
					</tr>
					<tr>
						<td class="text-right"><b>이메일</b></td>
						<td>
							<div class="form-group">
				        <div class="input-group mb-3">
				          <input type="text" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1" />
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
						</td>
					</tr>
					<tr>
						<td colspan="2" class="text-center">
							<input type="button" value="찾기" onclick="" class="btn btn-secondary mr-3">
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<br />
	<%-- <div class="was-validated">
		<table class="table table-bordered" style="width:1000px;">
			<tr>
				<c:if test="${searchType == 'id'}">
					<c:set var="type" value="아이디"></c:set>
				</c:if>
				<c:if test="${searchType == 'pwd'}">
					<c:set var="type" value="비밀번호"></c:set>
				</c:if>
				<td colspan="2" class="text-center"><h2>${type} 찾기</h2></td>
			</tr>
			<tr>
				<td class="text-right"><b>성명</b></td>
				<td><input type="text" name="name" id="name" class="form-control" placeholder="성명을 입력하세요."></td>
			</tr>
			<tr>
				<td class="text-right"><b>아이디</b></td>
				<td><input type="text" name="mid" id="mid" class="form-control" placeholder="아이디를 입력하세요."></td>
			</tr>
			<tr>
				<td class="text-right"><b>이메일</b></td>
				<td>
					<div class="form-group">
		        <div class="input-group mb-3">
		          <input type="text" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1" />
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
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text-center">
					<input type="button" value="아이디 찾기" onclick="" class="btn btn-secondary mr-3">
					<input type="button" value="비밀번호 찾기" onclick="" class="btn btn-secondary">
				</td>
			</tr>
		</table>
	</div> --%>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>