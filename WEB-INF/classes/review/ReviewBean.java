package review;

import java.sql.Timestamp;

public class ReviewBean {
	private int reviewNum, bookNum, hitCnt, recommend;
	private String userID, reviewTitle, reviewContent;
	private Timestamp regDate;
	
	public static int pageSize = 10;
	public static int pageCount = 1;
	public static int pageNum = 1;
	
	public int getReviewNum() {
		return reviewNum;
	}
	public void setReviewNum(int reviewNum) {
		this.reviewNum = reviewNum;
	}
	public int getBookNum() {
		return bookNum;
	}
	public void setBookNum(int bookNum) {
		this.bookNum = bookNum;
	}
	public int getHitCnt() {
		return hitCnt;
	}
	public void setHitCnt(int hitCnt) {
		this.hitCnt = hitCnt;
	}
	public int getRecommend() {
		return recommend;
	}
	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getReviewTitle() {
		return reviewTitle;
	}
	public void setReviewTitle(String reviewTitle) {
		this.reviewTitle = reviewTitle;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	
	public static String pageNumber(int limit) {
		String str = "";
		int temp = (pageNum - 1) % limit;
		int startPage = pageNum - temp;
		
		// [prev page] 버튼 출력
		if ((startPage - limit) > 0) {
			str = "<a class='page' href='reviewList.jsp?pageNum=" + (startPage - 1) + "'>이전</a>";
		}
		
		// 페이지 번호 나열
		for (int i = startPage; i < (startPage + limit); i++) {
			if (i == pageNum) {
				str += "<a class='page' href='#'>" + i + "</a>";
			} else {
				str += "<a class='page' href='reviewList.jsp?pageNum=" + i + "'>" + i + "</a>";
			}
			if(i >= pageCount) break;
		}
		
		// [next page] 버튼 출력
		if ((startPage + limit) <= pageCount) {
			str += "<a class='page' href='reviewList.jsp?pageNum=" + (startPage + limit) + "'>다음</a>";
		}
		
		return str;
	}
}
