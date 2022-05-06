package lifeBookNotice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import lifeBookBoard.BoardBean;

public class NoticeDBBean {
	private static NoticeDBBean instance = new NoticeDBBean();
	public static NoticeDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	public int insertNotice(NoticeBean notice) throws Exception {
		Connection conn = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		int re = -1;
		int noticeNum;
		
		try {
			conn = getConnection();
			
			// 게시판 번호 세팅
			sql = "select max(noticenum) from notice";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				noticeNum = rs.getInt(1)+1;
			} else {
				noticeNum = 1;
			}
			
			// 공지사항 정보
			sql = "insert into notice(noticenum, noticetitle, noticecontent, userid, regdate) values(?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, noticeNum);
			pstmt.setString(2, notice.getNoticeTitle());
			pstmt.setString(3, notice.getNoticeContent());
			pstmt.setString(4, notice.getUserID());
			pstmt.executeUpdate();
			
			re = 1;
			
 			System.out.println("추가 성공");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("추가 실패");
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
	
	public ArrayList<NoticeBean> listNotice(String pageNum) {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ResultSet pageSet = null;
		
		int dbCount = 0;
		int absolutePage = 1;
		
		String sql = "select * from notice order by noticenum desc";
		String pageSetSql = "select count(*) from notice";
		
		ArrayList<NoticeBean> noticeList = new ArrayList<NoticeBean>();
		
		try {
			conn = getConnection();
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pageSet = stmt.executeQuery(pageSetSql);
			
			if (pageSet.next()) {
				dbCount = pageSet.getInt(1);
				pageSet.close();
			}
			
			if (dbCount % NoticeBean.pageSize == 0) {
				NoticeBean.pageCount = dbCount / NoticeBean.pageSize;
			} else {
				NoticeBean.pageCount = dbCount / NoticeBean.pageSize + 1;
			}
			
			if (pageNum != null) {
				NoticeBean.pageNum = Integer.parseInt(pageNum);
				absolutePage = (NoticeBean.pageNum - 1) * NoticeBean.pageSize + 1;
			}
			
			rs = stmt.executeQuery(sql);
			
			if (rs.next()) {
				rs.absolute(absolutePage);
				int count = 0;
				
				while (count < NoticeBean.pageSize) {
					NoticeBean notice = new NoticeBean();
					
					notice.setNoticeNum(rs.getInt(1));
					notice.setUserID(rs.getString(2));
					notice.setNoticeTitle(rs.getString(3));
					notice.setNoticeContent(rs.getString(4));
					notice.setRegDate(rs.getTimestamp(5));
					notice.setHitCnt(rs.getInt(6));
					
					noticeList.add(notice);
					
	 				if (rs.isLast()) {
						break;
					} else {
						rs.next();
					}
	 				
	 				count++;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pageSet != null) pageSet.close();
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return noticeList;
	}
	
	public NoticeBean getNotice(int noticeNum, boolean hitAdd) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		NoticeBean notice = null;
		
		try {
			conn = getConnection();
			
			if (hitAdd == true) {
				sql = "update notice set hitcnt=hitcnt+1 where noticenum=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, noticeNum);
				pstmt.executeUpdate();
			}
			
			sql = "select * from notice where noticenum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, noticeNum);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				notice = new NoticeBean();
				notice.setNoticeNum(rs.getInt(1));
				notice.setUserID(rs.getString(2));
				notice.setNoticeTitle(rs.getString(3));
				notice.setNoticeContent(rs.getString(4));
				notice.setRegDate(rs.getTimestamp(5));
				notice.setHitCnt(rs.getInt(6));
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
		
		return notice;
	}
	
	public int deleteNotice(int noticeNum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		int re = -1;
		
		try {
			conn = getConnection();
			sql = "select * from notice where noticenum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, noticeNum);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				sql = "delete from notice where noticenum=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, noticeNum);
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
	
	public int editNotice(NoticeBean notice) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		int re = -1;
		
		try {
			conn = getConnection();
			sql = "select * from notice where noticenum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, notice.getNoticeNum());
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				sql = "update notice set noticetitle=?, noticecontent=? where noticenum=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, notice.getNoticeTitle());
				pstmt.setString(2, notice.getNoticeContent());
				pstmt.setInt(3, notice.getNoticeNum());
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
