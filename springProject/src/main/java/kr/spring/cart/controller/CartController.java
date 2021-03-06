package kr.spring.cart.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.cart.service.CartService;
import kr.spring.cart.vo.CartVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
//카트랑 장바구니주문
@Controller
public class CartController {

	@Autowired
	private CartService cartService;
	
	@Autowired
	private MemberService memberService;
	
	// Member 자바빈(VO) 초기화
	 @ModelAttribute
	 public MemberVO initMember() {
			 
	    return new MemberVO();
	}
	@ModelAttribute
	public CartVO initCartVO() {
		return new CartVO();
	}
	private static final Logger logger = LoggerFactory.getLogger(CartController.class);
	
	//장바구니 목록
	@RequestMapping("cart/cartList.do")
	public ModelAndView cartList(CartVO cartVO, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Integer user_num = (Integer)session.getAttribute("user_num");
		logger.debug("<<user_num>>" + user_num);
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<CartVO> list = cartService.cartList(user_num);
		int sumMoney = cartService.sumMoney(user_num);
		//장바구니 전체 금액에 따라 배송비 구분
		//배송료 10만원 이상 =>무료 미만 => 2500원
		int fee = sumMoney >= 100000 ? 0 : 2500;
		map.put("sumMoney",sumMoney);
		map.put("fee", fee);
		map.put("allSum", sumMoney+fee);
		map.put("list",list);
		map.put("count",list.size());
		mav.addObject("map",map);
		mav.setViewName("cartList");
		logger.debug("<<count>>:" + list.size());
		return mav;
	}
	//장바구니 버튼 폼 cartVO로 넘겨야함 cartVO 필요한거 : 개수 , 제품 번호 
	//장바구니 추가
	@RequestMapping("cart/cartInsert.do")
	@ResponseBody
	public Map<String, String> cartInsert(CartVO cart, HttpSession session) {
		
		Map<String, String> map = new HashMap<String, String>();
		
		cart.setMem_num((Integer)session.getAttribute("user_num"));
		
		logger.debug("<<mem_num이 저장 되었는지 확인>> : " + cart.getMem_num());
		
		//장바구니에 지금 추가하려는 상품이 있는지 확인
		int count = cartService.cartCount(cart);
		
		logger.debug("<<카트 카운트 확인>> : " + count);
		// 카운트가 
		if(count == 0) {
			//없으면 insert
			cartService.cartInsert(cart);
			map.put("result", "add_success");
		}else {
			cartService.CurrentUpdate(cart);
			map.put("result", "cart_update");
		}
		return map;
	}
	
	//장바구니 삭제
	@GetMapping("cart/cartDelete.do")
	public String delete(@RequestParam int cart_num) {
		cartService.cartDelete(cart_num);
		return "redirect:cartList.do";
	}
	
	//장바구니 수정
	@RequestMapping("cart/cartUpdate.do")
	public String cartUpdate(@RequestParam int[] cart_quan, @RequestParam int[] prod_num, HttpSession session) {
		//session에서 유저 번호 알아옴
		Integer user_num = (Integer)session.getAttribute("user_num");
		for(int i=0; i<prod_num.length; i++) {
			CartVO cart = new CartVO();
			cart.setMem_num(user_num);
			cart.setProd_num(prod_num[i]);
			cart.setCart_quan(cart_quan[i]);
			cartService.cartUpdate(cart);
			logger.debug ("<<cartUpdate>>: " +cart);
		}
		return "redirect:cartList.do";
	}
		//장바구니 이미지 출력
	@GetMapping("cart/imageView.do")
	public ModelAndView viewImage(@RequestParam int prod_num) {
			
		CartVO cart =cartService.cartImg(prod_num);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("imageView");
		                //속성명         속성값(byte[]의 데이터)     
		mav.addObject("imageFile", cart.getThumbnail_img());
		mav.addObject("filename", cart.getThumbnail_filename());
			
		return mav;
		}
	
	//장바구니 정보 폼 전달
	@RequestMapping("cart/cartOrderForm")
	public String cartOrderForm(Model model,HttpSession session) {
		Integer mem_num = (Integer)session.getAttribute("user_num");
		int count = cartService.OrdercartCount(mem_num);
		List<CartVO> cartVO = cartService.cartList(mem_num);
		MemberVO memberVO = memberService.selectMember(mem_num);
		logger.debug("<<장바구니 주문에서 제품정보 넘어가는지 확인 cartVO>> : " + cartVO);
		logger.debug("<<장바구니 주문에서 숫자 제대로 넘어가는지 확인>> : " + count);
		logger.debug("<<장바구니 주문에서 회원정보 넘어가는지 확인 memberVO>> : " + memberVO);

		int totalPrice = 0;
		for(int i=0; i<cartVO.size(); i++) {
			totalPrice += cartVO.get(i).getMoney();
		}
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("count", count);
		model.addAttribute("cartVO", cartVO);
		model.addAttribute("memberVO", memberVO);
		
		
		return "cartOrderForm";
	}
}

