package lifeBookFAQ;

import java.sql.Timestamp;

public class FaqBean {
	private int faqNum;
	private String faqCategory;
	private String faqTitle;
	private String faqContent;
	private Timestamp regDate;
	
	public static int pageSize = 10;
	public static int pageCount = 1;
	public static int pageNum = 1;
	
	public static String pageNumber(int limit) {
		String str = "";
		int temp = (pageNum - 1) % limit;
		int startPage = pageNum - temp;
		
		// 占쎌뵠占쎌읈 占쎈읂占쎌뵠筌욑옙
		if ((startPage - limit) > 0) {
			str = "<a class='page' href='faqList.jsp?pageNum=" + (startPage - 1) + "'>이전</a>";
		}
		
		// 占쎈읂占쎌뵠筌욑옙 筌ｌ꼶�봺
		for (int i = startPage; i < (startPage + limit); i++) {
			if (i == pageNum) {
				str += "<a class='page' href='#'>" + i + "</a>";
			} else {
				str += "<a class='page' href='faqList.jsp?pageNum=" + i + "'>" + i + "</a>";
			}
			if(i >= pageCount) break;
		}
		
		// 占쎈뼄占쎌벉 占쎈읂占쎌뵠筌욑옙
		if ((startPage + limit) <= pageCount) {
			str += "<a class='page' href='faqList.jsp?pageNum=" + (startPage + limit) + "'>다음</a>";
		}
		
		return str;
	}
	
	public int getFaqNum() {
		return faqNum;
	}

	public void setFaqNum(int faqNum) {
		this.faqNum = faqNum;
	}

	public String getFaqCategory() {
		return faqCategory;
	}

	public void setFaqCategory(String faqCategory) {
		this.faqCategory = faqCategory;
	}

	public String getFaqTitle() {
		return faqTitle;
	}

	public void setFaqTitle(String faqTitle) {
		this.faqTitle = faqTitle;
	}

	public String getFaqContent() {
		return faqContent;
	}

	public void setFaqContent(String faqContent) {
		this.faqContent = faqContent;
	}

	public Timestamp getRegDate() {
		return regDate;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
}
