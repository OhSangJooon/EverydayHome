<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 
 * 작성일 : 2021. 10. 18.
 * 작성자 : 오상준
 * 설명 : 전체회원조회
 * 수정일 : 
--%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"><script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type ="text/javascript">
	$(document).ready(function() {
		$('input[type=checkbox]:checked').prop("checked", false);
		
		$('#stop_btn').click(function() {
		   	var output = '';
		   
			$('input[type=checkbox]:checked').each(function(index,item){
			    if(index !=0 ){
			    	output += ',';
			    }
					output += $(this).val();
			  	});
			
			  	var cnt = 0;
			  	cnt = output;
		      	if(cnt == 0){
		         	 alert("선택한 회원이 없습니다!");
		         	 return false;
		      	}else{
		    		if(confirm("선택한 회원의 권한을 변경 하시겠습니까?")){
			    
						$.ajax({
							url: 'stopAdminMember.do',
						   	type: 'post',
						   	data: {output : output},
						   	dataType : 'json',
							cache : false,
							timeout : 30000,
						    success: function(param) {
						    	alert('변경 완료!');
						    	location.reload();
						    	$('input[type=checkbox]:checked').prop("checked", false);
						    },
						    error : function() {
						    	alert('네트워크 오류!');
						    }
						});
		    		}else {
		    			$('input[type=checkbox]:checked').prop("checked", false);
		    		}
		    	}
		});
		
		$('#up_btn').click(function() {
		   	var output = '';
		   
			$('input[type=checkbox]:checked').each(function(index,item){
			    if(index !=0 ){
			    	output += ',';
			    }
					output += $(this).val();
			  	});
			    
				var cnt = 0;
			  	cnt = output;
		      	if(cnt == 0){
		         	 alert("선택한 회원이 없습니다!");
		         	 return false;
		      	}else{
		    		if(confirm("선택한 회원의 권한을 변경 하시겠습니까?")){
			   
						$.ajax({
							url: 'upAdminMember.do',
						   	type: 'post',
						   	data: {output : output},
						   	dataType : 'json',
							cache : false,
							timeout : 30000,
						    success: function(param) {
						    	alert('변경 완료!');
						    	location.reload();
						    	$('input[type=checkbox]:checked').prop("checked", false);
						    },
						    error : function() {
						    	alert('네트워크 오류!');
						    }
						});
		    		}else {
		    			$('input[type=checkbox]:checked').prop("checked", false);
		    		}
		      	}
		});
		
		$('#seller_btn').click(function() {
		   	var output = '';
		   
			$('input[type=checkbox]:checked').each(function(index,item){
			    if(index !=0 ){
			    	output += ',';
			    }
					output += $(this).val();
			  	});
			    
				var cnt = 0;
			  	cnt = output;
		      	if(cnt == 0){
		         	 alert("선택한 회원이 없습니다!");
		         	 return false;
		      	}else{
		    		if(confirm("선택한 회원의 권한을 변경 하시겠습니까?")){
			   
						$.ajax({
							url: 'upSellerMember.do',
						   	type: 'post',
						   	data: {output : output},
						   	dataType : 'json',
							cache : false,
							timeout : 30000,
						    success: function(param) {
						    	alert('변경 완료!');
						    	location.reload();
						    	$('input[type=checkbox]:checked').prop("checked", false);
						    },
						    error : function() {
						    	alert('네트워크 오류!');
						    }
						});
		    		}else {
		    			$('input[type=checkbox]:checked').prop("checked", false);
		    		}
		      	}
		});
		
		$('#delete_btn').click(function() {
		   	var output = '';
		   
			$('input[type=checkbox]:checked').each(function(index,item){
			    if(index !=0 ){
			    	output += ',';
			    }
					output += $(this).val();
			  	});
				var cnt = 0;
		  		cnt = output;
	      		if(cnt == 0){
	         		alert("선택한 회원이 없습니다!");
	         		return false;
	      		}else{
	    			if(confirm("선택한 회원의 권한을 변경 하시겠습니까?")){
		   
						$.ajax({
							url: 'deleteAdminMember.do',
						   	type: 'post',
						   	data: {output : output},
						   	dataType : 'json',
							cache : false,
							timeout : 30000,
						    success: function(param) {
						    	alert('변경 완료!');
						    	location.reload();
						    	$('input[type=checkbox]:checked').prop("checked", false);
						    },
						    error : function() {
						    	alert('네트워크 오류!');
						    }
						});
	    			}else {
	    				$('input[type=checkbox]:checked').prop("checked", false);
	    			}
	    		}
		});
		
		$('#search_form').submit(function() {
			if($('#keyword').val().trim() == '') {
				alert('검색어를 입력하세요!');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
	
</script>

<c:if test="${!empty user_num && user_auth == 4}">
<div class = "container-fluid contents-wrap" style = "width:90%">
	<div class="text-center col-sm-30 my-5">
		<div align = "left">
			<h2 class="admin-page-h2">관리자 페이지</h2>
		</div>
	<c:if test = "${count == 0}">
	<div class = "text-center">
		회원 가입한 회원이 없습니다.
	</div>
	</c:if>
	<c:if test = "${count > 0}">
		<div class = "text-right">
			<input type = "button" class = "btn btn-outline-dark" value = "뒤로 가기" onclick = "location.href='myPage.do'">
			<input type = "button" class = "btn btn-outline-dark" value = "홈으로" onclick = "location.href='${pageContext.request.contextPath}/main/main.do'"> 
			<input type = "button" class = "btn btn-outline-dark" value = "회원 정지" id = "stop_btn">
			<input type = "button" class = "btn btn-outline-dark" value = "일반회원 등급변경" id = "up_btn">
			<input type = "button" class = "btn btn-outline-dark" value = "판매자 등급변경" id = "seller_btn">
			<input type = "button" class = "btn btn-outline-dark" value = "회원 탈퇴" id = "delete_btn"> 
		</div>
		<br>
	<table class="table table-sm">
			<tr>
				<th scope="col">회원 번호</th>
				<th scope="col">아이디</th>
				<th scope="col">이름</th>
				<th scope="col">이메일</th>
				<th scope="col">전화번호</th>
				<th scope="col">우편번호</th>
				<th scope="col">주소</th>
				<th scope="col">상세주소</th>
				<th scope="col">가입일</th>
				<th scope="col">회원 등급</th>
				<th scope="col">선택</th>
			</tr>
			<c:forEach var = "member" items = "${list}">
			<tr>
				<th scope = "row">${member.mem_num}</th>
				<td>${member.mem_id}</td>
				<td>${member.mem_name}</td>
				<td>${member.email}</td>
				<td>${member.phone}</td>
				<td>${member.zipcode}</td>
				<td>${member.address1}</td>
				<td>${member.address2}</td>
				<td>${member.reg_date}</td>
				<td>
					<c:if test="${member.mem_auth == 0}">탈퇴회원</c:if>
				    <c:if test="${member.mem_auth == 1}">정지회원</c:if>
				    <c:if test="${member.mem_auth == 2}">일반회원</c:if>
				    <c:if test="${member.mem_auth == 3}">판매회원</c:if>
				    <c:if test="${member.mem_auth == 4}">관리자</c:if>
				</td>
				<td>
				    <c:if test="${member.mem_auth != 4 && member.mem_auth != 0}">
				    	<input type = "checkbox" aria-label="Checkbox for following text input" value = "${member.mem_num}">
				    </c:if>
				</td>
			</tr>
			</c:forEach>
		</table>
		<div align = "center">
			${pagingHtml}
		</div>
	</c:if>
	</div>
	<div align="center" style="background-color: #f5f5ff; width :100%; height: 100%;">
	<br>  
	<form action="adminMemberView.do" method="get" id="search_form">
		<select name="keyfield">
			<option value="1">아이디</option>
			<option value="2">이름</option>
			<option value="3">이메일</option>
		</select>
		<input type="search" name="keyword" id = "keyword" style="height: 28px;" placeholder="검색어를 입력하세요.">
		<input type="submit" value="검색">
	</form>
		<br>
	</div>
</div>
	
</c:if>



<%-- 비정상적인 접근 --%>
<c:if test="${empty user_num || user_auth != 4}">
	<h1>관리자만 접근할 수 있습니다.</h1>
	<script type="text/javascript">
	$(function(){
		alert("관리자만 접근할 수 있습니다.");
		location.href="${pageContext.request.contextPath}/main/main.do";
	});
	</script>
</c:if>