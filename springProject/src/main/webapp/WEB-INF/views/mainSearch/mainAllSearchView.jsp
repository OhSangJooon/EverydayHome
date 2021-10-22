<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 
 * 작성일 : 2021. 10. 22.
 * 작성자 : 오상준
 * 설명 : 통합검색 출력
 * 수정일 : 
--%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<div align = "left">
			<h2 class="admin-page-h2" style="float: left;">분류 : ${keyfield}</h2>
			<h3 class="admin-page-h3"><span style="color: red;">'${keyword}'</span> 의 통합검색 결과</h3><br>
			
</div>
<div class = "container-fluid contents-wrap" style = "width:99%">
		<div class="text-center col-sm-10 my-5" style="float: right;">
		<%-- 카드시작 --%>
		<div class="row my-5 ml-5 mr-5" align="center">
		<%-- 등록된 게시물이 없는 경우 --%>
		<c:if test="${houseCount == 0}">
			<div class="result-display">
				등록된 게시물이 없습니다.
			</div>
		</c:if>
		<%-- 등록된 게시물이 있는 경우 --%>
		<c:if test="${houseCount > 0}">
			<!-- 반복문 시작 -->
			<c:forEach var="houseBoard" items="${houseList}">
				<div class="col-3">
					<div class="card" style="height: 465px; width: 220px;">
			            <div class="card-header">
			            	<div style="float: left; cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/member/myPage.do'">
				         		<%-- 회원 프로필 사진이 없는 경우 --%>
								<c:if test="${empty houseBoard.profile_filename }">
									<img src="${pageContext.request.contextPath }/resources/images/basic.jpg" width="33" height="33" class="my-photo">
								</c:if>
								<%-- 회원 프로필 사진이 있는 경우 --%>
								<c:if test="${!empty houseBoard.profile_filename }">
									<img src="${pageContext.request.contextPath }/member/boardPhotoView.do?mem_num=${houseBoard.mem_num}" width="33" height="33" class="my-photo">
								</c:if>
								  <b style="font-size: 17px">${ houseBoard.nickname }</b>
			            	</div>
			            </div>
			           
			            <div class="card-body">
				            <div align="center" style="cursor: pointer;"  onclick="location.href='${pageContext.request.contextPath}/houseBoard/detail.do?house_num=${houseBoard.house_num}'">
					            <%-- 사진파일이 없는 경우 --%>
					            <c:if test="${ empty houseBoard.thumbnail_filename }">
					            	<img src="${pageContext.request.contextPath}/resources/images/basic.jpg" style="height: 270px; width: 175px;" />
					            </c:if>
					            <%-- 사진파일이 있는 경우 --%>
					            <c:if test="${!empty houseBoard.thumbnail_filename }">
					            	<img src="${pageContext.request.contextPath}/member/thumbnailPhotoView.do?house_num=${houseBoard.house_num}" style="height: 270px; width: 175px;" />
					            </c:if>
				            </div>
				           <div class="box">  
				           <br> 
				          
				              <div class="content">
				              		<h5 class="card-title"><a href="${pageContext.request.contextPath}/houseBoard/detail.do?house_num=${houseBoard.house_num}" class="btn btn-outline-dark">${ houseBoard.house_title }</a></h5>
				              </div>
				           </div>
			           <br>
		            </div>
		          </div>
				</div>
			</c:forEach>
			<!-- 반복문 끝 -->
		</c:if>
		<!-- 카드 끝 -->
	</div>
	<div class="align-center">${housePagingHtml}</div>
</div>
</div>
<!-- 중앙 내용 끝 --> 