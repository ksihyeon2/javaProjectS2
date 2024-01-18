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
  		let gymName = $("#gymName").val();
  		let area = $("#area").val();
  		let address = $("#address").val();
  		let tel = $("#tel").val();
  		
  		
  		let ans = confirm("신규 등록 하시겠습니까?");
  		
  		if(!ans){
  			return false;
  		};
  		
  		
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
  	<form name="magazineInsertForm" method="post" enctype="multipart/form-data">
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
		        	<select name="area" id="area" onchange="areaCheck()">
				        <option value="" ${area == '' ? 'selected' : ''}>지역</option>
				        <option ${area == '서울' ? 'selected' : ''}>서울</option>
				        <option ${area == '경기' ? 'selected' : ''}>경기</option>
				        <option ${area == '인천' ? 'selected' : ''}>인천</option>
				        <option ${area == '충남' ? 'selected' : ''}>충남</option>
				        <option ${area == '대전' ? 'selected' : ''}>대전</option>
				       	<option ${area == '충북' ? 'selected' : ''}>충북</option>
				       	<option ${area == '부산' ? 'selected' : ''}>부산</option>
			         	<option ${area == '울산' ? 'selected' : ''}>울산</option>
		          	<option ${area == '전북' ? 'selected' : ''}>전북</option>
		          	<option ${area == '광주' ? 'selected' : ''}>광주</option>
			        </select>
		        </td>
		      </tr>
		      <tr>
		        <th>주소<span class="must">*</span></th>
		        <td><input type="text" name="address" id="addrss" class="form-control" required/></td>
		      </tr>
		      <tr>
		        <th>대표사진 <span class="must"></span></th>
		        <td><input type="file" name="thumbnailFile" id="maThumbnail" onchange="thumbnailCheck(this)" class="form-control-file border form-control"/></td>
		      </tr>
		      <tr>
		        <th>전화번호<span class="must">*</span></th>
		        <td><input type="tel" name="tel" id="tel" class="form-control"/></td>
		      </tr>
		      <tr>
		        <td colspan="2" class="text-center">
							<button type="button" onclick="gymInput()" class="btn btn-secondary ">등록하기</button>
		        </td>
		      </tr>
						  </table>
						</div>
			  	</form>
			  <!-- 
			  <div class="row text-center">
					<div class="col-4"><img id="thumbnailDemo" width="300px"/></div>			  
					<div class="col-8"><img id="detailDemo" width="600px"/></div>			  
			  </div>
			   -->
		  </div>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>