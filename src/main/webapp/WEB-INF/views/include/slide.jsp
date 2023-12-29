<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<script>
	'use strict';
	
  function fCheck() {
	  let area = document.getElementById("area").value;
	  let gymName = document.getElementById("gymName").value;
	  
	  if(area == ""){
		  alert("검색하실 지역을 선택해 주세요.");
		  $("#area").focus();
		  return false;
	  } else if (gymName == ""){
		  alert("검색하실 지점을 입력해 주세요.");
		  $("#gymName").focus();
	  	return false;
	  } 
	  
	  gymForm.submit();
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
	        	<button class="btn btn-success" type="button" onclick="fCheck()"><i class='fas fa-search' style='font-size:25px'></i></button>  
	        </div>
        </form>
        <a class="btn btn-primary btn-lg text-uppercase mt-4" href="${ctp}/gym/gymList">모든 지점 보기</a>
    </div>
</header>