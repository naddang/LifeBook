package lifeBookQnA;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class QnaDBBean {
	private static QnaDBBean instance = new QnaDBBean();
	public static QnaDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	public int insertQna(QnaBean qna) throws Exception {
		Connection conn = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		int re = -1;
		int number;
		int qnanum = qna.getQnaNum();
		int qnaref = qna.getQnaRef();
		int qnastep = qna.getQnaStep();
		int qnalevel = qna.getQnaLevel();
		
		try {
			conn = getConnection();
			
			sql = "select max(qnanum) from qna";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				number = rs.getInt(1)+1;
			} else {
				number = 1;
			}
			
			if (qnanum != 0) {
				sql = "update qna set qnastep=qnastep+1 where qnaref=? and qnastep > ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, qnaref);
				pstmt.setInt(2, qnastep);
				pstmt.executeUpdate();
				
				qnastep = qnastep + 1;
				qnalevel = qnalevel + 1;
			} else {
				qnaref = number;
				qnastep = 0;
				qnalevel = 0;
			}
			
			sql = "insert into qna(qnanum, userid, category, qnatitle, qnacontent, qnapwd, regdate, qnaref, qnastep, qnalevel)"
					+ " values(?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, qna.getUserID());
			pstmt.setString(3, qna.getCategory());
			pstmt.setString(4, qna.getQnaTitle());
			pstmt.setString(5, qna.getQnaContent());
			pstmt.setString(6, qna.getQnaPWD());
			pstmt.setTimestamp(7, qna.getRegDate());
			pstmt.setInt(8, qnaref);
			pstmt.setInt(9, qnastep);
			pstmt.setInt(10, qnalevel);
			pstmt.executeUpdate();
			
			re = 1;
			
 			System.out.println("추가성공");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("추가실패");
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
	
	public ArrayList<QnaBean> listQna(String pageNumber) {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ResultSet pageSet = null;
		
		int dbCount = 0;
		int absolutePage = 1;
		
		String sql = "select * from qna order by qnaref desc, qnastep, qnanum desc";
		String pageSetSql = "select count(qnanum) from qna";
		
		ArrayList<QnaBean> qnaList = new ArrayList<>();
		
		try {
			conn = getConnection();
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pageSet = stmt.executeQuery(pageSetSql);
			
			if (pageSet.next()) {
				dbCount = pageSet.getInt(1);
				pageSet.close();
			}
			
			if (dbCount % QnaBean.pageSize == 0) {
				QnaBean.pageCount = dbCount / QnaBean.pageSize;
			} else {
				QnaBean.pageCount = dbCount / QnaBean.pageSize + 1;
			}
			
			if (pageNumber != null) {
				QnaBean.pageNum = Integer.parseInt(pageNumber);
				absolutePage = (QnaBean.pageNum - 1) * QnaBean.pageSize + 1;
			}
			
			rs = stmt.executeQuery(sql);
			
			if (rs.next()) {
				rs.absolute(absolutePage);
				int count = 0;
				
				while (count < QnaBean.pageSize) {
					QnaBean qna = new QnaBean();
					
					qna.setQnaNum(rs.getInt(1));
					qna.setUserID(rs.getString(2));
					qna.setCategory(rs.getString(3));
					qna.setQnaTitle(rs.getString(4));
					qna.setQnaContent(rs.getString(5));
					qna.setQnaPWD(rs.getString(6));
					qna.setRegDate(rs.getTimestamp(7));
					qna.setQnaRef(rs.getInt(8));
					qna.setQnaStep(rs.getInt(9));
					qna.setQnaLevel(rs.getInt(10));
										
					qnaList.add(qna);
					
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
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return qnaList;
	}
	
	public QnaBean getQna(int qnanum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		QnaBean qna = null;
		
		try {
			conn = getConnection();
			sql = "select * from qna where qnanum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qnanum);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				qna = new QnaBean();

				qna.setQnaNum(rs.getInt(1));
				qna.setUserID(rs.getString(2));
				qna.setCategory(rs.getString(3));
				qna.setQnaTitle(rs.getString(4));
				qna.setQnaContent(rs.getString(5));
				qna.setQnaPWD(rs.getString(6));
				qna.setRegDate(rs.getTimestamp(7));
				qna.setQnaRef(rs.getInt(8));
				qna.setQnaStep(rs.getInt(9));
				qna.setQnaLevel(rs.getInt(10));
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
		
		return qna;
	}
	
	public int editQna(QnaBean qna) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		int re = -1;
		try {
			conn = getConnection();
			sql = "select * from qna where qnanum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qna.getQnaNum());
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				sql = "update qna set category=?, qnatitle=?, qnacontent=? where qnanum=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, qna.getCategory());
				pstmt.setString(2, qna.getQnaTitle());
				pstmt.setString(3, qna.getQnaContent());
				pstmt.setInt(4, qna.getQnaNum());
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
	
	public int deleteQna(int qnanum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		int re = -1;
		
		try {
			conn = getConnection();
			sql = "select * from qna where qnanum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qnanum);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				sql = "delete from qna where qnanum=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, qnanum);
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
