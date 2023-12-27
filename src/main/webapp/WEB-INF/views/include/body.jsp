<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
	<!-- Portfolio Grid-->
<section class="page-section bg-light" id="portfolio">
    <div class="container">
        <div class="text-center">
            <h2 class="section-heading text-uppercase">맞춤 추천 운동법</h2>
            <h3 class="section-subheading text-muted"><%-- ${year}년 ${month}월 추천 여행지 입니다. --%></h3>
        </div>
        <div class="row">
            <div class="col-lg-4 col-sm-6 mb-4">
                <!-- Portfolio item 1-->
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
              <!-- Portfolio item 2-->
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
              <!-- Portfolio item 3-->
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
          <hr />
          <div class="text-center mt-4">
            <h2 class="section-heading text-uppercase">맞춤 추천 식단</h2>
            <h3 class="section-subheading text-muted"><%-- ${year}년 ${month}월 추천 여행지 입니다. --%></h3>
        	</div>
          <div class="col-lg-4 col-sm-6 mb-4 mb-lg-0">
              <!-- Portfolio item 4-->
              <div class="portfolio-item">
                  <a class="portfolio-link" data-bs-toggle="modal" href="#portfolioModal4">
                      <div class="portfolio-hover">
                          <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
                      </div>
                      <img class="img-fluid" src="assets/img/portfolio/4.jpg" alt="..." />
                  </a>
                  <div class="portfolio-caption">
                      <div class="portfolio-caption-heading">Lines</div>
                      <div class="portfolio-caption-subheading text-muted">Branding</div>
                  </div>
              </div>
          </div>
          <div class="col-lg-4 col-sm-6 mb-4 mb-sm-0">
              <!-- Portfolio item 5-->
              <div class="portfolio-item">
                  <a class="portfolio-link" data-bs-toggle="modal" href="#portfolioModal5">
                      <div class="portfolio-hover">
                          <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
                      </div>
                      <img class="img-fluid" src="assets/img/portfolio/5.jpg" alt="..." />
                  </a>
                  <div class="portfolio-caption">
                      <div class="portfolio-caption-heading">Southwest</div>
                      <div class="portfolio-caption-subheading text-muted">Website Design</div>
                  </div>
              </div>
          </div>
          <div class="col-lg-4 col-sm-6">
              <!-- Portfolio item 6-->
                <div class="portfolio-item">
                    <a class="portfolio-link" data-bs-toggle="modal" href="#portfolioModal6">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
                        </div>
                        <img class="img-fluid" src="assets/img/portfolio/6.jpg" alt="..." />
                    </a>
                    <div class="portfolio-caption">
                        <div class="portfolio-caption-heading">Window</div>
                        <div class="portfolio-caption-subheading text-muted">Photography</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
