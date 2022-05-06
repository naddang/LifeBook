package lifeBookBoard;

import java.sql.Timestamp;

public class BoardBean {
	private String userID;
	private String boardTitle;
	private String boardContent;
	private int boardNum;
	private int hitCnt;
	private Timestamp regDate;
	private int recommend;
	private String fileName;
	private int fileSize;
	private String realFileName;
	private String userIP;
	
	public static int pageSize = 10;
	public static int pageCount = 1;
	public static int pageNum = 1;
		
	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}

	public String getBoardContent() {
		return boardContent;
	}

	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}

	public int getBoardNum() {
		return boardNum;
	}

	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
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

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public int getFileSize() {
		return fileSize;
	}

	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}

	public String getRealFileName() {
		return realFileName;
	}

	public void setRealFileName(String realFileName) {
		this.realFileName = realFileName;
	}

	public String getUserIP() {
		return userIP;
	}

	public void setUserIP(String userIP) {
		this.userIP = userIP;
	}
	
	public static int getPageSize() {
		return pageSize;
	}

	public static void setPageSize(int pageSize) {
		BoardBean.pageSize = pageSize;
	}

	public static int getPageCount() {
		return pageCount;
	}

	public static void setPageCount(int pageCount) {
		BoardBean.pageCount = pageCount;
	}

	public static int getPageNum() {
		return pageNum;
	}

	public static void setPageNum(int pageNum) {
		BoardBean.pageNum = pageNum;
	}

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
}
