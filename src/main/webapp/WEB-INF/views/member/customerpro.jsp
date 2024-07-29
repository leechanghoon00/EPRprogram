<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("utf-8");
	String cus_id = (String) session.getAttribute("cus_id");
	String cus_name = (String) session.getAttribute("cus_name");
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
    padding: 8px 10px;
    display: none;
} 

	input[type='text'] {
    width: 60%; /* 입력 필드의 너비를 100%로 설정하여 셀 안에 맞춤 */
}
	input[type='email'] {
    width: 60%; /* 입력 필드의 너비를 100%로 설정하여 셀 안에 맞춤 */
}
  #useradd {
            float: right; /* 오른쪽으로 플로팅 */
        }
.card-title {
	font-size:30px;
	text-align:center;
	padding-top:40px;
	padding-bottom:0;
}
</style>
  
  <script >
  //페이지가 로드될 때 스크립트가 실행되도록 합니다.
	document.addEventListener('DOMContentLoaded', function() {
	    var selectElement = document.querySelector('select[class="datatable-selector"]');
		var optionElement = selectElement.querySelector('option[value="-1"]');
		
    	// 선택된 옵션을 변경합니다.
    	optionElement.selected = true;
		const tableTh = document.getElementById('tableTh').rows[0];
		
		// <tr> 요소에서 <th> 요소를 찾습니다.
		const thElements = tableTh.querySelectorAll('th');
		// 각 <th> 요소에서 <button> 요소를 찾습니다.
		thElements.forEach(th => {
		    const button = th.querySelector('button');
		    if (button) {
		        // <button> 요소가 있는 경우 처리할 작업을 수행합니다.
		        button.className = '';
				
		     	button.onclick = function(event){
		     		return false;
		     	}   
		    }
		});
    	
    	// 변경된 select 요소에 대한 이벤트를 수동으로 트리거합니다.
    	var event = new Event('change');
    	selectElement.dispatchEvent(event);
		
	});
  
  
 
 
  function moduser(button) {
		button.value = '수정완료';
		
		const del = document.querySelector('input[name="delOffer"]');
		del.style.display="inline-block";
   		del.value = "수정취소";
   		
		const clickedRow = button.closest('tr'); // 클릭한 id가져오기
   		const id = clickedRow.querySelector('td:nth-child(3)').textContent.trim(); // 클릭된 행의 id 값을 가져옵니다.
		
   		$("#modifyBtn").attr("onclick","modifyUser('"+id+"')");

		del.addEventListener('click', function() {
		    location.href = "${contextPath }/member/customerpro.do";
		});
		
		
		const changeInfoRows = document.querySelectorAll('[id="user.cus"]');
	    changeInfoRows.forEach((row) => {
	        const pwd  = row.querySelector('td:nth-child(4)');
	        const address = row.querySelector('td:nth-child(5)');
	        const phone = row.querySelector('td:nth-child(6)');
	        
	        if (!pwd.querySelector('input')) {
	            const pwdInput = document.createElement('input');
	            pwdInput.style = "width:100px";
	            pwdInput.type = 'text';
	            pwdInput.id = 'pwd';
	            pwdInput.className = 'pwd';
	            pwdInput.name = 'pwd';
	            pwdInput.value = '';
	            pwd.innerHTML = '';
	            pwd.appendChild(pwdInput);
	        }
	        if (!address.querySelector('input')) {
	            const addressInput = document.createElement('input');
	            addressInput.style = "width:200px";
	            addressInput.type = 'text';
	            addressInput.id = 'address';
	            addressInput.className = 'address';
	            addressInput.name = 'address';
	            addressInput.value = '';
	            address.innerHTML = '';
	            address.appendChild(addressInput);
	        }
	        if (!phone.querySelector('input')) {
	            const phoneInput = document.createElement('input');
	            phoneInput.style = "width:130px";
	            phoneInput.type = 'text';
	            phoneInput.id = 'phone';
	            phoneInput.className = 'phone';
	            phoneInput.name = 'phone';
	            phoneInput.value = '';
	            phone.innerHTML = '';
	            phone.appendChild(phoneInput);
	        }
	       
	        
		});
	    	       
	}
  
  function modifyUser(cus_id) {
	  let flag = true;

 	    const cus_pwd = $('#pwd').val();
 	    const cus_address = $('#address').val();
 	    const cus_phone = $('#phone').val();			    
 	    
  	if (cus_pwd == '') {
          alert('비밀번호를 입력해주세요.');
          $('#pwd').focus();
          flag = false;
      } else if (cus_address == '') {
          alert('주소를 입력해주세요.');
          $('#address').focus();
          flag = false;
      } else if (cus_phone == '') {
          alert('전화번호를 입력해주세요.');
          $('#phone').focus();
          flag = false;
      }      
      
	    if(flag) {
	    		        
			const product = [];
		    
		    const item = {
		    		"cus_id": cus_id,
		            "cus_pwd": cus_pwd,
		            "cus_address": cus_address,
		            "cus_phone": cus_phone
		    };
		    
		    product.push(item);
		    
	    	sendData(product);
	    }
  }
  
  function sendData(product){

	    console.log(product);

	    $.ajax({
	        url: '${contextPath}/member/modcustomer1.do',  
	        type: 'POST',                     
	        contentType: "application/json",  // 변경된 contentType
	        data: JSON.stringify(product),
	        success: function(returnData) {
	            console.log(returnData);
	            if (returnData.result == 0) {
	                alert('거래처정보 변경에 실패했습니다.');
	                return; // 함수 종료
	            } else {
	                // 회원가입 성공
	                alert('거래처정보 변경에 성공했습니다.');
	                location.href = '${contextPath}/member/customerpro.do';
	            }
	        },
	        error: function(xhr, status, error) {
	            // 서버 요청 실패
	            console.error("서버 요청 실패:", status, error);  
	            alert("정보수정 실패했습니다. 다시 시도해주세요. ");  
	        }
	    });
	 }
 
  </script>
</head>

<body>

  <jsp:include page="../common/header-customer.jsp"/>
  
  <main id="main" class="main">
	<div class="pagetitle">
      <h1>거래처정보 관리</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="${contextPath }/member/customer.do">Home</a></li>
          <li class="breadcrumb-item active">거래처정보 관리</li>
        </ol>
      </nav>
    
    </div>
    <section class="section">
      <div class="row">
        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">
              <h5 class="card-title">거래처 정보 관리</h5>
              <p></p>
				<table id= "tableTh" class="table datatable">
                        <thead>
                           <tr align='left'>
                              <th>가입일</th>
                              <th>이름</th>
                              <th>아이디</th>
                              <th>비밀번호</th>
                              <th>주소</th>
                              <th>전화번호</th>
                              <th>
                              	<input style="display:none" type="button" name="delOffer" class="noDel btn btn-primary" value= "수정취소" />
                              </th>
                           </tr>
                           </thead>
                           <tbody>                           
    				    	<tr id="user.cus">
                              <td>${user.cus_joinDate }</td>
                              <td>${user.cus_name }</td>
                              <td>${user.cus_id }</td>
                              <td>${user.cus_pwd }</td>
                              <td>${user.cus_address }</td>
                              <td>${user.cus_phone }</td>
                              <td><input class="btn btn-primary" type="button" id="modifyBtn" value="수정" onclick= "moduser(this)"/></td>
                           </tr> 
                        </tbody>
                        
                        	
                     </table>

                     
               		
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