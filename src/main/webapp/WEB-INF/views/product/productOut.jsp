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
	    price: true, // 판매가 열
	    orderDate: true // 주문일자 열
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
	    
	    // 판매가 열의 정렬 기능 추가
	    const priceTh = document.querySelector('th:nth-child(4)'); // 판매가 열
	    priceTh.addEventListener('click', function() {
	        sortTable(3, 'price'); // 4번째 열에 해당하는 인덱스 값 전달하여 정렬 수행
	    });
	
	    // 주문일자 열의 정렬 기능 추가
	    const orderDateTh = document.querySelector('th:nth-child(7)'); // 주문일자 열
	    orderDateTh.addEventListener('click', function() {
	        sortTable(6, 'orderDate'); // 7번째 열에 해당하는 인덱스 값 전달하여 정렬 수행
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
	
    const columns = [
	    { text: "거래처", datafield: "cus_name"},
	    { text: "제품명", datafield: "item_name"},
	    { text: "제품코드", datafield: "item_code"},
	    { text: "판매가", datafield: "item_price"},
	    { text: "수량", datafield: "item_orderAmount"},
	    { text: "매출액", datafield: "item_totalPrice"},
	    { text: "거래일자", datafield: "item_orderDate"}
	  ];
  
  function excelDownload() {
	  const url = "${contextPath}/product/excelProductOut.do";
	  
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
      <h1>제품출하량</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="${contextPath }/member/main.do">Home</a></li>
          <li class="breadcrumb-item active">제품출하량</li>
        </ol>
      </nav>
    </div>
    <!-- End Page Title -->
	<section class="section">
		<form id="excelForm" name="excelForm">
			<input type="hidden" name="excelFileNm" value="제품출하량.xls">
			<input type="hidden" id="columnsNm" name="columnsNm" />
			<input type="hidden" id="datafield" name="datafield"/>
		</form>
      <div class="row">
        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">
              <h5 class="card-title">제품출하량</h5>
              <p></p>

				<div style= "text-align:right; padding-right:30px;">
					<button type="button" class="btn btn-secondary rounded-pill" onclick="excelDownload()">엑셀 다운로드</button>
				</div>
              <!-- Table with stripped rows -->
              <table id= "tableTh" class="table datatable">
                <thead>
                  <tr>
                    <th>거래처</th>
                    <th>제품명</th>
                    <th>제품코드</th>
                    <th>판매가</th>
                    <th>수량</th>
                    <th>매출액</th>
                    <th data-type="date" data-format="YYYY/DD/MM">거래일자</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="sales" items="${salesList }">
                  	<tr>
                  		<td style="width:200px; text-align:center">${sales.cus_name }</td>
                  		<td style="padding-left:30px;">${sales.item_name }</td>
                  		<td style="text-align:center">${sales.item_code }</td>
                  		<td style="text-align:right; padding-right:30px;" >${sales.item_price }</td>
                  		<td style="text-align:right; padding-right:30px;">${sales.item_orderAmount }</td>
                  		<td style="text-align:right; padding-right:30px;">${sales.item_totalPrice }</td>
                  		<td style="text-align:center">${sales.item_orderDate }</td>
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

 	<jsp:include page="../common/footer.jsp"/>
 
	
	<!-- JS Files -->
	<jsp:include page="../common/scripts.jsp"/>
</body>

</html>