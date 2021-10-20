package kr.spring.event.vo;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.NotEmpty;

import org.springframework.web.multipart.MultipartFile;

public class EventVO {
	private int event_num;				//이벤트 번호
	@NotEmpty
	private String event_title;			//제목
	@NotEmpty
	private String event_content;		//내용
	private String event_type; 			//분류 널가능
	private String event_day; 			//진행 날짜
	private int event_hits; 			//조회수 널가능 기본값 0 
	private Date event_reg_date; 		//작성일 널가능 기본값 sysdate
	private Date event_modi; 			//수정일 널가능 기본값 sysdate
	private byte[] event_photo; 		//사진(blob) 널가능
	private String event_filename;		//사진 파일 이름 널가능
	private int mem_num;				//회원 번호
	
	private byte[] profile; 			// 프로필 사진
	private String profile_filename; 	// 프로필 사진 파일명
	
	
	public void setUpload(MultipartFile upload)throws IOException{
		//MultipartFile -> byte[]
		setEvent_photo(upload.getBytes());
		//파일명 구하기
		setEvent_filename(upload.getOriginalFilename());
	}
	public int getEvent_num() {
		return event_num;
	}
	public void setEvent_num(int event_num) {
		this.event_num = event_num;
	}
	public String getEvent_title() {
		return event_title;
	}
	public void setEvent_title(String event_title) {
		this.event_title = event_title;
	}
	public String getEvent_content() {
		return event_content;
	}
	public void setEvent_content(String event_content) {
		this.event_content = event_content;
	}
	public String getEvent_type() {
		return event_type;
	}
	public void setEvent_type(String event_type) {
		this.event_type = event_type;
	}
	public int getEvent_hits() {
		return event_hits;
	}
	public void setEvent_hits(int event_hits) {
		this.event_hits = event_hits;
	}
	public Date getevent_reg_date() {
		return event_reg_date;
	}
	public void setevent_reg_date(Date event_reg_date) {
		this.event_reg_date = event_reg_date;
	}
	public Date getevent_modi() {
		return event_modi;
	}
	public void setevent_modi(Date event_modi) {
		this.event_modi = event_modi;
	}
	public byte[] getEvent_photo() {
		return event_photo;
	}
	public void setEvent_photo(byte[] event_photo) {
		this.event_photo = event_photo;
	}
	public String getEvent_filename() {
		return event_filename;
	}
	public void setEvent_filename(String event_filename) {
		this.event_filename = event_filename;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public byte[] getProfile() {
		return profile;
	}
	public void setProfile(byte[] profile) {
		this.profile = profile;
	}
	public String getProfile_filename() {
		return profile_filename;
	}
	public void setProfile_filename(String profile_filename) {
		this.profile_filename = profile_filename;
	}
	
	public String getEvent_day() {
		return event_day;
	}
	public void setEvent_day(String event_day) {
		this.event_day = event_day;
	}
	@Override
	public String toString() {
		return "EventVO [event_num=" + event_num + ", event_title=" + event_title + ", event_content=" + event_content
				+ ", event_type=" + event_type + ", event_day=" + event_day + ", event_hits=" + event_hits
				+ ", event_reg_date=" + event_reg_date + ", event_modi=" + event_modi + ", event_filename="
				+ event_filename + ", mem_num=" + mem_num + ", profile_filename=" + profile_filename + "]";
	}
	
	
}
