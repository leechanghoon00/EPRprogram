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

.code, .amount {
	width: 150px;
}

.namewidth {
	width: 300px;
}

.datatable-table > thead > tr > th {
    text-align: center;
    vertical-align: top;
    padding: 8px 10px;
}

.datatable-table > tbody {
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

.display-none {
    display: none !important;
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

.divButton { /* 0409 버튼 색깔, 기울기 추가 - 김지현*/
	height:40px;
	margin-right:20px;
	padding: 0.5rem 1rem; 
    border-radius: 5px;
    border: none;
    color: #fff;
    cursor: pointer;
    background-color: #007bff;
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
	    var codeInputs = document.querySelectorAll('input[name="item_code"]');
	    var priceInputs = document.querySelectorAll('input[name="item_price"]');
	    amountInputs.forEach(function(input) {
	        input.setAttribute('data-original-value', input.value.trim()); // 현재 값 설정
	    });
	    codeInputs.forEach(function(input) {
	        input.setAttribute('data-original-value', input.value.trim()); // 현재 값 설정
	    });
	    priceInputs.forEach(function(input) {
	        input.setAttribute('data-original-value', input.value.trim()); // 현재 값 설정
	    });
	}
	
	
	function fn_modStock(button, index) {
		console.log("클릭된 버튼의 인덱스:", index);
		button.value = '수정완료';
		
		// 모든 행을 숨김 처리
	    const allRows = document.querySelectorAll('[id^="changeInfo"]');
	    allRows.forEach(row => {
	        row.style.display = 'none';
	    });
		
	    // 클릭된 행만 보이도록 변경
	    const clickedRow = document.getElementById('changeInfo' + index);
	    clickedRow.style.display = '';

	    const modbutton = document.querySelector('input[name="modButton"]');
	    modbutton.style.display = 'none';
	    
		const del = document.querySelector('input[name="delStock"]');
		del.value = "수정취소";
		
		del.addEventListener('click', function() {
		    location.href = "${contextPath }/product/manageStock.do";
		});
		
		
		const codeTd = clickedRow.querySelector('td:nth-child(2)');
	    const priceTd = clickedRow.querySelector('td:nth-child(3)');
	    const amountTd = clickedRow.querySelector('td:nth-child(4)');
	    
	        // 이미 input 태그가 존재하는지 확인
	        if (!codeTd.querySelector('input')) {
	            const codeInput = document.createElement('input');
	            codeInput.type = 'text';
	            codeInput.id = 'code_' + index;
	            codeInput.className = 'code';
	            codeInput.name = 'item_code';
	            codeInput.value = codeTd.textContent;
	            codeInput.oninput = function() {
	            	modValueTotal(index); // modValueTotal 함수 호출시 인덱스 전달
	            };
	            codeTd.innerHTML = '';
	            codeTd.appendChild(codeInput);
	        }
	        if (!priceTd.querySelector('input')) {
	            const priceInput = document.createElement('input');
	            priceInput.type = 'text';
	            priceInput.id = 'price_' + index;
	            priceInput.className = 'price';
	            priceInput.name = 'item_price';
	            priceInput.value = priceTd.textContent;
	            priceInput.oninput = function() {
	            	modValueTotal(index); // modValueTotal 함수 호출시 인덱스 전달
	            };
	            priceTd.innerHTML = '';
	            priceTd.appendChild(priceInput);
	        }
        	if (!amountTd.querySelector('input')) {
                const amountInput = document.createElement('input');
                amountInput.type = 'text';
                amountInput.id = 'amount_' + index;
	            amountInput.className = 'amount';
                amountInput.name = 'item_amount';
                amountInput.value = amountTd.textContent;
                amountInput.oninput = function() {
	                modValueTotal(index); // modValueTotal 함수 호출시 인덱스 전달
	            };
                amountTd.innerHTML = '';
                amountTd.appendChild(amountInput);
            }
        	
        	initializeOriginalValues();
        	
	        // 이벤트 위임을 사용하여 input 요소의 focus와 input 이벤트를 처리합니다.
	        document.addEventListener('focus', function(event) {
	            var target = event.target;
	            if (target.tagName === 'INPUT' && target.name === 'item_amount') {
	                if (target.value.trim() === '0') {
	                    target.value = '';
	                }
	            }
	        }, true); // 캡처링 단계에서 이벤트를 캡처합니다.

	        document.addEventListener('input', function(event) {
	            var target = event.target;
	            if (target.tagName === 'INPUT' && target.name === 'item_amount') {
	                // 숫자 이외의 문자 제거
	                target.value = target.value.replace(/[^\d]/g, '');
	            }
	        });

	        // 이벤트 위임을 사용하여 input 요소의 focus와 input 이벤트를 처리합니다.
	        document.addEventListener('focus', function(event) {
	            var target = event.target;
	            if (target.tagName === 'INPUT' && target.name === 'item_price') {
	                if (target.value.trim() === '0') {
	                    target.value = '';
	                }
	            }
	        }, true); // 캡처링 단계에서 이벤트를 캡처합니다.

	        document.addEventListener('input', function(event) {
	            var target = event.target;
	            if (target.tagName === 'INPUT' && target.name === 'item_price') {
	                // 숫자 이외의 문자 제거
	                target.value = target.value.replace(/[^\d]/g, '');
	            }
	        });
	        
	    button.addEventListener('click', function() {
		    fn_mod(index);
		    
		});

	}

	 function modValueTotal(index) {
		
		 
		 // 수정된 주문수량을 가져와서 총액을 계산하여 화면에 업데이트
        var codeInput = document.querySelector('#code_' + index);
        var priceInput = document.querySelector('#price_' + index);
        var amountInput = document.querySelector('#amount_' + index);

        
        var code = codeInput.value.trim(); // 입력된 코드 값 가져오기
        var price = parseInt(priceInput.value.trim()); // 입력된 가격 값 가져오기 (정수로 변환)
        var amount = parseInt(amountInput.value.trim()); // 입력된 수량 값 가져오기 (정수로 변환)
        var codeOriginalValue = codeInput.getAttribute('data-original-value'); // 초기 코드 값 가져오기
        var priceOriginalValue = parseInt(priceInput.getAttribute('data-original-value')); // 초기 가격 값 가져오기 (정수로 변환)
        var amountOriginalValue = parseInt(amountInput.getAttribute('data-original-value')); // 초기 수량 값 가져오기 (정수로 변환)

     	// 코드 필드 포커스 아웃 이벤트 처리
        codeInput.addEventListener('blur', function() {
            // 코드 입력 필드가 비어있는 경우 원래 데이터 값으로 설정
            if (!codeInput.value.trim()) {
                codeInput.value = codeOriginalValue;
            }
        });

        // 가격 필드 포커스 아웃 이벤트 처리
        priceInput.addEventListener('blur', function() {
            // 가격 입력 필드가 비어있는 경우 원래 데이터 값으로 설정
            if (!priceInput.value.trim() || priceInput.value.trim() == 0) {
                priceInput.value = priceOriginalValue;
            }
        });
        
     	// 수량 입력 필드에서 포커스를 잃었을 때 이전 값으로 복원될 수 있도록 이벤트를 추가합니다.
        amountInput.addEventListener('blur', function() {
            // 입력된 값이 비어있는 경우 원래 설정된 값으로 복원합니다.
            if (!amountInput.value.trim()) {
                amountInput.value = amountOriginalValue;
            } else if (amountInput.value.trim() < amountOriginalValue) {
                // 입력된 수량이 설정된 값보다 작은 경우에도 포커스를 잃었을 때 이전 값으로 복원됩니다.
                amountInput.value = amountOriginalValue;
            }
        });
    } 
	
   
    function fn_mod(index) {
        const product = [];
		const nameValue = document.querySelector('[id="nameLabel_'+index+'"]');
		const codeInput = document.querySelector('[id="code_'+index+'"]');
		const priceInput = document.querySelector('[id="price_'+index+'"]');
		const amountInput = document.querySelector('[id="amount_'+index+'"]');
	        	const item_name = nameValue.textContent;
	        	const item_code = codeInput.value;
	            const item_price = priceInput.value;
	            const item_amount = amountInput.value;
	
	            const item = {
            		"item_name" : item_name,
            		"item_code" : item_code,
            		"item_price" : item_price,
	                "item_amount" : item_amount
	            };
	            if (item.item_name != "" && item.item_name != 0) {
	                product.push(item);
	            }
	        

        $.ajax({
            type : 'POST',
            url : "${contextPath }/product/modStock.do",
            contentType : "application/json", // 컨텐츠 타입 설정
            data : JSON.stringify(product),
            success : function(returnData) {
                console.log(returnData);
                if (returnData.result == 0) {
                    //fail
                    alert('재고수정이 실패했습니다.');
                } else if (returnData.result != 0) {
                    // suceess
                    alert('재고수정이 성공했습니다.');
			        location.href = '${contextPath }/product/manageStock.do';
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
    
    function fn_addStock() {
    	const button = document.querySelector('input[name="modButton"]');
	    button.value = '등록완료';
	    
		const del = document.querySelector('input[name="delStock"]');
		del.value = "등록취소";
		
		del.addEventListener('click', function() {
		    location.href = "${contextPath }/product/manageStock.do";
		});
		
		$("#modBtn").attr("onclick", "fn_add()");
		
		const modTh = document.querySelector('#modTh');
		modTh.className = '';
		modTh.classList.add('display-none');
		
		const modbuttons = document.querySelectorAll('[id^="modStock_"]');
		modbuttons.forEach(input => {
			input.style.display = 'none';
		});
		
		const nameInputs = document.querySelectorAll('[id^="addName_"]');
		nameInputs.forEach(input => {
			input.style.display = "inline-block";
		});
		
		const nameLabels = document.querySelectorAll('[id^="nameLabel_"]');
		nameLabels.forEach(label => {
			label.style.display = 'none';
		});
		
	    // 기존의 모든 상품 행을 숨김 처리합니다.
	    const changeInfoRows = document.querySelectorAll('[id^="changeInfo"]');
	    changeInfoRows.forEach(row => {
	        row.style.display = 'none';
	    });

	    // 새로운 상품 행을 만들고 노출시킵니다.
	    const newRow = document.createElement('tr');
	    newRow.id = 'newProductRow'; // 새로운 상품 행의 ID를 지정합니다.

	    // 각 열에 입력 필드를 추가합니다.
	    const nameCell = document.createElement('td');
	    const nameInput = document.createElement('input');
	    nameInput.type = 'text';
	    nameInput.name = 'new_item_name';
	    nameInput.placeholder = '제품명 입력';
	    nameCell.appendChild(nameInput);

	    const codeCell = document.createElement('td');
	    const codeInput = document.createElement('input');
	    codeInput.type = 'text';
	    codeInput.name = 'new_item_code';
	    codeInput.placeholder = '제품코드 입력';
	    codeCell.appendChild(codeInput);

	    const priceCell = document.createElement('td');
	    const priceInput = document.createElement('input');
	    priceInput.type = 'text';
	    priceInput.name = 'new_item_price';
	    priceInput.placeholder = '제품가격 입력';
	    priceCell.appendChild(priceInput);

	    const amountCell = document.createElement('td');
	    const amountInput = document.createElement('input');
	    amountInput.type = 'text';
	    amountInput.name = 'new_item_amount';
	    amountInput.placeholder = '제품수량 입력';
	    amountCell.appendChild(amountInput);

	    // 셀들을 행에 추가합니다.
	    newRow.appendChild(nameCell);
	    newRow.appendChild(codeCell);
	    newRow.appendChild(priceCell);
	    newRow.appendChild(amountCell);

	    // 테이블에 새로운 행을 추가합니다.
	    const tbody = document.querySelector('tbody');
	    tbody.appendChild(newRow);
	
    }
    
    function fn_add() {
        const product = [];
        const inputs = document.querySelectorAll('input[name="new_item_name"], input[name="new_item_code"], input[name="new_item_price"], input[name="new_item_amount"]');

	        for (let i = 0; i < inputs.length; i += 4) {
	        	const item_name = inputs[i].value;
	        	const item_code = inputs[i + 1].value;
	            const item_price = inputs[i + 2].value;
	            const item_amount = inputs[i + 3].value;
	
	            const item = {
            		"item_name" : item_name,
            		"item_code" : item_code,
            		"item_price" : item_price,
	                "item_amount" : item_amount
	            };
	            if (item.item_name != "" && item.item_name != 0) {
	                product.push(item);
	            }
	        }

        $.ajax({
            type : 'POST',
            url : "${contextPath }/product/addStock.do",
            contentType : "application/json", // 컨텐츠 타입 설정
            data : JSON.stringify(product),
            success : function(returnData) {
                console.log(returnData);
                if (returnData.result == 0) {
                    //fail
                    alert('제품등록이 실패했습니다.');
                } else if (returnData.result != 0) {
                    // suceess
                    alert('제품등록이 성공했습니다.');
			        location.href = '${contextPath }/product/manageStock.do';
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
    
	function fn_delStock() {
		
		const button = document.querySelector('input[name="modButton"]');
		button.value = "삭제완료";
		const cancelDel = document.querySelector('input[name="delStock"]');
		cancelDel.value = "삭제취소";
		
		// <tr> 요소에서 <th> 요소를 찾습니다.
		const thElements = tableTh.querySelectorAll('th');
		// <th> 요소에서 <button> 요소를 찾습니다.
	  	const select = thElements[0];
		select.textContent = '선택';
		
		const modTh = $('#modTh');
		modTh.style = 'display: none';
		const modbuttons = document.querySelectorAll('[id^="modStock_"]');
		modbuttons.forEach(input => {
			input.style.display = 'none';
		});
		
		// .nowidth 클래스를 가진 요소들의 너비를 변경합니다.
	    const elements = document.querySelectorAll('.nowidth');
	    elements.forEach(element => {
	        element.style.width = '300px';
	    });
	    
		
		const noTds = document.querySelectorAll('[id^="delName_"]');
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
		
		 
		$("#modBtn").attr("onclick", "");

		button.addEventListener('click', function() {
			fn_delete(product);
		});

		cancelDel.addEventListener('click', function() {
		    location.href = "${contextPath }/product/manageStock.do";
		});
		
	}
	
	function fn_delete(product) {
		
		if(confirm("삭제하시겠습니까?")) {
		$.ajax({
            type : 'POST',
            url : "${contextPath }/product/delStock.do",
            contentType : "application/json", // 컨텐츠 타입 설정
            data : JSON.stringify(product),
            success : function(returnData) {
                console.log(returnData);
                if (returnData.result == 0) {
                    //fail
                    alert('재고삭제가 실패했습니다.');
                } else if (returnData.result != 0) {
                    // suceess
                    alert('재고삭제가 성공했습니다.');
                    location.href = "${contextPath }/product/manageStock.do";
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
	    location.href = "${contextPath }/product/manageStock.do";
	}
	
const columns = [
	    { text: "제품명", datafield: "item_name"},
	    { text: "제품코드", datafield: "item_code"},
	    { text: "판매가", datafield: "item_price"},
	    { text: "수량", datafield: "item_amount"},
	  ];
  
  function excelDownload() {
	  const url = "${contextPath}/product/excelManageStock.do";
	  
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
      <h1>상품관리</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="${contextPath }/member/main.do">Home</a></li>
          <li class="breadcrumb-item active">상품관리</li>
        </ol>
      </nav>
    </div>
    <!-- End Page Title -->
	<section class="section">
		<form id="excelForm" name="excelForm">
			<input type="hidden" name="excelFileNm" value="개발부서 상품관리.xls">
			<input type="hidden" id="columnsNm" name="columnsNm" />
			<input type="hidden" id="datafield" name="datafield"/>
		</form>
      <div class="row">
        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">
              <h5 class="card-title">상품관리</h5>
              <p></p>

              <!-- Table with stripped rows -->
				<form id= "stockForm" method= "post" action= "${contextPath }/product/modStock.do">
	              	<div style= "text-align:right; padding-right:100px;">
    					<button type="button" class="btn btn-secondary rounded-pill" onclick="excelDownload()">엑셀 다운로드</button>
	              		<input class="divButton btn btn-primary" type= "button" id= "modBtn" name= "modButton" value= "제품등록" onclick= "fn_addStock()"/>
	              		<input class="divButton btn btn-primary" type= "button" id= "delBtn" name= "delStock" value= "제품삭제" onclick= "fn_delStock()"/>
	              	</div>
              <table id= "tableTh" class="table datatable">
                <thead>
                  <tr>
                    <th>제품명</th>
                    <th>제품코드</th>
                    <th>판매가</th>
                    <th>수량</th>
                    <th id="modTh"></th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="stock" items= "${stockList }" varStatus="loop">
                  	<tr id= "changeInfo${loop.index }" align= "center">
                  		<td id="item_name_${loop.index }" class= "namewidth">
                  		<input style= "display:none" type="checkbox" id="delName_${loop.index }" name= "item_name" value= "${stock.item_name }"/>
                  		<label id= "nameLabel_${loop.index }" for= "delName_${loop.index }">${stock.item_name }</label>
                  		<input style= "display:none" type="text" id="addName_${loop.index }" name= "item_name" value= "${stock.item_name }"/>
                  		</td>
                  		<td id="item_code_${loop.index }" class= "code">${stock.item_code }</td>
                  		<td id="item_price_${loop.index }">${stock.item_price }</td>
                  		<td id="item_amount_${loop.index }" class= "amount">${stock.item_amount }</td>
                  		<td id="modTd"><input type= "button" class= "btn btn-primary" id= "modStock_${loop.index }" name= "modStock" value= "수정" onclick= "fn_modStock(this, ${loop.index})"/></td>
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