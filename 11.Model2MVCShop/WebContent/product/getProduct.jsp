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
		
		$("button:contains('구매')").on("click",function(){
			
			self.location = "/purchase/addPurchase?prodNo="+$(this).val();
			
		})
		
		$("button:contains('이전')").on("click", function(){
			
			self.location = history.go(-1);
			
		})
		
		$("button:contains('확인')").on("click", function(){
			
			self.location = "/product/listProduct?menu=manage"
			
		})
		
		$('font').on("click", function(){
			alert("댓글이 삭제 되었습니다.");
			self.location = "/product/commentDelete?productCommentNo="+$(this).find("input").val()+"&prodNo=${product.prodNo}&menu=search"
			
		})
		
		$("button:contains('등록')").on("click", function(){
			$(self.location).attr("href","/product/getProduct?prodNo="
					+$("#no").val()+"&userComment="+encodeURI($(".form-control").val()));
		})
	})
		
	</script>
	
</head>

<body>
<!-- $(self.location).attr("href","/product/getProduct?prodNo="
					+$("#no").val()+"&userComment="+$(".form-control").val()); -->

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">제품 상세 조회</h3>
	       <h5 class="text-muted">제품 <strong class="text-danger">확인</strong></h5>
	    </div>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodNo}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품명</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품이미지</strong></div>
			<div class="col-xs-8 col-md-4"><img src = "/images/uploadFiles/${product.fileName}"></div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품상세정보</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodDetail }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>제조일자</strong></div>
			<div class="col-xs-8 col-md-4">${product.manuDate }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>가격</strong></div>
			<div class="col-xs-8 col-md-4">￦ ${product.price}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>등록일자</strong></div>
			<div class="col-xs-8 col-md-4">${user.regDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-md-12 text-center ">
		  		<c:if test="${param.comePath ne null || param.menu eq 'search'}">
						<c:choose>
							<c:when test="${param.comePath eq 'purchaser' && param.menu eq 'search' }">
							</c:when>
							<c:when test="${param.comePath eq 'saleList' && param.menu eq 'search' }">
							</c:when>
							<c:when test="${param.comePath eq null && param.menu eq 'search' }">
								<c:if test="${product.tranStatusCode > 0 ? false : true}">
						  			<button type="button" class="btn btn-primary" value="${product.prodNo}">구매</button>
						  			<button type="button" class="btn btn-primary">이전</button>
	  							</c:if>
						</c:when>
					</c:choose>
				</c:if>
	  		</div>
		</div>
		
 	</div>
 	
 	<div class="container">
			<div class="page-header text-info">
		       <h3>댓글목록</h3>
			    </div>
			<div>
				<div class="row">
		  				<div class="col-xs-2 col-md-2 "><strong>유저 아이디</strong></div>
						<div class="col-xs-8 col-md-4">댓글내용</div>
						<div class="col-xs-1 col-md-2">등록시간</div>
						<hr/>
		  		</div>
			</div>
			<c:set var="i" value="0"/>
			<c:forEach var="comments" items="${list}" >
				<c:set var="i" value="${i+1}"/>
				<div class="row">
					<div class="col-xs-2 col-md-2 "><strong>${comments.userId}</strong></div>
					<div class="col-xs-8 col-md-4">${comments.comments}</div>
					<div class="col-xs-1 col-md-2 ">${comments.regDate}</div>
					<div class="col-xs-1 col-md-4 right">
						<div class="row">
							<div class="col-xs-8"></div>
							<div class="col-xs-4">
								<c:if test="${user.userId eq comments.userId || user.userId eq 'admin' }">
								<font style="color:red;" id="delete">댓글삭제
								<input type="hidden" name="productCommentNo" value="${comments.productCommentNo}">
								</font>
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
			<div>
				<div class="row">
					<div class="col-xs-10"> 
						<div class="row">
							<div class="col-xs-2">
								댓글입력 :
							</div>
							<div class="col-xs-10">
								<input type="text" class="form-control" name="userComment" width="5px"
										style="background : #F0F8FF;">
							</div>
						</div>
					</div>
					<div class="col-xs-2">
								<input type="hidden" id="no" value="${product.prodNo}">
								<button type="button" class="btn btn-warning">등록</button>
					</div>
				</div>
			</div>
		</div>
</body>

</html>