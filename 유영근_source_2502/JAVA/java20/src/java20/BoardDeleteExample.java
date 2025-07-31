package java20;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class BoardDeleteExample {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Connection conn=null;
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			conn=DriverManager.getConnection(
					"jdbc:oracle:thin:@localhost:1521/XE", 
	                "c##human", 
	                "human"
	            );
			String sql="DELETE FROM boards WHERE bwriter=?";
			PreparedStatement pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, "winter");
			
			int rows=pstmt.executeUpdate();
			System.out.println("삭제된 행 수:"+rows);
			pstmt.close();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn!=null) {
				try {
					conn.close();
				}catch(SQLException e) {}
			}
		}
	}

}
