package lifeBookQnA;

import java.sql.Timestamp;

public class QnaBean {
	private int qnaNum;
	private String userID;
	private String category;
	private String qnaTitle;
	private String qnaContent;
	private String qnaPWD;
	private Timestamp regDate;
	private int qnaRef;
	private int qnaStep;
	private int qnaLevel;
	
	public static int pageSize = 10;
	public static int pageCount = 1;
	public static int pageNum = 1;
	
	public static String pageNumber(int limit) {
		String str = "";
		int temp = (pageNum - 1) % limit;
		int startPage = pageNum - temp;
		
		// 占쎌뵠占쎌읈 占쎈읂占쎌뵠筌욑옙
		if ((startPage - limit) > 0) {
			str = "<a class='page' href='qnaList.jsp?pageNum=" + (startPage - 1) + "'>이전</a>";
		}
		
		// 占쎈읂占쎌뵠筌욑옙 筌ｌ꼶�봺
		for (int i = startPage; i < (startPage + limit); i++) {
			if (i == pageNum) {
				str += "<a class='page' href='#'>" + i + "</a>";
			} else {
				str += "<a class='page' href='qnaList.jsp?pageNum=" + i + "'>" + i + "</a>";
			}
			if(i >= pageCount) break;
		}
		
		// 占쎈뼄占쎌벉 占쎈읂占쎌뵠筌욑옙
		if ((startPage + limit) <= pageCount) {
			str += "<a class='page' href='qnaList.jsp?pageNum=" + (startPage + limit) + "'>다음</a>";
		}
		
		return str;
	}
	
	public int getQnaNum() {
		return qnaNum;
	}

	public void setQnaNum(int qnaNum) {
		this.qnaNum = qnaNum;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getQnaTitle() {
		return qnaTitle;
	}

	public void setQnaTitle(String qnaTitle) {
		this.qnaTitle = qnaTitle;
	}

	public String getQnaContent() {
		return qnaContent;
	}

	public void setQnaContent(String qnaContent) {
		this.qnaContent = qnaContent;
	}

	public String getQnaPWD() {
		return qnaPWD;
	}

	public void setQnaPWD(String qnaPWD) {
		this.qnaPWD = qnaPWD;
	}

	public Timestamp getRegDate() {
		return regDate;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}

	public int getQnaRef() {
		return qnaRef;
	}

	public void setQnaRef(int qnaRef) {
		this.qnaRef = qnaRef;
	}

	public int getQnaStep() {
		return qnaStep;
	}

	public void setQnaStep(int qnaStep) {
		this.qnaStep = qnaStep;
	}

	public int getQnaLevel() {
		return qnaLevel;
	}

	public void setQnaLevel(int qnaLevel) {
		this.qnaLevel = qnaLevel;
	}
}