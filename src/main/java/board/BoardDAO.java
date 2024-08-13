package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class BoardDAO {

	private InitialContext init;
	private DataSource ds;
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private static BoardDAO instance = new BoardDAO();
	public static BoardDAO getInstance() {
		return instance;
	}
	
	private BoardDAO() {
		try {
			init = new InitialContext();
			ds = (DataSource)init.lookup("java:comp/env/jdbc/oracle");
		} catch(NamingException e) {
			e.printStackTrace();
		}
	}
	
	private void close() {
		try {
			if(rs != null) { rs.close(); }
			if(pstmt != null) { pstmt.close(); }
			if(conn != null) { conn.close(); }
		} catch(SQLException e) {}
	}
	
	private BoardDTO mapping(ResultSet rs) throws SQLException {
		BoardDTO dto = new BoardDTO();
		dto.setIdx(rs.getInt("idx"));
		dto.setName(rs.getString("name"));
		dto.setImage(rs.getString("image"));
		dto.setCategory(rs.getString("category"));
		dto.setPlace(rs.getString("place"));
		dto.setContent(rs.getString("content"));
		return dto;
	}
	
	// 게시글 전체 조회 및 조건 검색
	public List<BoardDTO> selectList() {
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		String sql = "select * from fish "
				+ "order by idx desc";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(mapping(rs));
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		return list;		
	}
	
	public List<BoardDTO> selectLike(String userid) {
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		String sql = "select * from fish join fish_like on fish.idx = fish_like.fish_idx where fish_like.userlike = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(mapping(rs));
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		return list;
	}

	
	public List<BoardDTO> selectList(String search, String category, String place, Paging paging) {
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		String sql = "select * from fish A LEFT join (select fish_idx, count(*) as likecount from fish_like group by fish_idx ) B"
				+ " on A.idx = B.fish_idx where name like '%' || ? || '%' "
				+ "and category like '%' || ? || '%' "
				+ "and place like '%' || ? || '%' "
				+ "order by B.likeCount desc NULLS LAST, A.idx "
				+ "offset ? rows fetch next ? rows only";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, search);
			pstmt.setString(2, category);
			pstmt.setString(3, place);
			pstmt.setInt(4, paging.getOffset());
			pstmt.setInt(5, paging.getFetch());
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(mapping(rs));
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		return list;		
	}
	
	public List<BoardDTO> selectList2(String search, String category, String place, Paging paging) {
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		String sql = "select * from fish "
				+ "where name like '%' || ? || '%' "
				+ "and category like '%' || ? || '%' "
				+ "and place like '%' || ? || '%' "
				+ "order by idx desc"
				+ "	offset ? rows"
				+ "	fetch next ? rows only";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, search);
			pstmt.setString(2, category);
			pstmt.setString(3, place);
			pstmt.setInt(4, paging.getOffset());
			pstmt.setInt(5, paging.getFetch());
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(mapping(rs));
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		return list;		
	}
	
	public int selectCount(String search, String category, String place) {
		int count = 0;
		String sql = "select count(*) from fish "
					+ "where name like '%' || ? || '%' "
					+ "and category like '%' || ? || '%' "
					+ "and place like '%' || ? || '%'";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, search);
			pstmt.setString(2, category);
			pstmt.setString(3, place);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				count = rs.getInt(1);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		return count;
	}
	
	
	public BoardDTO selectOne(int idx) {
		BoardDTO dto = null;
		String sql = "select * from fish where idx = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				dto = mapping(rs);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		return dto;
	}
	
	public int insert(BoardDTO dto) {
		int row = 0;
		String sql = "insert into fish (name, image, category, place, content) values (?, ?, ?, ?, ?)";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getImage());
			pstmt.setString(3, dto.getCategory());
			pstmt.setString(4, dto.getPlace());
			pstmt.setString(5, dto.getContent());
			row = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		return row;
	}
	
	public int modify(BoardDTO dto) {
		int row = 0;
		String sql = "update fish set name = ?, image = ?, category = ?, place = ?, content = ? where idx = ? ";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getImage());
			pstmt.setString(3, dto.getCategory());
			pstmt.setString(4, dto.getPlace());
			pstmt.setString(5, dto.getContent());
			pstmt.setInt(6, dto.getIdx());
			row = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		return row;
	}
	
	public int delete(int idx) {
		int row = 0;
		String sql = "delete from fish where idx = ?";
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
}
