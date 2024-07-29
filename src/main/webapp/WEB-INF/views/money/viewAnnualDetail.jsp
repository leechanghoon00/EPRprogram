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

	function permitAnnual() {
	    const product = []
	    const no = document.querySelector('input[name="no"]').value;
	    const annual_id = document.querySelector('input[name="annual_id"]').value;
	    const item = {
	    		"no" : no,
	    		"annual_id" : annual_id
	    };
	    
	    product.push(item);
	    $.ajax({
	        type : 'POST',
	        url : "${contextPath}/money/permitAnnual.do",
	        contentType : "application/json", // 컨텐츠 타입 설정
			data : JSON.stringify(product),
	        success : function(returnData) {
	            // 승인 처리 후 실행할 작업을 여기에 작성합니다.
	            if(returnData.result == 0){
	            	alert('연차승인에 실패했습니다.');
		            // 예를 들어, 페이지를 새로고침하는 등의 작업을 수행할 수 있습니다.
	            	location.reload();
	            } else if(returnData.result != 0) {
	            	alert('연차가 승인되었습니다.');
		            // 예를 들어, 페이지를 새로고침하는 등의 작업을 수행할 수 있습니다.
		            location.href= "${contextPath}/member/main.do";
	            }
	        },
	        error: function(xhr, status, error) {
	            // 오류 처리 코드를 여기에 작성합니다.
	            alert('오류가 발생했습니다.');
	            console.error(xhr.responseText);
	        }
	        
	    });
	}
	
	function deniedAnnual() {
		const product = []
	    const no = document.querySelector('input[name="no"]').value;
	    const annual_id = document.querySelector('input[name="annual_id"]').value;
		    const item = {
		    		"no" : no,
		    		"annual_id" : annual_id
		    };
		    
		    product.push(item);
		    $.ajax({
		        type: "POST",
		        url: "${contextPath}/money/deniedAnnual.do",
		        contentType : "application/json", // 컨텐츠 타입 설정
				data: JSON.stringify(product),
		        success: function(returnData) {
		            // 승인 처리 후 실행할 작업을 여기에 작성합니다.
		            if(returnData.result == 0){
		            	alert("연차 반려에 실패했습니다.");
			            // 예를 들어, 페이지를 새로고침하는 등의 작업을 수행할 수 있습니다.
		            	location.href= "${contextPath}/member/main.do";
		            } else if (returnData.result != 0){
		            	alert("연차가 반려 되었습니다.");
			            // 예를 들어, 페이지를 새로고침하는 등의 작업을 수행할 수 있습니다.
			            location.href= "${contextPath}/member/main.do";
		            }
		        },
		        error: function(xhr, status, error) {
		            // 오류 처리 코드를 여기에 작성합니다.
		            alert("오류가 발생했습니다.");
		            console.error(xhr.responseText);
		        }
		        
		    });
		}
</script>
</head>

