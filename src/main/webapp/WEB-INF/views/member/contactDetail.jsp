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
	String message_no = request.getParameter("message_no");
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
	
	function fn_confirm(){
		const message_no = <%=message_no %>;
		const item = {
			"message_no" : message_no
		};
		
		$.ajax({
            type : 'POST',
            url : "${contextPath }/member/contactConfirm.do",
            contentType : "application/json", // 컨텐츠 타입 설정
            data : JSON.stringify(item),
            success : function(returnData) {
                console.log(returnData);
                if (returnData.result != 0) {
                    //fail
                    alert('문의사항 확인했습니다.');
			        location.href = '${contextPath }/member/contact.do';
                } else if (returnData.result == 0) {
                    // suceess
                    alert('문의사항 확인 실패했습니다.');
			        location.href = '${contextPath }/member/contact.do';
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
  	<jsp:include page="../common/header.jsp"/>

  <main id="main" class="main">

    <div class="pagetitle">
      <h1>거래처 FAQ 관리</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="${contextPath }/member/main.do">Home</a></li>
          <li class="breadcrumb-item active">거래처 FAQ 관리</li>
        </ol>
      </nav>
    </div>
    <!-- End Page Title -->
    
          
     <section class="section">
     	<div class="row">
        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">
              <h5 class="card-title">거래처 FAQ 관리</h5>
              <p></p>
              <div class="row gy-4">

                <div class="col-md-6">
                  <input type="text" name="cus_name" class="form-control" value="${contact.cus_name }" readonly="readonly">
                </div>

                <div class="col-md-6 ">
                  <input type="email" class="form-control" name="cus_email"value="${contact.cus_email }" readonly="readonly">
                </div>

                <div class="col-md-12">
                  <input type="text" class="form-control" name="subject" value="${contact.subject }" readonly="readonly">
                </div>

                <div class="col-md-12">
                  <textarea class="form-control" name="contents" rows="6" readonly="readonly">${contact.contents }</textarea>
                </div>

				<div style= "text-align:center">
                  <input class= "btn btn-primary" type="button" value="확인" onclick="fn_confirm()"/>
                  <input class= "btn btn-primary" type="button" value="취소" onclick="location.href='${contextPath }/member/contact.do';"/>
				</div>

              </div>
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