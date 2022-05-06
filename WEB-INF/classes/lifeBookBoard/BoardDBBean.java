package lifeBookBoard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDBBean {
	private static BoardDBBean instance = new BoardDBBean();
	public static BoardDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	public int insertBoard(BoardBean board) throws Exception {
		Connection conn = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		int re = -1;
		int boardNum;
		
		try {
			conn = getConnection();
			
			// 게시판 번호 세팅
			sql = "select max(boardnum) from board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				boardNum = rs.getInt(1)+1;
			} else {
				boardNum = 1;
			}
			
			pstmt.close();
			
			// 게시판 정보
			sql = "insert into board values(?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNum);
			pstmt.setString(2, board.getUserID());
			pstmt.setString(3, board.getBoardTitle());
			pstmt.setString(4, board.getBoardContent());
			pstmt.setTimestamp(5, board.getRegDate());
			pstmt.setString(6, board.getUserIP());
			pstmt.setString(7, board.getFileName());
			pstmt.setInt(8, board.getFileSize());
			pstmt.setString(9, board.getRealFileName());
			pstmt.setInt(10, 0);
			pstmt.setInt(11, board.getRecommend());
			
			pstmt.executeUpdate();
			
			re = 1;
			
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
	
	public ArrayList<BoardBean> listBoard(String pageNum) {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ResultSet pageSet = null;
		
		int dbCount = 0;
		int absolutePage = 1;
		
		String sql = "select * from board order by boardnum desc";
		String pageSetSql = "select count(*) from board";
		
		ArrayList<BoardBean> boardList = new ArrayList<BoardBean>();
		
		try {
			conn = getConnection();
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pageSet = stmt.executeQuery(pageSetSql);
			
			if (pageSet.next()) {
				dbCount = pageSet.getInt(1);
				pageSet.close();
			}
			
			if (dbCount % BoardBean.pageSize == 0) {
				BoardBean.pageCount = dbCount / BoardBean.pageSize;
			} else {
				BoardBean.pageCount = dbCount / BoardBean.pageSize + 1;
			}
			
			if (pageNum != null) {
				BoardBean.pageNum = Integer.parseInt(pageNum);
				absolutePage = (BoardBean.pageNum - 1) * BoardBean.pageSize + 1;
			}
			
			rs = stmt.executeQuery(sql);
			
			if (rs.next()) {
				rs.absolute(absolutePage);
				int count = 0;
				
				while (count < BoardBean.pageSize) {
					BoardBean board = new BoardBean();
					
					board.setBoardNum(rs.getInt(1));
					board.setUserID(rs.getString(2));
					board.setBoardTitle(rs.getString(3));
					board.setBoardContent(rs.getString(4));
					board.setRegDate(rs.getTimestamp(5));
					board.setUserIP(rs.getString(6));
					board.setFileName(rs.getString(7));
					board.setFileSize(rs.getInt(8));
					board.setRealFileName(rs.getString(9));
					board.setHitCnt(rs.getInt(10));
					board.setRecommend(rs.getInt(11));
					
					boardList.add(board);
					
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
		
		return boardList;
	}
	
	public BoardBean getBoard(int boardNum, boolean hitAdd) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		BoardBean board = null;
		
		try {
			conn = getConnection();
			
			if (hitAdd == true) {
				sql = "update board set hitcnt=hitcnt+1 where boardnum=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, boardNum);
				pstmt.executeUpdate();
			}
			
			sql = "select * from board where boardnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNum);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				board = new BoardBean();
				board.setBoardNum(rs.getInt(1));
				board.setUserID(rs.getString(2));
				board.setBoardTitle(rs.getString(3));
				board.setBoardContent(rs.getString(4));
				board.setRegDate(rs.getTimestamp(5));
				board.setUserIP(rs.getString(6));
				board.setFileName(rs.getString(7));
				board.setFileSize(rs.getInt(8));
				board.setRealFileName(rs.getString(9));
				board.setHitCnt(rs.getInt(10));
				board.setRecommend(rs.getInt(11));
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
		
		return board;
	}
	
	public int deleteBoard(int boardNum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		int re = -1;
		
		try {
			conn = getConnection();
			sql = "select * from board where boardnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNum);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				sql = "delete from board where boardnum=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, boardNum);
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
	
	public int editBoard(BoardBean board) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		int re = -1;
		
		try {
			conn = getConnection();
			sql = "select * from board where boardnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board.getBoardNum());
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				sql = "update board set boardtitle=?, boardcontent=? where boardnum=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, board.getBoardTitle());
				pstmt.setString(2, board.getBoardContent());
				pstmt.setInt(3, board.getBoardNum());
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
	
	public ArrayList<BoardBean> getSearch(String searchField, String searchText) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<BoardBean> boardList = new ArrayList<BoardBean>();
		String sql = "select * from board where " + searchField.trim();
		
		try {
			if (searchText != null && !searchText.equals("")) {
				sql += " like '%" + searchText.trim() + "%' order by boardnum desc";
			}
			
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				BoardBean board = new BoardBean();
				
				board.setBoardNum(rs.getInt(1));
				board.setUserID(rs.getString(2));
				board.setBoardTitle(rs.getString(3));
				board.setBoardContent(rs.getString(4));
				board.setRegDate(rs.getTimestamp(5));
				board.setUserIP(rs.getString(6));
				board.setFileName(rs.getString(7));
				board.setFileSize(rs.getInt(8));
				board.setRealFileName(rs.getString(9));
				board.setHitCnt(rs.getInt(10));
				board.setRecommend(rs.getInt(11));
				
				boardList.add(board);
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
		return boardList;
	}
	
	public BoardBean getFileName(int boardNum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select filename, realfilename from board where boardnum=?";
		BoardBean board = null;
		
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNum);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				board = new BoardBean();
				board.setFileName(rs.getString(1));
				board.setRealFileName(rs.getString(2));
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
		
		return board;
	}
	
	public int recBoard(int boardNum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "update board set recommend=recommend+1, hitcnt=hitcnt-1 where boardnum=?";
		int re = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNum);
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
}
