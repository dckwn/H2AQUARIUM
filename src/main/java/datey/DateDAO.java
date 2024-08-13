package datey;

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


public class DateDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private Context init;
	private DataSource ds;
	
	private static DateDAO instance = new DateDAO();
	public static DateDAO getInstance() {
		return instance;
	}
	private DateDAO() {
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
	
	public List<DateDTO> select(){
		ArrayList<DateDTO> list = new ArrayList<>();
		String sql = "select * from datey";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				DateDTO dto = new DateDTO();
				dto.setDate_id(rs.getInt("date_id"));
				dto.setResDate(rs.getDate("resdate"));
				list.add(dto);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {close();}
		return list;
	}
	public int selectDay(int month, int day) {
		int idx = 0;
		String sql = "select Date_id from datey where EXTRACT (MONTH FROM resDate) = ? and EXTRACT (DAY FROM resDate) = ?"
				+ " and resdate >= sysdate";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, month);
			pstmt.setInt(2, day);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				idx = rs.getInt("date_id");
			}		
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {close();}
		
		return idx;
	}
	
	public int sysDay() {
		int sysDay = 0;
		String sql = "select EXTRACT (DAY FROM sysdate) as sysDay from dual";						
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				sysDay = rs.getInt("sysDay");
			}		
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {close();}
		
		return sysDay;
	}
	
	public int sysMonth() {
		int month = 0;
		String sql = "select EXTRACT (MONTH FROM sysdate) as month from dual";						
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				month = rs.getInt("month");
			}		
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {close();}
		
		return month;
	}
	
}
