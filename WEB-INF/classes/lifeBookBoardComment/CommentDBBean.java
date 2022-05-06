package lifeBookBoardComment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CommentDBBean {
	private static CommentDBBean instance = new CommentDBBean();
	public static CommentDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	public ArrayList<CommentBean> getList(int boardNum) {
		Connection conn = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from boardcomment where boardnum=? order by cmtnum desc";
		ArrayList<CommentBean> cmtList = new ArrayList<CommentBean>();
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNum);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				CommentBean cmt = new CommentBean();
				cmt.setCmtNum(rs.getInt(1));
				cmt.setBoardNum(boardNum);
				cmt.setCmtContent(rs.getString(3));
				cmt.setRegDate(rs.getTimestamp(4));
				cmt.setUserIP(rs.getString(5));
				cmtList.add(cmt);
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
	
	public int write(CommentBean cmt) {
		Connection conn = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		int re = -1;
		int number;
		
		try {
			conn = getConnection();
			
			sql = "select max(cmtnum) from boardcomment";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				number = rs.getInt(1)+1;
			} else {
				number = 1;
			}
			
			sql = "insert into boardcomment values(?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setInt(2, cmt.getBoardNum());
			pstmt.setString(3, cmt.getCmtContent());
			pstmt.setTimestamp(4, cmt.getRegDate());
			pstmt.setString(5, cmt.getUserIP());
			pstmt.executeUpdate();
			
			re = 1;
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
	
	public int deleteComment(int cmtNum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		int re = -1;
		
		try {
			conn = getConnection();
			sql = "select * from boardcomment where cmtnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cmtNum);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				sql = "delete from boardcomment where cmtnum=?";
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
	
	public int editComment(CommentBean cmt) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		int re = -1;
		
		try {
			conn = getConnection();
			sql = "select * from boardcomment where cmtnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cmt.getCmtNum());
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				sql = "update boardcomment set cmtcontent=?, regdate=sysdate where cmtnum=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, cmt.getCmtContent());
				pstmt.setInt(2, cmt.getCmtNum());
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
	
	public CommentBean getComment(int cmtNum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		CommentBean cmt = null;
		
		try {
			conn = getConnection();
			sql = "select * from boardcomment where cmtnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cmtNum);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				cmt = new CommentBean();
				cmt.setCmtNum(rs.getInt(1));
				cmt.setBoardNum(rs.getInt(2));
				cmt.setCmtContent(rs.getString(3));
				cmt.setUserIP(rs.getString(4));
				cmt.setRegDate(rs.getTimestamp(5));

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
		
		return cmt;
	}
}
