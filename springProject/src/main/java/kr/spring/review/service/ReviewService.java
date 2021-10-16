package kr.spring.review.service;

import java.util.List;

import kr.spring.review.vo.ReviewVO;

public interface ReviewService {
	public void reviewInsert(ReviewVO review);//리뷰등록
	public ReviewVO reviewDetail(int rev_num);//리뷰읽기
	public ReviewVO reviewUpdate(ReviewVO review);//리뷰수정
	public void reviewDelete(int rev_num); //리뷰삭제
	public List<ReviewVO> reviewbuyList(int mem_num); //구매한 제품 리스트 
	public List<ReviewVO> reviewList(int mem_num);//리뷰리스트
	public List<ReviewVO> reviewListStore(int prod_num);//리뷰 스토어에서 보게하기
	public int reviewMyCount(int mem_num);//내 리뷰 총 개수 세기
	public int reviewStoreCount(int prod_num);//상품 리뷰 총 개수 세기
	public void reviewFileDelete(int rev_num);
}
