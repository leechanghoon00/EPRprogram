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
<c:set var="remain_annual" value="${sessionScope.reqAnnual}" />
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
</style>
  
<script>
   let previousSelection = ''; // 이전 선택 값을 저장할 변수

	// 연차 종류 선택시, 날짜 선택부분 출력관리 
	function chk_annual_cd() {
		const annual_cd = document.getElementById("annual_cd");
		let endDateRow = document.getElementById("endDateRow");
		let endDateRow2 = document.getElementById("endDateRow2");
		var annual_annu_cd = annual_cd.value;
		let reasonTextarea = document.getElementById("reasonTextarea");

		// 이전 선택 값이 '2'이고 새로운 선택 값이 '2'가 아닌 경우에는 종료 부분을 보이도록 설정
		if (previousSelection === '2' && annual_annu_cd !== '2') {
			endDateRow.style.display = "block";
		}

		if (annual_annu_cd === '1') {
			alert("연차가 선택 되었습니다!");
			reasonTextarea.value = "개인적인 사유로 연차를 신청합니다.";
		} else if (annual_annu_cd === '3') {
			alert("병가가 선택 되었습니다!");
			reasonTextarea.value = "병가를 신청합니다.";
		} else if (annual_annu_cd === '4') {
			alert("예비군 훈련이 선택 되었습니다!");
			reasonTextarea.value = "예비군 훈련으로 인해 연차를 신청합니다.";
		}

		if (annual_annu_cd === '2') {
			alert("반차가 선택 되었습니다!");
			reasonTextarea.value = "개인적인 사유로 반차를 요청합니다.";
			endDateRow.style.display = "none"; // 종료 부분을 숨김
			endDateRow2.style.display = "none"; // 날짜 선택 부분을 숨김

		} else {
			endDateRow.style.display = "block"; // 다른 경우에는 종료 부분을 표시
			endDateRow2.style.display = "block"; // 다른 경우에는 날짜 선택 부분을 표시
		}
		// 현재 선택 값을 이전 선택 값으로 설정
		previousSelection = annual_annu_cd;
	}

	// 신청 완료 후, 내 연차 목록으로 이동하는 함수
	function backToList() {
		const annual_cd = document.getElementById("annual_cd").value;
		const frm = document.getElementById("sendAnnualForm");
		console.log(frm);
		if (annual_cd === '2') {
			frm.action = "${contextPath}/money/sendHalfAnnual.do";
			frm.submit();
		} else {
			alert("신청이 완료 되었습니다.");
			frm.submit();
		}

	}
	
	// 신청기간이 잔여연차보다 많으면 재설정
	function calcu_annual() {
		let startDate = new Date(document.getElementById("startDate").value);
		let endDate = new Date(document.getElementById("endDate").value);
	    let remain_annual = ${reqAnnual.remain_annual};
	    
	    // endDate와 startDate의 차이 계산
		let diffInMs = endDate.getTime() - startDate.getTime();
		let diffInDays = diffInMs / (1000 * 60 * 60 * 24);
		diffInDays = parseFloat((diffInDays + 1).toFixed(2));
		console.log(diffInDays);
	    // 잔여 연차와 선택한 기간 비교
	    if (diffInDays > remain_annual) {
	        alert("잔여 연차보다 신청 기간이 많습니다. 다시 선택해주세요.");
	        document.getElementById("endDate").value = ""; // endDate 값 초기화
	        document.getElementById("endDate").focus(); // endDate에 포커스 설정
	    }
	}
	
	// 시작일 및 종료일 조건
	document.addEventListener('DOMContentLoaded', function() {
	    document.getElementById("startDate").addEventListener("change", function() {
	        var startDate = new Date(this.value);
	        var endDateInput = document.getElementById("endDate");
	        var endDate = new Date(endDateInput.value);
	        var currentDate = Date.now(); // 현재 날짜 가져오기
	        
		    if (startDate < currentDate) {
		        alert("지난 날짜는 선택할 수 없습니다.");
		        this.value = ""; // 시작일 값 초기화
		    }
		

	        // 시작일이 종료일보다 이후인 경우
	        if (startDate > endDate) {
	            alert("시작일은 종료일보다 이전이 여야 합니다.");
	            this.value ="";
	        }
	    });

	    // 종료일 선택 시, 시작일의 최대값을 설정하여 종료일 이후의 날짜를 선택하지 못하도록 함
	    document.getElementById("endDate").addEventListener("change", function() {
	        var endDate = new Date(this.value);
	        var startDateInput = document.getElementById("startDate");
	        var startDate = new Date(startDateInput.value);

	        if (endDate < startDate) {
	            alert("종료일은 시작일 보다 이후여야 합니다.");
	            this.value="";
	        }
	    });
	});

