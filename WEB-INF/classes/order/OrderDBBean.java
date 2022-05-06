package order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class OrderDBBean {

	private static OrderDBBean instance = new OrderDBBean();
	
	//OrderDBBean객체 생성
	public static OrderDBBean getInstance(){
		return instance;
	}
	
	//DBCP 객체 생성
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:/comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	//주문테이블에 주문정보 삽입하는 메소드
	public int insertOrder(OrderBean order) {
		String insertQuery = "insert into order_table(ordernum, userid, booknum, orderrecipient, orderphonenum, orderaddr, amount) values(?,?,?,?,?,?,?)";
		String updateQuery = "update bookinfo set bookstock=boostock-? where booknum=?";
		int re = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(insertQuery);
			pstmt.setString(1, order.getOrderNum());
			System.out.println(order.getOrderNum());
			pstmt.setString(2, order.getUserID());
			System.out.println(order.getUserID());
			pstmt.setInt(3, order.getBookNum());
			System.out.println(order.getBookNum());
			pstmt.setString(4, order.getOrderRecipient());
			System.out.println(order.getOrderRecipient());
			pstmt.setString(5, order.getOrderPhoneNum());
			System.out.println(order.getOrderPhoneNum());
			pstmt.setString(6, order.getOrderAddr());
			System.out.println(order.getOrderAddr());
			pstmt.setInt(7, order.getAmount());
			System.out.println(order.getAmount());
			
			re = pstmt.executeUpdate();//삽입 성공시 re=1이 됨
			pstmt.close();
			
			pstmt = conn.prepareStatement(updateQuery);
			pstmt.setInt(1, order.getAmount());
			pstmt.setInt(2, order.getBookNum());
			
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
	
	//모든 주문정보를 가져오는 테이블
	public ArrayList<OrderBean> getAllOrder(String pageNum) {
		String selectQuery = "select * from order_table order by orderdate desc";
		String pageSetSql = "select count(*) from order_table";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		Statement stmt = null;;
		ResultSet rs = null;
		ResultSet pageSet = null;
		
		int dbCount = 0;
		int absolutePage = 1;
		
		ArrayList<OrderBean> orders = null;
		OrderBean order = null;
		
		try {
			orders = new ArrayList<OrderBean>();
			conn = getConnection();
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pageSet = stmt.executeQuery(pageSetSql);
			
			if (pageSet.next()) {
				dbCount = pageSet.getInt(1);
				pageSet.close();
			}
			
			if (dbCount % OrderBean.pageSize == 0) {
				OrderBean.pageCount = dbCount / OrderBean.pageSize;
			}else {
				OrderBean.pageCount = dbCount / OrderBean.pageSize + 1;
			}
			
			if (pageNum != null) {
				OrderBean.pageNum = Integer.parseInt(pageNum);
				absolutePage = (OrderBean.pageNum - 1) * OrderBean.pageSize + 1;
			}
			pstmt = conn.prepareStatement(selectQuery);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				rs.absolute(absolutePage);
				int count = 0;
				
				while (count < OrderBean.pageSize) {
					order = new OrderBean();
					
					order.setOrderNum(rs.getString(1));
					order.setUserID(rs.getString(2));
					order.setBookNum(rs.getInt(3));
					order.setOrderDate(rs.getTimestamp(4));
					order.setAmount(rs.getInt(8));
					
					orders.add(order);
					
					if (rs.isLast()) {
						break;
					}else {
						rs.next();
					}
					
					count++;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pageSet != null) pageSet.close();
				if(stmt != null) stmt.close();
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return orders;
	}
	
	//주문변수를 매개변수로 주문정보를 가져오는 메소드
	public OrderBean getOrder(String orderNum) {
		String selectQuery = "select * from order_table where ordernum=?";
		OrderBean order = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(selectQuery);
			pstmt.setString(1, orderNum);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				order = new OrderBean();
				order.setOrderNum(rs.getString(1));
				order.setUserID(rs.getString(2));
				order.setBookNum(rs.getInt(3));
				order.setOrderDate(rs.getTimestamp("orderdate"));
				order.setAmount(rs.getInt("amount"));
				order.setStatement(rs.getString("STATEMENT"));
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
		return order;
	}
	
	//아이디를 매개변수로 받아서 해당 아이디에 해당하는 주문정보를 받아오는 메소드
	public ArrayList<OrderBean> getMyOrder(String userID){
		String selectQuery = "select ordernum, userid, booknum, amount, orderdate, orderaddr, orderphonenum, statement from order_table where userID=?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<OrderBean> orders = null;
		OrderBean order = null;
		
		try {
			orders = new ArrayList<OrderBean>();
			conn = getConnection();
			pstmt = conn.prepareStatement(selectQuery);
			pstmt.setString(1, userID);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				order = new OrderBean();
				
				order.setOrderNum(rs.getString(1));
				order.setUserID(rs.getString(2));
				order.setBookNum(rs.getInt(3));
				order.setAmount(rs.getInt(4));
				order.setOrderDate(rs.getTimestamp(5));
				order.setOrderAddr(rs.getString(6));
				order.setOrderPhoneNum(rs.getString(7));
				order.setStatement(rs.getString(8));
				
				orders.add(order);
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
		return orders;
	}
	
	//넣어야 할 주문번호를 리턴하는 메소드
	public long getTodayOrderNumber() {
		String selectQuery = "select count(*) from order_table where to_char(orderdate,'yymmdd') = to_char(sysdate,'yymmdd')";
		long num = 0;
		
		//오늘 날짜와 주문번호 패턴 지정
		LocalDateTime now = LocalDateTime.now();
		String pattenOfOrderNum = DateTimeFormatter.ofPattern("yyMMdd0000").format(now);
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(selectQuery);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				num = Long.parseLong(pattenOfOrderNum) + rs.getInt(1) + 1;
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
		return num;
	}
	public int updateOrderStatement(String orderNum, String statement) {
		String updateQuery = "update order_table set statement=? where ordernum=?";
		int re = -1; // 실패했을 때 리턴할 숫자
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(updateQuery);
			pstmt.setString(1, statement);
			pstmt.setString(2, orderNum);
			
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
