package order;

import java.sql.Timestamp;

public class OrderBean {
	private String orderNum;
	private int  bookNum, amount;
	private String userID, orderRecipient, orderAddr, orderPhoneNum, statement;
	private Timestamp orderDate;
	
	public static int pageSize = 10;
	public static int pageCount = 1;
	public static int pageNum = 1;
	
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
	public String getOrderAddr() {
		return orderAddr;
	}
	public void setOrderAddr(String orderAddr) {
		this.orderAddr = orderAddr;
	}
	public String getOrderPhoneNum() {
		return orderPhoneNum;
	}
	public void setOrderPhoneNum(String orderPhoneNum) {
		this.orderPhoneNum = orderPhoneNum;
	}
	public String getStatement() {
		return statement;
	}
	public void setStatement(String statement) {
		this.statement = statement;
	}
	public Timestamp getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Timestamp orderDate) {
		this.orderDate = orderDate;
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
				str += "<a class='page'>" + i + "</a>";
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
