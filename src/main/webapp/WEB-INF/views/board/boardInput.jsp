<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>boardInput.jsp</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
  <style>
    th {
      text-align: center;
      background-color: gray;
    }
  </style>
  <script>
  	'use strict';
  	
  	function boardInputClose(){
  		let ans = confirm("게시물 작성을 취소하시겠습니까?");
  		
  		if(!ans){
  			return false;
  		}
  		
  		location.href="${ctp}/board/boardList";
  	}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br /></p>
<p><br /></p>
<p><br /></p>
<div class="container" style="width:60%">
	<div class="row mb-4">
		<div class="col-3 text-left">
			<a class="btn btn-secondary mb-4" href="javascript:boardInputClose()" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px'></i></a>
		</div>
		<div class="col-6 text-center">
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px">게 시 판 글 작 성</span>
		</div>
	</div>
	<hr />
	<form name="myform" method="post">
		<table class="table table-bordered">
			<tr>
        <th>글쓴이</th>
        <td>${sNickName}</td>
      </tr>
      <tr>
      	<th>분류</th>
      	<td>
      		<select class="form-control" name="part" style="width:150px;" onchange="searchCheck()">
	        <option selected value="">선택</option>
	        <option>운동</option>
	        <option>식단</option>
	        <option>기타</option>
	      </select>
      	</td>
      </tr>
      <tr>
        <th>글제목</th>
        <td><input type="text" name="title" id="title" placeholder="글제목을 입력하세요" autofocus required class="form-control"/></td>
      </tr>
      <tr>
      <!-- ckeditor을 사용하기 위해서는 id에 ckeditor에서 재공하는 id를 사용(= CKEDITOR) -->
        <th>글내용</th>
        <td><textarea rows="6" name="content" id="CKEDITOR" class="form-control" required></textarea></td>
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
      <tr>
        <th>공개여부</th>
        <td>
          <input type="radio" name="openSw" value="OK" checked />공개 &nbsp;
          <input type="radio" name="openSw" value="NO" />비공개
        </td>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
          <input type="submit" value="작성하기" class="btn btn-success" /> &nbsp;
          <input type="reset" value="다시입력" class="btn btn-warning" /> &nbsp;
        </td>
      </tr>
    </table>
    <input type="hidden" name="nickName" value="${sNickName}" />
    <input type="hidden" name="mid" value="${sMid}" />
	</form>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>