<body>

  	<jsp:include page="../common/header.jsp"/>
  	
	<main id="main" class="main">
	
		<form id="detailForm">
			<div>
			<input type="hidden" name="no" value="${viewAnnualDetail.no }" />
			<input type="hidden" name="annual_id" value="${viewAnnualDetail.annual_id }" />
			</div>
			<div class="row mb-3">
                  <label for="inputName" class="col-sm-2 col-form-label">이름</label>
                  <div class="col-sm-10">
                    <input id="inputName" style="border:none; background:none;" type="text" class="form-control" value= "${viewAnnualDetail.co_name}" disabled="disabled">
                  </div>
                </div>
			<div class="row mb-3">
                  <label for="inputRemain" class="col-sm-2 col-form-label">잔여 연차</label>
                  <div class="col-sm-10">
                    <input id="inputRemain" style="border:none; background:none;" type="text" class="form-control" value= "${viewAnnualDetail.remain_annual}" disabled="disabled">
                  </div>
                </div>
			<div class="row mb-3">
                  <label for="departmentInput" class="col-sm-2 col-form-label">부서</label>
                  <div class="col-sm-10">
                    <input id="departmentInput" style="border:none; background:none;" type="text" class="form-control" disabled="disabled">
                  </div>
                </div>
                
                <script>
				    // JavaScript를 사용하여 선택된 부서 값을 가져와서 input 요소의 value에 설정
				    let department = "";
				    <c:choose>
				        <c:when test="${viewAnnualDetail.co_deuser_cd == 1}">
				            department = "총무";
				        </c:when>
				        <c:when test="${viewAnnualDetail.co_deuser_cd == 2}">
				            department = "개발";
				        </c:when>
				        <c:when test="${viewAnnualDetail.co_deuser_cd == 3}">
				            department = "경영";
				        </c:when>
				    </c:choose>
				    document.getElementById("departmentInput").value = department;
				</script>
			<div class="row mb-3">
                  <label for="positionInput" class="col-sm-2 col-form-label">직급</label>
                  <div class="col-sm-10">
                    <input id= "positionInput" style="border:none; background:none;" type="text" class="form-control" disabled="disabled">
                  </div>
                </div>
                <script>
				    // JavaScript를 사용하여 선택된 부서 값을 가져와서 input 요소의 value에 설정
				    let position = "";
				    <c:choose>
						<c:when test="${viewAnnualDetail.co_user_cd == 2}">
							position = "팀장";
						</c:when>
						<c:when test="${viewAnnualDetail.co_user_cd == 3}">
							position = "사원";
						</c:when>
					</c:choose>
				    
				    document.getElementById("positionInput").value = position;
				</script>
			<div class="row mb-3">
                  <label for="annualInput" class="col-sm-2 col-form-label">연차 분류</label>
                  <div class="col-sm-10">
                    <input id= "annualInput" style="border:none; background:none;" type="text" class="form-control" disabled="disabled">
                  </div>
                </div>
                <script>
				    // JavaScript를 사용하여 선택된 부서 값을 가져와서 input 요소의 value에 설정
				    let annual = "";
				    <c:choose>
						<c:when test="${viewAnnualDetail.annual_annu_cd == 1}">
							annual = "연차";
						</c:when>
						<c:when test="${viewAnnualDetail.annual_annu_cd == 2}">
							annual = "반차";
						</c:when>
						<c:when test="${viewAnnualDetail.annual_annu_cd == 3}">
							annual = "병가";
						</c:when>
						<c:when test="${viewAnnualDetail.annual_annu_cd == 4}">
							annual = "예비군";
						</c:when>
					</c:choose>
				    
				    document.getElementById("annualInput").value = annual;
				</script>
			<div class="row mb-3">
                  <label for="inputStartDate" class="col-sm-2 col-form-label">시작일</label>
                  <div class="col-sm-10">
                    <input id="inputStartDate" style="border:none; background:none;" type="text" class="form-control" value= "${viewAnnualDetail.annual_startDay}" disabled="disabled">
                  </div>
                </div>
                
            <div class="row mb-3">
              <label for="inputEndDate" class="col-sm-2 col-form-label">종료일</label>
              <div class="col-sm-10">
                <input id="inputEndDate" style="border:none; background:none;" type="text" class="form-control" value= "${viewAnnualDetail.annual_endDay}" disabled="disabled">
              </div>
            </div>

            <div class="row mb-3">
              <label for="inputReason" class="col-sm-2 col-form-label">사유</label>
              <div class="col-sm-10">
                <input id="inputReason" style="border:none; background:none;" type="text" class="form-control" value= "${viewAnnualDetail.annual_reason}" disabled="disabled">
              </div>
            </div>

			<div style="padding-left: 0px;">
				<input type="button" class="btn btn-primary" onclick="permitAnnual()" value="승인">
				<input style="margin-left:30px;" type="button" class="btn btn-primary" onclick="deniedAnnual()" value="반려">
			</div>

		</form>
	</main>
	<!-- End #main -->

	<jsp:include page="../common/footer.jsp" />


	<!-- JS Files -->
	<jsp:include page="../common/scripts.jsp" />
</body>

</html>