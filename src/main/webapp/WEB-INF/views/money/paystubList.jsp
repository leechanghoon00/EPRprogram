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

const columns = [
    { text: "아이디", datafield: "pay_id"},
    { text: "이름", datafield: "co_name"},
    { text: "급여제공월", datafield: "work_period"},
    { text: "지급액", datafield: "pay"},
    { text: "잔여 연차", datafield: "remain_annual"},
  ];

function excelDownload() {
  const url = "${contextPath}/money/excelPayStub.do";
  
//엑셀에 보여줄 컬럼명, 리스트와 매칭 할 데이타필드 셋팅( columns[0] rowId제외 )
  var columnsNm = [];
  var datafield = [];
  for (var i = 0; i < columns.length; i++) {
    columnsNm[i] = columns[i].text;
    datafield[i] = columns[i].datafield;
  }
  $("#columnsNm").val(columnsNm);
  $("#datafield").val(datafield);

  $("#excelForm").attr("action", url);
  $("#excelForm").submit();
}


</script>
</head>



<body>

  	<jsp:include page="../common/header.jsp"/>
  	
	<main id="main" class="main">
		<div class="pagetitle">
			<h1>전체 급여명세서 관리</h1>
		</div>

		<section class="section">
			<form id="excelForm" name="excelForm">
				<input type="hidden" name="excelFileNm" value="급여명세서 목록.xls">
				<input type="hidden" id="columnsNm" name="columnsNm" />
				<input type="hidden" id="datafield" name="datafield"/>
			</form>
			<div class="row">
				<div class="col-lg-12">

					<div class="card">
						<div class="card-body">
							<h5 class="card-title">급여명세서 관리</h5>
							<p>※ 수정 후, 총무팀장에게 체크 ※</p>
							<div style="text-align:right; padding-right:50px;" >
								<button type="button" class="btn btn-secondary rounded-pill" onclick="excelDownload()">엑셀 다운로드</button>
								<input class="btn btn-primary" type="button" onclick="location.href='${contextPath}/money/addPayView.do';" value="등록하기"/>
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
								<c:choose>
									<c:when test="${not empty allPayList}">
										<!-- allPayList가 비어있지 않은 경우 -->
										<c:forEach items="${allPayList}" var="pay">
											<tr align='left'>
												<td><c:choose>
														<c:when test="${pay.co_deuser_cd == 1}">총무</c:when>
														<c:when test="${pay.co_deuser_cd == 2}">개발</c:when>
														<c:when test="${pay.co_deuser_cd == 3}">경영</c:when>
													</c:choose></td>
												<td><a
													href="${contextPath}/money/payListDetail.do?pay_id=${pay.pay_id}&work_period=${pay.work_period}">${pay.pay_id}</a></td>
												<td>${pay.co_name}</td>
												<td><c:choose>
														<c:when test="${pay.co_user_cd == 1}">대표</c:when>
														<c:when test="${pay.co_user_cd == 2}">팀장</c:when>
														<c:when test="${pay.co_user_cd == 3}">사원</c:when>
														<c:when test="${pay.co_user_cd == 4}">거래처</c:when>
													</c:choose></td>
												<td>${pay.work_period}</td>
												<td>${pay.pay}</td>
												<td>${pay.remain_annual}</td>
											</tr>
										</c:forEach>

									</c:when>
									<c:otherwise>
										<!-- allPayList가 비어있는 경우 -->
										<tr>
											<td colspan="6">데이터가 없습니다.</td>
										</tr>
									</c:otherwise>
								</c:choose>
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