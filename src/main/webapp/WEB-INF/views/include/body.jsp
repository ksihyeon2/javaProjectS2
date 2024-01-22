<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<style>
	body {
		background-color: rgb(76,76,76);
	}
</style>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<body>

<section class="page-section bg-light" id="portfolio">
	<div class="container">
  	<div class="text-center">
	    <h2 class="section-heading text-uppercase" style="color:white;">운동이 쉬워진다.<br />운동 고민 끝</h2>
	  	<h3 class="section-subheading" style="color:white;">헬스장에서든, 집에서든, 개인 맞춤 운동 추천과 코칭을 받으세요.<br />이제 운동 고민은 끝.</h3>
    </div>
    <div class="row">
    	<div class="col-lg-4 col-sm-6 mb-4">
      	<div class="portfolio-item">
        	<a class="portfolio-link" data-bs-toggle="modal" href="#portfolioModal1">
	          <div class="portfolio-hover">
            	<div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
	          </div>
	          <img class="img-fluid" src="assets/img/portfolio/1.jpg" alt="..." />
          </a>
          <div class="portfolio-caption">
            <div class="portfolio-caption-heading">Threads</div>
            <div class="portfolio-caption-subheading text-muted">Illustration</div>
          </div>
        </div>
      </div>
    	<div class="col-lg-4 col-sm-6 mb-4">
		    <div class="portfolio-item">
		      <a class="portfolio-link" data-bs-toggle="modal" href="#portfolioModal2">
	          <div class="portfolio-hover">
	              <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
	          </div>
	          <img class="img-fluid" src="assets/img/portfolio/2.jpg" alt="..." />
		      </a>
		      <div class="portfolio-caption">
	          <div class="portfolio-caption-heading">Explore</div>
	          <div class="portfolio-caption-subheading text-muted">Graphic Design</div>
		      </div>
		    </div>
	    </div>
	    <div class="col-lg-4 col-sm-6 mb-4">
		    <div class="portfolio-item">
	        <a class="portfolio-link" data-bs-toggle="modal" href="#portfolioModal3">
	          <div class="portfolio-hover">
	            <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
	          </div>
	          <img class="img-fluid" src="assets/img/portfolio/3.jpg" alt="..." />
	        </a>
	        <div class="portfolio-caption">
	          <div class="portfolio-caption-heading">Finish</div>
	          <div class="portfolio-caption-subheading text-muted">Identity</div>
	        </div>
		    </div>
	    </div>
    </div>
	</div>
</section>
</body>