package ino.web.freeBoard.dto;


public class Pagination {
	
		private int totalCount;   // 전체 데이터 수
	    private int currentPage;  // 현재 페이지
	    private int pageSize;     // 한 페이지당 데이터 개수
	    private int totalPage;    // 전체 페이지 수
	    private int startIndex;   // 데이터 시작 인덱스
	    private int endPage;      // 마지막 페이지 번호
	    private int startPage;    // 시작 페이지 번호
	    private int endIndex;     // 데이터 종료 인덱스
	    private String searchType;   // 검색 타입 (제목, 내용, 작성자 등)
	    private String searchValue;  // 검색 값

	    public Pagination(int totalCount, int currentPage, int pageSize) {
	        this.totalCount = totalCount;
	        this.currentPage = currentPage;
	        this.pageSize = pageSize;

	        // 전체 페이지 수 계산
	        this.totalPage = (int) Math.ceil((double) totalCount / pageSize);

	        // 데이터의 시작 인덱스 계산 (ROWNUM 시작은 1부터)
	        this.startIndex = (currentPage - 1) * pageSize + 1; // 시작 인덱스
	        // 데이터의 종료 인덱스 계산
	        this.endIndex = Math.min(currentPage * pageSize, totalCount); // 종료 인덱스

	        // 페이지 번호 계산 (5 페이지씩 보여주는 예시)
	        this.startPage = Math.max(1, currentPage - 2);
	        this.endPage = Math.min(totalPage, currentPage + 2);
	    }

	    public String getSearchType() {
			return searchType;
		}

		public void setSearchType(String searchType) {
			this.searchType = searchType;
		}

		public String getSearchValue() {
			return searchValue;
		}

		public void setSearchValue(String searchValue) {
			this.searchValue = searchValue;
		}

		public int getTotalCount() {
	        return totalCount;
	    }

	    public void setTotalCount(int totalCount) {
	        this.totalCount = totalCount;
	    }

	    public int getCurrentPage() {
	        return currentPage;
	    }

	    public void setCurrentPage(int currentPage) {
	        this.currentPage = currentPage;
	    }

	    public int getPageSize() {
	        return pageSize;
	    }

	    public void setPageSize(int pageSize) {
	        this.pageSize = pageSize;
	    }

	    public int getTotalPage() {
	        return totalPage;
	    }

	    public void setTotalPage(int totalPage) {
	        this.totalPage = totalPage;
	    }

	    public int getStartIndex() {
	        return startIndex;
	    }

	    public void setStartIndex(int startIndex) {
	        this.startIndex = startIndex;
	    }

	    public int getEndIndex() {
	        return endIndex;
	    }

	    public void setEndIndex(int endIndex) {
	        this.endIndex = endIndex;
	    }

	    public int getEndPage() {
	        return endPage;
	    }

	    public void setEndPage(int endPage) {
	        this.endPage = endPage;
	    }

	    public int getStartPage() {
	        return startPage;
	    }

	    public void setStartPage(int startPage) {
	        this.startPage = startPage;
	    }
    
}
