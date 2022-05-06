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
	
	//dbcp 객체생성
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	//userinfo에 데이터를 넣는 메소드
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
	
	//가입된 아이디인지 확인하는 메소드
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
 			
 			if (rs.next()) { //이미 있는 아이디인 경우
 				re = 1;
			}else { //없는 아이디인 경우
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
	
	//아이디와 비밀번호가 맞는지 확인
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
 				
 				if (realPWD.equals(userPWD)) { // 매개변수 pwd와 db에서 가져온값이 같은지 검사
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
	
	//세션에 저장한 id값을 매개변수로 유저 정보를 가져오는 메소드
	public UserInfoBean getUser(String userID){
		System.out.println(userID);
		String sql="select userid, userpwd, userphonenum, useraddr, userbirth, point, isadmin, username from userinfo where userid=?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		UserInfoBean user = null;
		
		try {
			System.out.println("try진입!");
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			
 			rs = pstmt.executeQuery();
 			System.out.println("쿼리날림!!");
 			
 			if (rs.next()) {
 				System.out.println("if문 진입!!!");
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
 			System.out.println("if문 종료!!!");
 			
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
	
	//회원정보를 수정하는 메소드
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
	
	//회원정보를 삭제하는 메소드
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
	
	//관리자면 1, 일반회원이면 0을 리턴하는 메소드
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
	public String findId(String userName, String userPhoneNum) { //아이디 찾기 메소드
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		String uid = null; //리턴받을 유저아이디
		
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
	
	public String findPwd(String userName, String userID, String userPhoneNum) { //비밀번호 찾기 메소드
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		String pwd = null; //리턴받을 유저비밀번호
		
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
	public int registerIdCheck(String userID) { //아이디 중복체크
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
			
			if (rs.next()) { //이미 존재하는 아이디
				result = 0;
			}else {
				result = 1;
			}
			
			System.out.println("아이디 중복체크결과 :"+"result");
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return result;
	}
	
	public static void makeCookie(HttpServletResponse response, String cName, String cValue, int cTime) {
		Cookie cookie = new Cookie(cName, cValue);  //쿠기 생성
		cookie.setPath("/");                        //경로 설정
		cookie.setMaxAge(cTime);                    //유지 기간 설정
		response.addCookie(cookie);                 //응답 객체에 추가
	}
	
	//명시한 이름의 쿠키를 찾아 그 값을 반환함.
	public static String readCookie(HttpServletRequest request, String cName) {
		String cookieValue = "";
		
		Cookie[] cookies = request.getCookies();  //클라이언트가 보내온 쿠키 목록을 받아서
		if (cookies != null) {   //쿠키가 존재한다면
			for(Cookie c : cookies) {
				String cookieName = c.getName();
				if (cookieName.equals(cName)) {   //그중 cName과 이름이 같은 쿠키가 있다면
					cookieValue = c.getValue();   //반환 값을 갱신한다
				}
			}
		}
		return cookieValue;   //그 값을 반환함.
	}
	
	//명시한 이름의 쿠키를 삭제함.
	public static void deleteCookie(HttpServletResponse response, String cName) {
		makeCookie(response, cName, "", 0);     //비어있는 문자열로 쿠키 생성, 유지 기간은 0으로 부여함
	}
}

