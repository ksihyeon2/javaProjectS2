<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="utf-8" />
    <title>home</title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="${ctp}/assets/favicon.ico" />
    <!-- Font Awesome icons (free version)-->
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <!-- Google fonts-->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="${ctp}/css/styles.css" rel="stylesheet" />
    <style>
    	body {
    		background-color: rgb(76,76,76);
    	}
    </style>
</head>
<body id="page-top">
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br /></p>
<p><br /></p>
<p><br /></p>
	<div class="container page-section" id="portfolio">
  	<div class="text-center">
	    <h2 class="section-heading text-uppercase" style="color:white;">운동이 쉬워진다.<br />운동 고민 끝</h2>
	  	<h3 class="section-subheading" style="color:white;">헬스장에서든, 집에서든, 개인 맞춤 운동 추천과 코칭을 받으세요.<br />이제 운동 고민은 끝.</h3>
    </div>
    <br /><br />
    <div class="row">
    	<div class="col-lg-4 col-sm-6 mb-4">
      	<div class="portfolio-item">
        	<a class="portfolio-link" href="${ctp}/health/healthOrder">
	          <div class="portfolio-hover">
            	<div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
	          </div>
	          <img class="img-fluid" src="assets/img/portfolio/1.jpg" alt="..." />
          </a>
          <div class="portfolio-caption">
            <div class="portfolio-caption-heading">맞춤 운동</div>
            <div class="portfolio-caption-subheading text-muted">"뭐부터 해야 하지?" 생각 없이 따라만 하세요.</div>
          </div>
        </div>
      </div>
    	<div class="col-lg-4 col-sm-6 mb-4">
		    <div class="portfolio-item">
		      <a class="portfolio-link" href="${ctp}/health/healthList">
	          <div class="portfolio-hover">
	              <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
	          </div>
	          <img class="img-fluid" src="assets/img/portfolio/2.jpg" alt="..." />
		      </a>
		      <div class="portfolio-caption">
	          <div class="portfolio-caption-heading">운동 목록</div>
	          <div class="portfolio-caption-subheading text-muted">"뭐부터 해야 하지?" 생각 없이 따라만 하세요.</div>
		      </div>
		    </div>
	    </div>
	    <div class="col-lg-4 col-sm-6 mb-4">
		    <div class="portfolio-item">
	        <a class="portfolio-link" href="${ctp}/board/boardList">
	          <div class="portfolio-hover">
	            <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
	          </div>
	          <img class="img-fluid" src="assets/img/portfolio/3.jpg" alt="..." />
	        </a>
	        <div class="portfolio-caption">
	          <div class="portfolio-caption-heading">커뮤니티</div>
	          <div class="portfolio-caption-subheading text-muted">여러 사람들과 소통을 통해 더 알아가 보세요.</div>
	        </div>
		    </div>
	    </div>
    </div>
	</div>
<p><br /></p>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="${ctp}/js/scripts.js"></script>
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
</body>
</html>
