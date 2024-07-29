<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var= "contextPath" value= "${pageContext.request.contextPath }" />
<%
	request.setCharacterEncoding("utf-8");
	String co_id = (String) session.getAttribute("co_id");
	String name = (String) session.getAttribute("name");
	String part = (String) session.getAttribute("part");
	String position = (String) session.getAttribute("position");
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
    
	 // 클릭 이벤트 리스너 등록
    $('a[href="${contextPath}/member/main.do"]').click(function(event) {
        // 클릭된 a 태그의 속성 값을 확인하여 대표인 경우에는 mainAdmin.do 로 이동하도록 처리
        if ("<%=position %>" === "대표") {
            event.preventDefault(); // 기본 이벤트 중단
            window.location.href = "${contextPath}/member/mainAdmin.do"; // 원하는 URL로 이동
        }
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
      <a href="${contextPath }/member/main.do" class="logo d-flex align-items-center">
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
            <span class="d-none d-md-block dropdown-toggle ps-2"><%=name %></span>
          </a>
          <!-- End Profile Image Icon -->

          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
            <li class="dropdown-header">
              <h6><%=name %></h6>
              <span><%=part %>부서 <%=position %></span>
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


      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#tables-general" data-bs-toggle="collapse" href="#">
          <i class="bi bi-menu-button-wide"></i><span>총무부서</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="tables-general" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="${contextPath }/product/productOut.do">
              <i class="bi bi-circle"></i><span>제품출하량</span>
            </a>
          </li>
          <li>
            <a href="${contextPath }/money/paystubList.do">
              <i class="bi bi-circle"></i><span>급여명세서 관리</span>
            </a>
          </li>
          <li>
            <a href="${contextPath }/product/productStock.do">
              <i class="bi bi-circle"></i><span>재고관리</span>
            </a>
          </li>
        </ul>
      </li>
      <!-- End General Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#tables-dev" data-bs-toggle="collapse" href="#">
          <i class="bi bi-wrench"></i><span>개발생산부서</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="tables-dev" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="${contextPath }/product/manageStock.do">
              <i class="bi bi-circle"></i><span>상품관리</span>
            </a>
          </li>
        </ul>
      </li>
      <!-- End Dev Nav -->


      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#tables-manage" data-bs-toggle="collapse" href="#">
          <i class="bi bi-layout-text-window-reverse"></i><span>경영지원부서</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="tables-manage" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="${contextPath }/member/user-profile.do">
              <i class="bi bi-circle"></i><span>인사관리</span>
            </a>
          </li>
          <li>
            <a href="${contextPath }/member/customer-profile.do">
              <i class="bi bi-circle"></i><span>거래처 관리</span>
            </a>
          </li>
          <li>
            <a href="${contextPath }/member/contact.do">
              <i class="bi bi-circle"></i><span>FAQ 관리</span>
            </a>
          </li>
        </ul>
      </li>
      <!-- End Manage Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#tables-head" data-bs-toggle="collapse" href="#">
          <i class="bi bi-x-diamond"></i><span>부서장(팀장) 전용</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="tables-head" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="${contextPath }/board/partInfo.do">
              <i class="bi bi-circle"></i><span>공지사항 관리(부서장)</span>
            </a>
          </li>
          <li>
            <a href="${contextPath }/money/chkUserInfo.do">
              <i class="bi bi-circle"></i><span>연차승인(부서장)</span>
            </a>
          </li>
        </ul>
      </li>
      <!-- End Part-Head Nav -->
      
      <li class="nav-heading">공통메뉴</li>

      <li class="nav-item">
        <a class="nav-link collapsed" href="${contextPath }/member/user.do">
          <i class="bi bi-person"></i>
          <span>개인정보관리</span>
        </a>
      </li>
     <!-- End Profile Page Nav -->

	<li class="nav-item"><a class="nav-link collapsed"
		data-bs-target="#icons-nav" data-bs-toggle="collapse" href="#">
			<i class="bi bi-gem"></i><span>개인 연차</span><i
			class="bi bi-chevron-down ms-auto"></i>
	</a>
		<ul id="icons-nav" class="nav-content collapse"
			data-bs-parent="#sidebar-nav">
			<li><a href="${contextPath }/money/requestAnnual.do"> <i
					class="bi bi-circle"></i><span>연차 신청</span>
			</a></li>
			<li><a href="${contextPath }/money/viewMyAnnual.do"> <i
					class="bi bi-circle"></i><span>연차 조회/관리</span>
			</a></li>
		</ul></li>
		<!-- End F.A.Q Page Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="${contextPath }/money/viewMyPayList.do">
          <i class="bi bi-envelope"></i>
          <span>급여명세서 조회</span>
        </a>
      </li>
      <!-- End Contact Page Nav -->
    </ul>

  </aside>
  <!-- End Sidebar-->