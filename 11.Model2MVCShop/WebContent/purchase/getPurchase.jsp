<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


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
   <link href="/css/animate.min.css" rel="stylesheet">
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
		
		$("button:contains('구매취소')").on("click" , function(){
			self.location = "/purchase/cancelPurchase?tranNo="+$("input").val();
		})
		
		$(".btn:contains('수정')").on("click" , function(){
			self.location = "/purchase/updatePurchase?tranNo="+$("input").val()+"&prodNo="+${purchase.purchaseProd.prodNo}; 
		})
		
		$(".btn:contains('확인')").on("click" , function(){
			self.location = "/purchase/listPurchase";
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
	
		<input type="hidden" value=${param.tranNo }>
		
		<div class="page-header">
	       <h3 class=" text-info">구매 상세 조회</h3>
	       <h5 class="text-muted">구매하신 내역을 다시한번 <strong class="text-danger">확인</strong>!!</h5>
	    </div>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>물품번호</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.purchaseProd.prodNo }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매자아이디</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.buyer.userId }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매방법</strong></div>
			<div class="col-xs-8 col-md-4">
				<c:if test="${purchase.paymentOption eq 1}">
					현금구매
				</c:if>
				<c:if test="${purchase.paymentOption eq 2}">
					신용구매
				</c:if>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매자 이름</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.receiverName }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>구매자 연락처</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.receiverPhone }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매자 주소</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.dlvyAddr }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매자 요청사항</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.dlvyRequest }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>배송희망일</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.dlvyDate }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>주문일</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.orderDate }</div>
		</div>
		
		<hr/>
		
		<div class="form-group">
	  		<div class="col-md-12 text-center ">
	  			<button type="button" class="btn btn-danger">구매취소</button>
	  			<a class="btn btn-primary btn" href="#" role="button">수정</a>
	  			<a class="btn btn-primary btn" href="#" role="button">확인</a>
	  		</div>
		</div>
		
 	</div>
 	
</body>

</html>