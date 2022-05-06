package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import member.managementMemberDBBean;

public class managementMemberDBBean {
private static managementMemberDBBean instance = new managementMemberDBBean();
	
	public static managementMemberDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	//회원목록 불러오는 메서드
//	public ArrayList<managementMemberBean> listMember(){
//		ArrayList<managementMemberBean> list = new ArrayList<managementMemberBean>();
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		String sql = "select * from test1";
//		
//		try {
//			con = getConnection();
//			pstmt = con.prepareStatement(sql);
//			rs = pstmt.executeQuery();
//			
//			while (rs.next()) {
//				managementMemberBean member = new managementMemberBean();
//				member.setUser_id(rs.getString("user_id"));
//				member.setUser_pwd(rs.getString("user_pwd"));
//				member.setUser_tel(rs.getInt("user_tel"));
//				member.setUser_phonenumber(rs.getInt("user_phonenumber"));
//				member.setUser_address(rs.getString("user_address"));
//				member.setUser_birthdate(rs.getDate("user_birthday"));
//				
//				list.add(member);
//			}
//			rs.close();
//            pstmt.close();
//            con.close();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return list;
//	}
	//선택한 회원정보 불러오는 메서드
	public managementMemberBean getMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		managementMemberBean member = new managementMemberBean();
		String sql = "select * from userinfo where userid=?";
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				member.setUserID(rs.getString("userID"));
				member.setUserPWD(rs.getString("userPWD"));
				member.setUserName(rs.getString("userName"));
				member.setUserPhoneNum(rs.getString("userPhoneNum"));
				member.setUserAddr(rs.getString("userAddr"));
				member.setUserBirth(rs.getTimestamp("userBirth"));				
				member.setPoint(rs.getInt("point"));
			}
			rs.close();
            pstmt.close();
            con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return member;
	}
	//회원정보 업데이트 메서드
	public int updateMember(managementMemberBean member) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "update userinfo set userphonenum=?, useraddr=?, point=? where userid=?";
		int re =-1;
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getUserPhoneNum());
			pstmt.setString(2, member.getUserAddr());
			pstmt.setInt(3, member.getPoint());
			pstmt.setString(4, member.getUserID());
			pstmt.executeUpdate();
			re=1;
			
			pstmt.close();
            con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return re;
	}
	//회원정보 삭제 메서드
	public int deleteMemberAdmin(String userID, String userPWD) {
	Connection con = null;
	PreparedStatement pstmt = null;
//	ResultSet rs = null;
//	String id="";
//	String pwd="";
	String sql = "delete from userinfo where userid=? and userpwd=?";
	int re=-1;
	
	try {
		con = getConnection();
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, userID);
		pstmt.setString(2, userPWD);
		pstmt.executeUpdate();
		re=1;
		
		pstmt.close();
        con.close();
        //rs.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
	return re;
}
}
