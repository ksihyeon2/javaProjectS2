<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>productInput.jsp</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
 	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
  <style>
  	a{
  		text-decoration-line:none;
  		color:black;
  	}
  	
  	.must {
  		color: red;
  	}
  </style>
  <script>
  	'use strict';
  	
  	function backCheck(){
  		let ans = confirm("상품 등록을 취소하시겠습니까?");
  		
  		if(!ans){
  			return false;
  		}
  		
  		location.href="productList";
  	}
  	
  	function inputCheck(){
  		
  		// 정규식
  		let regProductPrice = /^[0-9]/;
  		
  		let productName = $("#productName").val();
  		let productDetail = $("#productDetail").val();
  		let productPrice = $("#productPrice").val();
  		let productPhoto = $("#productPhoto").val();
  		let content = $("#CKEDITOR").val();
  		
  		if(productName.trim() == ""){
  			alert("상품명을 입력해 주세요.");
  			$("#productName").focus();
  			return false;
  		}
  		if(productDetail.trim() == ""){
  			alert("상품의 간단 설명을 입력해 주세요.");
  			$("#productDetail").focus();
  			return false;
  		}
  		if(productPrice.trim() == ""){
  			alert("상품의 가격을 입력해 주세요.");
  			$("#productPrice").focus();
  			return false;
  		}
  		if(!regProductPrice.test(productPrice)) {
    		alert("상품의 가격은 숫자로만 입력해 주세요.");
    		$("#productPrice").focus();
    		return false;
    	}
  		if(productPhoto.trim() == ""){
  			alert("상품의 대표 사진을 추가해 주세요.");
  			$("#productPhoto").focus();
  			return false;
  		}
  		
  	// 대표 사진 추가
  		let fName = $("#productPhoto").val();
  		let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
  		let maxSize = 1024 * 1024 * 10; // 10Mb
  		
			let fileSize = document.getElementById("productPhoto").files[0].size;
			if(ext != "jpg" && ext != "gif" && ext != "png" && ext != "jepg"){
				alert("업로드 파일은 'jpg/gif/png/jepg'만 가능합니다.");
	  	} else if(fileSize > maxSize) {
				alert("업로드 가능한 파일의 용량은 10MByte 입니다.");
	  	} else {
	  		productForm.submit();
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
			<a class="btn btn-secondary mb-4" href="javascript:backCheck()" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px'></i></a>
		</div>
		<div class="col-6 text-center">
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px;">신규 상품 추가</span>
		</div>
	</div>
	
	<div style="background-color:white; padding:20px; width: 1000px; margin-left: 180px">
  	<form name="productForm" method="post" enctype="multipart/form-data">
			<div class="table-responsive">
				<table class="table text-left">
		      <tr>
		        <th>상품명 <span class="must">*</span></th>
		        <td colspan="3"><input type="text" name="productName" id="productName" class="form-control" required /></td>
		      </tr>
		      <tr>
		        <th>간단 정보 <span class="must">*</span></th>
		        <td><input type="text" name="productDetail" id="productDetail" class="form-control" required /></td>
		      	<th>가격 <span class="must">*</span></th>
		        <td><input type="number" name="productPrice" id="productPrice" class="form-control" required /></td>
		      </tr>
		     	<tr>
		        <th>대표 사진 <span class="must">*</span></th>
		        <td colspan="3"><input type="file" name="fName" id="productPhoto" class="form-control-file border form-control"/></td>
		      </tr>
		      <tr>
		        <th>상세 설명 <span class="must">*</span></th>
		        <td colspan="3">
		        	<table class="table table-borderless">
		        		<tr>
			        		<td><textarea rows="10" name="content" id="CKEDITOR" class="form-control" required></textarea></td>
					        <!-- name=content에 있는 내용을 치환하겠다는 명령 -->
					        <script>
					        	CKEDITOR.replace("content",{
					        		height : 500,
					        		filebrowserUploadUrl : "${ctp}/imageUpload",  /* 파일(이미지) 업로드 시 매핑 경로 */
					        		uploadUrl : "${ctp}/imageUpload"							/* 여러개의 그림 파일을 드래그&드롭해서 올릴 수 있다. */
					        		/* 드래그&드롭 시 문제점 : 크기 설정 불가, 사진 업로드 전 파일 선택만 해도 파일에 자동 업로드 되어 파일을 삭제 후 글을 작성해도 해당 사진은 파일에 저장된다. */
					        	});
					        </script>
		        		</tr>
		        	</table>
		        </td>
		      </tr>
		      <tr>
		      	<td colspan="4" style="text-align: center;"><input type="button" value="등록하기" class="btn btn-secondary" onclick="inputCheck()" /></td>
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