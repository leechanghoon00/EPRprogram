<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("utf-8");
	String pay_id = (String) session.getAttribute("co_id");
	String name = (String) session.getAttribute("name");
	String part = (String) session.getAttribute("part");
	String position = (String) session.getAttribute("position");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>KG-ERP - Good Project</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- CSS Files -->
<jsp:include page="../common/styles.jsp"/>

<script>
document.addEventListener('DOMContentLoaded', function() {
	
	// label 요소를 선택합니다. 이 예시에서는 클래스 이름을 사용하여 선택하였습니다.
	const labelElement = document.querySelector('.datatable-dropdown label');

	// label 요소의 자식 노드 중 텍스트 노드를 찾습니다.
	const textNode = labelElement.childNodes[2];

	// 텍스트 노드의 내용을 가져옵니다.
	const labelText = ' 개씩 보기';
	textNode.textContent = labelText;
	
	const divElement = document.querySelector('.datatable-info');
	divElement.style = 'display:none';
});
</script>
</head>

<body>

  	<jsp:include page="../common/header.jsp"/>
  	
	<main id="main" class="main">
		<div class="pagetitle">
			<h1>부서원 연차 관리</h1>
		</div>

		<section class="section">
			<div class="row">
				<div class="col-lg-12">

					<div class="card">
						<div class="card-body">
							<h5 class="card-title">연차 신청자 목록</h5>
							<p>※ 정보가 일치하지 않을 경우, 총무부서로 연락 ※</p>

							<!-- Table with stripped rows -->
							<table class="table datatable">
								<thead>
									<tr align='left'>
										<th>이름</th>
										<th>부서</th>
										<th>직급</th>
										<th>종류</th>
										<th>기간</th>
										<th>잔여 연차</th>
										<th>승인 여부</th>
									</tr>
								</thead>
								<c:forEach var="list" items="${viewPartAnnual }" varStatus="loop">
								<tr>
									<td><a href="${contextPath }/money/viewAnnualDetail.do?no=${list.no}">${list.co_name}</a>
									</td>
									<td>
									<c:choose>
										<c:when test="${list.co_deuser_cd == 1}">총무</c:when>
										<c:when test="${list.co_deuser_cd == 2}">개발</c:when>
										<c:when test="${list.co_deuser_cd == 3}">경영</c:when>
									</c:choose>
									</td>
									<td>
									<c:choose>
										<c:when test="${list.co_user_cd == 1}">대표</c:when>
										<c:when test="${list.co_user_cd == 2}">팀장</c:when>
										<c:when test="${list.co_user_cd == 3}">사원</c:when>
									</c:choose>
									</td>
									<td>
									<c:choose>
										<c:when test="${list.annual_annu_cd == 1}">연차</c:when>
										<c:when test="${list.annual_annu_cd == 2}">반차</c:when>
										<c:when test="${list.annual_annu_cd == 3}">병가</c:when>
										<c:when test="${list.annual_annu_cd == 4}">예비군</c:when>
									</c:choose>
									</td>
									<td>${list.annual_period }</td>
									<td>${list.remain_annual }</td>
									<td>
									<c:choose>
										<c:when test="${list.annual_permit_cd == 1}">대기</c:when>
										<c:when test="${list.annual_permit_cd == 2}">승인</c:when>
										<c:when test="${list.annual_permit_cd == 3}">반려</c:when>
									</c:choose>
									</td>
								</tr>
								</c:forEach>

								</tbody>
							</table>
						</div>
					</div>

				</div>
			</div>
		</section>
	</main>
	<!-- End #main -->

	<jsp:include page="../common/footer.jsp" />


	<!-- JS Files -->
	<jsp:include page="../common/scripts.jsp" />
</body>

</html>