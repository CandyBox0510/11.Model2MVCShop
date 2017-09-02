<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css	/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
     </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		$(function(){
			 
			 $("button:contains('확인')").on("click",function(){
				 self.location = "/product/listProduct?menu=manage"
			 })
			 
			 $(".btn:contains('추가등록')").on("click",function(){
				 self.location = "/product/addProductView.jsp"
			 })
		 })
		
	</script>
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">상품등록</h3>
	    </div>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2" style="background:PapayaWhip;"><strong>상품명</strong></div>
			<div class="col-xs-8 col-md-4" style="background:Gainsboro;">${product.prodName }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2" style="background:PapayaWhip;"><strong>상품상세정보</strong></div>
			<div class="col-xs-8 col-md-4" style="background:Gainsboro;">${product.prodDetail }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2" style="background:PapayaWhip;"><strong>제조일자</strong></div>
			<div class="col-xs-8 col-md-4" style="background:Gainsboro;">${product.manuDate }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2" style="background:PapayaWhip;"><strong>가격</strong></div>
			<div class="col-xs-8 col-md-4" style="background:Gainsboro;">${product.price }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2" style="background:PapayaWhip;"><strong>상품이미지</strong></div>
			<div class="col-xs-8 col-md-4" style="background:Gainsboro;"><img src="/images/uploadFiles/${product.fileName }"/></div>
		</div>
		
		<hr/>
		
		<div class="form-group">
	  		<div class="col-md-12 text-center ">
	  			<button type="button" class="btn btn-primary">확인</button>
	  			<a class="btn btn-primary btn" href="#" role="button">추가등록</a>
	  		</div>
		</div>
		
		<br/>
		
 	</div>
 	<!--  화면구성 div Start /////////////////////////////////////-->

</body>

</html>