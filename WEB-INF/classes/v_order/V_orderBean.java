package v_order;

import java.sql.Timestamp;

public class V_orderBean {
	private String orderNum;
	private int bookNum, amount;
	private Timestamp orderDate;
	private String userID, orderRecipient, orderPhoneNum, orderAddr, bookName, bookImg, Statement;
	
	public static int pageSize = 10;
	public static int pageCount = 1;
	public static int pageNum = 1;
	
	public String getStatement() {
		return Statement;
	}
	public void setStatement(String statement) {
		Statement = statement;
	}
	public static int getPageSize() {
		return pageSize;
	}
	public static void setPageSize(int pageSize) {
		V_orderBean.pageSize = pageSize;
	}
	public static int getPageCount() {
		return pageCount;
	}
	public static void setPageCount(int pageCount) {
		V_orderBean.pageCount = pageCount;
	}
	public static int getPageNum() {
		return pageNum;
	}
	public static void setPageNum(int pageNum) {
		V_orderBean.pageNum = pageNum;
	}
	public String getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}
	public int getBookNum() {
		return bookNum;
	}
	public void setBookNum(int bookNum) {
		this.bookNum = bookNum;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public Timestamp getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Timestamp orderDate) {
		this.orderDate = orderDate;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getOrderRecipient() {
		return orderRecipient;
	}
	public void setOrderRecipient(String orderRecipient) {
		this.orderRecipient = orderRecipient;
	}
	public String getOrderPhoneNum() {
		return orderPhoneNum;
	}
	public void setOrderPhoneNum(String orderPhoneNum) {
		this.orderPhoneNum = orderPhoneNum;
	}
	public String getOrderAddr() {
		return orderAddr;
	}
	public void setOrderAddr(String orderAddr) {
		this.orderAddr = orderAddr;
	}
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	public String getBookImg() {
		return bookImg;
	}
	public void setBookImg(String bookImg) {
		this.bookImg = bookImg;
	}
	
	public static String pageNumber(int limit) {
		String str = "";
		int temp = (pageNum - 1) % limit;
		int startPage = pageNum - temp;
		
		// [prev page] 버튼 출력
		if ((startPage - limit) > 0) {
			str = "<a class='page' href='ordermgmt.jsp?pageNum=" + (startPage - 1) + "'>이전</a>";
		}
		
		// 페이지 번호 나열
		for (int i = startPage; i < (startPage + limit); i++) {
			if (i == pageNum) {
				str += "<a class='page'>"+ i + "</a>";
			} else {
				str += "<a class='page' href='ordermgmt.jsp?pageNum=" + i + "'>" + i + "</a>";
			}
			if(i >= pageCount) break;
		}
		
		// [next page] 버튼 출력
		if ((startPage + limit) <= pageCount) {
			str += "<a class='page' href='ordermgmt.jsp?pageNum=" + (startPage + limit) + "'>다음</a>";
		}
		
		return str;
	}
	
}
