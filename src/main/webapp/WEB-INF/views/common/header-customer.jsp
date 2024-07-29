<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var= "contextPath" value= "${pageContext.request.contextPath }" />
<%
	request.setCharacterEncoding("utf-8");
	String cus_id = (String) session.getAttribute("cus_id");
	String cus_name = (String) session.getAttribute("cus_name");
%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<style>
#sessionRefresh::before {
font-weight: bold !important;
}

</style>
<script>

let timer;
$(document).ready(function(){
    
    doTimer($("#sessionTimeOut").val());
    $(document).on('click', "i[id='sessionRefresh']", function(){
        clearTimeout(timer);
        doTimer($("#sessionTimeOut").val());
        sessionTimeOut();
    });
    
});

function sessionTimeOut() {
    return new Promise(function(resolve, reject) {
      $.get('${contextPath}/member/timeContinue.do', function(response) {
        if (response) {
            console.log("time2");
            time = <%=session.getMaxInactiveInterval() %>;
          resolve(response);
        }
        reject(new Error("Request is failed"));
      });
    });
  }

function doTimer(time){
    var date = new Date(null);
    if(time){
        date.setSeconds(time);
        document.getElementById("sessionTimer").innerHTML = date.toISOString().substr(11,8);
        if(time == 1){
        	clearTimeout(timer);
            alert("세션이 만료되었습니다. 다시 로그인해주세요");
            location.href = "${contextPath}/member/logout.do";
        }
 
        --time;
        timer = setTimeout(doTimer, 1000, time);
    }
    return;
}

</script>
   <!-- ======= Header ======= -->
  <header id="header" class="header fixed-top d-flex align-items-center">

    <div class="d-flex align-items-center justify-content-between">
      <a href="${contextPath }/member/customer.do" class="logo d-flex align-items-center">
        <img src="../assets/img/logo.png" alt="">
        <span class="d-none d-lg-block">KG-ERP</span>
      </a>
      <i class="bi bi-list toggle-sidebar-btn"></i>
    </div>
    <!-- End Logo -->

    <div class="search-bar"></div>
    <!-- End Search Bar -->

    <nav class="header-nav ms-auto">
        <div style="float:left; padding-right:30px;" >
    		<input type="hidden" id="sessionTimeOut" value="<%=session.getMaxInactiveInterval() %>" />
    		<span id="sessionTimer" style="vertical-align: -webkit-baseline-middle; font-weight: bold;"></span>
    		<i style="vertical-align: -webkit-baseline-middle; cursor:pointer;" id="sessionRefresh" class="bi bi-arrow-counterclockwise"  ></i>
    	</div> 
      <ul class="d-flex align-items-center">

        <li class="nav-item dropdown pe-3">

          <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
            <img src="../assets/img/profile-img.jpg" alt="Profile" class="rounded-circle">
            <span class="d-none d-md-block dropdown-toggle ps-2"><%=cus_name %></span>
          </a>
          <!-- End Profile Image Icon -->

          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
            <li class="dropdown-header">
              <h6><%=cus_name %></h6>
              <span><%=cus_name %> 담당자</span>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>


            <li>
              <a class="dropdown-item d-flex align-items-center" href="${contextPath }/member/logout.do">
                <i class="bi bi-box-arrow-right"></i>
                <span>로그아웃</span>
              </a>
            </li>

          </ul>
          <!-- End Profile Dropdown Items -->
        </li>
        <!-- End Profile Nav -->

      </ul>
    </nav><!-- End Icons Navigation -->

  </header><!-- End Header -->

  <!-- ======= Sidebar ======= -->
  <aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

      <li class="nav-heading">거래처메뉴</li>
      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#charts-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-bar-chart"></i><span>주문등록관리</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="charts-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="${contextPath }/product/offerMain.do">
              <i class="bi bi-circle"></i><span>주문등록</span>
            </a>
          </li>
          <li>
            <a href="${contextPath }/product/offerInfo.do">
              <i class="bi bi-circle"></i><span>주문조회</span>
            </a>
          </li>
          <li>
            <a href="${contextPath }/product/customerStock.do">
              <i class="bi bi-circle"></i><span>재고관리</span>
            </a>
          </li>
        </ul>
      </li>
      <!-- End Charts Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="${contextPath }/member/customerpro.do">
          <i class="bi bi-person"></i>
          <span>거래처정보관리</span>
        </a>
      </li>
      <!-- End Profile Page Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="${contextPath }/member/cus-contact.do">
          <i class="bi bi-card-list"></i>
          <span>FAQ</span>
        </a>
      </li>

    </ul>

  </aside>
  <!-- End Sidebar-->