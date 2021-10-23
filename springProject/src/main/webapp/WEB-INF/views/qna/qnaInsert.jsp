<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 
 * 작성일 : 2021. 10. 11.
 * 작성자 : 나윤경
 * 설명 : Qna 자주묻는질문 글쓰기 폼
 * 수정일 : 
--%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		$('#qnaInsertForm').submit(function(){
			if(confirm("등록하시겠습니까?")){
				if($('#qna_content').val().trim()==''){
					$('#qna_content').val('').focus();
					alert("질문내용을 입력해주세요!");
					return false;
				}
				if($('#qna_reply').val().trim()==''){
					$('#qna_reply').val('').focus();
					alert("답변내용을 입력해주세요!");
					return false;
				}
			}else{
				alert("취소되었습니다.");
				return false;
			}
		});

	});
</script>
<script type="text/javascript">
	var submit = document.getElementById('submit');
	submit.onclick = function() {
		var choice = confirm('글 등록을 하시겠습니까?');
		if(choice) {
			alert('등록이 완료되었습니다.');
		}
	};
</script>
<div class = "container-fluid contents-wrap" style = "width:95%">
   <div class="text-center col-sm-30 my-5">

<hr noshade="noshade" size="2">
<div align = "left">
	<h2 class="admin-page-h2">관리자 - 자주묻는질문 등록</h2>
</div>
	
		<div align="center" class = "container-fluid" style = "width:700px; border: 1px solid #d2f1f7; font-family: 'Gowun Dodum', sans-serif; ">
			<div class="text-center col-sm-12 my-5">
			<form:form id="qnaInsertForm" action="qnaInsert.do" modelAttribute="qnaVO">
				<div style="flex: auto;" class="input-group-prepend col-xs-2">
					<label class="input-group-text" for="qna_category" >카테고리</label>
					<select class="custom-select form-select-lg col-sm-3" name="qna_category" id="qna_category">
						<option value="주문/결제">주문/결제</option>
						<option value="배송관련">배송관련</option>
						<option value="취소/환불">취소/환불</option>
						<option value="반품/교환">반품/교환</option>
						<option value="증빙서류발급">증빙서류발급</option>
						<option value="회원정보변경">회원정보변경</option>
						<option value="서비스/기타">서비스/기타</option>
					</select>
				</div>
				<div style="display: inline-block;"><hr size="1" noshade="noshade"></div>
				<div class = "form-group row">		
					<label class = "col-sm-3 col-form-label" for="qna_content">질문내용</label>
					<form:textarea path="qna_content"/>
				</div>
				<div class = "form-group row">		
					<label class = "col-sm-3 col-form-label" for="qna_reply">답변내용</label>
					<form:textarea path="qna_reply"/>
				</div>
				<!-- 버튼 -->
				<div class="align-center">
					<input class = "btn btn-outline-dark" type="submit" value="등록">
					<input class = "btn btn-outline-dark" type="button" value="홈으로" onclick="location.href='qnaList.do'">
				</div>
			</form:form>
		</div>
		</div>
	</div>
</div>		
