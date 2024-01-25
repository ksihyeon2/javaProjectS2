<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>healthInputChange.jsp</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
   <style>
  	.must{
  		color: red;
  	}
  	
  	th {
  		text-align:right;
  	}
	  </style>
  <script>
  	'use strict';
  	
  	let pcnt = 1;
  	let mcnt = 1;
  	let ccnt = 1;
  	
  	function positionAdd(i){
  		if($("#position"+pcnt).val() == ""){
  			return false;
  		}
  		pcnt++;
  		let str = "";
  		str += "<table class='table table-borderless'><tr>"
  		str += "<td><input type='text' name='position"+pcnt+"' id='position"+pcnt+"' class='form-control'/></td>"
  		str += "</tr></table>"
  		$("#positionAppend").append(str);
  	}
  	
  	function motionAdd(i){
  		if($("#motion"+mcnt).val() == ""){
  			return false;
  		}
  		mcnt++;
  		let str = "";
  		str += "<table class='table table-borderless'><tr>"
  		str += "<td><input type='text' name='motion"+mcnt+"' id='motion"+mcnt+"' class='form-control'/></td>"
  		str += "</tr></table>"
  		$("#motionAppend").append(str);
  	}
  	
  	function cautionAdd(i){
  		if($("#caution"+ccnt).val() == ""){
  			return false;
  		}
  		ccnt++;
  		let str = "";
  		str += "<table class='table table-borderless'><tr>"
  		str += "<td><input type='text' name='caution"+ccnt+"' id='caution"+ccnt+"' class='form-control'/></td>"
  		str += "</tr></table>"
  		$("#cautionAppend").append(str);
  	}
  	
  	function healthInput(){
  		let hName = $("#hName").val();
  		let part = $("#part").val();
  		let detailPart = $("#detailPart").val();
  		let level = $("#level").val();
  		let breath = $("#breath").val();
  		let position = $("#position1").val();
  		let motion = $("#motion1").val();
  		let caution = $("#caution1").val();
  		
  		if(hName.trim() == ""){
  			alert("운동 이름을 입력해 주세요.");
  			$("#hName").focus();
  			return false;
  		}
  		if(part == ""){
  			alert("운동 부위를 선택해 주세요.");
  			$("#part").focus();
  			return false;
  		}
  		if(detailPart.trim() == ""){
  			alert("운동 상세 부위를 입력해 주세요.");
  			$("#detailPart").focus();
  			return false;
  		}
  		if(level == ""){
  			alert("운동 강도를 선택해 주세요.");
  			$("#level").focus();
  			return false;
  		}
  		if(position.trim() == ""){
  			alert("운동 시작 자세를 입력해 주세요.");
  			$("#position1").focus();
  			return false;
  		}
  		if(motion.trim() == ""){
  			alert("운동 동작을 입력해 주세요.");
  			$("#motion1").focus();
  			return false;
  		}
  		if(breath.trim() == ""){
  			alert("호흡법을 입력해 주세요.");
  			$("#breath").focus();
  			return false;
  		}
  		if(caution.trim() == ""){
  			alert("주의 사항을 입력해 주세요.");
  			$("#caution1").focus();
  			return false;
  		}
  		
  		position = $("#position"+pcnt).val();
  		motion = $("#motion"+mcnt).val();
  		caution = $("#caution"+ccnt).val();
  		if(position.trim() == ""){
  			pcnt = pcnt-1;
  		}
  		if(motion.trim() == ""){
  			mcnt = mcnt-1;
  		}
  		
  		if(caution.trim() == ""){
  			ccnt = ccnt-1;
  		}
  		
			position = "";
			if(pcnt == 1){
  			position = $("#position1").val();
			} else {
	  		for(let i=1; i<=pcnt; i++){
	  			position += i + "." + $("#position"+i).val() + "<br />";
	  		}
			}
			
  		motion = "";
  		if(mcnt == 1){
  			motion = $("#motion1").val();
  		} else {
	  		for(let i=1; i<=mcnt; i++){
	  			motion += i + "." + $("#motion"+i).val() + "<br />";
	  		}
  		}
  		
  		
  		caution = "";
  		if(ccnt == 1){
  			caution = $("#caution1").val();
  		} else {
	  		for(let i=1; i<=ccnt; i++){
	  			caution += i + "." + $("#caution"+i).val() + "<br />";
	  		}
  		}
  		
  		healthForm.position.value = position;
  		healthForm.motion.value = motion;
  		healthForm.caution.value = caution;
  		
			let ans = confirm("신규 등록 하시겠습니까?");
  		
  		if(!ans){
  			return false;
  		};
  		
  		// 사진 추가
  		let fName = $("#photo").val();
  		let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
  		let maxSize = 1024 * 1024 * 10; // 10Mb
  		
  		if(fName.trim() == ""){
  			healthForm.submit();
  		} else {
  			let fileSize = document.getElementById("photo").files[0].size;
				if(ext != "jpg" && ext != "gif" && ext != "png" && ext != "jepg" && ext != "mp4"){
	  			alert("업로드 파일은 'jpg/gif/png/jepg/mp4'만 가능합니다.");
		  	} else if(fileSize > maxSize) {
	  			alert("업로드 가능한 파일의 용량은 10MByte 입니다.");
		  	} else {
		  		
		  		healthForm.submit();
		  	}	
  		}
  	}
  	
  	function backCheck(){
  		let ans = confirm("수정을 취소하시겠습니까?");
  		
  		if(!ans){
  			return false;
  		}
  		
  		location.href = "healthContent?hName=${vo.HName}";
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
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px;">수정하기</span>
		</div>
	</div>
	
	<div style="background-color:white; padding:20px; width: 1000px; margin-left: 180px">
  	<form name="healthForm" method="post" enctype="multipart/form-data">
			<div class="table-responsive">
				<table class="table text-left">
		      <tr>
		        <th>운동 이름 <span class="must">*</span></th>
		        <td><input type="text" name="hName" id="hName" value="${vo.HName}" class="form-control" required /></td>
		      	<th>부위 <span class="must">*</span></th>
		        <td>
		        	<select name="part" id="part" class="form-control">
				        <option ${vo.part == '' ? 'selected' : '' }>선택</option>
				        <option ${vo.part == '가슴' ? 'selected' : '' }>가슴</option>
				        <option ${vo.part == '등' ? 'selected' : '' }>등</option>
				        <option ${vo.part == '하체' ? 'selected' : '' }>하체</option>
				        <option ${vo.part == '어깨' ? 'selected' : '' }>어깨</option>
				        <option ${vo.part == '삼두' ? 'selected' : '' }>삼두</option>
				       	<option ${vo.part == '이두' ? 'selected' : '' }>이두</option>
				       	<option ${vo.part == '코어' ? 'selected' : '' }>코어</option>
			         	<option ${vo.part == '전완근' ? 'selected' : '' }>전완근</option>
		          	<option ${vo.part == '유산소' ? 'selected' : '' }>유산소</option>
			        </select>
		        </td>
		      </tr>
		      <tr>
		        <th>상세 부위 <span class="must">*</span></th>
		        <td><input type="text" name="detailPart" id="detailPart" value="${vo.detailPart}" class="form-control" required /></td>
		      	<th>강도 <span class="must">*</span></th>
		        <td>
							<select name="level" id="level" class="form-control">
				        <option ${vo.level == '' ? 'selected' : '' }>선택</option>
				        <option ${vo.level == '1' ? 'selected' : '' }>초보</option>
				        <option ${vo.level == '2' ? 'selected' : '' }>중급</option>
				        <option ${vo.level == '3' ? 'selected' : '' }>고급</option>
			        </select>
						</td>
		      </tr>
		     	<tr>
		        <th>사진 변경</th>
		        <td>
		        	<c:if test="${vo.photo == ''}">
								<img src="${ctp}/health/준비중.png" width="250px">
							</c:if>
							<c:if test="${vo.photo != ''}">
								<img src="${ctp}/health/${vo.photo}" width="250px" />
							</c:if>
		        </td>
		        <td colspan="2"><input type="file" name="fName" id="photo" class="form-control-file border form-control"/></td>
		      </tr>
		      <tr>
		        <th>시작 자세 <span class="must">*</span></th>
		        <td colspan="3">
		        	<table class="table table-borderless">
		        		<tr>
		        			<td><input type="text" name="position1" id="position1" class="form-control"/></td>
		        			<td><input type="button" value="추가" id="pcnt1" class="btn btn-secondary" onclick="positionAdd(1)"></td>
		        		</tr>
		        	</table>
        			<div id="positionAppend"></div>
		        </td>
		      </tr>
		      <tr>
		        <th>운동 동작 <span class="must">*</span></th>
		        <td colspan="3">
		        	<table class="table table-borderless">
		        		<tr>
		        			<td><input type="text" name="motion1" id="motion1" class="form-control"/></td>
		        			<td><input type="button" value="추가" id="mcnt1" class="btn btn-secondary" onclick="motionAdd(1)"></td>
		        		</tr>
		        	</table>
        			<div id="motionAppend"></div>
		        </td>
		      </tr>
		      <tr>
		      	<th>호흡법 <span class="must">*</span></th>
		      	<td colspan="3"><input type="text" name="breath" id="breath" value="${vo.breath}" class="form-control" required /></td>
		      </tr>
		      <tr>
		        <th>주의 사항 <span class="must">*</span></th>
		        <td colspan="3">
		        	<table class="table table-borderless">
		        		<tr>
		        			<td><input type="text" name="caution1" id="caution1" class="form-control"/></td>
		        			<td><input type="button" value="추가" id="ccnt1" class="btn btn-secondary" onclick="cautionAdd(1)"></td>
		        		</tr>
		        	</table>
        			<div id="cautionAppend"></div>
		        </td>
		      </tr>
		      <tr>
		      	<th>코멘트</th>
		      	<td colspan="3"><input type="text" name="comment" value="${vo.comment}" class="form-control" required /></td>
		      </tr>
		      <tr>
		      	<td colspan="4" class="text-center"><input type="button" value="등록하기" class="btn btn-secondary" onclick="healthInput()"></td>
		      </tr>
			  </table>
			</div>
			<input type="hidden" name="position" id="position" />
			<input type="hidden" name="motion" id="motion" />
			<input type="hidden" name="caution" id="caution" />
  	</form>
  </div>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>