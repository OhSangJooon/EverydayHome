<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- 
 * 작성일 : 2021. 10. 8.
 * 작성자 : 오상준
 * 설명 : 사이트 회원가입 폼 작성
 * 수정일 : 
--%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	$(function() {
		
		var checkID = 0;
		
		// 아이디 중복체크
		$("#confirmId").click(function(){
			if($('#mem_id').val().trim()==''){
				$('#message_id').css('color','red').text('아이디를 입력하세요!');
				$('#mem_id').val('').focus();//공백이 있으면 공백을 지우고 포커스를 줌
				return;
			}
			$.ajax({
				url:'confirmId.do',
				type:'post',
				data:{mem_id:$('#mem_id').val()},
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){
					if(param.result == 'idNotFound'){
						$('#message_id').css('color','#000').text('등록가능ID');
						checkId = 1;
					}else if(param.result == 'idDuplicated'){
						$('#message_id').css('color','red').text('중복된 ID');
						$('#mem_id').val('').focus();
						checkId = 0;
					}else if(param.result == 'notMatchPattern'){
						$('#message_id').css('color','red').text('영문,숫자 4자이상 12자이하 입력');
						$('#mem_id').val('').focus();
						checkId = 0;
					}else{
						checkId = 0;
						alert('ID중복체크 오류');
					}
				},
				error : function(request,status,error){      // 에러메세지 반환
		               alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);
		            }
			}); //end if ajax
		}); //end if click
		
		
		//아이디 중복 안내 메시지 초기화 및 아이디 중복 값 초기화
		$('#register_form #mem_id').keydown(function(){
			checkId = 0;
			$('#message_id').text('');
		});
		
		
		
		//---------------------이메일 인증 부분
		
		$("#email_check_button").hide();	// body가 시작하면 인증확인 버튼 숨기기
		var emailCheckCode = "";	// 이메일 인증번호 변수
		var emailCertification = false;	// 이메일 인증 성공 여부
		
		$("#email_send_button").click(function(){	// 인증번호전송 버튼 클릭시
				
			if($("#email").val().trim() == ""){
				alert("이메일을 입력해주세요!!");
				return false;
			}
				
			var email = $("#email").val();					// 입력 이메일
			var email_Check = $("#email_check");			// 인증번호 입력란
			var email_CheckBox = $("#email_check_button");	// 인증번호전송 버튼
				
			// 인증번호 전송 클릭시 입력 이메일 전송 ajax 작성
			$.ajax({
				type : "GET",
				url:"mailCheck.do?email=" + email,
				success:function(data){
					console.log("data : " + data);			// 나중에 삭제꼭하자!!!!
					email_Check.attr("disabled",false);		// 인증번호 입력란 활성화
					$("#email_check_button").show();		// 인증확인 버튼 보이기
					emailCheckCode = data;					// 변수에 인증번호 담기
				},
				error : function(){
					alert("네트워크 오류 발생!!");
				}
			});
				
		});	// end of send
		
		/* 인증번호 비교 */
		$("#email_check_button").click(function(){			// 인증확인 버튼 클릭시
			var user_inputCode = $("#email_check").val();	// 사용자 입력코드    
			    
		    if(user_inputCode == emailCheckCode){	// 인증번호가 일치한 경우
		    	alert("인증번호가 일치합니다.");
		    	$("#email_check_button").hide();	// 인증확인 버튼 숨기기
		    	emailCertification = true;			// 인증여부 성공으로 변경
		    	$("#email_check").attr("readonly",true);	// 인증번호 입력칸 비활성화
		    }else{	// 인증번호 불일치
		    	alert("인증번호가 불일치합니다.");
		    }		
		});
		
		
		
		// submit 이벤트 발생시 emailCertification가 false라면 체크 다시
		//submit 이벤트 발생시 아이디 중복 체크 여부 확인
		$('#register_form').submit(function(){
			if(checkId==0){
				$('#message_id').css('color','red').text('아이디 중복 체크 필수');
				if($('#mem_id').val().trim()==''){
					$('#mem_id').val('').focus();
				}
				return false;
			}
			
			if(emailCertification==false){
				alert("이메일 인증을 해주세요!!");
				return false;
			}
		});
	});
