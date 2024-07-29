<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>
<%@ taglib prefix= "c" uri= "http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("utf-8");
	String co_id = (String) session.getAttribute("co_id");
	String name = (String) session.getAttribute("name");
	String part = (String) session.getAttribute("part");
	String position = (String) session.getAttribute("position");
%>
<c:set var= "contextPath" value= "${pageContext.request.contextPath }" />
<c:set var= "possi_part" value= "${possi_part }" />
<c:set var= "possi_position" value= "${possi_position }" />
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
#main {
    margin-top: 60px;
    padding: 20px 30px;
    transition: all 0.3s;
    min-height: 730px;
}

section > div {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 100px; /* 위로 이동할 픽셀 수 */
}

</style>
</head>

<body>
  	<jsp:include page="../common/header.jsp"/>

  <main id="main" class="main">

    <div class="pagetitle">
      <h1>접근불가</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="${contextPath }/member/main.do">Home</a></li>
          <li class="breadcrumb-item active">접근불가</li>
        </ol>
      </nav>
    </div>
    <!-- End Page Title -->
	<section>
		<div>
		<table>
			<tr>
			<th><h2><label>접근권한이 없습니다.</label></h2></th>
			<th></th>
			</tr>
			<tr>
			<td style="padding-top:30px;"><h5>**경영지원부서 담당자에게 문의하세요.**</h5></td>
			<td></td>
			</tr>
			<tr>
			<td style="padding-top:30px;"><h4>접근 가능부서 : ${possi_part }부서</h4></td>
			<td style="padding-top:30px; padding-left:20px;"><h5>직급 : ${possi_position }</h5></td>		
			</tr>
		</table>
		</div>
	</section>
  </main><!-- End #main -->
	
 	<jsp:include page="../common/footer.jsp"/>
 
	
	<!-- JS Files -->
	<jsp:include page="../common/scripts.jsp"/>
</body>

</html>