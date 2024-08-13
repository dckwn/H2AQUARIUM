package showtable;

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


public class ShowDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private Context init;
	private DataSource ds;
	
	private static ShowDAO instance = new ShowDAO();
	public static ShowDAO getInstance() {
		return instance;
	}
	private ShowDAO() {
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
	
	public List<ShowDTO> select(){
		ArrayList<ShowDTO> list = new ArrayList<>();
		String sql = "select * from showtable";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ShowDTO dto = new ShowDTO();
				dto.setShow_id(rs.getInt("show_id"));
				dto.setShow_name(rs.getString("show_name"));
				dto.setShow_img(rs.getString("show_img"));
				dto.setShow_content(rs.getString("show_content"));
				list.add(dto);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {close();}
		return list;
	}
}
