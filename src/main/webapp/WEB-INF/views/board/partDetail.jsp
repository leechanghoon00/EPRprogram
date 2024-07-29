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
    
              
				<div class="row mb-3">
                  <label for="inputName" class="col-sm-2 col-form-label">작성자</label>
                  <div class="col-sm-10">
                    <input id="inputName" name="co_name" style="border:none; background:none;" type="text" class="form-control" value= "${annoDetail.co_name}" disabled="disabled">
                  </div>
                </div>
			<div class="row mb-3">
                  <label for="partInput" class="col-sm-2 col-form-label">부서</label>
                  <div class="col-sm-10">
                    <input id="partInput" name="anno_part_nm" style="border:none; background:none;" type="text" class="form-control" value= "${annoDetail.anno_part_nm}" disabled="disabled">
                  </div>
                </div>
                
            <div class="row mb-3">
              <label for="inputDate" class="col-sm-2 col-form-label">작성일자</label>
              <div class="col-sm-10">
                <input id="inputDate" name="anno_date" style="border:none; background:none;" type="text" class="form-control" value= "${annoDetail.anno_date}" disabled="disabled">
              </div>
            </div>

            <div class="row mb-3">
              <label for="inputTitle" class="col-sm-2 col-form-label">제목</label>
              <div class="col-sm-10">
                <input id="inputTitle" name="anno_title" type="text" class="form-control" value= "${annoDetail.anno_title}" readonly="readonly">
              </div>
            </div>

            <div class="row mb-3">
              <label for="inputContent" class="col-sm-2 col-form-label">내용</label>
              <div class="col-sm-10">
                <textarea id="inputContent" class="form-control" name="anno_content" rows="6" readonly="readonly">${annoDetail.anno_content }</textarea>
              </div>
            </div>

			<div style= "text-align:center">
                  <input class= "btn btn-primary" type="button" value="확인" onclick="location.href='${contextPath }/member/main.do';"/>
			</div>


  </main><!-- End #main -->

	<jsp:include page="../common/footer.jsp" />


	<!-- JS Files -->
	<jsp:include page="../common/scripts.jsp" />
</body>

</html>