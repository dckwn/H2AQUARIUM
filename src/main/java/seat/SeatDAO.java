package seat;

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


public class SeatDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private Context init;
	private DataSource ds;
	
	private static SeatDAO instance = new SeatDAO();
	public static SeatDAO getInstance() {
		return instance;
	}
	private SeatDAO() {
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
	
	public List<SeatDTO> select(){
		ArrayList<SeatDTO> list = new ArrayList<>();
		String sql = "select * from seat order by seat_id";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				SeatDTO dto = new SeatDTO();
				dto.setSeat_id(rs.getInt("seat_id"));
				dto.setSeat_num(rs.getString("seat_num"));
				list.add(dto);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {close();}
		return list;
	}
	
	public int count() {
		int count = 0;
		String sql = "select count(*) as cnt from seat";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				count = rs.getInt("cnt");
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {close();}
		
		return count;
		
	}
}
