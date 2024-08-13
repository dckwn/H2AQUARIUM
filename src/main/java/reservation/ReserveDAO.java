package reservation;

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



public class ReserveDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private Context init;
	private DataSource ds;
	
	private static ReserveDAO instance = new ReserveDAO();
	public static ReserveDAO getInstance() {
		return instance;
	}
	private ReserveDAO() {
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

	private ReserveDTO mapping(ResultSet rs) throws SQLException {
		ReserveDTO dto = new ReserveDTO();
		dto.setIdx(rs.getInt("idx"));
		dto.setShow_id(rs.getInt("show_id"));
		dto.setDate_id(rs.getInt("date_id"));
		dto.setTime_id(rs.getInt("time_id"));
		dto.setSeat_id(rs.getInt("Seat_id"));
		dto.setUser_id(rs.getInt("user_id"));
		return dto;
	}
	
	private InfoDTO mappingInfo(ResultSet rs) throws SQLException {
		InfoDTO dto = new InfoDTO();
		dto.setIdx(rs.getInt("idx"));
		dto.setUserid(rs.getString("userid"));
		dto.setShow_name(rs.getString("show_name"));
		dto.setResDate(rs.getDate("resDate"));
		dto.setTime_part(rs.getString("time_part"));
		dto.setSeat_num(rs.getString("seat_num"));
		return dto;
	}
	
	public List<InfoDTO> info(String search){
		if("all".equals(search)) {search = "";}
		ArrayList<InfoDTO> list = new ArrayList<>();
		String sql = "select reservation.idx, datey.resDate, showtable.show_name, timey.time_part, seat.seat_num, fish_member.userid from reservation "
				+ "join datey on reservation.date_id = datey.date_id "
				+ "join showtable on reservation.show_id = showtable.show_id "
				+ "join timey on reservation.time_id = timey.time_id "
				+ "join seat on reservation.seat_id = seat.seat_id "
				+ "join fish_member on reservation.user_id = fish_member.idx "
				+ "where show_name like '%' || ? || '%' "
				+ "order by fish_member.userid, datey.resDate, timey.time_part";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, search);
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				list.add(mappingInfo(rs));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {close();}
		return list;
	}
	
	public List<InfoDTO> info2(){
		ArrayList<InfoDTO> list = new ArrayList<>();
		String sql = "select reservation.idx, datey.resDate, showtable.show_name, timey.time_part, seat.seat_num, fish_member.userid from reservation "
				+ "join datey on reservation.date_id = datey.date_id "
				+ "join showtable on reservation.show_id = showtable.show_id "
				+ "join timey on reservation.time_id = timey.time_id "
				+ "join seat on reservation.seat_id = seat.seat_id "
				+ "join fish_member on reservation.user_id = fish_member.idx "
				+ "offset ? rows "
				+ "fetch next ? rows only";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, 0);
			pstmt.setInt(2, 0);
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				list.add(mappingInfo(rs));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {close();}
		return list;
	}
	
	public List<ReserveDTO> select(){
		ArrayList<ReserveDTO> list = new ArrayList<>();
		String sql = "select * from reservation";
		
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
	
	public int insert(ReserveDTO dto) {
		int row = 0;
		String sql = "insert into reservation (show_id, date_id, time_id, seat_id, user_id) "
				+ "values (?, ?, ?, ?, ?)";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getShow_id());
			pstmt.setInt(2, dto.getDate_id());
			pstmt.setInt(3, dto.getTime_id());
			pstmt.setInt(4, dto.getSeat_id());
			pstmt.setInt(5, dto.getUser_id());
			row = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {close();}
		
		return row;
	}
	
	public int insert2(ReserveDTO dto) {
		int row = 0;
		String sql = "insert into reservation (show_id, date_id, time_id, seat_id, user_id) "
				+ "values (?, ?, ?, ?, ?)";
		try {
			conn = ds.getConnection();
			
			for(int i = 0; i < dto.getSeat().length; i++) {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getShow_id());
			pstmt.setInt(2, dto.getDate_id());
			pstmt.setInt(3, dto.getTime_id());
			pstmt.setInt(4, dto.getSeat()[i]);
			pstmt.setInt(5, dto.getUser_id());
			row = pstmt.executeUpdate();
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {close();}
		
		return row;
	}
	
	public int delete(int idx) {
		int row = 0;
		String sql = "delete from reservation where idx = ?";
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
	
	public List<InfoDTO> selectOne(String userid){
		ArrayList<InfoDTO> list = new ArrayList<>();
		String sql = "select reservation.idx, datey.resDate, showtable.show_name, timey.time_part, seat.seat_num, fish_member.userid from reservation "
				+ "join datey on reservation.date_id = datey.date_id "
				+ "join showtable on reservation.show_id = showtable.show_id "
				+ "join timey on reservation.time_id = timey.time_id "
				+ "join seat on reservation.seat_id = seat.seat_id "
				+ "join fish_member on reservation.user_id = fish_member.idx where userid = ? "
				+ "order by fish_member.userid, datey.resDate, timey.time_part";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				list.add(mappingInfo(rs));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {close();}
		return list;
	}
	
	public int selectSold(int show_id, int date_id, int time_id) {
		int count = 0;
		String sql = "select count(*) as sold from reservation "
				+ "join seat on seat.seat_id = reservation.seat_id "
				+ "where show_id=? and date_id=? and time_id=?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, show_id);
			pstmt.setInt(2, date_id);
			pstmt.setInt(3, time_id);
			rs = pstmt.executeQuery();
			if(rs.next())
				count = rs.getInt("sold");
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {close();}
		
		return count;
	}
	
	public boolean check(ReserveDTO dto, int seat_id) {
		boolean check = false;
		String sql = "select * from reservation "
				+ "where show_id = ? "
				+ "and date_id = ? "
				+ "and time_id = ? "
				+ "and seat_id = ?";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);			
			pstmt.setInt(1, dto.getShow_id());
			pstmt.setInt(2, dto.getDate_id());
			pstmt.setInt(3, dto.getTime_id());
			pstmt.setInt(4, seat_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {check = true;}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {close();}
		return check;
	}
}
