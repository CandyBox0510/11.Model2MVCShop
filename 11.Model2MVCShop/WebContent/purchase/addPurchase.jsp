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
		
		$("button:contains('��ǰ')").on("click",function(){
			self.location = "/product/listProduct?menu=search"
		});
		
		$(".btn:contains('�����̷�')").on("click",function(){
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
						<i class="glyphicon glyphicon-circle-arrow-down"></i> ������ ���� ���Ű� �Ϸ�Ǿ����ϴ�.
         			</div>
         			<!--  ȸ������ ������ -->
					<ul class="list-group">
						 <li class="list-group-item">
						 	�� ǰ �� ȣ   : ${purchase.purchaseProd.prodNo }
						 </li>
						 <li class="list-group-item">
						 	������ ���̵� : ${purchase.buyer.userId }
						 </li>
						 <li class="list-group-item">
						 	�� �� �� ��   : ${purchase.paymentOption eq 1 ? '���ݱ���' : '�ſ뱸��' } 
						 </li>
						 <li class="list-group-item">
						 	������ �̸�   : ${purchase.receiverName } 
						 </li>
						 <li class="list-group-item">
						 	������ ����ó : ${purchase.receiverPhone }
						 </li>
						 <li class="list-group-item">
						 	������ �ּ�   : ${purchase.dlvyAddr }
						 </li>
						 <li class="list-group-item">
						 	���ſ�û����  : ${purchase.dlvyRequest }
						 </li>
						 <li class="list-group-item">
						 	����������  : ${purchase.dlvyDate }
						 </li>
					</ul>
		        </div>
		        
		      <div class="form-group">
				<div class="col-sm-offset-4  col-sm-4 text-center">
		     		<button type="button" class="btn btn-primary">��ǰ �� ����</button>
					<a class="btn btn-primary btn" href="#" role="button">�����̷� ����</a>
		    	</div>
		 	  </div>
</div>
</body>
</html>