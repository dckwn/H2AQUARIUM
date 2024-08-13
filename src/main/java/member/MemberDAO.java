package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MemberDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private Context init;
	private DataSource ds;
	
	private static MemberDAO instance = new MemberDAO();
	public static MemberDAO getInstance() {
		return instance;
	}
	private MemberDAO() {
		try {
			init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/oracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	private void close() {
		try {
			if(rs != null) 		rs.close();
			if(pstmt != null) 	pstmt.close();
			if(conn != null) 	conn.close();
		}catch(SQLException e) {}
	}
	
	private MemberDTO mapping(ResultSet rs) throws SQLException {
		MemberDTO dto = new MemberDTO();
		dto.setEmail(rs.getString("email"));
		dto.setGender(rs.getString("gender"));
		dto.setIdx(rs.getInt("idx"));
		dto.setUserid(rs.getString("userid"));
		dto.setUsername(rs.getString("username"));
		dto.setUserpw(rs.getString("userpw"));
		dto.setIsAdmin(rs.getInt("isAdmin"));
		dto.setProfile_image(rs.getString("profile_image"));
		return dto;
	}
	
	public List<MemberDTO> select(){
		ArrayList<MemberDTO> list = new ArrayList<>();
		String sql = "select * from fish_member where isAdmin = 0 order by idx";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				list.add(mapping(rs));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {close();}
		
		return list;
	}
	
	public MemberDTO selectOne(int idx) {
		MemberDTO dto = null;
		String sql = "select * from fish_member where idx = ?";
		try{
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = mapping(rs);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {close();}
		return dto;
	}
	
	public String selectProfile(String userid) {
		String profile_image = null;
		String sql = "select profile_image from fish_member where userid = ?";
		try{
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				profile_image = rs.getString("profile_image");
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {close();}
		return profile_image;
	}	
	
	// 회원 가입
	public int insert(MemberDTO dto) {
		int row = 0;
		String sql = "insert into fish_member (userid, userpw, username, email, gender, profile_image) "
				+ "values (?, ?, ?, ?, ?, ?)";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserid());
			pstmt.setString(2, dto.getUserpw());
			pstmt.setString(3, dto.getUsername());
			pstmt.setString(4, dto.getEmail());
			pstmt.setString(5, dto.getGender());
			pstmt.setString(6, dto.getProfile_image());
			row = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		return row;
	}
	
	//회원정보수정
	public int update(MemberDTO dto) {
		int row=0;
		String profile = "";
		if(dto.getProfile_image() != null) {
			profile = ", profile_image=?";
		}
		String sql = "update fish_member set userid=?, userpw=?, username=?, email=?"+profile+" where idx = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserid());
			pstmt.setString(2, dto.getUserpw());
			pstmt.setString(3, dto.getUsername());
			pstmt.setString(4, dto.getEmail());
			if(("".equals(profile)) == false) {
				pstmt.setString(5, dto.getProfile_image());
				pstmt.setInt(6, dto.getIdx());
			}
			else {
				pstmt.setInt(5, dto.getIdx());
			}
			row = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {close();}
		
		return row;
	}
	
	//회원탈퇴
	public int delete(int idx) {
		int row=0;
		String sql = "delete from fish_member where idx=?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			row = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {close();}
		
		return row;
	}
	
	// 로그인
	public MemberDTO login(MemberDTO dto) {
		MemberDTO login = null;
		String sql = "select * from fish_member where userid = ? and userpw = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserid());
			pstmt.setString(2, dto.getUserpw());
			rs = pstmt.executeQuery();
			while(rs.next()) {
				login = mapping(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		return login;
	}
	
	
	//중복확인
		public Boolean check(String userid) throws SQLException {
			Boolean check = true;
			String sql = "select * from fish_member where userid = ?";
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				check = false;
			}
			
			close();
			return check;
		}
		
		public int alarm(String userid) {
			int count = 0;
			String sql = "select fish_idx from fish_member join alarm on alarm.userid = ?";
			
			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					count = rs.getInt("fish_idx");
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}
			
			return count;
		}
		
		public int deleteAlarm(String userid, int idx) {
			int row = 0;
			String sql = "delete from alarm where userid=? and fish_idx=?";
			
			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				pstmt.setInt(2, idx);
				row = pstmt.executeUpdate();
			}catch(SQLException e) {
				e.printStackTrace();
			}finally {close();}
			
			return row;
		}
		

}
