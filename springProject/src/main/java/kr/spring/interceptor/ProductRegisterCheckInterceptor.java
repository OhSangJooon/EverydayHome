package kr.spring.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.spring.store.service.StoreService;
import kr.spring.store.vo.StoreVO;

public class ProductRegisterCheckInterceptor extends HandlerInterceptorAdapter{
	
private static final Logger logger = LoggerFactory.getLogger(WriterCheckInterceptor.class);
	
	@Autowired
	private StoreService storeService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		logger.debug("===== 로그인 회원번호와 작성자 회원번호 일치 여부 체크 =====");
		
		// 작성자 회원번호 구하기
		int prod_num = Integer.parseInt(request.getParameter("prod_num")); // 전송되는 데이터 뽑아내기
		StoreVO storeVO = storeService.selectProduct(prod_num); // 한 건의 레코드 구하기
		
		// 로그인 회원번호 구하기
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		logger.debug("<<작성자 회원번호>> : " + storeVO.getMem_num());
		logger.debug("<<로그인 회원번호>> : " + user_num);
		
		// 회원번호 일치 여부 체크
		if(user_num != storeVO.getMem_num()) {
			logger.debug("<<로그인 회원번호와 작성자 회원번호 불일치>>");
			
			request.setAttribute("accessMsg", "로그인 회원번호와 작성자 회원번호 불일치");
			request.setAttribute("accessBtn", "목록");
			request.setAttribute("accessUrl", request.getContextPath() + "/store/storeCategory.do");
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/common/notice.jsp");
			
			dispatcher.forward(request, response);
			
			return false;
		} // end of if
		
		logger.debug("<<로그인 회원번호와 작성자 회원번호 일치>>");
		
		return true;
	}
}
