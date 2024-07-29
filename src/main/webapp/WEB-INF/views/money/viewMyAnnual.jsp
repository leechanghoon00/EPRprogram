<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("utf-8");
	String pay_id = (String) session.getAttribute("co_id");
	String name = (String) session.getAttribute("name");
	String part = (String) session.getAttribute("part");
	String position = (String) session.getAttribute("position");
	String no = (String) session.getAttribute("no");
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
#cancel2 {
  padding: 3px 9px; /* 여백 설정 */
  border-radius: 5px; /* 테두리 둥글게 설정 */
  border: none; /* 테두리 제거 */
  color: #fff; /* 텍스트 색상 설정 */
  cursor: pointer; /* 마우스 커서 모양 변경 */
}

#cancel1 {
	border-radius: 5px;
	border: none;
	color: F0F0F0;
}


#cancel2 {
  background-color: #007bff; /* 배경 색상 설정 */
}



#cancel2:hover {
  background-color: #0056b3; /* 호버 상태일 때 배경 색상 변경 */
}
</style>

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


document.addEventListener('DOMContentLoaded', function() {
    // 삭제 버튼에 클릭 이벤트를 추가합니다.
    var deleteButtons = document.querySelectorAll('input[type="submit"]');
    deleteButtons.forEach(function(button) {
        button.addEventListener('click', function(event) {
            event.preventDefault(); // 기본 이벤트 동작을 중지합니다.
	
            if (confirm('정말로 취소 하시겠습니까?')) {
            // 클릭된 삭제 버튼이 속한 행의 시퀀스 번호 추출
            var row = button.parentNode.parentNode; // 삭제 버튼의 부모 요소가 행이므로, 한 번 더 부모 요소로 이동하여 행을 가져옵니다.
            var sequenceNumber = row.cells[8].textContent.trim(); // 시퀀스 번호가 있는 열의 내용을 가져옵니다.

            // 새로운 폼 엘리먼트 생성
            var form = document.createElement('form');
            form.setAttribute('method', 'post');
            form.setAttribute('action', '${contextPath}/money/cancelMyAnnual.do');

            // 시퀀스 번호를 전송할 hidden input 요소 생성
            var input = document.createElement('input');
            input.setAttribute('type', 'hidden');
            input.setAttribute('name', 'no');
            input.setAttribute('value', sequenceNumber);

            // 폼에 hidden input 요소 추가
            form.appendChild(input);

            // 폼을 body에 추가하고 서버로 전송
            document.body.appendChild(form);
            form.submit();
            }
        });
    });
});

</script>
</head>

<body>

  	<jsp:include page="../common/header.jsp"/>
  	
	<main id="main" class="main">
		<div class="pagetitle">
			<h1>연차 사용 기록</h1>
		</div>

		<section class="section">
			<div class="row">
				<div class="col-lg-12">

					<div class="card">
						<div class="card-body">
							<h5 class="card-title">연차 사용 기록</h5>
							<p>※ 정보가 일치하지 않을 경우, 총무부서로 연락 ※</p>

							<!-- Form 태그를 테이블 전체를 감싸도록 이동 -->
							<form action="${contextPath}/money/cancelMyAnnual.do"
								method="post">
								<!-- Table with stripped rows -->
								<table class="table datatable">
									<thead>
										<tr align='left'>
											<th>이름</th>
											<th>부서</th>
											<th>직급</th>
											<th>종류</th>
											<th>휴가 기간</th>
											<th>잔여 연차</th>
											<th>승인 여부</th>
											<th>신청 일시</th>
											<th>신청 번호</th>
											<th>취소</th>
										</tr>
									</thead>
									<c:forEach var="list" items="${viewMyAnnualList }"
										varStatus="loop">
										<tr>
											<td>${list.co_name}</td>
											<td><c:choose>
													<c:when test="${list.co_deuser_cd == 1}">총무</c:when>
													<c:when test="${list.co_deuser_cd == 2}">개발</c:when>
													<c:when test="${list.co_deuser_cd == 3}">경영</c:when>
												</c:choose></td>
											<td><c:choose>
													<c:when test="${list.co_user_cd == 1}">대표</c:when>
													<c:when test="${list.co_user_cd == 2}">팀장</c:when>
													<c:when test="${list.co_user_cd == 3}">사원</c:when>
												</c:choose></td>
											<td><c:choose>
													<c:when test="${list.annual_annu_cd == 1}">연차</c:when>
													<c:when test="${list.annual_annu_cd == 2}">반차</c:when>
													<c:when test="${list.annual_annu_cd == 3}">병가</c:when>
													<c:when test="${list.annual_annu_cd == 4}">예비군</c:when>
												</c:choose></td>
											<td>${list.annual_period}</td>
											<td>${list.remain_annual}</td>
											<td><c:choose>
													<c:when test="${list.annual_permit_cd == 1}">대기</c:when>
													<c:when test="${list.annual_permit_cd == 2}">승인</c:when>
													<c:when test="${list.annual_permit_cd == 3}">반려</c:when>
												</c:choose></td>
											<td>${list.annual_submit_time}</td>
											<td>${list.no}</td>
											<td>
												<input type="hidden" name="no" value="${list.no}">
												<c:choose>
													<c:when
														test="${list.annual_permit_cd eq 2 or list.annual_permit_cd eq 3}">
														<input type="submit" id="cancel1" value="취소 불가" disabled>
													</c:when>
													<c:otherwise>
														<input type="submit" id="cancel2" value="취소">
													</c:otherwise>
												</c:choose>
											</td>
										</tr>
									</c:forEach>
								</table>
							</form>
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