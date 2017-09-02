<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--   jQuery , Bootstrap CDN  -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
	<style>
        body {
            padding-top : 70px;
        }
   	</style>
   	
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	 	
	
</head>
	
<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">
	<!-- Carousel
    ================================================== -->
	    <div id="myCarousel" class="carousel slide" data-ride="carousel">
	      <!-- Indicators -->
	      <ol class="carousel-indicators">
	        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
	        <li data-target="#myCarousel" data-slide-to="1"></li>
	        <li data-target="#myCarousel" data-slide-to="2"></li>
	      </ol>
	      <div class="carousel-inner" role="listbox">
	        <div class="item active">
	          <img class="img-responsive center-block" src="http://cfile30.uf.tistory.com/image/276817415415E08412A0E5" alt="First slide"
	          		style="width:1000px; height:400px;">
	          <div class="container">
	            <div class="carousel-caption">
	              <h1></h1>
	              <p><code></code></p>
	            </div>
	          </div>
	        </div>
	        <div class="item">
	          <img class="img-responsive center-block" src="http://kr.visitanaheim.org/images/header_images/shopping.jpg" alt="Second slide"
	          		style="width:1000px; height:400px;">
	          <div class="container">
	            <div class="carousel-caption">
	              <h1></h1>
	              <br/>
	              <br/>
	              <p><a class="btn btn-lg btn-primary" href="/product/listProduct?menu=search" role="button">쇼핑하기</a></p>
	            </div>
	          </div>
	        </div>
	        <div class="item">
	          <img class="img-responsive center-block" src="http://cfile4.uf.tistory.com/image/2349963C50EBD2C336AFDC" alt="Second slide"
	          		style="width:1000px; height:400px;">
	          <div class="container">
	            <div class="carousel-caption">
	              <p></p>
	              <p><a class="btn btn-lg btn-primary" href="/user/getUser?userId=${sessionScope.user.userId}" role="button">개인정보 수정</a></p>
	            </div>
	          </div>
	        </div>
	      </div>
	      <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
	        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
	        <span class="sr-only">Previous</span>
	      </a>
	      <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
	        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
	        <span class="sr-only">Next</span>
	      </a>
	    </div><!-- /.carousel -->
    </div>

</body>

</html>