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

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>KG-ERP - Good Project</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- CSS Files -->
<jsp:include page="../common/styles.jsp"/>

<style>
#main {
	margin-top: 60px;
	padding: 20px 30px;
	transition: all 0.3s;
	min-height: 730px;
}
</style>
</head>

<body>
  	<jsp:include page="../common/header.jsp"/>
  	
	<main id="main" class="main">

		<div class="pagetitle">
			<h1>공지사항</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a
						href="${contextPath }/member/mainAdmin.do">Home</a></li>
					<li class="breadcrumb-item active">부서별 공지사항</li>
				</ol>
			</nav>
		</div>

		<section class="section">
			<div class="row">
				<div class="col-lg-6">

					<div class="card">
						<div class="card-body">
							<h5 class="card-title">총무부서 공지사항</h5>
							<p></p>

							<!-- Default Accordion -->
							<div class="accordion" id="general">
								<c:forEach var="list" items="${genList }" varStatus="loop">
									<div class="accordion-item">
										<h2 class="accordion-header" id="headingOne">
											<button id="generalBtn${loop.index }"
												class="accordion-button collapsed" type="button"
												data-bs-toggle="collapse"
												data-bs-target="#collapseGen${loop.index }"
												aria-expanded="false" aria-controls="collapseOne">
												<span onclick="location.href='${contextPath}/board/partDetail.do?anno_no=${list.anno_no }';"><strong>${list.anno_no }.${list.anno_title }</strong></span>
											</button>
										</h2>
										<div id="collapseGen${loop.index }"
											class="accordion-collapse collapse"
											aria-labelledby="headingOne"
											data-bs-parent="#accordionExample">
											<div class="accordion-body">${list.anno_content }</div>
										</div>
									</div>
								</c:forEach>
							</div>
							<!-- End Default Accordion Example -->


						</div>
					</div>
				</div>
				<div class="col-lg-6">

					<div class="card">
						<div class="card-body">
							<h5 class="card-title">개발부서 공지사항</h5>
							<p></p>

							<!-- Default Accordion -->
							<div class="accordion" id="dev">
								<c:forEach var="list" items="${devList }" varStatus="loop">
									<div class="accordion-item">
										<h2 class="accordion-header" id="headingOne">
											<button id="devBtn${loop.index }"
												class="accordion-button collapsed" type="button"
												data-bs-toggle="collapse"
												data-bs-target="#collapseDev${loop.index }"
												aria-expanded="false" aria-controls="collapseOne">
												<span onclick="location.href='${contextPath}/board/partDetail.do?anno_no=${list.anno_no }';"><strong>${list.anno_no }.${list.anno_title }</strong></span>
											</button>
										</h2>
										<div id="collapseDev${loop.index }"
											class="accordion-collapse collapse"
											aria-labelledby="headingOne"
											data-bs-parent="#accordionExample">
											<div class="accordion-body">${list.anno_content }</div>
										</div>
									</div>
								</c:forEach>
							</div>
							<!-- End Default Accordion Example -->


						</div>
					</div>
				</div>
				<div class="col-lg-6">

					<div class="card">
						<div class="card-body">
							<h5 class="card-title">경영부서 공지사항</h5>
							<p></p>

							<!-- Default Accordion -->
							<div class="accordion" id="manage">
								<c:forEach var="list" items="${manList }" varStatus="loop">
									<div class="accordion-item">
										<h2 class="accordion-header" id="headingOne">
											<button id="manageBtn${loop.index }"
												class="accordion-button collapsed" type="button"
												data-bs-toggle="collapse"
												data-bs-target="#collapseMan${loop.index }"
												aria-expanded="false" aria-controls="collapseOne">
												<span onclick="location.href='${contextPath}/board/partDetail.do?anno_no=${list.anno_no }';"><strong>${list.anno_no }.${list.anno_title }</strong></span>
											</button>
										</h2>
										<div id="collapseMan${loop.index }"
											class="accordion-collapse collapse"
											aria-labelledby="headingOne"
											data-bs-parent="#accordionExample">
											<div class="accordion-body">${list.anno_content }</div>
										</div>
									</div>
								</c:forEach>
							</div>
							<!-- End Default Accordion Example -->


						</div>
					</div>
				</div>
			</div>
		</section>
	</main>
	<!-- End #main -->

 	<jsp:include page="../common/footer.jsp"/>
 
	
	<!-- JS Files -->
	<jsp:include page="../common/scripts.jsp"/>
</body>

</html>