<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>


<div class="container">
	<h2>장바구니 주문</h2>
	<!-- 상품정보 -->
	<!-- 주문 상품수대로 for문 나오게 정보 들어가게 -->
	<div class="item">
	<table class="table">
   		 <thead class="thead-light">
		    <tr>
		      <th>#</th>
		      <th>제품명</th>
		      <th>제품가격</th>
		      <th>주문수량</th>
		      <th>합계</th>
		    </tr>
	  	</thead>
 		 <tbody>
   			 <c:forEach var="cartVO" items="${cartVO}" varStatus="status">
		        <tr>
		            <th>${status.count}</th>
		            <td>${cartVO.prod_name}</td>
		            <td><fmt:formatNumber pattern="###,###,###" value="${cartVO.prod_price}"/></td>
		            <td><fmt:formatNumber pattern="###,###,###" value="${cartVO.cart_quan}"/></td>
		            <td><fmt:formatNumber pattern="###,###,###" value="${cartVO.money}"/></td>
		        </tr>
 		    </c:forEach>
  		 </tbody>
    	 <tfoot>
    		<tr>
        		<td colspan="4"></td>
        		<td><fmt:formatNumber pattern="###,###,###" value="${totalPrice}"/></td>
   			</tr>
  		 </tfoot>
	</table>
	<!-- 상품정보 끝 -->
	<!-- 배송-사용자정보-주문버튼-->
	<div class="item">
	<!-- 사용자정보 폼 -->
	<div class="memberInfo">
		<ul>
			<li> 주문자 정보 </li> <!-- 수정안되게하기 뭔가 수정할 수 잇는 척 -->
			<li>이름 : <input type="text" name="mem_name" value="${memberVO.mem_name}"></li>
			<li>이메일 : <input type="text" name="email_name" value="${memberVO.email}"></li>
			<li>연락처 : <input type="text" name="phone_name" value="${memberVO.phone}"></li>
		</ul>
	</div>
	<!-- 사용자 정보 폼 끝 -->
	<!-- 배송정보 폼 -->
	<div class="ShippingInfo">
		<ul>
			<li> 수령인 정보</li>
			<li>받는 사람 <input type="text" name="Receiver_name" value="${memberVO.mem_name}"> </li>
			<li>연락처 <input type="text" name="Receiver_phone" value="${memberVO.phone}"> </li>
			<li>주소 <input type="text" name="order_zipcode" value="${memberVO.zipcode}"> </li>
			<li>주소1 <input type="text" name="order_address1" value="${memberVO.address1}"> </li>
			<li>주소2 <input type="text" name="order_address2" value="${memberVO.address2}"> </li>
		</ul>
	</div>
	<!-- 배송정보 폼 긑 -->
	<!-- 배송 - 사용자정보 폼 -->
	<!-- 배열로 cart_num을 넘겨줌 -->
	<div class="orderInfo">결제금액 ${cart.totalPrice}</div>
	<!-- 쿠폰정보 -->
	<div class="couponInfo">
		<div class="coupon-item">
			<ul>
			<li><h6>쿠폰사용</h6>
			<button class="btn btn-info" id="btn-coupon">보유쿠폰확인</button></li>
			<c:if test="${empty coupon_num}"><li>사용가능한 쿠폰이 존재하지 않습니다.</li></c:if>
			<c:if test="${empty coupon_num}">
			<c:forEach items="${couponVO}" var="couponVO">
			<li id="li-coupon-list">${coupon_name}<button data-coupon="N" data-serial="${coupon_num}">사용가능</button><li>
			</c:forEach>
			</c:if>
			<li><h6>포인트사용 ( 현재 포인트 : <span id="nowPoint" data-now-point="${memberVO.point}"><fmt:formatNumber pattern="###,###,###" value="${memberVO.point}"/> P</span>)</h6></li>
			<li><div>
				<button class="btn btn-outline-secondary" id="allPointBtn">전체사용</button>
				<input type="number" min="0" value="0" placeholder="0" id="pointInput" class="form-control text-end" style="color:#999;">
				<button class="btn btn-outline-secondary" id="confirmPointBtn">확인</button>
				<button class="btn btn-outline-secondary" id="cancelPointBtn">취소</button>
			</div></li>
			</ul>
			<div class="total" id="div-total" data-movie-price="${totalPrice}">
			<dl>
							<dt>상품금액</dt>
							<dd><fmt:formatNumber pattern="###,###,###" value="${totalPrice }"/>원</dd>
						</dl>
						<dl>
							<dt>쿠폰할인</dt>
							<dd><span>- </span><span id="coupon-money">0</span>원</dd>
						</dl>
						<dl>
							<dt>포인트할인</dt>
							<dd><span>- </span><span id="point-discount-money">0</span>원</dd>
						</dl>
						<dl>
							<dt>할인금액</dt>
							<dd><span>- </span><span id="discountPrice">0</span>원</dd>
						</dl>
						<dl>
							<dt>결제금액</dt>
							<dd id="dd-total-price"><span id="span-total-price"><fmt:formatNumber value="${tickets.totalPrice }"/></span>원</dd>
						</dl>
			</div>
		</div>	
	</div>
	<!-- 쿠폰정보 끝 -->
		<div class="payment-item">
	    <button type="button" id="btn-kakaopay" class="btn btn-info">카카오페이</button>
    	<button type="button" id="btn-inicis" class="btn btn-info">이니시스</button>
			<form action="complete" method="post" id="form-ordering">
			<input type="hidden" name="payment" value="" id="pay-ment">
			<input type="hidden" name="totalPrice" value="" id="pay-total-price">
			<input type="hidden" name="userId" value="" id="pay-user-id">
			<input type="hidden" name="usedPoint" value="" id="pay-user-point">
			<input type="hidden" name="serialNo" value="" id="pay-coupon-serial">				
			<input type="hidden" name="pay_price" value="${totalPrice}">
			<c:forEach var="cartVO" items="${cartVO}">
    		<input type="hidden" name="cart_num" value="${cartVO.cart_num}" />
			</c:forEach>
    		<input type="hidden" name="" value="${memberVO.mem_name}">
    		<input type="hidden" name="" value="${memberVO.email}">
    		<input type="hidden" name="" value="${memberVO.phone}">
    		<input type="hidden" name="" value="${memberVO.zipcode}">
    		<input type="hidden" name="" value="${memberVO.address1}">
    		<input type="hidden" name="" value="${memberVO.address2}">
			</form>
		</div>
	</div>
