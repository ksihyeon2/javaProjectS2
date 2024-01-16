<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>gyminfor.jsp</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br /></p>
<div class="container">
	<div class="row mb-4">
		<div class="col-3 text-left">
			<a class="btn btn-secondary mb-4" href="${ctp}/gym/gymList?pag=${pag}&pageSize=${pageSize}" style="margin-left:20px;"><i class='fas fa-arrow-left' style='font-size:24px'></i></a>
		</div>
		<div class="col-6 text-center">
			<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px">${vo.gymName}</span>
		</div>
	</div>
	<table class="text-center" style="width:100%">
		<tr>
			<td>
				<table class="text-center mr-4">
					<tr>
						<td colspan="3">
							<span class="text-center">
								<img src="${ctp}/images/gym/${vo.photo}" width="500px" height="350px" />
							</span>
						</td>
					</tr>
					<tr>
						<td colspan="3"><h1><b>${vo.gymName}</b></h1>
							<hr />
						</td>
					</tr>
					<tr class="text-center">
						<td><a href="#"><i class='far fa-star' style='font-size:24px'></i></a></td>
						<td><a href="javascript:viewCheck()"><i class='fas fa-map-marker-alt' style='font-size:24px'></i></a></td>
						<td><a href="#"><i class='far fa-calendar-check' style='font-size:24px'></i></a></td>
					</tr>		
					<tr class="mb-3">
						<td colspan="3" class="text-left">
							<hr />
							<b style="font-size:20px">오시는길</b>	
						</td>
					</tr>	
					<tr class="text-left">
						<td colspan="3">${vo.address}
							<hr />
						</td>
					</tr>
					<tr class="text-left">
						<td colspan="3">전화번호 : </td>
						<%--${vo.tel} --%>
					</tr>
					<tr class="text-left">
						<td colspan="3"><hr />홈페이지 :
							<c:if test="${!empty vo.homePage}">
								<a href="${vo.homePage}">${vo.homePage}</a>
							</c:if>
							<c:if test="${empty vo.homePage}">
								없음
							</c:if>
						</td>
					</tr>
				</table>
			</td>
			<td id="view">
				<table class="text-center ml-4">
					<tr>
						<td>
							<div id="daumRoughmapContainer1701572700477" class="root_daum_roughmap root_daum_roughmap_landing"></div>
							<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
								<script charset="UTF-8">
								new daum.roughmap.Lander({
									"timestamp" : "1701572700477",
									"key" : "2h322",
									"mapWidth" : "640",
									"mapHe	ight" : "360"
								}).render();
							</script>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>