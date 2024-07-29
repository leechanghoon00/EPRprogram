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

</style>
<script>
	document.querySelectorAll('.co_name_select').forEach(select => {
	    select.addEventListener('change', function() {
	        const co_deuser_cd = this.options[this.selectedIndex].getAttribute('data-co_deuser_cd');
	        const co_user_cd = this.options[this.selectedIndex].getAttribute('data-co_user_cd');
	
	        // 해당 select 요소가 속한 tr 요소를 찾습니다.
	        const tr = this.closest('tr');
	
	        // tr 내부에서만 처리할 코드를 여기에 추가합니다.
	        tr.querySelector('input[name="co_deuser_cd"]').value = co_deuser_cd;
	        tr.querySelector('input[name="co_user_cd"]').value = co_user_cd;
	    });
	});
	
	function validateSelect(select) {
        const selectedIndex = select.selectedIndex;
        const option = select.options[selectedIndex];
        const co_deuser_cd = option.getAttribute('data-co_deuser_cd');
        const co_user_cd = option.getAttribute('data-co_user_cd');
		
        // 검증 결과를 표시합니다.
        document.getElementById('deuser_cd').value = validateCoDeuserCd(co_deuser_cd);
        document.getElementById('user_cd').value = validateCoUserCd(co_user_cd);

    }
	
	function validateCoDeuserCd(co_deuser_cd) {
        // co_deuser_cd에 대한 검증 로직을 작성합니다.
        // 예를 들어, 특정 조건을 만족하는지 확인하고 그 결과를 반환합니다.
        if (co_deuser_cd === '1') {
            return '총무';
        } else if (co_deuser_cd === '2') {
            return '개발';
        } else if (co_deuser_cd === '3') {
            return '경영';
        } else {
        	return '';
        }
    }

    function validateCoUserCd(co_user_cd) {
        // co_user_cd에 대한 검증 로직을 작성합니다.
        // 예를 들어, 특정 조건을 만족하는지 확인하고 그 결과를 반환합니다.
        if (co_user_cd === '1') {
            return '대표';
        } else if (co_user_cd === '2') {
            return '팀장';
        } else if (co_user_cd === '3') {
            return '사원';
        } else {
        	return '';
        }
    }
	
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
 
    function convertDate(input) {
        // 입력된 값
        const period = document.getElementById('dateInput');
        const inputValue = input.value;

        // 입력된 값이 숫자 4자리인지 확인합니다.
        if (inputValue.length !== 4 || isNaN(inputValue)) {
            alert('올바른 기간을 입력하세요.'); // 잘못된 입력일 경우 알림을 표시합니다.
			input.value = '';
            return;
        }

        
        // 입력된 값을 연도와 월로 나누어서 변환합니다.
        const year = inputValue.slice(0, 2); // 연도
        const month = inputValue.slice(2); // 월

        // 변환된 값을 "YYYY-MM" 형식으로 조합합니다.
        const formattedDate = '20' + year + '.' + month;

        // 변환된 값을 input 요소에 설정합니다.
        input.value = formattedDate;
    }
 
	function addPay() {
		event.preventDefault(); // 기본 제출 동작을 중지합니다.
		const frm = document.getElementById('addForm');
		
		if (frm.co_deuser_cd.value == '') {
            alert('부서를 지정해주세요.');
            frm.co_deuser_cd.focus();
            return;
        } else if (frm.pay_id.value == '') {
            alert('이름을 입력해주세요.');
            frm.pay_id.focus();
            return;
        } else if (frm.co_user_cd.value == '') {
            alert('직급을 입력해주세요.');
            frm.co_user_cd.focus();
            return;
        } else if (frm.work_period.value == '') {
            alert('급여제공 월을 입력해주세요.');
            frm.work_period.focus();
            return;
        } else if (frm.pay.value == '') {
            alert('급여를 입력해주세요.');
            frm.pay.focus();
            return;
        } 

        var position = frm.co_user_cd.value;
        var depar = frm.co_deuser_cd.value;

        if (position == '대표') {
            position = 1;
        } else if (position == '팀장') {
            position = 2;
        } else if (position == '사원') {
            position = 3;
        }

        if (depar == '총무') {
            depar = 1;
        } else if (depar == '개발') {
            depar = 2;
        } else if (depar == '경영') {
            depar = 3;
        }
        frm.co_user_cd.value = position;
        frm.co_deuser_cd.value = depar;
      
        frm.action="${contextPath}/money/addPay.do"
        frm.submit();
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
			    <div class="row">
			        <div class="col-lg-12">
			            <div class="card">
			                <div class="card-body">
			                    <h5 class="card-title">급여명세서 수정</h5>
			                    <p>※ 수정 후, 총무팀장에게 체크 ※</p>
		
		                    <!-- Table with stripped rows -->
		                    <form id= "addForm" method="post" >
		                    	<div style="text-align:right; padding-right:50px;">
				                    <input class= "btn btn-primary" type="button" value="입력하기" onclick="addPay()">
				                    <input class= "btn btn-primary" type="reset" value="다시입력">
			                    </div>
		                    <table class="table datatable">
		                        <thead>
		                            <tr align="left">
		                                <th>부서</th>
		                                <th>이름</th>
		                                <th>직급</th>
		                                <th>급여제공월</th>
		                                <th>지급액</th>
		                            </tr>
		                        </thead>
		                        <tbody>
		                            <tr align="left">
		                                <td>
		                                	<input style="width:70px; border:none;" type="text" id= "deuser_cd" name="co_deuser_cd" >
		                                </td>
		                                <td>
		                                	<select style="width:130px; height:30px; border:none;" class="co_name_select" name= "pay_id" onchange="validateSelect(this)" class="co_name_select" >
			           		                   <option>직원선택</option>
			           		                   <c:forEach var= "list" items="${memList }" varStatus="loop">
							                    <option value="${list.co_name}" data-co_deuser_cd="${list.co_deuser_cd}" data-co_user_cd="${list.co_user_cd}">${list.co_name}</option>
							                   </c:forEach>
							                </select>
		                                </td>
		                                <td>
		                                	<input style="width:70px; border:none;" type="text" id= "user_cd" name="co_user_cd" >
		                                </td>
		                                <td>
		                                	<input type="text" name="work_period" id="dateInput" placeholder="YYMM" onblur="convertDate(this)">
		                                </td>
		                                <td>
		                                    <input type="text" name="pay"  oninput="formatInput(this)">
		                                </td>
		
		                            </tr>
		                            
		                        </tbody>
		                    </table>
		                    </form>
		                </div>
		            </div>
		        </div>
		    </div>
		</section>
	</main>
	<jsp:include page="../common/footer.jsp" />


	<!-- JS Files -->
	<jsp:include page="../common/scripts.jsp" />
</body>

</html>