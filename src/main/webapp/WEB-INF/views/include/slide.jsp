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
 		let demo = "";
 		
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
		  success : function(vos){
			  if(vos == ""){
				  $(".demo").text("검색하신 지점이 존재하지 않습니다.");
			  } else {
				  alert("기둘");
			  }
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
    			<option>서울</option>
    			<option>경기</option>
    			<option>인천</option>
    			<option>충남</option>
    			<option>충북</option>
    			<option>대전</option>
    			<option>울산</option>
    			<option>부산</option>
    			<option>전북</option>
    			<option>광주</option>
    		</select>
      	<input type="text" name="gymName" id="gymName" placeholder="지점명 검색" style="width:30%;height:35px"/>
      	<a href="#" onclick="gymSearch()" data-toggle="modal" data-target="#gymModal" class="btn btn-secondary"><i class='fas fa-search' style='font-size:25px'></i></a>
      </div>
    </form>
    <a class="btn btn-primary btn-lg text-uppercase mt-4" href="${ctp}/gym/gymList">모든 지점 보기</a>
  </div>
 
   
	   <!-- The Modal -->
	<div class="modal fade" id="gymModal">
		<div class="modal-dialog">
		    <div class="modal-content">
		    <!-- Modal Header -->
		        <div class="modal-header">
		        	<h4 class="modal-title" style="color:black">검색하신 지점의 정보입니다.</h4>
		          	<button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        <!-- Modal body -->    
		        <div class="modal-body demo" style="color:black"></div>
		        <!-- Modal footer -->
		        <div class="modal-footer">
		          	<button type="button" class="btn btn-danger" data-dismiss="modal">확인</button>
		        </div>
		    </div>
		</div>
	</div>
</header>