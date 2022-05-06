package userInfo;

import java.sql.Timestamp;

public class UserInfoBean {
	private String userID;
	private String userPWD;
	private String userAddr;
	private int isAdmin;
	private int point;
	private String userPhoneNum;
	private Timestamp userBirth;
	private String userName;

	public static int pageSize = 10;
	public static int pageCount = 1;
	public static int pageNum = 1;

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getUserPWD() {
		return userPWD;
	}

	public void setUserPWD(String userPWD) {
		this.userPWD = userPWD;
	}

	public String getUserAddr() {
		return userAddr;
	}

	public void setUserAddr(String userAddr) {
		this.userAddr = userAddr;
	}

	public int getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(int isAdmin) {
		this.isAdmin = isAdmin;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public String getUserPhoneNum() {
		return userPhoneNum;
	}

	public void setUserPhoneNum(String userPhoneNum) {
		this.userPhoneNum = userPhoneNum;
	}

	public Timestamp getUserBirth() {
		return userBirth;
	}

	public void setUserBirth(Timestamp userBirth) {
		this.userBirth = userBirth;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public static String pageNumber(int limit) {
		String str = "";
		int temp = (pageNum - 1) % limit;
		int startPage = pageNum - temp;

		// [prev page] 버튼 출력
		if ((startPage - limit) > 0) {
			str = "<a href='listMember.jsp?pageNum=" + (startPage - 1) + "'>이전</a>&nbsp;&nbsp;";
		}

		// 페이지 번호 나열
		for (int i = startPage; i < (startPage + limit); i++) {
			if (i == pageNum) {
				str += i + "&nbsp;&nbsp;";
			} else {
				str += "<a href='listMember.jsp?pageNum=" + i + "'>" + i + "</a>&nbsp;&nbsp;";
			}
			if (i >= pageCount)
				break;
		}

		// [next page] 버튼 출력
		if ((startPage + limit) <= pageCount) {
			str += "<a href='listMember.jsp?pageNum=" + (startPage + limit) + "'>다음</a>";
		}

		return str;
	}
}
