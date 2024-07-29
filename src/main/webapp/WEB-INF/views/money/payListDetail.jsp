<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("utf-8");
	String co_id = (String) session.getAttribute("co_id");
	String name = (String) session.getAttribute("name");
	String part = (String) session.getAttribute("part");
	String position = (String) session.getAttribute("position");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<script>
	
</script>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>KG-ERP - Good Project</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- CSS Files -->
<jsp:include page="../common/styles.jsp"/>
<style>
	div.datatable-top > div.datatable-dropdown, input.datatable-input {
		display: none;
	}
	div.datatable-bottom > div.datatable-info {
		display: none;
	}
	
	.datatable-top > h6 > a {
  color: #fff; /* 텍스트 색상 설정 */
  background-color: #007bff; /* 배경 색상 설정 */
  padding: 0.5rem 1rem; /* 여백 설정 */
  border-radius: 5px; /* 테두리 반경 설정 */
  text-decoration: none; /* 텍스트에 밑줄 제거 */
}
	
</style>

</head>

<body>

  	<jsp:include page="../common/header.jsp"/>
  	
	<main id="main" class="main">
		<div class="pagetitle">
			<h1>개인 급여명세서 확인</h1>
		</div>

		<section class="section">
			<div class="row">
				<div class="col-lg-12">

					<div class="card">
						<div class="card-body">
							<h5 class="card-title">${money.co_name }님 급여명세서 상세출력</h5>
							<p>※ 수정은 잔여연차, 지급액만 가능 ※</p>
							<div class="datatable-top">
							    <h6 style="text-align: right;"><a href="${contextPath }/money/modPayView.do">수정하기</a></h6>
							</div>

							<!-- Table with stripped rows -->
							<table class="table datatable">
								<thead>
									<tr align='left'>
										<th>부서</th>
										<th>아이디</th>
										<th>이름</th>
										<th>직급</th>
										<th>급여제공월</th>
										<th>지급액</th>
										<th>잔여 연차</th>
									</tr>
								</thead>
									<tr>
										<td>
											<c:choose>
												<c:when test="${money.co_deuser_cd == 1}">총무</c:when>
												<c:when test="${money.co_deuser_cd == 2}">개발</c:when>
												<c:when test="${money.co_deuser_cd == 3}">경영</c:when>
											</c:choose>
										</td>
										<td>${money.pay_id }</td>
										<td>${money.co_name }</td>
										<td>
											<c:choose>
												<c:when test="${money.co_user_cd == 1}">대표</c:when>
												<c:when test="${money.co_user_cd == 2}">팀장</c:when>
												<c:when test="${money.co_user_cd == 3}">사원</c:when>
												<c:when test="${money.co_user_cd == 4}">거래처</c:when>
											</c:choose>
										</td>
										<td>${money.work_period }</td>
										<td>${money.pay }</td>
										<td>${money.remain_annual }</td>
									</tr>
								
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