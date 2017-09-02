<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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
   
   
   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	function fncGetList(currentPage) {
		$('#currentPage').val(currentPage)
		$('form').attr("method","POST").attr("action","/purchase/listPurchase").submit();
	}
	
	$(function(){
		
		$("tr.ct_list_pop td:nth-child(1)").on("click" , function(){
			var url = $(this).find("input").val();
			if(url!=null){
				self.location = url;
			}
		})
		
		$("tr.ct_list_pop td:nth-child(2)").on("click" , function(){
			var url = $(this).find("input").val();
			if(url!=null){
				self.location = url;
			}
		})
		
		$("tr.ct_list_pop td:nth-child(6)").on("click" , function(){
			var url = $(this).find("input").val();
			if(url!=null){
				self.location = url;
			}
		})
		
		$(".ct_list_pop:nth-child(2n+2)").css("background-color" , "PapayaWhip");
			
	})
	
	</script>
	
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>���� ���� ���</h3>
	    </div>
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table ���� �˻� Start /////////////////////////////////////-->
		
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >��ǰ��</th>
            <th align="left">ȸ����</th>
            <th align="left">��ȭ��ȣ</th>
            <th align="left">�����Ȳ</th>
            <th align="left">��������</th>
          </tr>
        </thead>
       
		<tbody>
		
		 <c:set var="i" value="0"/>
		<c:forEach var="purchase" items="${list }">
			<c:set var="i" value="${i+1 }"/>
			<tr class="ct_list_pop">
				<td align="center" title="[Click]���ſϷ�� ���� ���� / ������� ���� �Ұ�">
					${i}
					<c:if test="${purchase.tranCode eq 1 }">
					<input type="hidden" value="/purchase/getPurchase?tranNo=${purchase.tranNo }"> 
					</c:if>
				</td>
				<td align="left">
					${purchase.purchaseProd.prodName }
					<input type="hidden" value="/product/getProduct?&comePath=purchaser&menu=search&prodNo=${purchase.purchaseProd.prodNo }">
				</td>
				<td align="left">${user.userName }</td>
				<td align="left">${user.phone }</td>
				<td align="left">����
							<c:choose>
							<c:when test="${! empty purchase.tranCode && purchase.tranCode eq 1}">
								���ſϷ�
							</c:when>
							<c:when test="${! empty purchase.tranCode && purchase.tranCode eq 2}">
								�����
							</c:when>
							<c:when test="${! empty purchase.tranCode && purchase.tranCode eq 3}">
								��ۿϷ�
							</c:when>
						</c:choose>
							<!-- ${purchase.tranCode} -->
						���� �Դϴ�.</td>
				<td align="left">	
				<c:if test="${! empty purchase.tranCode && purchase.tranCode eq 2}">
				���ǵ���
				<input type="hidden" value="/purchase/updateTranCode?tranNo=${purchase.tranNo }&tranCode=3">
				</c:if>
				</td>
			</tr>
	</c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>