package java20;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserSelectExample {

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
            String sql = "" +
                    " SELECT  userid \n"
                   +"       , username \n"
                   +"       , userpassword \n"
                   +"       , userage \n"
                   +"       , useremail  \n"
                   +" FROM users  \n" +
                   " WHERE userid=?";
            
               System.out.println(sql);
               PreparedStatement pstmt = conn.prepareStatement(sql);
               pstmt.setString(1, "winter");
			
			ResultSet rs=pstmt.executeQuery();
			if(rs.next()) {		
				User user=new User();
				user.setUserId(rs.getString("userid"));
				user.setUserName(rs.getString("username"));
				user.setUserPassword(rs.getString("userpassword"));
				user.setUserAge(rs.getInt("userage"));
				user.setUserEmail(rs.getString("useremail"));
				System.out.println(user);
			}else {
				System.out.println("사용자 아이디가 존재하지 않음");
			}
			rs.close();
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
