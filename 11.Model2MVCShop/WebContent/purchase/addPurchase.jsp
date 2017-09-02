<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>


<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
       body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 100px;
            padding: 50px;
        }
    </style>
	
	<script type="text/javascript">
	
	
	$(function(){
		
		$("button:contains('상품')").on("click",function(){
			self.location = "/product/listProduct?menu=search"
		});
		
		$(".btn:contains('구매이력')").on("click",function(){
			self.location = "/purchase/listPurchase"
		});
	})
		
		
	</script>	

</head>

</head>

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

<div class="container">

				<div class="panel panel-primary">
					<div class="panel-heading">
						<i class="glyphicon glyphicon-circle-arrow-down"></i> 다음과 같이 구매가 완료되었습니다.
         			</div>
         			<!--  회원관리 아이템 -->
					<ul class="list-group">
						 <li class="list-group-item">
						 	물 품 번 호   : ${purchase.purchaseProd.prodNo }
						 </li>
						 <li class="list-group-item">
						 	구매자 아이디 : ${purchase.buyer.userId }
						 </li>
						 <li class="list-group-item">
						 	구 매 방 법   : ${purchase.paymentOption eq 1 ? '현금구매' : '신용구매' } 
						 </li>
						 <li class="list-group-item">
						 	구매자 이름   : ${purchase.receiverName } 
						 </li>
						 <li class="list-group-item">
						 	구매자 연락처 : ${purchase.receiverPhone }
						 </li>
						 <li class="list-group-item">
						 	구매자 주소   : ${purchase.dlvyAddr }
						 </li>
						 <li class="list-group-item">
						 	구매요청사항  : ${purchase.dlvyRequest }
						 </li>
						 <li class="list-group-item">
						 	배송희망일자  : ${purchase.dlvyDate }
						 </li>
					</ul>
		        </div>
		        
		      <div class="form-group">
				<div class="col-sm-offset-4  col-sm-4 text-center">
		     		<button type="button" class="btn btn-primary">상품 더 보기</button>
					<a class="btn btn-primary btn" href="#" role="button">구매이력 보기</a>
		    	</div>
		 	  </div>
</div>
</body>
</html>