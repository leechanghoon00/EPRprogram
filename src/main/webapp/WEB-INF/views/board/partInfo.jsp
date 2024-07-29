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
.datatable-table th button, .datatable-pagination-list button {
    color: inherit;
    border: 0;
    background-color: inherit;
    cursor: pointer;
    text-align: center;
    font-weight: inherit;
    font-size: inherit;
}

</style>
  
<script>

	//각 열의 정렬 방향을 관리하는 객체
	const sortDirections = {
	    annoDate: true // 작성일자 열
	};
	
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
		const thElement = tableTh.cells[5];

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
	    
	    // 주문일자 열의 정렬 기능 추가
	    const orderDateTh = document.querySelector('th:nth-child(5)'); // 주문일자 열
	    orderDateTh.addEventListener('click', function() {
	        sortTable(4, 'annoDate'); // 5번째 열에 해당하는 인덱스 값 전달하여 정렬 수행
	    });
	
	    // 테이블 정렬 함수
	    function sortTable(columnIndex, columnName) {
	        const table = document.querySelector('.datatable');
	        const rows = Array.from(table.querySelectorAll('tr')).slice(1); // 첫 번째 행은 제외
	        const isNumeric = columnIndex === 3; // 판매가 열은 숫자형 데이터인지 확인
	
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
	
   function delBoard(button, index) {
	   // 클릭된 버튼을 통해 해당 줄을 식별합니다.
	    const clickedRow = button.closest('tr');

	    const anno_no = clickedRow.querySelector('td:nth-child(1)').innerText;
	    
	    if(confirm("삭제하시겠습니까?")) {
	    	$.ajax({
		        url: '${contextPath}/board/delBoard.do',  
		        type: 'POST',
		        contentType: 'application/json',
		        data: JSON.stringify({ anno_no: anno_no }), 
		        success: function(returnData) {
		        	if (returnData.result != 0) {
		                // 성공적으로 삭제되었을 때의 동작을 여기에 작성합니다.
		                alert("공지가 성공적으로 삭제되었습니다.");
		                location.href = '${contextPath}/board/partInfo.do';
		            } else {
		                alert("공지사항 삭제에 실패했습니다.");
		            }
		        },
		        error: function(xhr, status, error) {
		            console.error(xhr.responseText);
		        }
		    });
	    }
   }
   
</script>
</head>

<body>

  	<jsp:include page="../common/header.jsp"/>
  	
  <main id="main" class="main">

    <div class="pagetitle">
      <h1>공지사항 관리</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="${contextPath }/member/main.do">Home</a></li>
          <li class="breadcrumb-item active">공지사항</li>
        </ol>
      </nav>
    </div>
    <!-- End Page Title -->
	<section class="section">
      <div class="row">
        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">
              <h5 class="card-title"><%=part %>부서 공지사항</h5>
              <p></p>

              <!-- Table with stripped rows -->
              <table id= "tableTh" class="table datatable">
              <thead>
	            	<tr>
	            	<th>순번</th>
	            	<th>제목</th>
	            	<th>작성자</th>
	            	<th>부서</th>
	            	<th data-type='date' id= "anno_date" data-format='YYYY/DD/MM'>작성일자</th>
	            	<th>
	            		<input class="noDel btn btn-primary" type= "button" id= "writeBoard" value= "새글쓰기" onclick="location.href='${contextPath}/board/annoAdd.do';"/>
	            	</th>
	            	</tr>
            	</thead>
            	<tbody>
            		<c:forEach var="list" items="${annoList }" varStatus="loop">
            		<tr>
	            		<td style='text-align:center'>${list.anno_no }</td>
	            		<td style='text-align:left; padding-left:30px;'>
	            		<a href='${contextPath }/board/annoDetail.do?anno_no=${list.anno_no }' >${list.anno_title }</a>
	            		</td>
	            		<td style='text-align:center' >${list.co_name }</td>
	            		<td style='text-align:center' >${list.anno_part_nm }</td>
	            		<td style='text-align:center'>${list.anno_date }</td>
	            		<td style="width:150px;">
	            			<input class="btn btn-primary" type= "button" id= "delBoard" value= "삭제" onclick="delBoard(this, ${loop.index})"/>
	            		</td>
            		</tr>
            		</c:forEach>
            	</tbody>
              </table>
              <!-- End Table with stripped rows -->

            </div>
          </div>

        </div>
      </div>
    </section>
  </main><!-- End #main -->

	<jsp:include page="../common/footer.jsp" />


	<!-- JS Files -->
	<jsp:include page="../common/scripts.jsp" />
</body>

</html>