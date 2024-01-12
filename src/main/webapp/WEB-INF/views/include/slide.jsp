<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<script>
	'use strict';
	
  function gymSearch(){
	  let area = $("#area").val();
 		let gymName = document.getElementById("gymName").value;
 		
	  if (gymName == ""){
		  alert("검색하실 지점을 입력해 주세요.");
		  $("#gymName").focus();
		  location.reload();
	  	return false;
	  }
	  
	  let query = {
			  area:area,
			  gymName:gymName
	  }
	  
	  $.ajax({
		  url : "${ctp}/gym/gmySearchList",
		  type : "post",
		  data : query,
		  success : function(res){
			  
		  },
		  error : function(){
			  alert("전송 오류");
		  }
	  });
  }
</script>
<header class="masthead">
    <div class="container">
        <div class="masthead-subheading">내 주변 지점을 검색해보세요.</div>
        <form name="gymForm" method="post" action="${ctp}/gym/gymSearch">
	        <div class="mb-4">
	        	<select name="area"	id="area" style="width:10%;height:35px">
	      			<option value="">지역선택</option>
	      			<option>강원도</option>
	      			<option>경기도</option>
	      			<option>충청북도</option>
	      			<option>충청남도</option>
	      			<option>경상북도</option>
	      			<option>전라북도</option>
	      			<option>경상남도</option>
	      			<option>전라남도</option>
	      			<option>제주특별자치도</option>
	      		</select>
	        	<input type="text" name="gymName" id="gymName" placeholder="지점명 검색" style="width:30%;height:35px"/>
	        	<a href="#" onclick="gymSearch()" data-toggle="modal" data-target="#delModal" class="btn btn-secondary"><i class='fas fa-search' style='font-size:25px'></i></a>
	        </div>
        </form>
        <a class="btn btn-primary btn-lg text-uppercase mt-4" href="${ctp}/gym/gymList">모든 지점 보기</a>
    </div>
    
    
    
    
    <!-- The Modal -->
<div class="modal fade" id="delModal">
	<div class="modal-dialog">
	    <div class="modal-content">
	    <!-- Modal Header -->
	        <div class="modal-header">
	        	<h4 class="modal-title"><b>${vo.name}</b>님 탈퇴를 원하시면 비밀번호를 입력해 주세요.<br /><span style="color:red;font-size:10pt">탈퇴 후 같은 아이디로 1개월간 재가입 하실 수 없습니다.</span></h4>
	          	<button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
	        <!-- Modal body -->    
	        <div class="modal-body">
	         	<input type="password" name="delPwd" id="delPwd" class="form-control" />
	        	<input type="hidden" name="delMid" id="delMid" value="${sMid}" />
	        </div>
	        <!-- Modal footer -->
	        <div class="modal-footer">
	          	<button type="button" class="btn btn-primary" onclick="memberDelOk()">확인</button>
	          	<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
	        </div>
	    </div>
	</div>
</div>
</header>