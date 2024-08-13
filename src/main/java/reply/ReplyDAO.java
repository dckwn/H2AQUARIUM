package reply;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ReplyDAO {
	
	private InitialContext init;
	private DataSource ds;
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private static ReplyDAO instance = new ReplyDAO();
	public static ReplyDAO getInstance() {
		return instance;
	}
	
	private ReplyDAO () {
		try {
			init = new InitialContext();
			ds = (DataSource)init.lookup("java:comp/env/jdbc/oracle");
		} catch(NamingException e) {
			e.printStackTrace();
		}
	}
	
	private void close() {
		try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		} catch(SQLException e) {}
	}
	
	private ReplyDTO mapping(ResultSet rs) throws SQLException {
		ReplyDTO dto = new ReplyDTO();
		dto.setIdx(rs.getInt("idx"));
		dto.setFish_idx(rs.getInt("fish_idx"));
		dto.setWriter(rs.getString("writer"));
		dto.setContent(rs.getString("content"));
		dto.setWriteDate(rs.getDate("writeDate"));
		return dto;
	}
	
	public List<ReplyDTO> selectList(int fish_idx) {
		ArrayList<ReplyDTO> list = new ArrayList<ReplyDTO>();
		String sql = "select * from fish_reply where fish_idx = ? order by idx";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, fish_idx);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(mapping(rs));
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		return list;
	}
	
	public ReplyDTO selectOne(int fish_idx, int idx ) {
		ReplyDTO dto = null;
		String sql = "select * from fish_reply where fish_idx = ? and idx = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, fish_idx);
			pstmt.setInt(2, idx);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				dto = mapping(rs);
				
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		return dto;
	}
	
	public int insert(ReplyDTO dto) {
		int row = 0;
		String sql = "insert into fish_reply (fish_idx, writer, content) values(?, ?, ?)";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getFish_idx());
			pstmt.setString(2, dto.getWriter());
			pstmt.setString(3, dto.getContent());
			row = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		return row;
	}
	
	public int delete(ReplyDTO dto) {
		int row = 0;
		String sql = "delete from fish_reply where idx = ? and writer = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getIdx());
			pstmt.setString(2, dto.getWriter());
			row = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		return row;
	}
	
	public int modify(ReplyDTO dto) {
		int row = 0;
		String sql = "update fish_reply set content = ? where idx = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getContent());
			pstmt.setInt(2, dto.getIdx());
			row = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		return row;
	}
	
	public String changeUser(String content) {
		String str[] = content.split(" ");
		String user = "";
		for(int i = 0; i < str.length; i++) {
			if(str[i].startsWith("@")) {
				str[i] = "<span id=\"alarmUser\">" + str[i] + "</span>";
			}
			user += str[i]+" ";
		}
		return user;
	}
}
