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

.amount {
	width: 100px;
}

.datatable-top, .datatable-bottom {
    padding: 8px 10px;
    display: none;
}

.card-title {
	font-size:30px;
	text-align:center;
	padding-top:40px;
	padding-bottom:0;
}

</style>  

  <!-- =======================================================
  * Template Name: NiceAdmin
  * Updated: Mar 10 2024 with Bootstrap v5.3.3
  * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->

<script>
    
    // 페이지가 로드될 때 스크립트가 실행되도록 합니다.
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
      
    	initializeOriginalValues(); // 초기값 설정 함수 호출

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
    
    
    // 주문 가능 수량의 초기값을 설정하는 함수
    function initializeOriginalValues() {
        var amountInputs = document.querySelectorAll('input[name="item_amount"]');
        amountInputs.forEach(function(input) {
            input.setAttribute('data-original-value', input.value.trim()); // 현재 값 설정
        });
    }

    function fn_reset() {

     	var orderAmountInputs = document.querySelectorAll('input[name="item_orderAmount"]');
        var totalInputs = document.querySelectorAll('input[name="item_totalPrice"]');
        var amountInputs = document.querySelectorAll('input[name="item_amount"]');

        orderAmountInputs.forEach(function(input, index) {
            var orderAmount = parseFloat(input.value.trim()) || 0;
            if (orderAmount !== 0) {
                input.value = 0;
                var amountInput = amountInputs[index];
                var originalValue = amountInput.getAttribute('data-original-value');
                amountInput.value = originalValue;
            }
        });

        totalInputs.forEach(function(input) {
            input.value = 0;
        });
    }

    function calculateTotal(index) {
        var itemPrice = parseFloat(document.querySelector('#price_' + index).textContent);
        var orderAmountInput = document.querySelector('#orderAmount_' + index);

        var orderAmount = parseFloat(orderAmountInput.value.trim()) || ''; // 입력된 값 가져오기
        var amountInput = document.querySelector('#amount_' + index);
        var originalValue = parseFloat(amountInput.getAttribute('data-original-value')) || 0; // 초기값 가져오기

        var newAmount = originalValue - orderAmount;
        if (newAmount < 0) { // 주문 수량이 주문 가능 수량을 초과하는 경우
            orderAmountInput.value = originalValue; // 주문 가능 수량으로 자동 조정
            orderAmount = originalValue;
            newAmount = 0;
        }

        amountInput.value = newAmount; // 주문 가능 수량 업데이트

        var total = itemPrice * orderAmount;
        document.querySelector('#total_' + index).value = isNaN(total) ? '' : total; // 총액을 표시
    }

    function fn_offer() {
    	const cus_id = "<%=cus_id %>";
        const product = [];
        const inputs = document.querySelectorAll('input[name="item_name"], input[name="item_amount"], input[name="item_orderAmount"], input[name="item_totalPrice"]');

	        for (let i = 0; i < inputs.length; i += 4) {
	            const item_name = inputs[i].value;
	            const item_amount = inputs[i + 1].value;
	            const item_orderAmount = inputs[i + 2].value;
	            const item_totalPrice = inputs[i + 3].value;
	
	            const item = {
	                "cus_id" : cus_id,
            		"item_name" : item_name,
	                "item_amount" : item_amount,
	                "item_orderAmount" : item_orderAmount,
	                "item_totalPrice" : item_totalPrice
	            };
	            if (item.item_orderAmount != "" && item.item_orderAmount != 0) {
	                product.push(item);
	            }
	        }
        
        

        $.ajax({
            type : 'POST',
            url : "${contextPath }/product/offer.do",
            contentType : "application/json", // 컨텐츠 타입 설정
            data : JSON.stringify(product),
            success : function(returnData) {
                console.log(returnData);
                if (returnData.result == 0) {
                    //fail
                    alert('주문등록이 실패했습니다.');
			        location.href = '${contextPath }/product/offerMain.do';
                } else if (returnData.result != 0) {
                    // suceess
                    alert('주문등록이 성공했습니다.');
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

</script>

</head>

<body>

  <jsp:include page="../common/header-customer.jsp"/>
  
  <main id="main" class="main">

    <div class="pagetitle">
      <h1>주문등록</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="${contextPath }/member/customer.do">Home</a></li>
          <li class="breadcrumb-item active">주문등록</li>
        </ol>
      </nav>
    </div>
    <!-- End Page Title -->
	<section class="section">
      <div class="row">
        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">
              <h5 class="card-title">주문등록</h5>
              <p></p>

              <!-- Table with stripped rows -->
             <form id= "offerForm" method= "post" action= "${contextPath }/product/offer.do">
             	<div style="text-align:right; padding-right:100px; padding-bottom:30px;">
	             	<input type="button" class= "btn btn-primary" value= "주문등록" onclick= "fn_offer()">
	             	<input type="button" class= "btn btn-primary" name= "cancel" value= "취소" onclick= "fn_reset()">
             	</div>
              <table id= "tableTh" class="table datatable">
                <thead>
                  <tr>
                    <th>제품명</th>
                    <th>제품코드</th>
                    <th>판매가</th>
                    <th>주문가능수량</th>
                    <th>주문수량</th>
                    <th>주문총액</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="offers" items="${offersList}" varStatus="loop">
				    <tr align= "center">
				        <td id="item_name_${loop.index }"><input type= "hidden" name= "item_name" value= "${offers.item_name}"/>${offers.item_name}</td>
				        <td id="item_code_${loop.index }">${offers.item_code}</td>
				        <td id="price_${loop.index }">${offers.item_price}</td>
				        <td><input type= "text" id="amount_${loop.index }" class= "amount" name= "item_amount" value= "${offers.item_amount}" readonly="readonly" /></td>
				        <td><input type= "text" id="orderAmount_${loop.index }" class= "amount" name= "item_orderAmount" value= "0" oninput="calculateTotal(${loop.index})" /></td>
				        <td><input type= "text" id="total_${loop.index }" name= "item_totalPrice" value= "0" readonly="readonly" /></td>
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