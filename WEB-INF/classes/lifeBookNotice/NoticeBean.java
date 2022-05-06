package lifeBookNotice;

import java.sql.Timestamp;

public class NoticeBean {
	private int noticeNum;
	private String noticeTitle;
	private String noticeContent;
	private String userID;
	private int hitCnt;
	private Timestamp regDate;
	
	public static int pageSize = 10;
	public static int pageCount = 1;
	public static int pageNum = 1;
	
	public static String pageNumber(int limit) {
		String str = "";
		int temp = (pageNum - 1) % limit;
		int startPage = pageNum - temp;
		
		if ((startPage - limit) > 0) {
			str = "<a class='page' href='list.jsp?pageNum=" + (startPage - 1) + "'>이전</a>";
		}
		
		for (int i = startPage; i < (startPage + limit); i++) {
			if (i == pageNum) {
				str += "<a class='page' href='#'>" + i + "</a>";
			} else {
				str += "<a class='page' href='list.jsp?pageNum=" + i + "'>" + i + "</a>";
			}
			if(i >= pageCount) break;
		}
		
		if ((startPage + limit) <= pageCount) {
			str += "<a class='page' href='list.jsp?pageNum=" + (startPage + limit) + "'>다음</a>";
		}
		
		return str;
	}

	public int getNoticeNum() {
		return noticeNum;
	}

	public void setNoticeNum(int noticeNum) {
		this.noticeNum = noticeNum;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getNoticeContent() {
		return noticeContent;
	}

	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public int getHitCnt() {
		return hitCnt;
	}

	public void setHitCnt(int hitCnt) {
		this.hitCnt = hitCnt;
	}

	public Timestamp getRegDate() {
		return regDate;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}

	public static int getPageSize() {
		return pageSize;
	}

	public static void setPageSize(int pageSize) {
		NoticeBean.pageSize = pageSize;
	}

	public static int getPageCount() {
		return pageCount;
	}

	public static void setPageCount(int pageCount) {
		NoticeBean.pageCount = pageCount;
	}

	public static int getPageNum() {
		return pageNum;
	}

	public static void setPageNum(int pageNum) {
		NoticeBean.pageNum = pageNum;
	}
	
}
