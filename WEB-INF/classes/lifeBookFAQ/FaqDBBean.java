package lifeBookFAQ;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class FaqDBBean {
	private static FaqDBBean instance = new FaqDBBean();
	public static FaqDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	public int insertFaq(FaqBean faq) throws Exception {
		Connection conn = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		int re = -1;
		int number;
		
		try {
			conn = getConnection();
			
			sql = "select max(faqnum) from faq";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				number = rs.getInt(1)+1;
			} else {
				number = 1;
			}
			
			sql = "insert into faq(faqnum, faqcategory, faqtitle, faqcontent, regdate)"
					+ " values(?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, faq.getFaqCategory());
			pstmt.setString(3, faq.getFaqTitle());
			pstmt.setString(4, faq.getFaqContent());
			pstmt.setTimestamp(5, faq.getRegDate());
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
	
	public ArrayList<FaqBean> listFaq(String pageNumber) {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ResultSet pageSet = null;
		
		int dbCount = 0;
		int absolutePage = 1;
		
		String sql = "select * from faq order by faqnum desc";
		String pageSetSql = "select count(faqnum) from faq";
		
		ArrayList<FaqBean> faqList = new ArrayList<>();
		
		try {
			conn = getConnection();
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pageSet = stmt.executeQuery(pageSetSql);
			
			if (pageSet.next()) {
				dbCount = pageSet.getInt(1);
				pageSet.close();
			}
			
			if (dbCount % FaqBean.pageSize == 0) {
				FaqBean.pageCount = dbCount / FaqBean.pageSize;
			} else {
				FaqBean.pageCount = dbCount / FaqBean.pageSize + 1;
			}
			
			if (pageNumber != null) {
				FaqBean.pageNum = Integer.parseInt(pageNumber);
				absolutePage = (FaqBean.pageNum - 1) * FaqBean.pageSize + 1;
			}
			
			rs = stmt.executeQuery(sql);
			
			if (rs.next()) {
				rs.absolute(absolutePage);
				int count = 0;
				
				while (count < FaqBean.pageSize) {
					FaqBean faq = new FaqBean();
					
					faq.setFaqNum(rs.getInt(1));
					faq.setFaqCategory(rs.getString(2));
					faq.setFaqTitle(rs.getString(3));
					faq.setFaqContent(rs.getString(4));
					faq.setRegDate(rs.getTimestamp(5));
										
					faqList.add(faq);
					
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
		
		return faqList;
	}
	
	public FaqBean getFaq(int faqNum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		FaqBean faq = null;
		
		try {
			conn = getConnection();
			sql = "select * from faq where faqnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, faqNum);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				faq = new FaqBean();
				
				faq.setFaqNum(rs.getInt(1));
				faq.setFaqCategory(rs.getString(2));
				faq.setFaqTitle(rs.getString(3));
				faq.setFaqContent(rs.getString(4));
				faq.setRegDate(rs.getTimestamp(5));
				
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
		
		return faq;
	}
	
	public int editFaq(FaqBean faq) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		int re = -1;
		try {
			conn = getConnection();
			sql = "select * from faq where faqnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, faq.getFaqNum());
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				sql = "update faq set faqcategory=?, faqtitle=?, faqcontent=? where faqnum=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, faq.getFaqCategory());
				pstmt.setString(2, faq.getFaqTitle());
				pstmt.setString(3, faq.getFaqContent());
				pstmt.setInt(4, faq.getFaqNum());
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
	
	public int deleteFaq(int faqNum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		int re = -1;
		
		try {
			conn = getConnection();
			sql = "select * from faq where faqnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, faqNum);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				sql = "delete from faq where faqnum=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, faqNum);
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
	
	public ArrayList<FaqBean> getSearchFaq(String searchField, String searchText) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<FaqBean> faqList = new ArrayList<>();
		String sql = "select * from faq where " + searchField.trim();
		
		try {
			if (searchText != null && !searchText.equals("")) {
				sql += " like '%" + searchText.trim() + "%' order by faqnum desc";
			}
			
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				FaqBean faq = new FaqBean();
				
				faq.setFaqNum(rs.getInt(1));
				faq.setFaqCategory(rs.getString(2));
				faq.setFaqTitle(rs.getString(3));
				faq.setFaqContent(rs.getString(4));
				faq.setRegDate(rs.getTimestamp(5));
				
				faqList.add(faq);
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
		return faqList;
	}
}
