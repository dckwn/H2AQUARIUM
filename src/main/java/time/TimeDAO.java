package time;

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


public class TimeDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private Context init;
	private DataSource ds;
	
	private static TimeDAO instance = new TimeDAO();
	public static TimeDAO getInstance() {
		return instance;
	}
	private TimeDAO() {
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
	
	public List<TimeDTO> select(){
		ArrayList<TimeDTO> list = new ArrayList<>();
		String sql = "select * from timey order by time_id";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				TimeDTO dto = new TimeDTO();
				dto.setTime_id(rs.getInt("time_id"));
				dto.setTime_part(rs.getString("time_part"));
				list.add(dto);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {close();}
		return list;
	}
}