</script>
<!-- 중앙 내용 시작 -->

<div class = "container-fluid" style = "width:700px;">
	<div align = "left">
			<h3>회원 가입</h3>
	</div>
	<div class="text-center col-sm-12 my-5">
		
	<form:form id="register_form" action="registerUser.do" modelAttribute="memberVO">
		<div class = "form-group row">
			<label class = "col-sm-3 col-form-label" for="mem_id">아이디&nbsp;</label>
			<form:input path="mem_id" placeholder="4~12 영문,숫자만 허용"/>&nbsp;&nbsp;&nbsp;
			<input class = "btn btn-outline-dark" type="button" id="confirmId" value="ID중복체크">
			<span id="message_id"></span>
			<form:errors path="mem_id" cssClass="error-color"/>
		</div>
		<div class = "form-group row">
				<label class = "col-sm-3 col-form-label" for="mem_name">이름&nbsp;</label>
				<form:input path="mem_name"/>
				<form:errors path="mem_name" cssClass="error-color"/>
		</div>	
		<div class = "form-group row">
				<label class = "col-sm-3 col-form-label" for="nickname">닉네임&nbsp;</label>
				<form:input path="nickname"/>
				<form:errors path="nickname" cssClass="error-color"/>
		</div>
		<div class = "form-group row">	
				<label class = "col-sm-3 col-form-label" for="passwd">비밀번호&nbsp;</label>
				<form:password path="passwd" placeholder="4~12 영문,숫자만 허용"/>
				<form:errors path="passwd" cssClass="error-color"/>
		</div>	
		<div class = "form-group row">
				<label class = "col-sm-3 col-form-label" for="phone">전화번호&nbsp;</label>
				<form:input path="phone"/>
				<form:errors path="phone" cssClass="error-color"/>
		</div>
		<div class = "form-group row">	
				<label class = "col-sm-3 col-form-label" for="email">이메일&nbsp;</label>
				<form:input path="email"/>
				<form:errors path="email" cssClass="error-color"/>
		</div>
		<div class = "form-group row">	
				<label class = "col-sm-3 col-form-label" for="email_check">이메일인증&nbsp;</label>
				<input type="text" id="email_check" size="10" disabled="disabled">&nbsp;&nbsp;&nbsp;
				<input class = "btn btn-outline-dark" type="button" id="email_send_button" value="인증번호전송">&nbsp;&nbsp;&nbsp;
				<input type="button" id="email_check_button" class = "btn btn-outline-dark" value="인증확인">
		</div>
		<div class = "form-group row">	
				<label class = "col-sm-3 col-form-label" for="zipcope">우편번호&nbsp;</label>
				<input id="zipcode" name="zipcode" placeholder="우편번호" type="text" value="" maxlength="5" readonly="readonly"/>&nbsp;&nbsp;&nbsp;
				<input class = "btn btn-outline-dark" type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
				
				<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">

				</div>
				<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("address1").value = extraAddr;
                
                } else {
                    document.getElementById("address1").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode;
                document.getElementById("address1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("address2").focus();
            }
        }).open();
    }
	</script>
			<form:errors path="zipcode" cssClass="error-color"/>
			</div>
			<div class = "form-group row">
				<label class = "col-sm-3 col-form-label" for="address1">주소&nbsp;</label>
				<input id="address1" name="address1" type="text" value="" maxlength="30" readonly="readonly" placeholder="주소"/>
				<form:errors path="address1" cssClass="error-color"/>
			</div>
			<div class = "form-group row">
				<label class = "col-sm-3 col-form-label" for="address2">나머지주소&nbsp;</label>
				<form:input path="address2" maxlength="30" placeholder="상세주소"/>
				<form:errors path="address2" cssClass="error-color"/>
			</div>
			<br>
			<div class = "form-group row">
				<div class = "text-center col-sm-10">
					<form:button class = "btn btn-outline-dark">가입</form:button>
					<input class = "btn btn-outline-dark" type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
				</div>
			</div>
		
		
	</form:form>
	
	</div>
</div>
<!-- 중앙 내용 끝 -->