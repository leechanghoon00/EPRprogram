<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>
<%@ taglib prefix= "c" uri= "http://java.sun.com/jsp/jstl/core" %>
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

.nowidth {
	width: 150px;
}

.code, .amount, .orderAmount {
	width: 150px;
}

.datatable-table > thead > tr > th {
    text-align: center;
    vertical-align: top;
    padding: 8px 10px;
}

.datatable-table th button, .datatable-pagination-list button {
    color: inherit;
    border: 0;
    background-color: inherit;
    cursor: pointer;
    text-align: center;
    font-weight: inherit;
    font-size: inherit;
}

input[type="text" i] {
    border: 0px;
    padding-block: 1px;
    padding-inline: 2px;
    text-align: center;
}

.display-block {
    display: block !important;
}

.display-inlineblock {
    display: inline-block !important;
}
.datatable-top, .datatable-bottom {
    padding: 8px 10px;
    display: none;
}

/* amountTh를 항상 보이도록 함 */
.alwaysview {
    display: table-cell !important;
}

.card-title {
	font-size:30px;
	text-align:center;
	padding-top:40px;
	padding-bottom:0;
}

</style>  

<script>
	//페이지가 로드될 때 스크립트가 실행되도록 합니다.
	document.addEventListener('DOMContentLoaded', function() {
	    var selectElement = document.querySelector('select[class="datatable-selector"]');
		var optionElement = selectElement.querySelector('option[value="-1"]');
		
		// 선택된 옵션을 변경합니다.
		optionElement.selected = true;
		
		// 변경된 select 요소에 대한 이벤트를 수동으로 트리거합니다.
		var event = new Event('change');
		selectElement.dispatchEvent(event);
		
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
		
	});
	
	
	
	//주문 가능 수량의 초기값을 설정하는 함수
	function initializeOriginalValues() {
	    var amountInputs = document.querySelectorAll('input[name="item_amount"]');
	    amountInputs.forEach(function(input) {
	        input.setAttribute('data-original-value', input.value.trim()); // 현재 값 설정
	    });
	    
	    var orderAmountTds = document.querySelectorAll('[id^="orderTd_"]');
		orderAmountTds.forEach(function(td) {
		    td.setAttribute('data-original-value', td.textContent.trim()); // 현재 값 설정
		});
	    
	}
	function fn_modOffer(button, index) {
		console.log("클릭된 버튼의 인덱스:", index);
		button.value = '수정완료';
		
		initializeOriginalValues();
				
		// 모든 행을 숨김 처리
	    const allRows = document.querySelectorAll('[id^="changeInfo"]');
	    allRows.forEach(row => {
	        row.style.display = 'none';
	    });

	    // 클릭된 행만 보이도록 변경
	    const clickedRow = document.getElementById('changeInfo' + index);
	    clickedRow.style.display = '';
	    
	    
		// amountTh를 보이도록 변경
		const amountTh = document.querySelector('#amountTh');
	    amountTh.className = 'alwaysview';

	    // amountTd를 보이도록 변경
	    const amountTd = document.getElementById('amountTd' + index);
	    amountTd.style.display = '';
		
		const del = document.querySelector('input[name="delOffer"]');
		del.value = "수정취소";
		
		del.addEventListener('click', function() {
		    location.href = "${contextPath }/product/offerInfo.do";
		});
		
		
		const changeInfoRows = document.querySelectorAll('[id^="changeInfo"]');
	    changeInfoRows.forEach((row, index) => {
	        const orderTd = row.querySelector('td:nth-child(6)');
	        const totalTd = row.querySelector('td:nth-child(7)');
	        // 이미 input 태그가 존재하는지 확인
	        if (!orderTd.querySelector('input')) {
	            const orderAmountInput = document.createElement('input');
	            orderAmountInput.type = 'text';
	            orderAmountInput.id = 'orderAmount_' + index;
	            orderAmountInput.className = 'orderAmount';
	            orderAmountInput.name = 'item_orderAmount';
	            orderAmountInput.value = orderTd.textContent;
	            orderAmountInput.oninput = function() {
	                calculateTotal(index); // calculateTotal 함수 호출시 인덱스 전달
	            };
	            orderTd.innerHTML = '';
	            orderTd.appendChild(orderAmountInput);
	        }
        	if (!totalTd.querySelector('input')) {
                const totalPriceInput = document.createElement('input');
                totalPriceInput.type = 'text';
                totalPriceInput.id = 'total_' + index;
                totalPriceInput.name = 'item_totalPrice';
                totalPriceInput.value = totalTd.textContent;
                totalPriceInput.readOnly = true; // readonly 속성 설정
                totalTd.innerHTML = '';
                totalTd.appendChild(totalPriceInput);
            }
        	
	        // 이벤트 위임을 사용하여 input 요소의 focus와 input 이벤트를 처리합니다.
	        document.addEventListener('focus', function(event) {
	            var target = event.target;
	            if (target.tagName === 'INPUT' && target.name === 'item_orderAmount') {
	                if (target.value.trim() === '0') {
	                    target.value = '';
	                }
	            }
	        }, true); // 캡처링 단계에서 이벤트를 캡처합니다.

	        document.addEventListener('input', function(event) {
	            var target = event.target;
	            if (target.tagName === 'INPUT' && target.name === 'item_orderAmount') {
	                // 숫자 이외의 문자 제거
	                target.value = target.value.replace(/[^\d]/g, '');
	            }
	        });
		});
	    
	    button.addEventListener('click', function() {
		    fn_sendOffer(index);
		    
		});

	}

	 function calculateTotal(index) {
		
		 
		 // 수정된 주문수량을 가져와서 총액을 계산하여 화면에 업데이트
        var itemPrice = parseFloat(document.querySelector('#price_' + index).textContent);
        var orderAmountInput = document.querySelector('#orderAmount_' + index);

        var orderAmount = parseFloat(orderAmountInput.value.trim()) || ''; // 입력된 값 가져오기
        var amountInput = document.querySelector('#amount_' + index);
        var originalAmountValue = parseFloat(amountInput.getAttribute('data-original-value')) || 0; // 초기값 가져오기
        var orderAmountTd = document.querySelector('#orderTd_'+ index);
        var originalOrderAmountValue = parseFloat(orderAmountTd.getAttribute('data-original-value')) || 0; // 초기값 가져오기
		
        console.log(originalOrderAmountValue);
        
        var newAmount = originalAmountValue + originalOrderAmountValue - orderAmount;
        if (newAmount < 0) { // 주문 수량이 주문 가능 수량을 초과하는 경우
            orderAmountInput.value = originalAmountValue; // 주문 가능 수량으로 자동 조정
            orderAmount = originalAmountValue;
            newAmount = 0;
        }
        

        amountInput.value = newAmount; // 주문 가능 수량 업데이트
	    
        var total = itemPrice * orderAmount;
        document.querySelector('#total_' + index).value = isNaN(total) ? '' : total; // 총액을 표시
    } 
	
   
    function fn_sendOffer(index) {
		const cus_id = '<%=cus_id %>';
        const product = [];

	            const no = document.querySelector('#delNo_'+index).value;
	        	const item_name = document.querySelector('#item_name_'+index).textContent;
	            const item_amount = document.querySelector('#amount_'+index).value;
	            const item_orderAmount = document.querySelector('#orderAmount_'+index).value;
	            const item_totalPrice = document.querySelector('#total_'+index).value;
	            const item_orderDate = document.querySelector('#orderDate_'+index).value;
	
	            const item = {
	                "no" : no,
            		"cus_id" : cus_id,
            		"item_name" : item_name,
	                "item_amount" : item_amount,
	                "item_orderAmount" : item_orderAmount,
	                "item_totalPrice" : item_totalPrice,
	                "item_orderDate" : item_orderDate
	            };
	            
	            if (item.item_orderAmount != "" && item.item_orderAmount != 0) {
	                product.push(item);
	            }
        
        

        $.ajax({
            type : 'POST',
            url : "${contextPath }/product/modOffer.do",
            contentType : "application/json", // 컨텐츠 타입 설정
            data : JSON.stringify(product),
            success : function(returnData) {
                console.log(returnData);
                if (returnData.result == 0) {
                    //fail
                    alert('주문수정이 실패했습니다.');
			        location.href = '${contextPath }/product/offerInfo.do';
                } else if (returnData.result != 0) {
                    // suceess
                    alert('주문수정이 성공했습니다.');
			        location.href = '${contextPath }/product/offerInfo.do';
                }
                // AJAX 요청이 성공하면 이 부분이 실행됨
                // 서버로부터의 응답을 처리할 수 있음
            },
            error : function(xhr, status, error) {
                // AJAX 요청이 실패하면 이 부분이 실행됨
                console.error(xhr.responseText);
            }
        });
        
    }
    
	function fn_delOffer() {
		
		// <tr> 요소에서 <th> 요소를 찾습니다.
		const thElements = tableTh.querySelectorAll('th');
		// <th> 요소에서 <button> 요소를 찾습니다.
	  	const select = thElements[0];
		select.textContent = '선택';
		
		const modTh = $('#modTh');
		modTh.style = 'display: none';
		const modbuttons = document.querySelectorAll('[id^="modOffer_"]');
		modbuttons.forEach(input => {
			input.style.display = 'none';
		});
		
		// .nowidth 클래스를 가진 요소들의 너비를 변경합니다.
	    const elements = document.querySelectorAll('.nowidth');
	    elements.forEach(element => {
	        element.style.width = '300px';
	    });
		
		
		const noTds = document.querySelectorAll('[id^="delNo_"]');
        const product = [];
		
        noTds.forEach(input => {
	        input.classList.add('display-inlineblock');
	        input.addEventListener('change', function() {
	            // 체크박스의 선택 여부에 따라 해당 값을 배열에 추가하거나 제거합니다.
	            if (input.checked) {
	                product.push(input.value);
	            } else {
	                // 체크박스가 해제된 경우 해당 값을 배열에서 제거합니다.
	                const index = product.indexOf(input.value);
	                if (index !== -1) {
	                    product.splice(index, 1);
	                }
	            }
	        });

	    });
		
	    
		const delOffer = document.querySelector('input[name="modbutton"]');
		delOffer.style = "display:inline-block";
		delOffer.value = "삭제완료";
		const cancelDel = document.querySelector('input[name="delOffer"]');
		cancelDel.value = "삭제취소";
		 

		delOffer.addEventListener('click', function() {
		    fn_delete(product);
		});
		cancelDel.addEventListener('click', function() {
		    location.href = "${contextPath }/product/offerInfo.do";
		});
		
	}
	
	function fn_delete(product) {
		console.log(product);
		
		$.ajax({
            type : 'POST',
            url : "${contextPath }/product/delOffer.do",
            contentType : "application/json", // 컨텐츠 타입 설정
            data : JSON.stringify(product),
            success : function(returnData) {
                console.log(returnData);
                if (returnData.result == 0) {
                    //fail
                    alert('주문삭제가 실패했습니다.');
			        location.href = '${contextPath }/product/offerInfo.do';
                } else if (returnData.result != 0) {
                    // suceess
                    alert('주문삭제가 성공했습니다.');
			        location.href = '${contextPath }/product/offerInfo.do';
                }
                // AJAX 요청이 성공하면 이 부분이 실행됨
                // 서버로부터의 응답을 처리할 수 있음
            },
            error : function(xhr, status, error) {
                // AJAX 요청이 실패하면 이 부분이 실행됨
                console.error(xhr.responseText);
            }
        });
	}
	
	const columns = [
	    { text: "주문번호", datafield: "no"},
	    { text: "제품명", datafield: "item_name"},
	    { text: "제품코드", datafield: "item_code"},
	    { text: "판매가", datafield: "item_price"},
	    { text: "주문수량", datafield: "item_orderAmount"},
	    { text: "주문총액", datafield: "item_totalPrice"},
	    { text: "제품명", datafield: "item_orderDate"},
	  ];
 
	
  function excelDownload() {
	  const url = "${contextPath}/product/excelOfferInfo.do";
	  
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

  <jsp:include page="../common/header-customer.jsp"/>
  
  <main id="main" class="main">

    <div class="pagetitle">
      <h1>주문조회</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="${contextPath }/member/customer.do">Home</a></li>
          <li class="breadcrumb-item active">주문조회</li>
        </ol>
      </nav>
    </div>
    <!-- End Page Title -->
	<section class="section">
		<form id="excelForm" name="excelForm">
			<input type="hidden" name="excelFileNm" value="고객 주문조회.xls">
			<input type="hidden" id="columnsNm" name="columnsNm" />
			<input type="hidden" id="datafield" name="datafield"/>
		</form>
      <div class="row">
        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">
              <h5 class="card-title">주문조회</h5>
              <p></p>

              <!-- Table with stripped rows -->
             <form id= "offerForm" method= "post" action= "#">
             	<div style="text-align:right; padding-right:100px; padding-bottom:10px;">
	             	<button type="button" class="btn btn-secondary rounded-pill" onclick="excelDownload()">엑셀 다운로드</button>
	             	<input style= "display:none" class= "btn btn-primary" type="button" name= "modbutton"  />
	             	<input type="button" class= "btn btn-primary" name= "delOffer" value= "주문취소" onclick= "fn_delOffer()" />
             	</div>
              <table id= "tableTh" class="table datatable">
                <thead>
                  <tr>
                    <th id= "offerNoTh">주문번호</th>
                    <th>제품명</th>
                    <th>제품코드</th>
                    <th>판매가</th>
                    <th id= "amountTh" style= "display:none">주문가능수량</th>
                    <th>주문수량</th>
                    <th>주문총액</th>
                    <th>주문일자</th>
                    <th id= "modTh"></th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="offers" items="${offersInfo}" varStatus="loop">
				    <tr id= "changeInfo${loop.index }" align= "center">
				        <td id="noTd_${loop.index }" class= "nowidth" >
				        <input style= "display:none" type="checkbox" id="delNo_${loop.index }" name= "no" value= "${offers.no }"/>
				        <label for= "delNo_${loop.index }">${offers.no }</label>
				        </td>
				        <td id="item_name_${loop.index }"><input type= "hidden" name= "item_name" value= "${offers.item_name}"/>${offers.item_name}</td>
				        <td id="item_code_${loop.index }" class= "code">${offers.item_code}</td>
				        <td id="price_${loop.index }">${offers.item_price}</td>
				        <td id="amountTd${loop.index }" style= "display:none"><input type= "text" class= "amount" id="amount_${loop.index }" name= "item_amount" value= "${offers.item_amount}" readonly="readonly" /></td>
				        <td id="orderTd_${loop.index }">${offers.item_orderAmount }</td>
				        <td id="totalTd_${loop.index }">${offers.item_totalPrice }</td>
				        <td id="orderDateTd_${loop.index }"><input type= "text" id= "orderDate_${loop.index }" name= "item_orderDate" value= "${offers.item_orderDate}" readonly="readonly" /></td>
				        <td><input type= "button" class= "btn btn-primary" id= "modOffer_${loop.index }" name= "modOffer" value= "수정" onclick= "fn_modOffer(this, ${loop.index})"/></td>
				    </tr>
				</c:forEach>
                </tbody>
              </table>
             </form>
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