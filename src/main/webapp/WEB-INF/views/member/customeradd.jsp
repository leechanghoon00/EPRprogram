<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("utf-8");
	String co_id = (String) session.getAttribute("co_id");
	String name = (String) session.getAttribute("name");
	String part = (String) session.getAttribute("part");
	String position = (String) session.getAttribute("position");
%>

<c:set var= "contextPath" value= "${pageContext.request.contextPath }" />
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
input[type='text'] {
    width: 80%; /* 입력 필드의 너비를 100%로 설정하여 셀 안에 맞춤 */
}

.datatable-top, .datatable-bottom {
    display:none;
}
</style>

<script>
	// 페이지가 로드될 때 스크립트가 실행되도록 합니다.
	document.addEventListener('DOMContentLoaded', function() {
	    const tableTh = document.getElementById('tableTh').rows[0];
	
	    // <tr> 요소에서 <th> 요소를 찾습니다.
	    const thElements = tableTh.querySelectorAll('th');
	    // 각 <th> 요소에서 <button> 요소를 찾습니다.
	    thElements.forEach(th => {
	        const button = th.querySelector('button');
	        if (button) {
	            // <button> 요소가 있는 경우 처리할 작업을 수행합니다.
	            button.className = '';
	
	            button.onclick = function(event) {
	                return false;
	            }
	        }
	    });
	});



function adduser() {
    
   event.preventDefault(); // 기본 제출 동작을 중지합니다.
   const frm = document.getElementById('cusAddForm');
   
   if (frm.cus_joinDate.value == '') {
       alert('가입일자를 지정해주세요.');
       frm.cus_joinDate.focus();
       return;
   } else if (frm.cus_name.value == '') {
       alert('이름을 입력해주세요.');
       frm.cus_name.focus();
       return;
   } else if (frm.cus_id.value == '') {
       alert('아이디를 입력해주세요.');
       frm.cus_id.focus();
       return;
   } else if (frm.cus_pwd.value == '') {
       alert('비밀번호를 입력해주세요.');
       frm.cus_pwd.focus();
       return;
   } else if (frm.cus_address.value == '') {
       alert('주소를 입력해주세요.');
       frm.cus_address.focus();
       return;
   } else if (frm.cus_phone.value == '') {
       alert('전화번호를 입력해주세요.');
       frm.cus_phone.focus();
       return;
   } 

   frm.action = "${contextPath}/member/customerjoin.do";
   frm.submit();
}

</script>




</head>

<body>
  	<jsp:include page="../common/header.jsp"/>
  
  <main id="main" class="main">
	<div class="pagetitle">
      <h1>인사관리</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="${contextPath }/member/main.do">Home</a></li>
          <li class="breadcrumb-item active">인사관리</li>
        </ol>
      </nav>
    </div>
    <section class="section">
			<div class="row">
				<div class="col-lg-12">

					<div class="card">
						<div class="card-body">
							<h5 class="card-title">거래처 추가</h5>
							<p></p>
    
    						<form id="cusAddForm" method="post">
    							<div style="text-align:right; padding-right:15px;" > <!-- 150px에서 15px로 수정 - 김지현 0411 -->
    								<button  class= "btn btn-primary" onclick="adduser()">거래처등록</button> <!-- style width 지움 - 김지현 0411 -->
    								<button type="reset" style="width:100px;" class= "btn btn-primary" onclick="location.href='${contextPath}/member/customer-profile.do';">등록취소</button>
    							</div>
								<table id="tableTh" class="table datatable">
								    <thead>
								         <tr align='left'>
							                 <th>가입일</th>
							                 <th>이름</th>
							                 <th>아이디</th>
							                 <th>비밀번호</th>
							                 <th>거래처 주소</th>
							                 <th>거래처 전화번호</th>
							             </tr>
							        </thead>
							    <tbody>
							        <tr>
							            <td><input style= "width:100px;" type='date' name='cus_joinDate'></td>
							            <td><input style= "width:100px;" type='text' name='cus_name'></td>
							            <td><input style= "width:100px;" type='text' name='cus_id'></td>
							            <td><input style= "width:100px;" type='password' name='cus_pwd'></td>
							            <td><input style= "width:200px;" type='text' name='cus_address'></td>
							            <td><input style= "width:130px;" type='tel' name='cus_phone'></td>
							        </tr>
							    </tbody>
							</table>
						</form>
 						</div>
					</div>

				</div>
			</div>
		</section>

  </main><!-- End #main -->

 	<jsp:include page="../common/footer.jsp"/>
 
	
	<!-- JS Files -->
	<jsp:include page="../common/scripts.jsp"/>
</body>

</html>