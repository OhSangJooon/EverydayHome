package kr.spring.event.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.event.service.EventService;
import kr.spring.event.vo.EventVO;
import kr.spring.util.PagingUtil;

@Controller
public class EventController {

	@Autowired
	private EventService eventService;
	
	@ModelAttribute
	public EventVO initCommand() {
		
		return new EventVO();
	}
	private static final Logger logger = LoggerFactory.getLogger(EventController.class);

	//이벤트 리스트 출력
	@RequestMapping("event/eventList.do")
	public ModelAndView eventList(@RequestParam(value="pageNum",defaultValue="1") int currentPage, HttpSession session){
		//총 레코드 수
		int count = eventService.eventTotalCount();
		//페이징 처리
		PagingUtil page = new PagingUtil(currentPage, count, 10, 10, "/EverydayHome/event/eventList.do");
		
		List<EventVO> list =null;
		
		if(count > 0) {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("start", page.getStartCount());
			map.put("end", page.getEndCount());
			
			list = eventService.eventGetList(map);
		}
		//권한정보 받아오기
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		//전달 객체 생성
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("eventList");
		mav.addObject("count",count);
		mav.addObject("list",list);
		mav.addObject("pagingHtml",page.getPagingHtml());
		mav.addObject("user_auth",user_auth);
		
		return mav;
	}
	//이벤트 상세정보 출력
	@GetMapping("event/eventDetail.do")
	public ModelAndView eventDetail(@RequestParam(value="event_num") int event_num, HttpSession session) {
		
		eventService.eventGetHits(event_num);
		EventVO event = eventService.eventDetail(event_num);
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("eventDetail");
		mav.addObject("event", event);
		mav.addObject("user_auth",user_auth);
		
		return mav;
	}
	
	@GetMapping("/event/eventWrite.do")
	public String form() {
	
		return "eventWrite";
	
	}
	//이벤트 게시판 작ㅅ성
	@PostMapping("/event/eventWrite.do")
	public String submit(@Valid EventVO eventVO, BindingResult result, HttpSession session) {
		
		
		if(result.hasErrors()) {
			return form();
		}
		
		Integer mem_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		if(user_auth!=4) {
			return "redirect:eventList.do";
		}
		
		eventVO.setMem_num(mem_num);
		eventService.eventWrite(eventVO);
				
		logger.debug("<<이벤트정보>>:" + eventVO);
		
		return "redirect:eventList.do";
	}
	//이벤트 업데이트 창 출력
	
	@GetMapping("/event/eventUpdate.do")
	public String updateForm(@RequestParam int event_num, Model model, HttpSession session) {
		
		EventVO eventVO = eventService.eventDetail(event_num);
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		model.addAttribute("eventVO",eventVO);
		model.addAttribute("user_auth",user_auth);
		
		if(user_auth!=4) {
			return " redirect:eventList.do";
		}
		
		return "eventUpdate";
	}
	//이벤트 업데이트 
	@PostMapping("/event/eventUpdate.do")
	public String submitUpdate(@Valid EventVO eventVO, BindingResult result) {
		logger.debug("<<수정>>:" + eventVO);
		
		if(result.hasErrors()) {
			return "redirect:eventList.do";
		}
		
		eventService.eventUpdate(eventVO);
		return "redirect:eventList.do";
	}
	//글 수정시 이미지 
	@RequestMapping("/event/deleteFile.do")
	@ResponseBody
	public Map<String,String> processFile(int event_num, HttpSession session) {
		
		Map<String,String> map = new HashMap<String, String>();
		
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		if(user_auth !=4) {
			map.put("result", "wrongauth");
			
		}else {
			eventService.deleteFile(event_num);
			map.put("result", "success");
		}
		
		return map;
	}
	
	// CKEditor를 이용한 이미지 업로드
	@RequestMapping("/event/imageUploader.do")
	@ResponseBody
	public Map<String,Object> uploadImage(MultipartFile upload, HttpSession session, HttpServletRequest request) throws Exception {
		
		// 업로드할 절대 경로 구하기
		String realFolder = session.getServletContext().getRealPath("/resources/image_upload");
		
		// 업로드한 파일 이름
		String org_filename = upload.getOriginalFilename();
		String str_filename = System.currentTimeMillis() + org_filename; // long타입으로 밀리세컨드를 가져와서 중복되지 않은 파일명을 만듦
		
		logger.debug("<<원본 파일명>> : " + org_filename);
		logger.debug("<<저장할 파일명>> : " + str_filename);
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		String filepath = realFolder + "\\" + user_num + "\\" + str_filename;
		logger.debug("<<파일 경로>> : " + filepath);
		
		File f = new File(filepath);
		if(!f.exists()) { // 폴더가 존재하지 않는다면 만들자
			f.mkdirs();
		}
		
		upload.transferTo(f); // 경로가 있다면 파일 업로드
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("uploaded", true);
		map.put("url", request.getContextPath() + "/resources/image_upload/" + user_num + "/" + str_filename); // 리퀘스트를 사용해서 경로를 읽어옴
		
		return map;
	}
	
	//이벤트삭제하기
	@GetMapping("/event/eventDelete.do")
	public String delete(@RequestParam int event_num, HttpSession session) {
		
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_auth!=4) {
			return " redirect: eventList.do";
		}
		eventService.eventDelete(event_num);
		
		return "redirect:eventList.do";
	}
	//이벤트 이미지 출력
	@GetMapping("/event/imageView.do")
	public ModelAndView viewImage(@RequestParam int event_num) {
		
		EventVO event =eventService.eventDetail(event_num);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("imageView");
		                //속성명         속성값(byte[]의 데이터)     
		mav.addObject("imageFile", event.getEvent_photo());
		mav.addObject("filename", event.getEvent_filename());
		
		return mav;
	}
}
//카테고리 추가해야함 카테고리 추가후 mapper에 있는 sql수정필요 ==> 현재 다 1로 해둠
//리스트에서 이미지파일 썸네일처럼 미리보기 추가해야함
//이미지 여러개 보일 수 있게 구현할수 있다면 하기
//수정 jsp에서 이미지 파일 넣을 수 있게 수정해야함
//수정,글등록 완료시 글등록 완료 알림창 뜨게 바꾸기 << 이건 notice도 마찬가지 
//버튼 디자인 변경 << notice도 마찬가지
//수정 오류있음 수정해야함