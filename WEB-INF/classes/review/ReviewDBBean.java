package review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import lifeBookBoard.BoardBean;


public class ReviewDBBean {
	
	private static ReviewDBBean instance = new ReviewDBBean();
	
	//OrderDBBean객체 생성
	public static ReviewDBBean getInstance(){
		return instance;
	}
	
	//DBCP 객체 생성
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:/comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	//DB에 리뷰를 집어넣는 메소드
	public int insertReview(ReviewBean review) {
		String insertQuery = "insert into review(reviewnum, userid, booknum, reviewtitle, reviewcontent) values(?,?,?,?,?)";
		int re = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(insertQuery);
			pstmt.setInt(1, getReviewNum());
			pstmt.setString(2, review.getUserID());
			pstmt.setInt(3, review.getBookNum());
			pstmt.setString(4, review.getReviewTitle());
			pstmt.setString(5, review.getReviewContent());
			
			re = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return re;
	}
	
	//DB에서 리뷰 리스트를 가져오는 메소드
	public ArrayList<ReviewBean> getReviewList(String pageNum){
		String selectQuery = "select reviewnum, booknum, userid, reviewtitle, regdate, hitcnt, recommend from review order by reviewnum desc";
		String pageSetSql = "select count(*) from review";
		ArrayList<ReviewBean> list = null;
		ReviewBean review = null;
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ResultSet pageSet = null;
		
		int dbCount = 0;
		int absolutePage = 1;
		
		try {
			conn = getConnection();
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pageSet = stmt.executeQuery(pageSetSql);
			System.out.println("1단계!");
			
			if (pageSet.next()) {
				System.out.println("2단계!");
				dbCount = pageSet.getInt(1);
				pageSet.close();
			}
			
			if (dbCount % ReviewBean.pageSize == 0) {
				ReviewBean.pageCount = dbCount / ReviewBean.pageSize;
			} else {
				ReviewBean.pageCount = dbCount / ReviewBean.pageSize + 1;
			}
			
			if (pageNum != null) {
				ReviewBean.pageNum = Integer.parseInt(pageNum);
				absolutePage = (ReviewBean.pageNum - 1) * ReviewBean.pageSize + 1;
			}
			
			rs = stmt.executeQuery(selectQuery);
			
			System.out.println("쿼리날림!");
			System.out.println(rs.next());
			if (rs.next()) {
				rs.absolute(absolutePage);
				int count = 0;
				System.out.println("if문 진입!");
				
				list = new ArrayList<ReviewBean>();
				while (count < ReviewBean.pageSize) {
					System.out.println("while문 진입!");
					review = new ReviewBean();
					review.setReviewNum(rs.getInt(1));
					review.setBookNum(rs.getInt(2));
					review.setUserID(rs.getString(3));
					review.setReviewTitle(rs.getString(4));
					review.setRegDate(rs.getTimestamp(5));
					review.setHitCnt(rs.getInt(6));
					review.setRecommend(rs.getInt(7));
					
					list.add(review);
					
					if (rs.isLast()) {
						break;
					} else {
						rs.next();
					}
	 				
	 				count++;
				}
				System.out.println("메소드 종료!");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pageSet != null) pageSet.close();
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return list;
	}
	
	//리뷰 작성자가 현재 접속한 사람이 같은지 확인하는 메소드
	public int checkID(int reviewNum, String userID) {
		String selectQuery = "select * from review where reviewnum=? and userid=?";
		int re = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(selectQuery);
			pstmt.setInt(1, reviewNum);
			pstmt.setString(2, userID);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				re = 1;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return re;
	}
	
	//리뷰번호와 아이디를 매개변수로받아 해당 리뷰를 삭제하는 메소드
	public int deleteReview(int reviewNum, String userID) {
		int re = -1;
		
		//해당글의 작성자가 세션에 저장된 아이디와 동일한지 확인함
		if (checkID(reviewNum, userID) == 1) {
			String deleteQuery = "delete from review where reviewnum=?";
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(deleteQuery);
				pstmt.setInt(1, reviewNum);
				
				re = pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				try {
					if(pstmt != null) pstmt.close();
					if(conn != null) conn.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			
		}
		
		return re;
	}
	
	//리뷰번호를 매개변수로 리뷰하나를 리턴하는 메소드
	public ReviewBean getReview(int reviewNum) {
		String selectQuery = "select * from review where reviewnum=?";
		ReviewBean review = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(selectQuery);
			pstmt.setInt(1, reviewNum);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				review = new ReviewBean();
				review.setReviewNum(rs.getInt(1));
				review.setUserID(rs.getString(2));
				review.setBookNum(rs.getInt(3));
				review.setReviewTitle(rs.getString(4));
				review.setReviewContent(rs.getString(5));
				review.setRegDate(rs.getTimestamp(6));
				review.setHitCnt(rs.getInt(7));
				review.setRecommend(rs.getInt(8));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return review;
	}
	
	public int updateReview(ReviewBean review) {
		String updateQuery = "update review set reviewtitle=?, reviewcontent=? where reviewnum=?";
		int re = -1;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(updateQuery);
			pstmt.setString(1, review.getReviewTitle());
			pstmt.setString(2, review.getReviewContent());
			pstmt.setInt(3, review.getReviewNum());
			
			re = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return re;
	}
	
	//리뷰 등록시 글번호를 리턴하는 메소드
	private int getReviewNum() {
		String selectQuery = "select max(reviewnum) from review";
		int re = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(selectQuery);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				re = rs.getInt(1) + 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return re;
	}
	
	public int addRec(int reviewNum) {
		String updateQuery = "update review set recommend=recommend+1 where reviewnum=?";
		int re = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(updateQuery);
			pstmt.setInt(1, reviewNum);
			
			re = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return re;
	}
}
