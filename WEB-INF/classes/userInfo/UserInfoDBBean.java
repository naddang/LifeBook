package userInfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;


public class UserInfoDBBean {
	
	private static UserInfoDBBean instance=new UserInfoDBBean();
	
	public static UserInfoDBBean getInstance() {
		return instance;
	}
	
	//dbcp ��ü����
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	//userinfo�� �����͸� �ִ� �޼ҵ�
	public int insertUser(UserInfoBean user) {
		String sql="insert into userinfo values(?,?,?,?,?,?,?,?)";
		int re=-1;
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPWD());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserPhoneNum());
			pstmt.setString(5, user.getUserAddr());
			pstmt.setTimestamp(6, user.getUserBirth());
			pstmt.setInt(7, 0);
			pstmt.setInt(8, user.getIsAdmin());
			
			pstmt.executeUpdate();
			
			re=1;
			
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
	
	//���Ե� ���̵����� Ȯ���ϴ� �޼ҵ�
	public int confirmID(String userID) { 
		String sql = "select userid from userinfo where userid=?";
		int re = -1;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			
 			rs = pstmt.executeQuery();
 			
 			if (rs.next()) { //�̹� �ִ� ���̵��� ���
 				re = 1;
			}else { //���� ���̵��� ���
				re = -1;
			}
 			
 			rs.close();
 			pstmt.close();
 			conn.close();
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
	
	//���̵�� ��й�ȣ�� �´��� Ȯ��
	public int userCheck(String userID, String userPWD){ 
		String sql = "select userpwd from userinfo where userid=?";
		int re = -1;
		String realPWD;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			
 			rs = pstmt.executeQuery();
 			
 			if(rs.next()) {
 				realPWD = rs.getString("userpwd");
 				
 				if (realPWD.equals(userPWD)) { // �Ű����� pwd�� db���� �����°��� ������ �˻�
					re = 1;
				}else {
					re = 0;
				}
 			}else {
 				re=-1;
			}
 			
 			rs.close();
 			pstmt.close();
 			conn.close();
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
	
	//���ǿ� ������ id���� �Ű������� ���� ������ �������� �޼ҵ�
	public UserInfoBean getUser(String userID){
		System.out.println(userID);
		String sql="select userid, userpwd, userphonenum, useraddr, userbirth, point, isadmin, username from userinfo where userid=?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		UserInfoBean user = null;
		
		try {
			System.out.println("try����!");
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			
 			rs = pstmt.executeQuery();
 			System.out.println("��������!!");
 			
 			if (rs.next()) {
 				System.out.println("if�� ����!!!");
 				user = new UserInfoBean();
 				
 				user.setUserID(rs.getString("userid"));
 				user.setUserPWD(rs.getString("userpwd"));
 				user.setUserName(rs.getString("username"));
 				user.setUserPhoneNum(rs.getString("userphonenum"));
 				user.setUserAddr(rs.getString("useraddr"));
 				user.setUserBirth(rs.getTimestamp("userbirth"));
 				user.setPoint(rs.getInt("point"));
 				user.setIsAdmin(rs.getInt("isadmin"));
 				
 				System.out.println(rs.getString("userid"));
			}
 			System.out.println("if�� ����!!!");
 			
 			rs.close();
 			pstmt.close();
 			conn.close();
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
		
		return user;
	}
	
	public ArrayList<UserInfoBean> getAllUser(String pageNum){
		String selectQuery = "select * from userinfo";
		String pageSetSql = "select count(*) from userinfo";
		
		Connection conn = null;
		Statement stmt = null;;
		ResultSet rs = null;
		ResultSet pageSet = null;
		ArrayList<UserInfoBean> users = null;
		
		int dbCount = 0;
		int absolutePage = 1;
		
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			users = new ArrayList<UserInfoBean>();
			
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pageSet = stmt.executeQuery(pageSetSql);
			
			if (pageSet.next()) {
				dbCount = pageSet.getInt(1);
				pageSet.close();
			}
			
			if (dbCount % UserInfoBean.pageSize == 0) {
				UserInfoBean.pageCount = dbCount / UserInfoBean.pageSize;
			}else {
				UserInfoBean.pageCount = dbCount / UserInfoBean.pageSize + 1;
			}
			
			if (pageNum != null) {
				UserInfoBean.pageNum = Integer.parseInt(pageNum);
				absolutePage = (UserInfoBean.pageNum - 1) * UserInfoBean.pageSize + 1;
			}
			
			rs = stmt.executeQuery(selectQuery);
			
			if (rs.next()) {
				rs.absolute(absolutePage);
				int count = 0;
				
				while (count < UserInfoBean.pageSize) {
					UserInfoBean user = new UserInfoBean();
					user.setUserID(rs.getString(1));
					user.setUserPWD(rs.getString(2));
					user.setUserName(rs.getString(3));
					user.setUserPhoneNum(rs.getString(4));
					user.setUserAddr(rs.getString(5));
					user.setUserBirth(rs.getTimestamp(6));
					user.setPoint(rs.getInt(7));
					user.setIsAdmin(rs.getInt(8));
					
					users.add(user);
					
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
		return users;
	}
	
	//ȸ�������� �����ϴ� �޼ҵ�
	public int updateUser(UserInfoBean user) {
		String sql="update userinfo set userpwd=?, useraddr=?, userphonenum=? where userid=?";
		int re=-1;
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		try {
			conn=getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserPWD());
			pstmt.setString(2, user.getUserAddr());
			pstmt.setString(3, user.getUserPhoneNum());
			pstmt.setString(4, user.getUserID());
			
			re = pstmt.executeUpdate();
			
 			pstmt.close();
 			conn.close();
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
	
	//ȸ�������� �����ϴ� �޼ҵ�
	public int deleteUser(String userID, String userPWD) {
		String sql = "";
		String pwd = "";
		int re = -1;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			sql = "select userpwd from userinfo where userid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				pwd = rs.getString(1);
				pstmt.close();
				
				if (pwd.equals(userPWD)) {
					sql="delete from userinfo where userid=?";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, userID);
					
					pstmt.executeUpdate();
					
					re = 1;
				}else {
					re = 0;
				}
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
		System.out.println(re);
		return re;
	}
	
	//�����ڸ� 1, �Ϲ�ȸ���̸� 0�� �����ϴ� �޼ҵ�
	public int isAdmin(String userID) {
		String sql="select isadmin from userinfo where userid=?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int adminYN = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			
 			rs = pstmt.executeQuery();
 			
 			if (rs.next()) {
 				adminYN = rs.getInt(1);
 			}
 			
 			rs.close();
 			pstmt.close();
 			conn.close();
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
		
		return adminYN;
	}
	public String findId(String userName, String userPhoneNum) { //���̵� ã�� �޼ҵ�
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		String uid = null; //���Ϲ��� �������̵�
		
		try {
			conn = getConnection();
			sql = "select userid from userinfo where username=? and userphonenum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userName);
			pstmt.setString(2, userPhoneNum);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				uid = rs.getString("userid");
			}
		} catch (Exception e) {
				e.printStackTrace();
		}
		return uid;
	}
	
	public String findPwd(String userName, String userID, String userPhoneNum) { //��й�ȣ ã�� �޼ҵ�
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		String pwd = null; //���Ϲ��� ������й�ȣ
		
		try {
			conn = getConnection();
			sql = "select userpwd from userinfo where username=? and userid=? and userphonenum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userName);
			pstmt.setString(2, userID);
			pstmt.setString(3, userPhoneNum);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				pwd = rs.getString("userpwd");
			}
		} catch (Exception e) {
				e.printStackTrace();
		}
		return pwd;
	}
	public int registerIdCheck(String userID) { //���̵� �ߺ�üũ
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		int result = -1;
		
		try {
			conn = getConnection();
			sql=("select userid from userinfo where userid=?");
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) { //�̹� �����ϴ� ���̵�
				result = 0;
			}else {
				result = 1;
			}
			
			System.out.println("���̵� �ߺ�üũ��� :"+"result");
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return result;
	}
	
	public static void makeCookie(HttpServletResponse response, String cName, String cValue, int cTime) {
		Cookie cookie = new Cookie(cName, cValue);  //��� ����
		cookie.setPath("/");                        //��� ����
		cookie.setMaxAge(cTime);                    //���� �Ⱓ ����
		response.addCookie(cookie);                 //���� ��ü�� �߰�
	}
	
	//����� �̸��� ��Ű�� ã�� �� ���� ��ȯ��.
	public static String readCookie(HttpServletRequest request, String cName) {
		String cookieValue = "";
		
		Cookie[] cookies = request.getCookies();  //Ŭ���̾�Ʈ�� ������ ��Ű ����� �޾Ƽ�
		if (cookies != null) {   //��Ű�� �����Ѵٸ�
			for(Cookie c : cookies) {
				String cookieName = c.getName();
				if (cookieName.equals(cName)) {   //���� cName�� �̸��� ���� ��Ű�� �ִٸ�
					cookieValue = c.getValue();   //��ȯ ���� �����Ѵ�
				}
			}
		}
		return cookieValue;   //�� ���� ��ȯ��.
	}
	
	//����� �̸��� ��Ű�� ������.
	public static void deleteCookie(HttpServletResponse response, String cName) {
		makeCookie(response, cName, "", 0);     //����ִ� ���ڿ��� ��Ű ����, ���� �Ⱓ�� 0���� �ο���
	}
}

