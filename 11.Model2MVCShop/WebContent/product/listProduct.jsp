<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
     
    
    <c:if test="${wishSuccess eq 'success'}">
			<script type="text/javascript">
		alert("장바구니에 등록되었습니다.");
			</script>
			
 	</c:if>
 	<!--  ///////////////////////// JavaScript ////////////////////////// -->	
	<script type="text/javascript">
		
		var number = null;
	
		//=============    검색 / page 두가지 경우 모두  Event  처리 =============
		function fncGetList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/product/listProduct?searchSortPrice="+$("select[name='searchSortPrice']").val()+"&menu=${param.menu}").submit();
		}
		
		function fncPriceGetList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/product/listProduct?searchSortPrice="+$("select[name='searchSortPrice']").val()+"&menu=${param.menu}").submit();
		}
		
		
		//============= "검색"  Event  처리 =============	
		 $(function() {
			 //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 $( "button.btn.btn-default" ).on("click" , function() {
				fncGetList(1);
			});
			 
			//상품명 클릭시 getProduct
			  $("tbody tr td:nth-child(2)").on("click", function(){
				 console.log("히든1 : "+$(this).find('input').val());
				 console.log("히든2 : "+$($(this).find('input')[1]).val());
				 				 
				 self.location = "/product/getProduct?prodNo="+$(this).find('input').val()+"&menu="+$($(this).find('input')[1]).val();
			 }) 
			 
			 //상품명 마우스 접근시 툴팁표시
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
			 
			 
			 //물품 구별을 쉽게하기위한 삭선,색표시
			 $("tbody tr td:nth-child(2)").each(function(index){
				 number = index+parseInt('1');
			 if($($(this).find('input')[2]).val() != ''){   //현재 판매중이 아니면
				 if("${param.menu}" != "manage"){ //매니저가 아니면
				 	$(this).html('<del>'+$(this).html()+'</del>'); //삭선표시
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
				 if($($(this).find('input')[0]).val() != ''){   //현재 판매중이 아니면
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
			 
			 
			 //배송하기
			 $("tbody tr td:nth-child(6) span").on("click", function(){
				 console.log("히든1 : "+$(this).find('input').val());
				 self.location = "/purchase/updateTranCodeByProd?prodNo="+$(this).find('input').val()+"&tranCode=2";
		 	 })
			 
			 
			 //위시리스트 추가
			 $("tbody tr td:nth-child(7)").on("click", function(){
				 console.log("히든1 : "+$(this).find('input').val());
				 if($(this).find('input').val() != null){
				 	self.location = "/purchase/addWishPurchase?prodNo="+$(this).find('input').val();
				 }
			 })
			 
			 //상품명 이름 오토컴플릿
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
		
				//무한스크롤
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
																	searchC = '판매중';
																break;
																case '1' : 
																	searchC = '재고없음';
																case '2' : 
																	searchC = '재고없음';
																break;
																case '3' : 
																	searchC = '판매완료';
																break;
																}
															}
															if(searchC != null){
																all += searchC																										
															}
														if(menu == 'manage'){
															
															switch(product[i].tranStatusCode){
															
															case '1' :
																dlvy = '구매완료 / <span>배송하기<input type="hidden" value='+product[i].prodNo+'></span>';
																break;
															case '2' :
																dlvy = '배송중';
																break;
															case '3' :
																dlvy = '배송완료';
																break;
															default :
																dlvy = '판매중';
																break;
															}
														}
												if(dlvy != null){
													all += dlvy+'</td>'	
												}
												if(menu != null && menu != 'manage'){
													wishes = '<td align="center">';
														if(product[i].tranStatusCode != null){
															wishes += '장바구니 불가(재고X)';
														}
														if(product[i].tranStatusCode == null){
															wishes += '<input type="hidden" value='+product[i].prodNo+'>장바구니 담기';
														}
												all += wishes+'</td>'
												}
										+'</tr>'+
									'<tr>'+
										'<td colspan="11" bgcolor="D6D7D6" height="1"></td>'+
									'</tr>'	
									
									$("table.table tbody").html($("table.table tbody").html()+all);
									}
											
									//ajax 목록 링크 및 색 추가
									$("tbody tr:nth-child(2n+2)" ).css("background-color" , "PapayaWhip");
									//상품명 클릭시 getProduct
									  $("tbody tr td:nth-child(2)").on("click", function(){
										 console.log("히든1 : "+$(this).find('input').val());
										 console.log("히든2 : "+$($(this).find('input')[1]).val());
										 self.location = "/product/getProduct?prodNo="+$(this).find('input').val()+"&menu="+$($(this).find('input')[1]).val();
									 }) 
									 
									 //상품명 마우스 접근시 툴팁표시
									 $("tbody tr td:nth-child(2)").tooltip({
										
										items:'[data-photo]',
										content:function(){
												var photo = $(this).data('photo');
											 return '<img src=../images/uploadFiles/'+photo+'/>';
										 },
										 classes: { "ui-tooltip" : "highlight"},
										 show: { effect: "blind", duration: 500 }
									})
									 
									 
									 //물품 구별을 쉽게하기위한 삭선,색표시 (물품이름)
									 $("tbody tr td:nth-child(2)").each(function(index){
									 if($($(this).find('input')[2]).val() != ""){   //현재 판매중이 아니면
										 if(menu != 'manage'){ //매니저가 아니면
										 	$(this).html('<del>'+$(this).html()+'</del>'); //삭선표시
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
									 
									 
									 //물품 구별을 쉽게하기위한 색표시 (현재상태)
									 $("tbody tr td:nth-child(6)").each(function(index){
										 if($($(this).find('input')[0]).val() != "" ){//현재 판매중이 아니면
											 if(menu == 'manage'){
												switch($($(this).find('input')[0]).val()){
													case '1' : //구매자가 구매 누름 (배송 전)
													$(this).css("color" , "blue");
													break;
													case '2' : //배송하기 버튼 누름 (배송 중)
													$(this).css("color" , "green");
													break;
													case '3' : //구매자가 배송 확인 (배송 완료)
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
									 
									 
									 //배송하기
									 $("tbody tr td:nth-child(6) span").on("click", function(){
										 console.log("히든1 : "+$(this).find('input').val());
										 self.location = "/purchase/updateTranCodeByProd?prodNo="+$(this).find('input').val()+"&tranCode=2";
								 	 })
									 
									 
									 //위시리스트 추가
									 $("tbody tr td:nth-child(7)").on("click", function(){
										 console.log("히든1 : "+$(this).find('input').val());
										 if($(this).find('input').val() != null){
										 	self.location = "/purchase/addWishPurchase?prodNo="+$(this).find('input').val();
										 }
									 })
									//ajax 목록 링크 및 색 추가 끝
								}
						})//end ajax  
						console.log(page++);
					 }//end if문
				 }); 
				$("tbody tr:nth-child(2n+2)" ).css("background-color" , "PapayaWhip");
		 });
	
	</script>
	
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>${param.menu eq "search" ? "상품목록조회" : "상품 관리"}</h3>
	    </div>
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    		<c:if test="${param.menu eq 'manage' }">
						<div>
							<font color="black">■ 판매중&nbsp;</font>
							<font color="blue">■ 구매완료/배송하기&nbsp;</font>
							<font color="green">■ 배송중&nbsp;</font>
							<font color="red">■ 배송완료</font>
						</div>			
					</c:if>
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0" ${ !empty search.searchCondition && search.searchCondition eq 0 ? "selected" : "" }>상품명</option>
						<option value="1" ${ !empty search.searchCondition && search.searchCondition eq 1 ? "selected" : "" }>상품번호</option>
						<option value="2" ${ !empty search.searchCondition && search.searchCondition eq 2 ? "selected" : "" }>상품가격</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
        <thead>
          <tr>
            <th align="left">No</th>
            <th align="left" >상품명</th>
            <th align="left" width="4">
            	가격
            </th>
            <th align="left" width="150">
            		<select class="form-control" name="searchSortPrice" onchange="javascript:fncPriceGetList(1);" style="color:#8082F5;font-size:9pt">
						<option value="0" ${ !empty search.searchSortPrice && search.searchSortPrice eq 0 ? "selected" : "" }>전체 가격</option>
						<option value="1" ${ !empty search.searchSortPrice && search.searchSortPrice eq 1 ? "selected" : "" }>높은 가격순</option>
						<option value="2" ${ !empty search.searchSortPrice && search.searchSortPrice eq 2 ? "selected" : "" }>낮은 가격순</option>
					</select></th>
            <th align="left">등록일</th>
            <th align="left">현재상태</th>
            <c:if test="${!empty param.menu && param.menu ne 'manage' }">
            <th align="left">장바구니</th>
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
									판매중
								</c:when>
								<c:when test="${product.tranStatusCode <= 2 && product.tranStatusCode>=1 }">
									재고없음
								</c:when>
								<c:when test="${!empty product.tranStatusCode && product.tranStatusCode eq 3 }">
									판매완료
								</c:when>
							</c:choose>
							<c:if test="${product.tranStatusCode ne null ? '재고없음' : '판매중'}"></c:if>				
						</c:if>
						
						<c:if test="${!empty param.menu && param.menu eq 'manage' }">
							<c:choose>
								<c:when test="${product.tranStatusCode eq 1 }">
									구매완료 / <span>배송하기<input id="md" type="hidden" value=${product.prodNo }></span>
								</c:when>
								<c:when test="${product.tranStatusCode eq 2 }">
									배송중
								</c:when>
								<c:when test="${product.tranStatusCode eq 3 }">
									배송완료
								</c:when>
								<c:otherwise>
									판매중
								</c:otherwise>
							</c:choose>
						</c:if>
				</td>
				<c:if test="${!empty param.menu && param.menu ne 'manage' }">
				<td align="center">
					<c:if test="${product.tranStatusCode ne null}">
					장바구니 불가(재고X)
					</c:if>
					<c:if test="${product.tranStatusCode eq null}">
					<input type="hidden" value="${product.prodNo }" >
					장바구니 담기
					</c:if>
				</td>
				</c:if>	
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>