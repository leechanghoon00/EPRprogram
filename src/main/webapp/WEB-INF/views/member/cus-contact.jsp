<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix= "c" uri= "http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("utf-8");
	String cus_id = (String) session.getAttribute("cus_id");
	String cus_name = (String) session.getAttribute("cus_name");
%>
<c:set var= "contextPath" value= "${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>KG-ERP - Good Project</title>
  <meta content="" name="description">
  <meta content="" name="keywords">
  
<!-- CSS Files -->
<jsp:include page="../common/styles.jsp"/>

</head>

<body>

  <jsp:include page="../common/header-customer.jsp"/>

  <main id="main" class="main">

    <div class="pagetitle">
      <h1>FAQ</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="${contextPath }/member/customer.do">Home</a></li>
          <li class="breadcrumb-item active">FAQ</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section contact">

      <div class="row gy-4">

        <div class="col-xl-6">

          <div class="row">
            <div class="col-lg-6">
              <div class="info-box card">
                <i class="bi bi-geo-alt"></i>
                <h3>Address</h3>
                <p><br>서울시 동작구 노량진동, 45-3</p>
              </div>
            </div>
            <div class="col-lg-6">
              <div class="info-box card">
                <i class="bi bi-telephone"></i>
                <h3>Call Us</h3>
                <p><br>02-866-9357</p>
              </div>
            </div>
            <div class="col-lg-6">
              <div class="info-box card">
                <i class="bi bi-envelope"></i>
                <h3>Email Us</h3>
                <p><br>Erp@kg-erp.com</p>
              </div>
            </div>
            <div class="col-lg-6">
              <div class="info-box card">
                <i class="bi bi-clock"></i>
                <h3>Open Hours</h3>
                <p>Monday - Friday<br>9:00AM - 06:00PM</p>
              </div>
            </div>
          </div>

        </div>

        <div class="col-xl-6">
          <div class="card p-4">
            <form action="${contextPath }/member/sendMessage.do" method="post">
              <div class="row gy-4">

                <div class="col-md-6">
                  <input type="text" name="cus_name" class="form-control" value= "<%=cus_name %>" readonly="readonly">
                </div>

                <div class="col-md-6 ">
                  <input type="email" class="form-control" name="cus_email" placeholder="이메일" required>
                </div>

                <div class="col-md-12">
                  <input type="text" class="form-control" name="subject" placeholder="제목" required>
                </div>

                <div class="col-md-12">
                  <textarea class="form-control" name="contents" rows="6" placeholder="내용" required></textarea>
                </div>

				<div style= "text-align:center">
                  <button class= "btn btn-primary" type="submit">Send Message</button>
				</div>

              </div>
            </form>
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