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
	div.datatable-top > div.datatable-dropdown, input.datatable-input {
		display: none;
	}
	div.datatable-bottom > div.datatable-info {
		display: none;
	}
	
	#modPay,
	input[type="reset"] {
	  padding: 0.5rem 1rem; /* 여백 설정 */
	  border-radius: 5px; /* 테두리 둥글게 설정 */
	  border: none; /* 테두리 제거 */
	  color: #fff; /* 텍스트 색상 설정 */
	  cursor: pointer; /* 마우스 커서 모양 변경 */
	}
	
	#modPay {
	  background-color: #007bff; /* 배경 색상 설정 */
	}
	
	input[type="reset"] {
	  background-color: #007bff; /* 배경 색상 설정 */
	}
	
	#modPay:hover {
	  background-color: #0056b3; /* 호버 상태일 때 배경 색상 변경 */
	}
	
	input[type="reset"]:hover {
	  background-color: #0056b3; /* 호버 상태일 때 배경 색상 변경 */
	}

</style>
  
<script>

    // 쉼표(,)를 추가하여 천 단위로 구분된 형태로 변환하는 함수
    function numberWithCommas(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

 // 입력 필드의 값이 변경될 때마다 호출되는 함수
    function formatInput(input) {
        // 입력된 값을 가져옵니다.
        let value = input.value;
        // 입력된 값이 빈 문자열인 경우, 변환을 건너뜁니다.
        if (value === '') {
            return;
        }
        // 입력된 값을 정수로 변환합니다.
        let intValue = parseInt(value.replace(/,/g, ''), 10);
        // 변환된 값을 쉼표(,)를 추가하여 문자열로 변환합니다.
        let formattedValue = numberWithCommas(intValue);
        // 변환된 값을 입력 필드에 설정합니다.
        input.value = formattedValue;
    }

    function checkInput(input) {
        // 입력된 값이 빈 문자열인 경우 처리를 건너뜁니다.
        if (input.value === '') {
        	return;
        }

        // 입력된 값이 숫자인지 확인합니다.
        if (isNaN(input.value)) {
            alert("숫자를 입력해주세요.");
            input.value = ''; // 입력 필드를 비웁니다.
            return;
        }
        
        // 입력된 값이 14를 초과하는지 확인합니다.
        if (parseInt(input.value) > 14) {
            alert("잔여 연차는 14일을 초과할 수 없습니다.");
            input.value = '14.0'; // 입력된 값을 14로 설정합니다.
        }
    }
</script>
</head>

<body>

  	<jsp:include page="../common/header.jsp"/>
  	
	<main id="main" class="main">
		<div class="pagetitle">
			<h1>급여명세서 수정</h1>
		</div>

		<section class="section">
			<form method="post" action="${contextPath}/money/modPay.do">
			    <div class="row">
			        <div class="col-lg-12">
			            <div class="card">
			                <div class="card-body">
			                    <h5 class="card-title">급여명세서 수정</h5>
			                    <p>※ 수정 후, 총무팀장에게 체크 ※</p>
								
								<div style="text-align:right; padding-right:50px;">
									<input type="submit" value="수정하기" id="modPay">
			                    	<input type="reset" value="다시입력">
								</div>
			                    <!-- Table with stripped rows -->
			                    <table class="table datatable">
			                        <thead>
			                            <tr align="left">
			                                <th>부서</th>
			                                <th>이름</th>
			                                <th>직급</th>
			                                <th>급여제공월</th>
			                                <th>지급액</th>
			                                <th>잔여 연차</th>
			                            </tr>
			                        </thead>
			                        <tbody>
			                            <tr align="left">
			                                <td>
			                                    <c:choose>
			                                        <c:when test="${money.co_deuser_cd == 1}">총무</c:when>
			                                        <c:when test="${money.co_deuser_cd == 2}">개발</c:when>
			                                        <c:when test="${money.co_deuser_cd == 3}">경영</c:when>
			                                    </c:choose>
			                                </td>
			                                <td>${money.co_name}</td>
			                                <td>
			                                    <c:choose>
			                                        <c:when test="${money.co_user_cd == 1}">대표</c:when>
			                                        <c:when test="${money.co_user_cd == 2}">팀장</c:when>
			                                        <c:when test="${money.co_user_cd == 3}">사원</c:when>
			                                        <c:when test="${money.co_user_cd == 4}">거래처</c:when>
			                                    </c:choose>
			                                </td>
			                                <td>${money.work_period}</td>
			                                <td>
			                                    <input type="hidden" name="pay_id" value="${money.pay_id}">
			                                    <input type="text" name="pay" value="${money.pay}" oninput="formatInput(this)">
			                                </td>
			                                <td>
			                                    <input type="text" name="remain_annual" id="remain_annual" value="${money.remain_annual}" oninput="checkInput(this)">
			                                </td>
			                            </tr>
			                        </tbody>
			                    </table>
			                </div>
			            </div>
			        </div>
			    </div>
			</form>
		</section>
	</main>
		<jsp:include page="../common/footer.jsp" />


	<!-- JS Files -->
	<jsp:include page="../common/scripts.jsp" />

</body>

</html>