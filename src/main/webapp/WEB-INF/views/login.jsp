<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>
<%@ taglib prefix= "c" uri= "http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<c:set var= "contextPath" value= "${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="css/mmain.css" rel="stylesheet" type="text/css">
<script>
	const signup = document.getElementById("sign-up");
	signin = document.getElementById("sign-in");
	loginin = document.getElementById("login-in");
	loginup = document.getElementById("login-up");
	
	signup.addEventListener("click", () => {
	    loginin.classList.remove("block");
	    loginup.classList.remove("none");
	
	    loginin.classList.add("none");
	    loginup.classList.add("block");
	})
	
	signin.addEventListener("click", () => {
	    loginin.classList.remove("none");
	    loginup.classList.remove("block");
	
	    loginin.classList.add("block");
	    loginup.classList.add("none");
	})
	 
</script>
<!-- Vendor CSS Files -->
<link href="assets/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="assets/vendor/bootstrap-icons/bootstrap-icons.css"
	rel="stylesheet">
<link href="assets/vendor/boxicons/css/boxicons.min.css"
	rel="stylesheet">
<link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
<link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
<link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
<link href="assets/vendor/simple-datatables/style.css"
	rel="stylesheet">

<!-- Template Main CSS File -->
<link href="assets/css/style.css" rel="stylesheet">
<style>
body {
	background-color: #ffffff;  /* 사진배경이랑 색깔 맞춤 0405 */
}

.login__title {
  font-size: 2rem;
  margin-bottom: 2rem;
}
</style>
<title>KG-ERP - Good Project</title>
</head>
<body>
	
   <div class="login">
    <div class="login__content">
      <div class="login__img">
        <img src="https://image.freepik.com/free-vector/code-typing-concept-illustration_114360-3581.jpg" alt="user login">
      </div>
      <div class="login__forms">
        <!-- login form -->
		<form action="${contextPath}/member/login.do" method= "post" class="login__register" id="login">
		
          <h1 class="login__title">로그인</h1>
          <div class="login__box">
            <i class='bx bx-user login__icon'></i>
            <input type="text" name="co_id" placeholder="아이디" class="login__input">
          </div>
          <div class="login__box">
            <i class='bx bx-lock login__icon'></i>
            <input type="password" name="co_pwd" placeholder="비밀번호" class="login__input">
          </div>
         
          
			<input type="submit" class="btn btn-primary" value="로그인"> <!-- 0409수정 - 김지현 -->
		
            
        </form>
      </div>
    </div>
  </div>
</body>
</html>