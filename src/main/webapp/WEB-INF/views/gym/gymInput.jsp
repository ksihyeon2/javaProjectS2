<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>gymInput.jsp</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
  <style>
  	.must{
  		color: red;
  	}
  </style>
  <script>
  	'use strict';
  	
  	function gymInput(){
  		/* 정규식 */
  		let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g;
  		let regURL = /^(https?:\/\/)?([a-z\d\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?$/;
  		
  		let gymName = $("#gymName").val();
  		let area = $("#area").val();
  		let address = $("#address").val();
  		let homePage = $("#homePage").val();
  		let tel1 = $("#tel1").val();
  		let tel2 = $("#tel2").val();
  		let tel3 = $("#tel3").val();
  		let tel = tel1 + "-" + tel2 + "-" + tel3;
  		
  		if(gymName.trim() == "") {
  			alert("등록하실 헬스장의 이름을 입력해 주세요.");
  			$("#gymName").focus();
  			return false;
  		}
  		if(area == ""){
  			alert("등록하실 헬스장의 지역을 선택해 주세요.");
  			$("#area").focus();
  			return false;
  		}
  		if(address.trim() == ""){
  			alert("등록하실 헬스장의 주소를 입력해 주세요.");
  			$("#address").focus();
  			return false;
  		}
  		if(!regTel.test(tel)){
  			alert("전화번호 형식을 다시 확인해 주세요.");
  			$("#tel1").focus();
  			return false;
  		} else {
  			gymForm.tel.value = tel;
  		}
  		if(homePage != "https://"){
	  		if(!regURL.test(homePage)){
	  			alert("홈페이지 주소가 URL 형식에 맞지 않습니다.\n다시 확인해 주세요.");
	  			$("#homePage").focus();
	  			return false;
	  		}
  		}
  		
  		let ans = confirm("신규 등록 하시겠습니까?");
  		
  		if(!ans){
  			return false;
  		};
  		
  		let fName = $("#gymPhoto").val();
  		let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
  		let maxSize = 1024 * 1024 * 10; // 10Mb
  		
  		if(fName.trim() == ""){
  			gymForm.submit();
  		} else {
  			let fileSize = document.getElementById("gymPhoto").files[0].size;
				if(ext != "jpg" && ext != "gif" && ext != "png" && ext != "jepg"){
	  			alert("업로드 파일은 'jpg/gif/png/jepg'만 가능합니다.");
		  	} else if(fileSize > maxSize) {
	  			alert("업로드 가능한 파일의 용량은 10MByte 입니다.");
		  	} else {
	  			gymForm.submit();
		  	}	
  		}
  	}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br /></p>
<p><br /></p>
<p><br /></p>
<p><br /></p>
<div class="container">
	<div class="row mb-4">
		<div class="col-3 text-left">
			<a class="btn btn-secondary mb-4" href="gymList" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px'></i></a>
		</div>
		<div class="col-6 text-center">
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px">신규 헬스장 등록하기</span>
		</div>
	</div>
	
	<div style="background-color:white; padding:20px; width: 800px; margin-left: 250px">
  	<form name="gymForm" method="post" enctype="multipart/form-data">
			<div class="table-responsive">
				<table class="table text-left">
		      <tr>
		        <th>헬스장 이름 <span class="must">*</span></th>
		        <td>
							<input type="text" name="gymName" id="gymName" class="form-control" required />
		        </td>
		      </tr>
		      <tr>
		        <th>지역 <span class="must">*</span></th>
		        <td>
		        	<select name="area" id="area">
				        <option value="">지역</option>
				        <option>서울</option>
				        <option>경기</option>
				        <option>인천</option>
				        <option>충남</option>
				        <option>대전</option>
				       	<option>충북</option>
				       	<option>부산</option>
			         	<option>울산</option>
		          	<option>전북</option>
		          	<option>광주</option>
			        </select>
		        </td>
		      </tr>
		      <tr>
		        <th>주소<span class="must">*</span></th>
		        <td><input type="text" name="address" id="address" class="form-control" required/></td>
		      </tr>
		      <tr>
		        <th>대표사진</th>
		        <td><input type="file" name="fName" id="gymPhoto" class="form-control-file border form-control"/></td>
		      </tr>
		      <tr>
		        <th>홈페이지</th>
		        <td><input type="text" name="homePage" id="homePage" value="https://" class="form-control"/></td>
		      </tr>
		      <tr>
		        <th>전화번호<span class="must">*</span></th>
		        <td>
		        	<!-- <input type="tel" name="tel" id="tel" class="form-control"/> -->
		        	<div class="form-group">
					      <div class="input-group mb-3">
					        <div class="input-group-prepend">
					            <select name="tel1" id="tel1" class="custom-select">
					              <option value="" selected>선택</option>
					              <option>010</option>
					              <option>02</option>
					              <option>031</option>
					              <option>032</option>
					              <option>041</option>
					              <option>042</option>
					              <option>043</option>
					              <option>051</option>
					              <option>052</option>
					              <option>061</option>
					              <option>062</option>
					            </select>-
					        </div>
					        <input type="text" name="tel2" id="tel2" size=4 maxlength=4 class="form-control"/>-
					        <input type="text" name="tel3" id="tel3" size=4 maxlength=4 class="form-control"/>
					      </div>
					    </div>
		        </td>
		      </tr>
		      <tr>
		        <td colspan="2" class="text-center">
		        	<input type="hidden" name="tel" />
							<button type="button" onclick="gymInput()" class="btn btn-secondary ">등록하기</button>
		        </td>
		      </tr>
			  </table>
			</div>
  	</form>
  </div>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>