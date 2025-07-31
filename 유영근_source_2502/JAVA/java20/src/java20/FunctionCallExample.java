package java20;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Types;

public class FunctionCallExample {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Connection conn = null;
		try {
			Class.forName("oracle.jdbc.OracleDriver");            
	        conn = DriverManager.getConnection(
	                							"jdbc:oracle:thin:@localhost:1521/XE", 
	                							"c##human", 
	                							"human"
	        									);
	        String sql="{? = call user_login(?,?)}";
	        CallableStatement cstmt=conn.prepareCall(sql);
	        
	        cstmt.registerOutParameter(1, Types.INTEGER);
	        cstmt.setString(2, "winter");
	        cstmt.setString(3, "12345");
	        
	        cstmt.execute();
	        int result =cstmt.getInt(1);
	        
	        cstmt.close();
	        
	        String message=switch(result) {
	        case 0->"로그인 성공";
	        case 1->"비밀번호가 틀림";
	        default->"아이디가 존재하지 않음";
	        };
	        System.out.println(message);
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
