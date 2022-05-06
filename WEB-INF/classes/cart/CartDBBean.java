package cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import order.OrderDBBean;


public class CartDBBean {
	private static CartDBBean instance = new CartDBBean();
	
	public static CartDBBean getinstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:/comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	
	public int insertCart(CartBean cart) {
		String insertQuery = "insert into cart values(?,?,?,?,?)";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		int re = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(insertQuery);
			pstmt.setString(1, getCartNum(cart.getUserID()));
			pstmt.setString(2, cart.getUserID());
			pstmt.setInt(3, cart.getBookNum());
			pstmt.setInt(4, getBookPrice(cart.getBookNum()) * cart.getQuantity());
			pstmt.setInt(5, cart.getQuantity());

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
				e.printStackTrace();
			}
		}
		return re;
	}
	
	public ArrayList<CartBean> getCartList(String userID){
		String selectQuery = "select * from cart where userID=?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<CartBean> cartList = null;
		CartBean cart = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(selectQuery);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			cartList = new ArrayList<CartBean>();
			while (rs.next()) {
				cart = new CartBean();
				cart.setCartNum(rs.getString(1));
				cart.setUserID(rs.getString(2));
				cart.setBookNum(rs.getInt(3));
				cart.setTotalPrice(rs.getInt(4));
				cart.setQuantity(rs.getInt(5));
				
				cartList.add(cart);
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
		
		return cartList;
	}
	
	public int deleteCart(String cartNum) {
		String deleteQuery = "delete from cart where cartNum=?";
		int re = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(deleteQuery);
			pstmt.setString(1, cartNum);
			
			re = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return re;
	}
	
	private int getBookPrice(int bookNum) {
		String selectQuery = "select bookprice from bookinfo where booknum=?";
		int re = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(selectQuery);
			pstmt.setInt(1, bookNum);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				re = rs.getInt(1);
			}
			
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return re;
	}
	
	public CartBean getCart(String cartNum) {
		String selectQuery = "select * from cart where cartnum=?";
		CartBean cart = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(selectQuery);
			pstmt.setString(1, cartNum);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				cart = new CartBean();
				cart.setCartNum(cartNum);
				cart.setUserID(rs.getString(2));
				cart.setBookNum(rs.getInt(3));
				cart.setTotalPrice(rs.getInt(4));
				cart.setQuantity(rs.getInt(5));
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
		return cart;
	}
	
	
	private String getCartNum(String userID) {
		String selectQuery = "select max(cartnum) from cart where cartNum like ?";
		String cartNum = "";
		
		//오늘 날짜와 주문번호 패턴 지정
		LocalDateTime now = LocalDateTime.now();
		String pattenOfNum = DateTimeFormatter.ofPattern("yyMMdd").format(now);
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(selectQuery);
			pstmt.setString(1, pattenOfNum+"%");
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				pattenOfNum = DateTimeFormatter.ofPattern("yyMMdd0000").format(now);
				cartNum = String.valueOf(rs.getLong(1) + 1);
				System.out.println(rs.getInt(1));
				System.out.println(cartNum);
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
		return cartNum;
	}
	
	public int insertSelectedOrder(String[] cartNum, String recipient, String addr, String phoneNum, String userID) {
		String insertQuery = "insert into order_table(ordernum, userid, booknum, orderrecipient, orderphonenum, orderaddr, amount) values(?,?,?,?,?,?,?)";
		String updateQuery = "update bookinfo set update bookinfo set bookstock=boostock-? where booknum=?";
		System.out.println("배열크기:"+cartNum.length);
		int re = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			CartDBBean cartDB = CartDBBean.getinstance();
			OrderDBBean orderDB = OrderDBBean.getInstance();
			CartBean cart = null;
			for (int i = 1; i < cartNum.length; i++) {
				pstmt = conn.prepareStatement(insertQuery);
				long orderNum = orderDB.getTodayOrderNumber();
				cart = cartDB.getCart(cartNum[i]);
				System.out.println(cartNum[i]);
				pstmt.setLong(1, orderNum);
				pstmt.setString(2, userID);
				pstmt.setInt(3, cart.getBookNum());
				pstmt.setString(4, recipient);
				pstmt.setString(5, phoneNum);
				pstmt.setString(6, addr);
				pstmt.setInt(7, cart.getQuantity());
				
				pstmt.executeUpdate();
				deleteCart(cartNum[i]);
				pstmt.close();
				
				pstmt = conn.prepareStatement(updateQuery);
				pstmt.setInt(1, cart.getQuantity());
				pstmt.setInt(2, cart.getBookNum());
			}
			re = 1;
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
	
	public int deleteAllMyCart(String userID) {
		String deleteQuery = "delete from cart where userid=?";
		int re = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(deleteQuery);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			re = 1;
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

	public int modifyQuantity(int quantity, String cartNum) {
		String selectQuery = "update cart set quantity=?, totalprice=? where cartnum=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		int re = -1;
		try {
			CartBean cart = getCart(cartNum);
			conn = getConnection();
			pstmt = conn.prepareStatement(selectQuery);
			pstmt.setInt(1, quantity);
			System.out.println(quantity);
			pstmt.setInt(2, getBookPrice(cart.getBookNum()) * quantity);
			System.out.println(getBookPrice(cart.getBookNum()) * quantity);
			pstmt.setString(3, cartNum);
			System.out.println(cartNum);
			pstmt.executeUpdate();
			re=1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return re;
		
	}
}