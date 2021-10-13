package kr.spring.qna.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.qna.service.QnaService;
import kr.spring.qna.vo.QnaVO;
import kr.spring.util.PagingUtil;

@Controller
public class QnaController {
		//로그 처리 (로그 대상 지정)
		private static final Logger log = LoggerFactory.getLogger(QnaController.class);
		
		@Autowired
		private QnaService qnaService;
		
		//자바빈 초기화
		@ModelAttribute
		public QnaVO initCommand() {
			return new QnaVO();
		}
		
		@GetMapping("/qna/qnaInsert.do")
		//글쓰기 폼 호출
		public String qnaInsert() {
			log.debug("<<글쓰기 폼 호출>>");
			
			return "qna/qnaInsert";
		}
		//글쓰기 처리
		@PostMapping("/qna/qnaInsert.do")
		public String qnaInsertSubmit(@Valid QnaVO vo, BindingResult result) {
			//유효성 체크 결과 오류가 있으면 폼 호출
			if(result.hasErrors()) {
				return qnaInsert();
			}
			//글쓰기
			qnaService.qnaInsert(vo);
			
			return "redirect:/qna/qnaList.do";
		}

		
		//게시판 목록
		@RequestMapping("/qna/qnaList.do")
		public ModelAndView getQnaList(
			@RequestParam(value="pageNum", defaultValue="1")int currentPage) {
			
			log.debug("<<currentPage>>: " + currentPage);
			
			//총 레코드 수
			int count = qnaService.getQnaCount();
			
			//페이지 처리
			PagingUtil page = new PagingUtil(currentPage, count, 10, 10, "qnaList.do");
			
			//목록 호출
			List<QnaVO> list = null;
			if(count>0) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("start", page.getStartCount());
				map.put("end", page.getEndCount());
				
				list = qnaService.getQnaList(map);
			}
			
			ModelAndView mav = new ModelAndView();
			
			//뷰 이름 설정
			mav.setViewName("qnaList");
			
			//데이터 저장
			mav.addObject("count",count);
			mav.addObject("list", list);
			mav.addObject("pagingHtml", page.getPagingHtml());
			
			return mav;
			
		}
		
		/*
		//글 상세
		@RequestMapping("/serviceBoard/serviceBoardDetail.do")
		public ModelAndView serviceBoardDetail(@RequestParam int num) {
			QnaVO serviceboard = serviceBoardService.getServiceBoard(num);
									//뷰 이름					//속성명		//속성값
			return new ModelAndView("/serviceBoard/serviceBoardDetail","serviceboard","serviceboard");
		}
		*/
		
		//수정폼
		@GetMapping("/qna/qnaUpdate.do")
		public String qnaUpdate(@RequestParam int num, Model model) {
			QnaVO qna = qnaService.getQna(num);
			
			model.addAttribute("qnaVO", qna);
			return "qna/qnaUpdate";
			
		}
		//수정 처리
		@PostMapping("/qna/qnaUpdate.do")
		public String qnaUpdateSubmit(@Valid QnaVO vo, BindingResult result) {
			//유효성 체크 결과 오류가 있으면 폼을 호출
			if(result.hasErrors()) {
				return "qna/qnaUpdate";
				
			}
			qnaService.qnaUpdate(vo);
			return "redirect:/qna/qnaList.do";
		}
		
		//글 삭제 폼
		@GetMapping("/qna/qnaDelete.do")
		public String qnaDelete(@RequestParam int num, Model model) {
			QnaVO vo = new QnaVO();
			vo.setQna_num(num);
			
			model.addAttribute("qnaVO",vo);
			
			return "qna/qnaDelete";
		}
		//글 삭제 처리
		@PostMapping("/qna/qnaDelete.do")
		public String qnaDeleteSubmit(@Valid QnaVO vo, BindingResult result) {
			
			qnaService.qnaDelete(vo.getQna_num());
			
			return "redirect:/qna/qnaList.do";
		}
		
		
}
