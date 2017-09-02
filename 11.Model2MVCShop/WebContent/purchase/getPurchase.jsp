<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
		
		$("button:contains('�������')").on("click" , function(){
			self.location = "/purchase/cancelPurchase?tranNo="+$("input").val();
		})
		
		$(".btn:contains('����')").on("click" , function(){
			self.location = "/purchase/updatePurchase?tranNo="+$("input").val()+"&prodNo="+${purchase.purchaseProd.prodNo}; 
		})
		
		$(".btn:contains('Ȯ��')").on("click" , function(){
			self.location = "/purchase/listPurchase";
		})
		
	})

		
	</script>
	
</head>

<body>


	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<input type="hidden" value=${param.tranNo }>
		
		<div class="page-header">
	       <h3 class=" text-info">���� �� ��ȸ</h3>
	       <h5 class="text-muted">�����Ͻ� ������ �ٽ��ѹ� <strong class="text-danger">Ȯ��</strong>!!</h5>
	    </div>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��ǰ��ȣ</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.purchaseProd.prodNo }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�����ھ��̵�</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.buyer.userId }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>���Ź��</strong></div>
			<div class="col-xs-8 col-md-4">
				<c:if test="${purchase.paymentOption eq 1}">
					���ݱ���
				</c:if>
				<c:if test="${purchase.paymentOption eq 2}">
					�ſ뱸��
				</c:if>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>������ �̸�</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.receiverName }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>������ ����ó</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.receiverPhone }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>������ �ּ�</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.dlvyAddr }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>������ ��û����</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.dlvyRequest }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��������</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.dlvyDate }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�ֹ���</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.orderDate }</div>
		</div>
		
		<hr/>
		
		<div class="form-group">
	  		<div class="col-md-12 text-center ">
	  			<button type="button" class="btn btn-danger">�������</button>
	  			<a class="btn btn-primary btn" href="#" role="button">����</a>
	  			<a class="btn btn-primary btn" href="#" role="button">Ȯ��</a>
	  		</div>
		</div>
		
 	</div>
 	
</body>

</html>