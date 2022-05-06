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
	
	//OrderDBBean��ü ����
	public static ReviewDBBean getInstance(){
		return instance;
	}
	
	//DBCP ��ü ����
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:/comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	//DB�� ���並 ����ִ� �޼ҵ�
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
	
	//DB���� ���� ����Ʈ�� �������� �޼ҵ�
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
			System.out.println("1�ܰ�!");
			
			if (pageSet.next()) {
				System.out.println("2�ܰ�!");
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
			
			System.out.println("��������!");
			System.out.println(rs.next());
			if (rs.next()) {
				rs.absolute(absolutePage);
				int count = 0;
				System.out.println("if�� ����!");
				
				list = new ArrayList<ReviewBean>();
				while (count < ReviewBean.pageSize) {
					System.out.println("while�� ����!");
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
				System.out.println("�޼ҵ� ����!");
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
	
	//���� �ۼ��ڰ� ���� ������ ����� ������ Ȯ���ϴ� �޼ҵ�
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
	
	//�����ȣ�� ���̵� �Ű������ι޾� �ش� ���並 �����ϴ� �޼ҵ�
	public int deleteReview(int reviewNum, String userID) {
		int re = -1;
		
		//�ش���� �ۼ��ڰ� ���ǿ� ����� ���̵�� �������� Ȯ����
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
	
	//�����ȣ�� �Ű������� �����ϳ��� �����ϴ� �޼ҵ�
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
	
	//���� ��Ͻ� �۹�ȣ�� �����ϴ� �޼ҵ�
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
