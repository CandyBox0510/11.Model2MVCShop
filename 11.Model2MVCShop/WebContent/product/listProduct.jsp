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
    
     
    
    <c:if test="${wishSuccess eq 'success'}">
			<script type="text/javascript">
		alert("��ٱ��Ͽ� ��ϵǾ����ϴ�.");
			</script>
			
 	</c:if>
 	<!--  ///////////////////////// JavaScript ////////////////////////// -->	
	<script type="text/javascript">
		
		var number = null;
	
		//=============    �˻� / page �ΰ��� ��� ���  Event  ó�� =============
		function fncGetList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/product/listProduct?searchSortPrice="+$("select[name='searchSortPrice']").val()+"&menu=${param.menu}").submit();
		}
		
		function fncPriceGetList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/product/listProduct?searchSortPrice="+$("select[name='searchSortPrice']").val()+"&menu=${param.menu}").submit();
		}
		
		
		//============= "�˻�"  Event  ó�� =============	
		 $(function() {
			 //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 $( "button.btn.btn-default" ).on("click" , function() {
				fncGetList(1);
			});
			 
			//��ǰ�� Ŭ���� getProduct
			  $("tbody tr td:nth-child(2)").on("click", function(){
				 console.log("����1 : "+$(this).find('input').val());
				 console.log("����2 : "+$($(this).find('input')[1]).val());
				 				 
				 self.location = "/product/getProduct?prodNo="+$(this).find('input').val()+"&menu="+$($(this).find('input')[1]).val();
			 }) 
			 
			 //��ǰ�� ���콺 ���ٽ� ����ǥ��
			 $("tbody tr td:nth-child(2)").tooltip({
				
				items:'[data-photo]',
				content:function(){
						var photo = $(this).data('photo');
						if(photo == ''){
							return '<img src="http://placehold.it/200x150"/>';
						}else{
					 		return '<img src=../images/uploadFiles/'+photo+' style="width:300px; height:300px;"  />';
						}
				 },
				 show: { effect: "blind", duration: 500 },
				 fixedWidth : 250,
				 fixedHeight : 250
			})
			 
			 
			 //��ǰ ������ �����ϱ����� �輱,��ǥ��
			 $("tbody tr td:nth-child(2)").each(function(index){
				 number = index+parseInt('1');
			 if($($(this).find('input')[2]).val() != ''){   //���� �Ǹ����� �ƴϸ�
				 if("${param.menu}" != "manage"){ //�Ŵ����� �ƴϸ�
				 	$(this).html('<del>'+$(this).html()+'</del>'); //�輱ǥ��
				 }else{
					switch($($(this).find('input')[2]).val()){
						case '1' :
						$(this).css("color" , "blue");
						break;
						case '2' : 
						$(this).css("color" , "green");
						break;
						case '3' : 
						$(this).css("color" , "red");
						break;
						}
					 }
				 }
			 })
			 
			 $("tbody tr td:nth-child(6)").each(function(index){
				 if($($(this).find('input')[0]).val() != ''){   //���� �Ǹ����� �ƴϸ�
					 if("${param.menu}" == "manage"){
						switch($($(this).find('input')[0]).val()){
							case '1' :
							$(this).css("color" , "blue");
							break;
							case '2' : 
							$(this).css("color" , "green");
							break;
							case '3' : 
							$(this).css("color" , "red");
							break;
						}
					 }
				 }else{
					 if("${param.menu}" != "manage"){
					 	$(this).css("color","red");
					 }
				 }
		 	})
			 
			 
			 //����ϱ�
			 $("tbody tr td:nth-child(6) span").on("click", function(){
				 console.log("����1 : "+$(this).find('input').val());
				 self.location = "/purchase/updateTranCodeByProd?prodNo="+$(this).find('input').val()+"&tranCode=2";
		 	 })
			 
			 
			 //���ø���Ʈ �߰�
			 $("tbody tr td:nth-child(7)").on("click", function(){
				 console.log("����1 : "+$(this).find('input').val());
				 if($(this).find('input').val() != null){
				 	self.location = "/purchase/addWishPurchase?prodNo="+$(this).find('input').val();
				 }
			 })
			 
			 //��ǰ�� �̸� �������ø�
			 $( "input[name='searchKeyword']" ).autocomplete({
			
				source: function(request, response){
	
	           	 			$.ajax({
						
									async : false,
							
									method : "POST",
									
									url : "/product/json/autoListProduct/",
									
									headers : {
												"Accept" : "application/json",
												"Content-Type" : "application/json"
											   },
									
									data : JSON.stringify({
										
											name : encodeURIComponent(request.term)
											
											}),
									
									success : function(JSONData, status){
												 response(JSONData)
											  }
									})
	           			 }
	         	});
		
				//���ѽ�ũ��
				var page = 2;
				var searchC = null;
				var dlvy = null;
				var wishes = null;
				var tsc = null;
				var all = '';
				
				$( window ).scroll(function(){
					/* var menu = location.href.split("listProduct?menu=")[1]; */
					var menu = "${menu}";
					 if ($(window).scrollTop() == $(document).height() - $(window).height()){
						 $.ajax({
								url:"/product/json/listProduct",
								method:"POST",
								headers : {
										"Accept" : "application/json",
										"Content-Type" : "application/json"
								},
								data:JSON.stringify({
									currentPage : page
								}),
								
								success : function(JSONData, status){
										
											var product = JSONData.list;
											
											for(i in JSONData.list){
				
												number=number+parseInt('1');
												all = '<tr>'+
												'<td align="center">'+number+'</td>'+
												'<td align="left" data-photo='+product[i].fileName+'>'+
													'<input type="hidden" value='+product[i].prodNo+'>'+
													'<input type="hidden" value=search>'+
													'<input type="hidden" value='
													 tsc = product[i].tranStatusCode == null ? '' : product[i].tranStatusCode   
													 all += tsc +'>'+product[i].prodName+
												'</td>'+	
												'<td align="left">'+product[i].price+'</td>'+
												'<td align="left"></td>'+
												'<td align="left">'+product[i].regDate+'</td>'+
												'<td align="left">'+
														'<input type="hidden" value='+ tsc + '>'
															if(menu == 'search'){
																
																switch(product[i].tranStatusCode){
																case null :
																	searchC = '�Ǹ���';
																break;
																case '1' : 
																	searchC = '������';
																case '2' : 
																	searchC = '������';
																break;
																case '3' : 
																	searchC = '�ǸſϷ�';
																break;
																}
															}
															if(searchC != null){
																all += searchC																										
															}
														if(menu == 'manage'){
															
															switch(product[i].tranStatusCode){
															
															case '1' :
																dlvy = '���ſϷ� / <span>����ϱ�<input type="hidden" value='+product[i].prodNo+'></span>';
																break;
															case '2' :
																dlvy = '�����';
																break;
															case '3' :
																dlvy = '��ۿϷ�';
																break;
															default :
																dlvy = '�Ǹ���';
																break;
															}
														}
												if(dlvy != null){
													all += dlvy+'</td>'	
												}
												if(menu != null && menu != 'manage'){
													wishes = '<td align="center">';
														if(product[i].tranStatusCode != null){
															wishes += '��ٱ��� �Ұ�(���X)';
														}
														if(product[i].tranStatusCode == null){
															wishes += '<input type="hidden" value='+product[i].prodNo+'>��ٱ��� ���';
														}
												all += wishes+'</td>'
												}
										+'</tr>'+
									'<tr>'+
										'<td colspan="11" bgcolor="D6D7D6" height="1"></td>'+
									'</tr>'	
									
									$("table.table tbody").html($("table.table tbody").html()+all);
									}
											
									//ajax ��� ��ũ �� �� �߰�
									$("tbody tr:nth-child(2n+2)" ).css("background-color" , "PapayaWhip");
									//��ǰ�� Ŭ���� getProduct
									  $("tbody tr td:nth-child(2)").on("click", function(){
										 console.log("����1 : "+$(this).find('input').val());
										 console.log("����2 : "+$($(this).find('input')[1]).val());
										 self.location = "/product/getProduct?prodNo="+$(this).find('input').val()+"&menu="+$($(this).find('input')[1]).val();
									 }) 
									 
									 //��ǰ�� ���콺 ���ٽ� ����ǥ��
									 $("tbody tr td:nth-child(2)").tooltip({
										
										items:'[data-photo]',
										content:function(){
												var photo = $(this).data('photo');
											 return '<img src=../images/uploadFiles/'+photo+'/>';
										 },
										 classes: { "ui-tooltip" : "highlight"},
										 show: { effect: "blind", duration: 500 }
									})
									 
									 
									 //��ǰ ������ �����ϱ����� �輱,��ǥ�� (��ǰ�̸�)
									 $("tbody tr td:nth-child(2)").each(function(index){
									 if($($(this).find('input')[2]).val() != ""){   //���� �Ǹ����� �ƴϸ�
										 if(menu != 'manage'){ //�Ŵ����� �ƴϸ�
										 	$(this).html('<del>'+$(this).html()+'</del>'); //�輱ǥ��
										 }else{
											switch($($(this).find('input')[2]).val()){
												case '1' :
												$(this).css("color" , "blue");
												break;
												case '2' : 
												$(this).css("color" , "green");
												break;
												case '3' : 
												$(this).css("color" , "red");
												break;
												}
											 }
										 }
									 })
									 
									 
									 //��ǰ ������ �����ϱ����� ��ǥ�� (�������)
									 $("tbody tr td:nth-child(6)").each(function(index){
										 if($($(this).find('input')[0]).val() != "" ){//���� �Ǹ����� �ƴϸ�
											 if(menu == 'manage'){
												switch($($(this).find('input')[0]).val()){
													case '1' : //�����ڰ� ���� ���� (��� ��)
													$(this).css("color" , "blue");
													break;
													case '2' : //����ϱ� ��ư ���� (��� ��)
													$(this).css("color" , "green");
													break;
													case '3' : //�����ڰ� ��� Ȯ�� (��� �Ϸ�)
													$(this).css("color" , "red");
													break;
												}
											 }
										 }else{
											 if(menu != "manage"){
											 	$(this).css("color","red");
											 }
										 }
								 	})
									 
									 
									 //����ϱ�
									 $("tbody tr td:nth-child(6) span").on("click", function(){
										 console.log("����1 : "+$(this).find('input').val());
										 self.location = "/purchase/updateTranCodeByProd?prodNo="+$(this).find('input').val()+"&tranCode=2";
								 	 })
									 
									 
									 //���ø���Ʈ �߰�
									 $("tbody tr td:nth-child(7)").on("click", function(){
										 console.log("����1 : "+$(this).find('input').val());
										 if($(this).find('input').val() != null){
										 	self.location = "/purchase/addWishPurchase?prodNo="+$(this).find('input').val();
										 }
									 })
									//ajax ��� ��ũ �� �� �߰� ��
								}
						})//end ajax  
						console.log(page++);
					 }//end if��
				 }); 
				$("tbody tr:nth-child(2n+2)" ).css("background-color" , "PapayaWhip");
		 });
	
	</script>
	
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>${param.menu eq "search" ? "��ǰ�����ȸ" : "��ǰ ����"}</h3>
	    </div>
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    		<c:if test="${param.menu eq 'manage' }">
						<div>
							<font color="black">�� �Ǹ���&nbsp;</font>
							<font color="blue">�� ���ſϷ�/����ϱ�&nbsp;</font>
							<font color="green">�� �����&nbsp;</font>
							<font color="red">�� ��ۿϷ�</font>
						</div>			
					</c:if>
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0" ${ !empty search.searchCondition && search.searchCondition eq 0 ? "selected" : "" }>��ǰ��</option>
						<option value="1" ${ !empty search.searchCondition && search.searchCondition eq 1 ? "selected" : "" }>��ǰ��ȣ</option>
						<option value="2" ${ !empty search.searchCondition && search.searchCondition eq 2 ? "selected" : "" }>��ǰ����</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table ���� �˻� Start /////////////////////////////////////-->
		
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
        <thead>
          <tr>
            <th align="left">No</th>
            <th align="left" >��ǰ��</th>
            <th align="left" width="4">
            	����
            </th>
            <th align="left" width="150">
            		<select class="form-control" name="searchSortPrice" onchange="javascript:fncPriceGetList(1);" style="color:#8082F5;font-size:9pt">
						<option value="0" ${ !empty search.searchSortPrice && search.searchSortPrice eq 0 ? "selected" : "" }>��ü ����</option>
						<option value="1" ${ !empty search.searchSortPrice && search.searchSortPrice eq 1 ? "selected" : "" }>���� ���ݼ�</option>
						<option value="2" ${ !empty search.searchSortPrice && search.searchSortPrice eq 2 ? "selected" : "" }>���� ���ݼ�</option>
					</select></th>
            <th align="left">�����</th>
            <th align="left">�������</th>
            <c:if test="${!empty param.menu && param.menu ne 'manage' }">
            <th align="left">��ٱ���</th>
            </c:if>
			<c:if test="${!empty param.menu && param.menu eq 'manage' }">
			<th></th>
			</c:if>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="product" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left" data-photo="${product.fileName }">
					<input type="hidden" value="${product.prodNo}">
					<input type="hidden" value="${param.menu}">
					<input type="hidden" value="${product.tranStatusCode }">
					${product.prodName }
			  </td>	
			  <td align="left">${product.price }</td>
			  <td align="left"></td>
			  <td align="left">${product.regDate }</td>
			  <td align="left">
						<input type="hidden" value="${product.tranStatusCode }">
						<c:if test="${!empty param.menu && param.menu eq 'search'}">		
							<c:choose>
								<c:when test="${product.tranStatusCode eq null }">
									�Ǹ���
								</c:when>
								<c:when test="${product.tranStatusCode <= 2 && product.tranStatusCode>=1 }">
									������
								</c:when>
								<c:when test="${!empty product.tranStatusCode && product.tranStatusCode eq 3 }">
									�ǸſϷ�
								</c:when>
							</c:choose>
							<c:if test="${product.tranStatusCode ne null ? '������' : '�Ǹ���'}"></c:if>				
						</c:if>
						
						<c:if test="${!empty param.menu && param.menu eq 'manage' }">
							<c:choose>
								<c:when test="${product.tranStatusCode eq 1 }">
									���ſϷ� / <span>����ϱ�<input id="md" type="hidden" value=${product.prodNo }></span>
								</c:when>
								<c:when test="${product.tranStatusCode eq 2 }">
									�����
								</c:when>
								<c:when test="${product.tranStatusCode eq 3 }">
									��ۿϷ�
								</c:when>
								<c:otherwise>
									�Ǹ���
								</c:otherwise>
							</c:choose>
						</c:if>
				</td>
				<c:if test="${!empty param.menu && param.menu ne 'manage' }">
				<td align="center">
					<c:if test="${product.tranStatusCode ne null}">
					��ٱ��� �Ұ�(���X)
					</c:if>
					<c:if test="${product.tranStatusCode eq null}">
					<input type="hidden" value="${product.prodNo }" >
					��ٱ��� ���
					</c:if>
				</td>
				</c:if>	
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