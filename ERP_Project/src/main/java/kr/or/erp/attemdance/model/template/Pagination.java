package kr.or.erp.attemdance.model.template;

import kr.or.erp.attemdance.model.vo.PageInfo;

public class Pagination {
	
	//페이징 처리하기위한 메소드
	public static PageInfo getPageInfo(int listCount, int currentPage, int pageLimit, int boardLimit) {
	
		int maxPage = (int)Math.ceil((double)listCount/boardLimit);
		
		int startPage = (currentPage-1)/pageLimit * pageLimit + 1;
		
		int endPage = startPage+pageLimit-1; 
		
		if(maxPage<endPage) {
			endPage = maxPage; //maxPage에 담긴 값을 endPage에 대입하기
		}
		
		//처리된 페이지 정보 데이터 담아주기
		PageInfo pi = new PageInfo(listCount, currentPage, pageLimit, boardLimit, maxPage, startPage, endPage);
		
		return pi;
		
	}
}
