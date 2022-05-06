package v_order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import order.OrderBean;


public class V_orderDBBean {
	private static V_orderDBBean instance = new V_orderDBBean();
	
	//��ü�� �������ִ� �޼ҵ�
	public static V_orderDBBean getInstance(){
		return instance;
	}
	
	//dbcp��ü�� �������ִ� �޼ҵ�
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:/comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	//�ֹ������� ���� �信�� ��� �ֹ������� �������� �޼ҵ�
	public ArrayList<V_orderBean> getAllOrderView(String pageNum){
		String selectQuery = "select * from v_order order by orderdate";
		String pageSetSql = "select count(*) from v_order";
		
		Connection conn = null;
		Statement stmt = null;;
		ResultSet rs = null;
		ResultSet pageSet = null;
		ArrayList<V_orderBean> orders = null;
		
		int dbCount = 0;
		int absolutePage = 1;
		
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			orders = new ArrayList<V_orderBean>();
			
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pageSet = stmt.executeQuery(pageSetSql);
			
			if (pageSet.next()) {
				dbCount = pageSet.getInt(1);
				pageSet.close();
			}
			
			if (dbCount % V_orderBean.pageSize == 0) {
				V_orderBean.pageCount = dbCount / V_orderBean.pageSize;
			}else {
				V_orderBean.pageCount = dbCount / V_orderBean.pageSize + 1;
			}
			
			if (pageNum != null) {
				V_orderBean.pageNum = Integer.parseInt(pageNum);
				absolutePage = (V_orderBean.pageNum - 1) * V_orderBean.pageSize + 1;
			}
			
			rs = stmt.executeQuery(selectQuery);
			
			if (rs.next()) {
				rs.absolute(absolutePage);
				int count = 0;
				
				while (count < V_orderBean.pageSize) {
					V_orderBean order_view = new V_orderBean();
					order_view.setOrderNum(rs.getString(1));
					order_view.setOrderDate(rs.getTimestamp(2));
					order_view.setUserID(rs.getString(3));
					order_view.setOrderRecipient(rs.getString(4));
					order_view.setOrderPhoneNum(rs.getString(5));
					order_view.setOrderAddr(rs.getString(6));
					order_view.setAmount(rs.getInt(7));
					order_view.setBookNum(rs.getInt(8));
					order_view.setBookName(rs.getString(9));
					order_view.setBookImg(rs.getString(10));
					order_view.setStatement(rs.getString(11));
					
					orders.add(order_view);
					
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
		return orders;
	}
	
	//�ֹ���ȣ�� �Ű������� �޾� �ش� �ֹ���ȣ�� �ش��ϴ� �����͸� �������� �޼ҵ�
	public V_orderBean getOrderView(String orderNum) {
		String selectQuery = "select * from v_order where ordernum=?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		V_orderBean order_view = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(selectQuery);
			pstmt.setString(1, orderNum);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				order_view = new V_orderBean();
				
				order_view.setOrderNum(orderNum);
				order_view.setOrderDate(rs.getTimestamp(2));
				order_view.setUserID(rs.getString(3));
				order_view.setOrderRecipient(rs.getString(4));
				order_view.setOrderPhoneNum(rs.getString(5));
				order_view.setOrderAddr(rs.getString(6));
				order_view.setAmount(rs.getInt(7));
				order_view.setBookNum(rs.getInt(8));
				order_view.setBookName(rs.getString(9));
				order_view.setBookImg(rs.getString(10));
				order_view.setStatement(rs.getString(11));
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
		
		return order_view;
	}
	
	public V_orderBean getNoMemberOrder(String orderNum) {
		String selectQuery = "select * from v_order where ordernum=? and userid=?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		V_orderBean order_view = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(selectQuery);
			pstmt.setString(1, orderNum);
			pstmt.setString(2, "��ȸ��");
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				order_view = new V_orderBean();
				
				order_view.setOrderNum(orderNum);
				order_view.setOrderDate(rs.getTimestamp(2));
				order_view.setUserID(rs.getString(3));
				order_view.setOrderRecipient(rs.getString(4));
				order_view.setOrderPhoneNum(rs.getString(5));
				order_view.setOrderAddr(rs.getString(6));
				order_view.setAmount(rs.getInt(7));
				order_view.setBookNum(rs.getInt(8));
				order_view.setBookName(rs.getString(9));
				order_view.setBookImg(rs.getString(10));
				order_view.setStatement(rs.getString(11));
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
		
		return order_view;
	}
}
