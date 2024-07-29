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
    width: 60%; /* 입력 필드의 너비를 100%로 설정하여 셀 안에 맞춤 */
}
input[type='email'] {
    width: 60%; /* 입력 필드의 너비를 100%로 설정하여 셀 안에 맞춤 */
}
 #useradd {
            float: right; /* 오른쪽으로 플로팅 */
}
</style>
  
<script >

	//각 열의 정렬 방향을 관리하는 객체
	const sortDirections = {
	    password: true, // 비밀번호 열
	};
	
   //페이지가 로드될 때 스크립트가 실행되도록 합니다.
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
		
		const tableTh = document.getElementById('tableTh').rows[0];
	    
		
		// tableTh에서 10번째 열에 해당하는 th 요소를 선택합니다.
		const thElement = tableTh.cells[9];

		// th 요소의 자식 요소 중 클래스명이 datatable-sorter인 button 요소를 찾습니다.
		const buttonElement = thElement.querySelector('button.datatable-sorter');
		const noDelElement = thElement.querySelector('input.noDel');

		// button 요소가 존재하면 제거합니다.
		if (buttonElement) {
		    thElement.removeChild(buttonElement);
		}

		// noDel 요소를 th 요소에 추가합니다.
		if (noDelElement) {
		    thElement.appendChild(noDelElement);
		}
	    
		
	    // 비밀번호 열의 정렬 기능 추가
	    const passwordTh = document.querySelector('th:nth-child(4)'); // 판매가 열
	    passwordTh.addEventListener('click', function() {
	        sortTable(3, 'password'); // 4번째 열에 해당하는 인덱스 값 전달하여 정렬 수행
	    });
	
	
	    // 테이블 정렬 함수
	    function sortTable(columnIndex, columnName) {
	        const table = document.querySelector('.datatable');
	        const rows = Array.from(table.querySelectorAll('tr')).slice(1); // 첫 번째 행은 제외
	        const isNumeric = columnIndex === 3; // 비밀번호 열은 숫자형 데이터인지 확인
	
	        rows.sort((rowA, rowB) => {
	            const valueA = rowA.cells[columnIndex].textContent.trim();
	            const valueB = rowB.cells[columnIndex].textContent.trim();
	            const compareResult = isNumeric ? valueA - valueB : valueA.localeCompare(valueB);
	            return sortDirections[columnName] ? compareResult : -compareResult;
	        });
	
	        // 정렬 방향 변경
	        sortDirections[columnName] = !sortDirections[columnName];
	
	        // 정렬된 행을 테이블에 다시 삽입
	        table.querySelector('tbody').innerHTML = '';
	        rows.forEach(row => {
	            table.querySelector('tbody').appendChild(row);
	        });
	    }
	    
		
	});
  
  
  
 function deluser(button, index) {
	    // 클릭된 버튼을 통해 해당 줄을 식별합니다.
	    const clickedRow = button.closest('tr');

	    // 식별된 줄에서 co_id 값을 추출합니다.
	    const co_id = clickedRow.querySelector('td:nth-child(3)').innerText;
	    
	    if(confirm("삭제하시겠습니까?")) {
	    	$.ajax({
		        url: '${contextPath}/member/deluser.do',  
		        type: 'POST',
		        contentType: 'application/json',
		        data: JSON.stringify({ co_id: co_id }), // co_id를 JSON 형태로 전송합니다.
		        success: function(returnData) {
		        	if (returnData.result != 0) {
		                // 성공적으로 삭제되었을 때의 동작을 여기에 작성합니다.
		                alert("사용자가 성공적으로 삭제되었습니다.");
		                location.href = '${contextPath}/member/user-profile.do';
		            } else {
		                alert("사용자 삭제에 실패했습니다.");
		            }
		        },
		        error: function(xhr, status, error) {
		            console.error(xhr.responseText);
		        }
		    });
	    }
	
	    

	}
 

 
 
  function moduser(button, index) {
 		
 		const top = document.querySelector('div.datatable-top');
	  	top.style = "display:none"

	  	const bottom = document.querySelector('div.datatable-bottom');
	  	bottom.style = "display:none"

		const tableTh = document.getElementById('tableTh').rows[0];
		
	 	// <tr> 요소에서 <th> 요소를 찾습니다.
        const thElements = tableTh.querySelectorAll('th');
        // 각 <th> 요소에서 <button> 요소를 찾습니다.
        thElements.forEach(th => {
            const butt = th.querySelector('button');
            if (butt) {
                // <button> 요소가 있는 경우 처리할 작업을 수행합니다.
                butt.className = '';

                butt.onclick = function(event) {
                    return false;
                }
            }
        });
	  	
		// tableTh에서 10번째 열에 해당하는 th 요소를 선택합니다.
		const thElement = tableTh.cells[9];

		// th 요소의 자식 요소 중 클래스명이 datatable-sorter인 button 요소를 찾습니다.
		const noDelElement = thElement.querySelector('input.noDel');
		
		noDelElement.value = "수정취소";
		
   		noDelElement.addEventListener('click', function() {
		    location.href = "${contextPath }/member/user-profile.do";
		});
	  	
		button.value = '수정완료';
		
		const deluser = document.querySelectorAll('input[id^="deluser_"]');
		deluser.forEach(input => {
			input.style.display = 'none';
		});
		// 모든 행을 숨김 처리
	    const allRows = document.querySelectorAll('[id^="user.co"]');
	    allRows.forEach(row => {
	        row.style.display = 'none';
	    });

	    // 클릭된 행만 보이도록 변경
	    const clickedButtonRow = button.closest('tr'); // 클릭된 버튼이 속한 행을 가져옵니다.
   		clickedButtonRow.style.display = ''; // 행을 보이도록 설정합니다.
		
		const clickedRow = button.closest('tr'); // 클릭한 id가져오기
   		const id = clickedRow.querySelector('td:nth-child(3)').textContent.trim(); // 클릭된 행의 id 값을 가져옵니다.
   		
   		$("#modifyBtn"+index).attr("onclick","modifyUser('"+id+"', '"+index+"')");
		
		const changeInfoRows = document.querySelectorAll('[id="user.co_'+index+'"]');
	    changeInfoRows.forEach((row) => {
	        const pwd  = row.querySelector('td:nth-child(4)');
	        const email = row.querySelector('td:nth-child(5)');
	        const address = row.querySelector('td:nth-child(6)');
	        const phone = row.querySelector('td:nth-child(7)');
	        const deuser_cd = row.querySelector('td:nth-child(8)');
	        const user_cd = row.querySelector('td:nth-child(9)');
	        // 이미 input 태그가 존재하는지 확인
	        
	        if (!pwd.querySelector('input')) {
	            const pwdInput = document.createElement('input');
	            pwdInput.style = "width:100px";
	            pwdInput.type = 'text';
	            pwdInput.id = 'pwd' + index;
	            pwdInput.className = 'pwd';
	            pwdInput.name = 'pwd';
	            pwdInput.value = '';
	            pwd.innerHTML = '';
	            pwd.appendChild(pwdInput);
	        }
	        if (!email.querySelector('input')) {
	            const emailInput = document.createElement('input');
	            emailInput.style = "width:150px";
	            emailInput.type = 'email';
	            emailInput.id = 'email' + index;
	            emailInput.className = 'email';
	            emailInput.name = 'email';
	            emailInput.value = '';
	            email.innerHTML = '';
	            email.appendChild(emailInput);
	        }
	        if (!address.querySelector('input')) {
	            const addressInput = document.createElement('input');
	            addressInput.style = "width:200px";
	            addressInput.type = 'text';
	            addressInput.id = 'address' + index;
	            addressInput.className = 'address';
	            addressInput.name = 'address';
	            addressInput.value = '';
	            address.innerHTML = '';
	            address.appendChild(addressInput);
	        }
	        if (!phone.querySelector('input')) {
	            const phoneInput = document.createElement('input');
	            phoneInput.style = "width:130px";
	            phoneInput.type = 'tel';
	            phoneInput.id = 'phone' + index;
	            phoneInput.className = 'phone';
	            phoneInput.name = 'phone';
	            phoneInput.value = '';
	            phone.innerHTML = '';
	            phone.appendChild(phoneInput);
	        }
	        if (!deuser_cd.querySelector('input')) {
	            const deuser_cdInput = document.createElement('input');
	            deuser_cdInput.style = "width:70px";
	            deuser_cdInput.type = 'text';
	            deuser_cdInput.min = '1';
	            deuser_cdInput.max = '4';
	            deuser_cdInput.id = 'deuser_cd' + index;
	            deuser_cdInput.className = 'deuser_cd';
	            deuser_cdInput.name = 'deuser_cd';
	            deuser_cdInput.value = '';
	            deuser_cd.innerHTML = '';
	            deuser_cd.appendChild(deuser_cdInput);
	        }
	        if (!user_cd.querySelector('input')) {
	            const user_cdInput = document.createElement('input');
	            user_cdInput.style = "width:70px";
	            user_cdInput.type = 'text';
	            user_cdInput.min = '1';
	            user_cdInput.max = '4';
	            user_cdInput.id = 'user_cd' + index;
	            user_cdInput.className = 'user_cd';
	            user_cdInput.name = 'user_cd';
	            user_cdInput.value = '';
	            user_cd.innerHTML = '';
	            user_cd.appendChild(user_cdInput);
	        }
	        
		});
	    
    
		
  }
  
  function modifyUser(co_id, index) {
	  let flag = true;

 	    const co_pwd = $('#pwd'+index).val();
 	    const co_email = $('#email'+index).val();
 	    const co_address = $('#address'+index).val();
 	    const co_phone = $('#phone'+index).val();			    
 	    const co_user_cd = $('#user_cd'+index).val();
 	    const co_deuser_cd = $('#deuser_cd'+index).val();
 	    
  	if (co_pwd == '') {
          alert('비밀번호를 입력해주세요.');
          $('#pwd'+index).focus();
          flag = false;
      } else if (co_email == '' || co_email.indexOf('@') === -1) {
          alert('이메일을 형식에 맞게 입력해주세요.');
          $('#email'+index).focus();
          flag = false;
      } else if (co_address == '') {
          alert('주소를 입력해주세요.');
          $('#address'+index).focus();
          flag = false;
      } else if (co_phone == '') {
          alert('전화번호를 입력해주세요.');
          $('#phone'+index).focus();
          flag = false;
      } else if (co_user_cd == '') {
          alert('부서를 입력해주세요.');
          $('#user_cd'+index).focus();
          flag = false;
      } else if (co_deuser_cd == '') {
          alert('직급을 입력해주세요.');
          $('#deuser_cd'+index).focus();
          flag = false;
      }
      
      
	    if(flag) {
	    	var position = co_user_cd;
	        var depar = co_deuser_cd;

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
	        
			const product = [];
		    
		    const item = {
		            "co_id": co_id,
		            "co_pwd": co_pwd,
		            "co_email": co_email,
		            "co_address": co_address,
		            "co_phone": co_phone,
		            "co_user_cd": position,
		            "co_deuser_cd": depar
		    };
		    
		    product.push(item);
		    
	    	sendData(product);
	    }
  }
  
  function sendData(product){
	  

	    console.log(product);

	    $.ajax({
	        url: '${contextPath}/member/moduser.do',  
	        type: 'POST',                     
	        contentType: "application/json",  // 변경된 contentType
	        data: JSON.stringify(product),
	        success: function(returnData) {
	            console.log(returnData);
	            if (returnData.result == 0) {
	                alert('개인정보 변경에 실패했습니다.');
	                return; // 함수 종료
	            } else {
	                // 회원가입 성공
	                alert('개인정보 변경에 성공했습니다.');
	                location.href = '${contextPath}/member/user-profile.do';
	            }
	        },
	        error: function(xhr, status, error) {
	            // 서버 요청 실패
	            console.error("서버 요청 실패:", status, error);  
	            alert("정보수정 실패했습니다. 다시 시도해주세요. ");  
	        }
	    });
 	 }
  
  const columns = [
	    { text: "입사일", datafield: "co_joinDate"},
	    { text: "이름", datafield: "co_name"},
	    { text: "아이디", datafield: "co_id"},
	    { text: "이메일", datafield: "co_email"},
	    { text: "주소", datafield: "co_address"},
	    { text: "전화번호", datafield: "co_phone"}
	  ];
  
  function excelDownload() {
	  const url = "${contextPath}/member/excelUser.do";
	  
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
      <h1>인사관리</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="${contextPath }/member/main.do">Home</a></li>
          <li class="breadcrumb-item active">인사관리</li>
        </ol>
      </nav>
    </div>

		<section class="section">
		<form id="excelForm" name="excelForm">
			<input type="hidden" name="excelFileNm" value="인사관리.xls">
			<input type="hidden" id="columnsNm" name="columnsNm" />
			<input type="hidden" id="datafield" name="datafield"/>
		</form>
			<div class="row">
				<div class="col-lg-12">

					<div class="card">
						<div class="card-body">
							<h5 class="card-title">직원정보</h5>
							<p></p>
							
								<div style= "text-align:right; padding-right:30px;">
									<button type="button" class="btn btn-secondary rounded-pill" onclick="excelDownload()">엑셀 다운로드</button>
								</div>
							<table id="tableTh" class="table datatable">
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
										<th>
											<input type="button" class="noDel btn btn-primary" onclick="location.href='${contextPath }/member/useradd.do';"	value="계정추가" />
										</th>

									</tr>
								</thead>
								<tbody>
									<c:forEach var="user" items="${userprofile}" varStatus="loop">
										<tr id="user.co_${loop.index }">
											<td>${user.co_joinDate }</td>
											<td>${user.co_name }</td>
											<td>${user.co_id }</td>
											<td>${user.co_pwd }</td>
											<td>${user.co_email }</td>
											<td>${user.co_address }</td>
											<td>${user.co_phone }</td>
											<td><c:choose>
													<c:when test="${user.co_deuser_cd == 1}">총무</c:when>
													<c:when test="${user.co_deuser_cd == 2}">개발</c:when>
													<c:when test="${user.co_deuser_cd == 3}">경영</c:when>
												</c:choose></td>
											<td><c:choose>
													<c:when test="${user.co_user_cd == 1}">대표</c:when>
													<c:when test="${user.co_user_cd == 2}">팀장</c:when>
													<c:when test="${user.co_user_cd == 3}">사원</c:when>
													<c:when test="${user.co_user_cd == 4}">거래처</c:when>
												</c:choose></td>
											<td>
												<input class= "btn btn-primary" id="modifyBtn${loop.index }" type="button" value="수정" onclick="moduser(this,${loop.index})" /> 
												<input class= "btn btn-primary" type="button" value="삭제" onclick="deluser(this,${loop.index})" id="deluser_${loop.index }" />
											</td>

										</tr>
									</c:forEach>
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