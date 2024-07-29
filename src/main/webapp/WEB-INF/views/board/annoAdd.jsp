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
	String anno_no = (String) request.getParameter("anno_no");
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
	
	function sendBoard(){
        event.preventDefault(); // 기본 제출 동작을 중지합니다.

		const frm = document.getElementById('annoAdd');
		
		const title = frm.anno_title.value;
		const content = frm.anno_content.value;
		
		if (title == ""){
			alert('제목을 입력하세요.');
			frm.anno_title.focus();
			return;
		} else if (content == ""){
			alert('내용을 입력하세요.');
			frm.anno_content.focus();
			return;
		}
		
		frm.action = "${contextPath}/board/addAnno.do";
		frm.submit();
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
          <li class="breadcrumb-item active"><%=part %>부서 공지사항 관리</li>
        </ol>
      </nav>
    </div>
    <!-- End Page Title -->
    
              <form id="annoAdd" method= "post">
				<div class="row mb-3">
                  <label for="inputName" class="col-sm-2 col-form-label">작성자</label>
                  <div class="col-sm-10">
                    <input id="inputName" name="co_name" style="border:none; background:none;" type="text" class="form-control" value= "<%=name %>" readonly="readonly">
                  </div>
                </div>
			<div class="row mb-3">
                  <label for="partInput" class="col-sm-2 col-form-label">부서</label>
                  <div class="col-sm-10">
                    <input id="partInput" name="anno_part_nm" style="border:none; background:none;" type="text" class="form-control" value= "<%=part %>" readonly="readonly">
                  </div>
                </div>
                
            <div class="row mb-3">
              <label for="inputTitle" class="col-sm-2 col-form-label">제목</label>
              <div class="col-sm-10">
                <input id="inputTitle" name="anno_title" type="text" class="form-control" placeholder="제목을 입력하세요.">
              </div>
            </div>

            <div class="row mb-3">
              <label for="inputContent" class="col-sm-2 col-form-label">내용</label>
              <div class="col-sm-10">
                <textarea id="inputContent" class="form-control" name="anno_content" rows="6" placeholder="내용을 입력하세요."></textarea>
              </div>
            </div>

			<div style= "text-align:center">
                  <input class= "btn btn-primary" id="sendBtn" type="button" value="작성완료" onclick="sendBoard()"/>
                  <input class= "btn btn-primary" type="button" value="취소" onclick="location.href='${contextPath }/board/partInfo.do';"/>
			</div>
			</form>


  </main><!-- End #main -->

	<jsp:include page="../common/footer.jsp" />


	<!-- JS Files -->
	<jsp:include page="../common/scripts.jsp" />
</body>

</html>