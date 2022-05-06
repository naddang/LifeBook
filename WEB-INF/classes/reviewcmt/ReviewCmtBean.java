package reviewcmt;

import java.sql.Timestamp;

public class ReviewCmtBean {
	private int rvCmtNum, reviewNum;
	private String rvCmtContent;
	private Timestamp regDate;
	
	public int getRvCmtNum() {
		return rvCmtNum;
	}
	public void setRvCmtNum(int rvCmtNum) {
		this.rvCmtNum = rvCmtNum;
	}
	public int getReviewNum() {
		return reviewNum;
	}
	public void setReviewNum(int reviewNum) {
		this.reviewNum = reviewNum;
	}
	public String getRvCmtContent() {
		return rvCmtContent;
	}
	public void setRvCmtContent(String rvCmtContent) {
		this.rvCmtContent = rvCmtContent;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
}
