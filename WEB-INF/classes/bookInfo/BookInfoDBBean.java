package bookInfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;



public class BookInfoDBBean {
	private static BookInfoDBBean instance = new BookInfoDBBean();
	
	//��ü�� �������ִ� �޼ҵ�
	public static BookInfoDBBean getInstance(){
		return instance;
	}
	
	//dbcp��ü�� �������ִ� �޼ҵ�
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:/comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	//Database�� å ������ �߰��ϴ� �޼ҵ�
	public int insertBookInfo(BookInfoBean book) {//������ ����
		String insertQuery = "insert into bookinfo values(?,?,?,?,?,?,?,?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		int re = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(insertQuery);
			pstmt.setInt(1, book.getBookNum());
			pstmt.setString(2, book.getBookName());
			pstmt.setString(3, book.getBookDetails());
			pstmt.setInt(4, book.getBookPrice());
			pstmt.setString(5, book.getBookPub());
			pstmt.setString(6, book.getAuthor());
			pstmt.setString(7, book.getBookImg());
			pstmt.setInt(8, book.getBookStock());

			re = pstmt.executeUpdate();
			
			re = 1;
			pstmt.close();
			conn.close();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				// TODO: handle exception
			}
		}
		return re;
	}
	
	//å ��ȣ�� �������� �޼ҵ�
	public int getCategoryNumber(String str_category){
		int category = Integer.parseInt(str_category+"00000");
		String selectQuery = "select count(*) from bookinfo where booknum >= ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int re = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(selectQuery);
			
			pstmt.setInt(1, category);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				re = category + rs.getInt(1) + 1;
			}
		} catch (Exception se) {
			se.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return re;
	}
	
	//DB���� å�� ������ �������� �޼ҵ�
	public ArrayList<BookInfoBean> getBookList(String pageNum, String category){
		//String selectQuery = "select * from bookinfo where booknum between ? and ? and rownum<?";
		String selectQuery = "select * from bookinfo where booknum between ? and ?";
		System.out.println("pageNum===>"+pageNum);
		System.out.println("category===>"+category);
		
//		String selectQuery2 = "select count(bookNum) from bookinfo";
		String selectQuery2 = "select count(bookNum) from bookinfo where booknum between ? and ?";
		
		String minCategory = category + "00000";
		String maxCategory = category + "99999";
		
		int dbCount=0; //���� �Ѱ���
		int absolutePage = 1;//ù��° �Խñ��� ���� ��ġ
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		//Statement stmt = null;
		ResultSet rs = null;
		
		ResultSet pageSet = null;
		
		//ArrayList<BookInfoBean> books = null;
		ArrayList<BookInfoBean> books = new ArrayList<BookInfoBean>();
		
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement(selectQuery2,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			//stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pstmt.setString(1, minCategory);
			pstmt.setString(2, maxCategory);
			pageSet = pstmt.executeQuery();
			//pageSet = stmt.executeQuery(selectQuery2);
			if (pageSet.next()) {
				dbCount = pageSet.getInt(1);
				pageSet.close();
			}
			//������ �� ���ϱ�
			if (dbCount % BookInfoBean.pageSize == 0) {//������ ������� 10
				BookInfoBean.pageCount = dbCount / BookInfoBean.pageSize;
				//10�� ����� �� �������� ���
			} else {
				BookInfoBean.pageCount = dbCount / BookInfoBean.pageSize +1;
				//10�� ����� �� �������� �ʴ� ���(ex 81~89���� ��� 9������ ����)
			}
			
			if (pageNum != null) {
				BookInfoBean.pageNum = Integer.parseInt(pageNum);
				absolutePage = (BookInfoBean.pageNum-1)*BookInfoBean.pageSize +1;
				//1������ : 0*10+1=1 / 2������ : 1*10+1=11
			}
			
			pstmt = conn.prepareStatement(selectQuery,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pstmt.setString(1, minCategory);
			pstmt.setString(2, maxCategory);
			System.out.println("@@@"+minCategory);
			System.out.println("@@@"+maxCategory);
			//pstmt.setInt(3, page*10);
			
			rs = pstmt.executeQuery();
			//books = new ArrayList<BookInfoBean>();
			
			if (rs.next()) {
				rs.absolute(absolutePage);
				int count = 0;
			
			while (count<BookInfoBean.pageSize) {
				BookInfoBean book = new BookInfoBean();
				
				book.setBookNum(rs.getInt(1));
				book.setBookName(rs.getString(2));
				book.setBookDetails(rs.getString(3));
				book.setBookPrice(rs.getInt(4));
				book.setBookPub(rs.getString(5));
				book.setAuthor(rs.getString(6));
				book.setBookImg(rs.getString(7));
				book.setBookStock(rs.getInt(8));
				
				books.add(book);
				
				if (rs.isLast()) {
					break;
				} else {
					rs.next();
				}
				count++;
				}
			}
			rs.close();
			//stmt.close();
			pstmt.close();
			conn.close();
		} catch (Exception se) {
			se.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				//if(stmt != null) stmt.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return books;
	}
	
	//�˻�� �Ű������� �޾Ƽ� �ش� �˻�� �ش�Ǵ� �����͸� �����ϴ� �޼ҵ�
	public ArrayList<BookInfoBean> searchBookList(String pageNum, String search){
		String selectQuery = "select * from bookinfo where bookname like ? or author like ?";
		String selectQuery2 = "select count(*) from bookinfo where bookname like ? or author like ?";
		search = "%"+search+"%";
		
		Connection conn = null;
		//Statement stmt = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet pageSet = null;
//		ArrayList<BookInfoBean> books = null;
		ArrayList<BookInfoBean> books = new ArrayList<BookInfoBean>();
		
		int dbCount=0; //���� �Ѱ���
		int absolutePage = 1;//ù��° �Խñ��� ���� ��ġ
		
		try {
			conn = getConnection();
			//stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			//pageSet = stmt.executeQuery(selectQuery2);
			pstmt = conn.prepareStatement(selectQuery2,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pstmt.setString(1, search);
			pstmt.setString(2, search);
			pageSet = pstmt.executeQuery();
			
			if (pageSet.next()) {
				dbCount = pageSet.getInt(1);
				pageSet.close();
			}
			//������ �� ���ϱ�
			if (dbCount % BookInfoBean.pageSize == 0) {//������ ������� 10
				BookInfoBean.pageCount = dbCount / BookInfoBean.pageSize;
				//10�� ����� �� �������� ���
			} else {
				BookInfoBean.pageCount = dbCount / BookInfoBean.pageSize +1;
				//10�� ����� �� �������� �ʴ� ���(ex 81~89���� ��� 9������ ����)
			}
			
			if (pageNum != null) {
				BookInfoBean.pageNum = Integer.parseInt(pageNum);
				absolutePage = (BookInfoBean.pageNum-1)*BookInfoBean.pageSize +1;
				//1������ : 0*10+1=1 / 2������ : 1*10+1=11
			}
			
			pstmt = conn.prepareStatement(selectQuery,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pstmt.setString(1, search);
			pstmt.setString(2, search);
			
			rs = pstmt.executeQuery();
			System.out.println("��������!");
			//books = new ArrayList<BookInfoBean>();
			
			if (rs.next()) {
				rs.absolute(absolutePage);
				int count = 0;
			
			while (count<BookInfoBean.pageSize) {
				System.out.println("while����!");
				BookInfoBean book = new BookInfoBean();
				
				book.setBookNum(rs.getInt(1));
				book.setBookName(rs.getString(2));
				book.setBookDetails(rs.getString(3));
				book.setBookPrice(rs.getInt(4));
				book.setBookPub(rs.getString(5));
				book.setAuthor(rs.getString(6));
				book.setBookImg(rs.getString(7));
				book.setBookStock(rs.getInt(8));
				
				books.add(book);
				
				if(rs.isLast()) {
					break;
				}else {
					rs.next();
				}
				count++;
			}
			}
			rs.close();
			//stmt.close();
			pstmt.close();
			conn.close();
		} catch (Exception se) {
			se.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return books;
	}
	
	//�ϳ��� å������ �����͸� �������� �޼ҵ�
	public BookInfoBean getBookInfo(int bookNum){
		String selectquery = "select * from bookinfo where booknum=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BookInfoBean book = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(selectquery);
			pstmt.setInt(1, bookNum);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				book = new BookInfoBean();
				book.setBookNum(rs.getInt(1));
				book.setBookName(rs.getString(2));
				book.setBookDetails(rs.getString(3));
				book.setBookPrice(rs.getInt(4));
				book.setBookPub(rs.getString(5));
				book.setAuthor(rs.getString(6));
				book.setBookImg(rs.getString(7));
				book.setBookStock(rs.getInt(8));
			}
		} catch (Exception se) {
			se.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return book;
	}
	
	//ī�װ��� ����Ʈ���� �������� �޼���
			public ArrayList<BookInfoBean> getCateBestList(String pageNum, String category){
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				ResultSet pageSet = null;
				String minCategory = category + "00000";
				String maxCategory = category + "99999";
				
				int dbCount=0; //���� �Ѱ���
				int absolutePage = 1;//ù��° �Խñ��� ���� ��ġ
				
//				ArrayList<BookInfoBean> books = null;	
				ArrayList<BookInfoBean> books = new ArrayList<BookInfoBean>();
				//String selectQuery = "select DISTINCT b.* , sum(o.AMOUNT) over(partition by o.booknum) from bookinfo b join order_table o on b.booknum = o.booknum where b.bookNum between ? and ? and rownum<=10";
//				String selectQuery = "select DISTINCT b.* , sum(o.AMOUNT) over(partition by o.booknum) from bookinfo b join order_table o on b.booknum = o.booknum where b.bookNum between ? and ? and rownum<=10 order by sum(o.AMOUNT) over(partition by o.booknum) desc";
//				String selectQuery = "select o.booknum, row_number() over(order by sum(o.amount) desc), b.bookname, b.bookimg, b.bookprice, b.author, b.bookpub, sum(o.amount) from order_table o join bookinfo b on o.booknum = b.booknum where b.booknum between ? and ? and rownum<=10 GROUP by o.booknum, b.bookname, b.bookimg, b.bookprice, b.author, b.bookpub";
				String selectQuery = "select o.booknum, row_number() over(order by sum(o.amount) desc), b.bookname, b.bookimg, b.bookprice, b.author, b.bookpub, sum(o.amount) from order_table o join bookinfo b on o.booknum = b.booknum where b.booknum between ? and ? GROUP by o.booknum, b.bookname, b.bookimg, b.bookprice, b.author, b.bookpub";
				String selectQuery2 = "select count(*) from (select booknum, row_number() over(order by sum(amount) desc) from order_table group by booknum)o join bookinfo b on b.booknum=o.booknum where b.booknum between ? and ?";
				try {
					conn = getConnection();
					pstmt = conn.prepareStatement(selectQuery2,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
					pstmt.setString(1, minCategory);
					pstmt.setString(2, maxCategory);
					pageSet = pstmt.executeQuery();
					
					if(pageSet.next()) {
						dbCount = pageSet.getInt(1);
						pageSet.close();
					}
					//������ �� ���ϱ�
					if (dbCount % BookInfoBean.pageSize == 0) {//������ ������� 10
						BookInfoBean.pageCount = dbCount / BookInfoBean.pageSize;
						//10�� ����� �� �������� ���
					} else {
						BookInfoBean.pageCount = dbCount / BookInfoBean.pageSize +1;
						//10�� ����� �� �������� �ʴ� ���(ex 81~89���� ��� 9������ ����)
					}
					
					if (pageNum != null) {
						BookInfoBean.pageNum = Integer.parseInt(pageNum);
						absolutePage = (BookInfoBean.pageNum-1)*BookInfoBean.pageSize +1;
						//1������ : 0*10+1=1 / 2������ : 1*10+1=11
					}
					
					pstmt = conn.prepareStatement(selectQuery,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
					pstmt.setString(1, minCategory);
					pstmt.setString(2, maxCategory);
					//pstmt.setInt(3, page*10);
					rs = pstmt.executeQuery();
					//books = new ArrayList<BookInfoBean>();
					if (rs.next()) {
						rs.absolute(absolutePage);
						int count = 0;
						
					while (count<BookInfoBean.pageSize) {
						BookInfoBean book = new BookInfoBean();
						book.setBookNum(rs.getInt(1));
						book.setBookName(rs.getString(3));
						book.setBookImg(rs.getString(4));
						book.setBookPrice(rs.getInt(5));
						book.setAuthor(rs.getString(6));
						book.setBookPub(rs.getString(7));

						books.add(book);
						
						if (rs.isLast()) {
							break;
						} else {
							rs.next();
						}
						count++;
						}
					}
				} catch (Exception se) {
					se.printStackTrace();
				}finally {
					try {
						if(rs != null) rs.close();
						if(pstmt != null) pstmt.close();
						if(conn != null) conn.close();
					} catch (Exception e) {
						// TODO: handle exception
					}
				}
				
				return books;
			}
			
			public ArrayList<BookInfoBean> getBestList(){
				ArrayList<BookInfoBean> books = new ArrayList<BookInfoBean>();
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String selectQuery = "select o.booknum, row_number() over(order by sum(o.amount) desc), b.bookname, b.bookimg, b.bookprice, b.author, b.bookpub, sum(o.amount) from order_table o join bookinfo b on o.booknum = b.booknum GROUP by o.booknum, b.bookname, b.bookimg, b.bookprice, b.author, b.bookpub";
				
				try {
					conn = getConnection();
					pstmt = conn.prepareStatement(selectQuery);
					rs = pstmt.executeQuery();
					
					while (rs.next()) {
						BookInfoBean book = new BookInfoBean();
						book.setBookNum(rs.getInt("bookNum"));
						book.setBookImg(rs.getString("bookImg"));
						book.setBookName(rs.getNString("bookName"));
						book.setAuthor(rs.getString("author"));
						book.setBookPub(rs.getNString("bookPub"));
						book.setBookPrice(rs.getInt("bookPrice"));						
						
						books.add(book);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}finally {
					try {
						if(rs != null) rs.close();
						if(pstmt != null) pstmt.close();
						if(conn != null) conn.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				return books;
			}
}