</script>
</head>

<body>

  	<jsp:include page="../common/header.jsp"/>
  	
	<main id="main" class="main">
      <div class="pagetitle">
         <h1>연차 신청하기</h1>
      </div>

      <form id="sendAnnualForm" method="post"
         action="${contextPath }/money/sendAnnual.do">
         <div class="row mb-3">
            <label for="inputText" class="col-sm-2 col-form-label">이름</label>
            <div class="col-sm-10">
               <span>${reqAnnual.co_name}</span> <input type="hidden"
                  name="pay_id" value="<%=pay_id%>" />
            </div>
         </div>

         <div class="row mb-3">
            <label for="inputText" class="col-sm-2 col-form-label">잔여 연차</label>
            <div class="col-sm-10">
               <span>${reqAnnual.remain_annual}</span>
            </div>
         </div>


         <div class="row mb-3">
            <label for="inputPart" class="col-sm-2 col-form-label">부서</label>
            <div class="col-sm-10">
               <span> <c:choose>
                     <c:when test="${reqAnnual.co_deuser_cd == 1}">총무</c:when>
                     <c:when test="${reqAnnual.co_deuser_cd == 2}">개발</c:when>
                     <c:when test="${reqAnnual.co_deuser_cd == 3}">경영</c:when>
                  </c:choose>
               </span>
            </div>
         </div>

         <div class="row mb-3">
            <label for="inputDepar" class="col-sm-2 col-form-label">직급</label>
            <div class="col-sm-10">
               <span> <c:choose>
                     <c:when test="${reqAnnual.co_user_cd == 1}">사장</c:when>
                     <c:when test="${reqAnnual.co_user_cd == 2}">팀장</c:when>
                     <c:when test="${reqAnnual.co_user_cd == 3}">사원</c:when>
                     <c:when test="${reqAnnual.co_user_cd == 4}">거래처</c:when>
                  </c:choose>
               </span>
            </div>
         </div>


         <div class="row mb-3">
            <label class="col-sm-2 col-form-label">종류</label>
            <div class="col-sm-10">
               <select id="annual_cd" class="form-select"
                  aria-label="Default select example" name="annual_annu_cd"
                  onchange="chk_annual_cd()">
                  <option selected>선택</option>
                  <option value="1">연차</option>
                  <option value="2">반차</option>
                  <option value="3">병가</option>
                  <option value="4">예비군</option>
               </select>
            </div>
         </div>


         <div class="row mb-3">
            <label for="inputDate" class="col-sm-2 col-form-label">시작</label>
            <div class="col-sm-10">
               <input id="startDate" type="date" class="form-control"
                  name="annual_startDay">
            </div>
         </div>


         <div class="row mb-3">
            <label id="endDateRow" for="endDate" class="col-sm-2 col-form-label">종료</label>
            <div id="endDateRow2" class="col-sm-10">
               <input id="endDate" type="date" class="form-control"
                  onchange="calcu_annual()" name="annual_endDay">
            </div>
         </div>



         <div>
            <div class="row mb-3">
               <label for="textarea" class="col-sm-2 col-form-label">사유</label>
               <div class="col-sm-10">
                  <textarea id="reasonTextarea" onchange="chk_annual_cd"
                     class="form-control" style="height: 100px" name="annual_reason"></textarea>
               </div>
            </div>
         </div>


         <div>
            <div class="row mb-3">
               <label class="col-sm-2 col-form-label">제출</label>
               <div class="col-sm-10">
                  <button class="btn btn-primary" onclick="backToList()">신청하기</button>

               </div>
            </div>
         </div>


      </form>


   </main>
	<!-- End #main -->

	<jsp:include page="../common/footer.jsp" />


	<!-- JS Files -->
	<jsp:include page="../common/scripts.jsp" />
</body>

</html>