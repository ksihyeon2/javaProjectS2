<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>healthInput.jsp</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
   <style>
  	.must{
  		color: red;
  	}
  </style>
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
			<a class="btn btn-secondary mb-4" href="healthList" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px'></i></a>
		</div>
		<div class="col-6 text-center">
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px;">신규 운동 추가</span>
		</div>
	</div>
	
	<div style="background-color:white; padding:20px; width: 1000px; margin-left: 180px">
  	<form name="gymForm" method="post" enctype="multipart/form-data">
			<div class="table-responsive">
				<table class="table text-left">
		      <tr>
		        <th>운동 이름 <span class="must">*</span></th>
		        <td colspan="3"><input type="text" name="hName" id="hName" class="form-control" required /></td>
		      </tr>
		      <tr>
		      	<th>부위 <span class="must">*</span></th>
		        <td>
		        	<select name="part" id="part" class="form-control">
				        <option value="">선택</option>
				        <option>가슴</option>
				        <option>등</option>
				        <option>하체</option>
				        <option>어깨</option>
				        <option>삼두</option>
				       	<option>이두</option>
				       	<option>코어</option>
			         	<option>전완근</option>
		          	<option>유산소</option>
			        </select>
		        </td>
		        <th>상세 부위</th>
		        <td><input type="text" name="detailPart" id="detailPart" class="form-control" required /></td>
		      </tr>
		      <tr>
		        <th>사진 추가</th>
		        <td colspan="3"><input type="file" name="fName" id="photo" class="form-control-file border form-control"/></td>
		      </tr>
		      <tr>
		        <th>시작 자세</th>
		        <td colspan="3">
		        	<table class="table table-borderless">
		        		<tr>
		        			<td><input type="text" name="homePage" id="homePage" class="form-control"/></td>
		        			<td><input type="button" value="추가" id="cnt" class="btn btn-secondary" onclick=""></td>
		        		</tr>
		        	</table>
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