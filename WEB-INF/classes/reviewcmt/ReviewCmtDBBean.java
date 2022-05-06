package reviewcmt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import lifeBookBoardComment.CommentBean;


public class ReviewCmtDBBean {
private static ReviewCmtDBBean instance = new ReviewCmtDBBean();
	
	//OrderDBBean梓端 持失
	public static ReviewCmtDBBean getInstance(){
		return instance;
	}
	
	//DBCP 梓端 持失
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:/comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	public int insertRvCmt(ReviewCmtBean reviewCmt) {
		String insertQuery = "insert into reviewcmt(rvcmtnum, reviewnum, rvcmtcontent) values(?,?,?)";
		int re = 0;
		
		Connection conn = null; 
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(insertQuery);
			pstmt.setInt(1, getRvCmtNum());
			System.out.println(getRvCmtNum());
			pstmt.setInt(2, reviewCmt.getReviewNum());
			System.out.println(reviewCmt.getReviewNum());
			pstmt.setString(3, reviewCmt.getRvCmtContent());
			System.out.println(reviewCmt.getRvCmtContent());
			
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
	
	public int getRvCmtNum() {
		String selectQuery = "select max(rvcmtnum) from reviewcmt";
		int re = 1;
		
		Connection conn = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			pstmt= conn.prepareStatement(selectQuery);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				re = rs.getInt(1)+1;
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
	
	public ArrayList<ReviewCmtBean> getList(int reviewNum) {
		Connection conn = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from reviewcmt where reviewnum=? order by rvcmtnum desc";
		ArrayList<ReviewCmtBean> cmtList = new ArrayList<ReviewCmtBean>();
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reviewNum);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				ReviewCmtBean rvCmt = new ReviewCmtBean();
				rvCmt.setRvCmtNum(rs.getInt(1));
				rvCmt.setReviewNum(rs.getInt(2));
				rvCmt.setRvCmtContent(rs.getString(3));
				rvCmt.setRegDate(rs.getTimestamp(4));
				cmtList.add(rvCmt);
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
		
		return cmtList;
	}
	
	public int deleteRvCmt(int cmtNum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		int re = -1;
		
		try {
			conn = getConnection();
			sql = "select * from reviewcmt where rvcmtnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cmtNum);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				sql = "delete from reviewcmt where rvcmtnum=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, cmtNum);
				pstmt.executeUpdate();
				re = 1;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
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
	
	public int updateRvCmt(ReviewCmtBean rvCmt) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		int re = -1;
		
		try {
			conn = getConnection();
			sql = "select * from reviewcmt where rvcmtnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rvCmt.getRvCmtNum());
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				sql = "update reviewcmt set rvcmtcontent=?, regdate=sysdate where rvcmtnum=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, rvCmt.getRvCmtContent());
				pstmt.setInt(2, rvCmt.getRvCmtNum());
				pstmt.executeUpdate();
				re = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
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
	
}
