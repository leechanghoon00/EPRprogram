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
        const frm = document.getElementById('userAddForm');
        
        if (frm.co_joinDate.value == '') {
            alert('입사일자를 지정해주세요.');
            frm.co_joinDate.focus();
            return;
        } else if (frm.co_name.value == '') {
            alert('이름을 입력해주세요.');
            frm.co_name.focus();
            return;
        } else if (frm.co_id.value == '') {
            alert('아이디를 입력해주세요.');
            frm.co_id.focus();
            return;
        } else if (frm.co_pwd.value == '') {
            alert('비밀번호를 입력해주세요.');
            frm.co_pwd.focus();
            return;
        } else if (frm.co_email.value == '') {
            alert('이메일을 입력해주세요.');
            frm.co_email.focus();
            return;
        } else if (frm.co_email.value.indexOf('@') === -1) {
            alert('이메일 형식에 맞게 입력해주세요.');
            frm.co_email.focus();
            return;
        } else if (frm.co_address.value == '') {
            alert('주소를 입력해주세요.');
            frm.co_address.focus();
            return;
        } else if (frm.co_phone.value == '') {
            alert('전화번호를 입력해주세요.');
            frm.co_phone.focus();
            return;
        } else if (frm.co_user_cd.value == '') {
            alert('부서를 입력해주세요.');
            frm.co_user_cd.focus();
            return;
        } else if (frm.co_deuser_cd.value == '') {
            alert('직급을 입력해주세요.');
            frm.co_deuser_cd.focus();
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
		
        frm.action = "${contextPath}/member/userjoin.do";
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
              <h5 class="card-title">직원등록</h5>
              <p></p>
              
              <form id="userAddForm" method="post" >
    				<div style="text-align:right; padding-right:150px;" >
    					<button style="width:100px;" class= "btn btn-primary" onclick="adduser()">직원등록</button>
    					<button type="reset" style="width:100px;" class= "btn btn-primary" onclick="location.href='${contextPath}/member/user-profile.do';">등록취소</button>
    				</div>
				<table id= "tableTh" class="table datatable">
			    <thead>
			        <tr align='left'>
			            <th>입사일</th>
			            <th>이름</th>
			            <th>아이디</th>
			            <th>비밀번호</th>
			            <th>이메일</th>
			            <th>주소</th>
			            <th>전화번호</th>
			            <th>부서</th>
			            <th>직급</th>
			        </tr>
			    </thead>
			    <tbody>
			        <tr align="center">
			            <td><input style= "width:100px;" type='date' name='co_joinDate'></td>
			            <td><input style= "width:100px;" type='text' name='co_name'></td>
			            <td><input style= "width:100px;" type='text' name='co_id'></td>
			            <td><input style= "width:100px;" type='password' name='co_pwd'></td>
			            <td><input style= "width:150px;" type='email' name='co_email'></td>
			            <td><input style= "width:200px;" type='text' name='co_address'></td>
			            <td><input style= "width:130px;" type='tel' name='co_phone'></td>
			            <td><input style= "width:70px;" type='text' name='co_deuser_cd'></td>
			            <td><input style= "width:70px;" type='text' name='co_user_cd'></td>
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