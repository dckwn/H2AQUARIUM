package like;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class LikeDAO {

	private InitialContext init;
	private DataSource ds;
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private static LikeDAO instance = new LikeDAO();
	public static LikeDAO getInstance() {
		return instance;
	}
	
	private LikeDAO() {
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
	
	private LikeDTO mapping(ResultSet rs) throws SQLException {
		LikeDTO dto = new LikeDTO();
		dto.setIdx(rs.getInt("idx"));
		dto.setFish_idx(rs.getInt("fish_idx"));
		dto.setUserlike(rs.getString("userlike"));
		return dto;
	}
	
	public LikeDTO likeCheck(String userid, int fish_idx) {
		LikeDTO dto = null;
		String sql = "select * from fish_like where userlike = ? and fish_idx = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setInt(2, fish_idx);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				dto = mapping(rs);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		return dto;
	}
	
	public int insert(String userid, int fish_idx) {
		int row = 0;
		String sql = "insert into fish_like (userlike, fish_idx) values(?, ?)";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setInt(2, fish_idx);
			row = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		return row;
	}
	
	public int delete(int idx) {
		int row = 0;
		String sql = "delete from fish_like where idx = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			row = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		return row;
	}
	
	public int conutLike(int fish_idx) {
		int count = 0;
		String sql = "select count(*) as count from fish_like where fish_idx = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, fish_idx);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				count = rs.getInt("count");
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		return count;
	}
	
	public List<Integer> bookmark_idx(String userid) {
		ArrayList<Integer> list = new ArrayList<Integer>();
		String sql = "select fish_idx from fish_like where userlike = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(rs.getInt("fish_idx"));
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		return list;
	}
	
}
