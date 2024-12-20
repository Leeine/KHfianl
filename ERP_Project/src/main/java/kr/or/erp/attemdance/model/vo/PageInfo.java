package kr.or.erp.attemdance.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class PageInfo {
	//페이징 처리 (사용자에게 보여줄 게시글 정보들)
	//준비물
	private int listCount; //총 게시글 개수
	private int currentPage; //현재 페이지
	private int pageLimit; // 페이지 하단에 보여질 페이징바 최대 개수
	private int ListLimit; //한 페이지에 보여질 게시글 개수
	
	private int maxPage; //가장 마지막 페이지는 몇번 페이지인지 (총 페이지 개수)
	private int startPage; //페이지 하단에 보여질 페이징바 개수
	private int endPage; //페이지 하단에 보여질 페이질바 끝수
}
