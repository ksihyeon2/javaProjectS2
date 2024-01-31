<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adminPage.jsp</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
  <script type="text/javascript">
	  google.charts.load("current", {packages:["corechart"]});
	  google.charts.setOnLoadCallback(drawChart);
	  function drawChart() {
	    var data = google.visualization.arrayToDataTable([
	    	['Task', 'Hours per Day'],
	    	['${hName[0]}', ${interest[0]}],
	  		['${hName[1]}', ${interest[1]}],
	  		['${hName[2]}', ${interest[2]}],
	  		['${hName[3]}', ${interest[3]}],
	  		['${hName[4]}', ${interest[4]}]
	    ]);
	
	    var options = {
	      title: '회원 인기 운동',
	      is3D: true,
	    };
	
	    var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
	    chart.draw(data, options);
	  }
	</script>
  <style>
  	a {
  		color:black;
  		text-decoration-line:none;
  	}
  	body {
  		background-color: rgb(76,76,76);
  	}
  	
  	.sidebar > nav {
  		background-color: rgb(189,189,189);
  		border-radius:30px;
  		padding: 20px;
  	}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br /></p>
<p><br /></p>
<p><br /></p>
<div class="container">
	<div class="sidebar p-3" style="margin-left:20px">
    <h2 ><b><a href="adminPage" style="color:white;margin-left:20px;margin-bottom:10px ">관리자 페이지</a></b></h2>
    <nav class="navbar">
      <div class="navbar-nav">
        	<div class="nav-item dropdown">
          	<a href="#" class="nav-link dropdown-toggle m-2" data-toggle="dropdown" id="nav-product"><b>회원</b></a>
          	<div class="dropdown-menu bg-transparent border-0 show">
	            <a href="memberList" class="dropdown-item">회원정보</a>
	            <a href="memberDelList" class="dropdown-item">회원탈퇴 관리</a>
            </div>
          </div>
          <div class="nav-item dropdown">
            <a href="#" class="nav-link dropdown-toggle m-2" data-toggle="dropdown" id="nav-product"><b>커뮤니티</b></a>
            <div class="dropdown-menu bg-transparent border-0 show">
	            <a href="#" class="dropdown-item">공지사항</a>
	            <a href="${ctp}/board/boardList?user=admin" class="dropdown-item">게시물</a>
            </div>
          </div>
          <div class="nav-item dropdown">
	          <a href="#" class="nav-link dropdown-toggle m-2" data-toggle="dropdown" id="nav-product"><b>관리</b></a>
	          <div class="dropdown-menu bg-transparent border-0 show">
	          	<a href="healthModifyList" class="dropdown-item">수정 요청 관리</a>
	            <a href="complaintList" class="dropdown-item">신고 관리</a>
	          </div>
          </div>
          <div class="nav-item dropdown">
            <a href="#" class="nav-link dropdown-toggle m-2" data-toggle="dropdown" id="nav-product"><b>정보</b></a>
            <div class="dropdown-menu bg-transparent border-0 show">
              <a href="#" data-toggle="modal" data-target="#myModal" class="dropdown-item">정보 수정</a>
              <a href="memberPwdChange" class="dropdown-item">비밀번호 수정</a>
              <a href="#" data-toggle="modal" data-target="#delModal" class="dropdown-item">관리자 정보</a>
          </div>
        </div>
      </div>
      <div>
      <div style="background-color: white;">
        <div class="row g-4 rounded m-0" style="width:1000px;border-color:black;border:2px solid;">
          <div class="col-sm-4 col-xl-4 d-flex">
          	<div class="d-flex align-items-center justify-content-between p-3">
              <div class="d-flex flex-column gmarketSans">
                <span class="text-black" style="font-size:1.5em">${sNickName}님 반갑습니다.</span>
                <span class="text-muted" style="font-size:12pt">[${strLevel}]</span>
              </div>
        		</div>
          </div>
          <div class="col-sm-2 col-xl-2">
            <div class="d-flex flex-column align-items-center justify-content-between p-3">
	              <div class="ms-3 mt-3">
	              <p class="mb-2 text-black" style="font-size:13pt">Today</p>
	              </div>
	              <div class="ms-3 mt-2 dropdown">
	                <h3 class="mb-2 text-black dropdown-toggle" data-toggle="dropdown"><a href="#">${memberToday}명</a></h3>
							    <div class="dropdown-menu">
							      <a class="dropdown-item" href="#">비회원(${today}명)</a>
							      <a class="dropdown-item" href="#">회원(${memberToday}명)</a>
							    </div>
	              </div>
              
            </div>
          </div>
          <div class="col-sm-2 col-xl-2">
            <div class="d-flex flex-column align-items-center justify-content-between p-3">
              <div class="ms-3 mt-3">
                <p class="mb-2 text-black" style="font-size:13pt">신고</p>
              </div>
              <div class="ms-3 mt-2">
                <h3 class="mb-2 text-black"><a href="#">${complaintSize}건</a></h3>
              </div>
            </div>
          </div>
          <div class="col-sm-2 col-xl-2">
	          <div class="d-flex flex-column align-items-center justify-content-between p-3">
              <div class="ms-3 mt-3">
                <p class="mb-2 text-black"  style="font-size:13pt">수정요청</p>
              </div>
              <div class="ms-3 mt-2">
                <h3 class="mb-2 text-black"><a href="#">${modifySize}건</a></h3>
              </div>
	          </div>
          </div>
          <div class="col-sm-2 col-xl-2">
	          <div class="d-flex flex-column align-items-center justify-content-between p-3">
              <div class="ms-3 mt-3">
                <p class="mb-2 text-black"  style="font-size:13pt">공지</p>
              </div>
              <div class="ms-3 mt-2">
                <h3 class="mb-2 text-black"><a href="${ctp}/board/boardMyList" class="dropdown-item">${boardCnt}건</a></h3>
              </div>
	          </div>
          </div>
        </div>
    	</div>
      <div class="pt-2 px-2">
        <div>
          <div>
            <div class="text-center rounded p-4">
              <div class="d-flex align-items-center justify-content-between mb-4 mt-2 border-bottom-design">
                <div class="d-flex mb-1">
                	<h3 class="mb-0 pretendard mr-2">회원 분석</h3>
                </div>
                <a href="#">전체보기<i class='fas fa-angle-right'></i></a>
              </div>
          		<div>
               <table>
               	<tr>
               		<td>
             			 <div id="piechart_3d" style="width: 900px; height: 300px;"></div>
               		</td>	
               	</tr>
               </table>
	           </div>
            </div>
          </div>
        </div>
			</div>
			</div>
		</nav>
	</div>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>