</div>
</div>


<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
    <script>
    //수령인 정보 되게 바꾸기
    
    var kakaopayment;
    $('#btn-kakaopay').click(function(){
        var IMP = window.IMP; 
        IMP.init("imp40494724"); 
        IMP.request_pay({
        	pg : "kakaopay", 
            pay_method : 'card',
            merchant_uid : 'merchant_' + new Date().getTime(),
            name : '매일의 집 결제',
            amount : ${totalPrice},
            buyer_email : '${memverVO.email}',
            buyer_name : '${memverVO.mem_name}',
            buyer_tel : '${memverVO.phone}',
            buyer_addr : '${memverVO.address1}',
            buyer_postcode : '${memverVO.zipcode}',
        }, function(rsp) {
            if ( rsp.success ) {
                //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
                jQuery.ajax({
                    url: "/payments/complete",
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        imp_uid : rsp.imp_uid
                    }
                }).done(function(data) {
                    //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                    if ( everythings_fine ) {
                        msg = '결제가 완료되었습니다.';
                        console.log(msg);
                        $('#pay_method').val(card);
                        $('#pay_type').val(kakaopayment);
                        $('#form_ordering').submit();
                    } else {
    	    			//[3] 아직 제대로 결제가 되지 않았습니다.
    	    			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
                    }
                });
                //결제완료 후 이동할 페이지 결제성공시 주문에 insert
                location.href="${pageContext.request.contextPath}/cart/payment.do";
            } else {
                var msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
                //실패시 이동할 페이지
                location.href="${pageContext.request.contextPath}/cart/cartList.do";
                alert(msg);
                
            }
        });
    });
	$('#btn-inicis').click(function(){       
        function inicis(){
       	    IMP.init("imp40494724");	
        	IMP.request_pay({
        	    pg : 'html5_inicis', //ActiveX 결제창은 inicis를 사용
        	    pay_method : inicisPayment, //card(신용카드), trans(실시간계좌이체), vbank(가상계좌), phone(휴대폰소액결제)
        	    merchant_uid : 'merchant_' + new Date().getTime(), //상점에서 관리하시는 고유 주문번호를 전달
        	    name : '매일의 집 결제',
        	    amount : totalPrice,
                buyer_email : '${memverVO.email}',
                buyer_name : '${memverVO.mem_name}',
                buyer_tel : '${memverVO.phone}',
                buyer_addr : '${memverVO.address1}',
                buyer_postcode : '${memverVO.zipcode}',
        	}, function(rsp) {
        	    if ( rsp.success ) {
        	    	//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
        	    	jQuery.ajax({
        	    		url: "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
        	    		type: 'POST',
        	    		dataType: 'json',
        	    		data: {
        		    		imp_uid : rsp.imp_uid
        		    		//기타 필요한 데이터가 있으면 추가 전달
        	    		}
        	    	}).done(function(data) {
        	    		//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
        	    		if ( everythings_fine ) {
        	    			var msg = '결제가 완료되었습니다.';
        	    			console.log(msg);
                            $('#pay_method').val(card);
                            $('#pay_type').val(simplePayment);
                            $('#form_ordering').submit();
        	    		} else {
        	    			//[3] 아직 제대로 결제가 되지 않았습니다.
        	    			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
        	    		}
        	    	});
                    location.href="${pageContext.request.contextPath}/cart/payment.do";
        	    } else {
                    var msg = '결제에 실패하였습니다.';
                    msg += '에러내용 : ' + rsp.error_msg;
                    //실패시 이동할 페이지
                    location.href="${pageContext.request.contextPath}/cart/cartList.do";
                    alert(msg);
        	    }
        	});
        }
    });
    </script>
<!-- 필요한거 목록 장바구니넘버, 멤버정보 , 총 카트 비용 계산, -->