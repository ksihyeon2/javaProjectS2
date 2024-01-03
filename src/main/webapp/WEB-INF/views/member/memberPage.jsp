<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberPage.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link href="${ctp}/css/styles.css" rel="stylesheet" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br /></p>
<p><br /></p>
<p><br /></p>
<div class="container" style="height:950px">
	<h2>마이페이지</h2>
	<hr />
	<div>
		<table class="table table-borderless" style="width:1000px">
			<tr>
				<td>
					<h3>${vo.nickName}님</h3>
					<a href="#" style="color:gray">${strLevel} ></a>
				</td>
				<td class="text-right"><a href="memberModify" style="color:gray">설정</a></td>
			</tr>
			<tr>
				<td>
					<table class="table table-bordered">
						<tr>
							<td><b>포인트</b><br /><a href="#" style="color:gray">${vo.point} point</a></td>
						</tr>
					</table>
				</td>
				<td>
					<table class="table table-bordered">
						<tr>
							<td><b>관심</b><br /><a href="#" style="color:gray">바로가기</a></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<table class="table table-borderless">
						<tr>
							<td>
								<table class="table table-bordered" style="width:200px;height:100px">
									<tr>
										<td>주문내역</td>
									</tr>
								</table>
							</td>
							<td>
								<table class="table table-bordered" style="width:200px;height:100px">
									<tr>
										<td>나의 리뷰 & 댓글</td>
									</tr>
								</table>
							</td>
							<td>
								<table class="table table-bordered" style="width:200px;height:100px">
									<tr>
										<td>작성글</td>
									</tr>
								</table>
							</td>
							<td>
								<table class="table table-bordered" style="width:200px;height:100px">
									<tr>
										<td>문의</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>