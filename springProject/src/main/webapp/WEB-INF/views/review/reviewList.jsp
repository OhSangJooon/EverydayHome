<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<%@ include file="/WEB-INF/views/member/common/myPageHeader.jsp" %>
<style>
.name-item{
	align-items: center;
}
.cart-container{
width:1136px;
margin : 0 auto;
}
.link-item{
margin: 0 auto;
width : 100%;
}
.container{
margin : 0 auto;
width:1138px;
}
.link-item{
	border-bottom : 1px solid #dbdbdb;
	width : 900px;
	margin : 0 auto;
}
.title{
	font-size:18px;
	weight:800;
	padding: 0x 10px 0px 10px;
	text-align:left;

}
.reg_date{
	font-size:15px;
	padding: 0px 10px 20px 10px;
	text-align:right;
}
.paging {
	text-align:center;
	padding : 50px;
	margin-top : 40px;
}
h2{
	text-align:left;
	margin : 70px 0px 50px 130px;
}
.write-button{
	text-align: right;
	margin : 40px 100px 0px 30px;
}
</style>
<!-- 제품정보도 받아올 수 있도록 sql수정하기 -->
<div class="container-fluid">
 <div class="main-container">
 	<div class="name-item">
 	<h2 style="font-family: 'Gowun Dodum', sans-serif;">내가 쓴 리뷰 목록</h2>
 	</div>
 	<div class="cart-container">
 	<c:if test="${count==0}">
 		<div class="link-item" style="font-family: 'Gowun Dodum', sans-serif;">작성한 리뷰가 없습니다.</div>
 	</c:if>
 	<c:if test="${count>0}">
 		<c:forEach var="list" items="${list}" varStatus="n">
 		<input type = "hidden" name="mem_num" value = "${mem_num}">
		<input type = "hidden" name="prod_num" value = "${prod_num}">
 		<div class="link-item" onclick="#">
 		<div class="content" style="font-size:12px;"> ${list.buis_name}</div>
 		<div class="title"> ${list.prod_name}</div><br>
		<div class="rating">별점 : <c:forEach var="var" items="${ratingOptions}" varStatus="status" begin="1" end="${list.rev_grade}">★</c:forEach></div>
 		<div class="content">${list.rev_content}</div>
 		<input type="hidden" name="prod_num"value="${list.prod_num}"/>
 		<c:if test="${!empty list.rev_filename}">
 		<div class="file-item mt-4 mb-4" style="text-align:center">
		<img src="imageView.do?rev_num=${list.rev_num}" style="max-width:500px">
		</div>
 		</c:if>
 		<div class="reg_date">
 		<a href="${pageContext.request.contextPath}/review/reviewUpdate.do?rev_num=${list.rev_num}" onclick="return confirm('리뷰를 수정하시겠습니까?');">수정</a><br>
 		<a href="${pageContext.request.contextPath}/review/reviewDelete.do?rev_num=${list.rev_num}" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
		</div>
 		</div>
 		</c:forEach>
 	</c:if>
	</div>

</div>
</div>