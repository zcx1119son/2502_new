package java20;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.io.FileInputStream;

public class BoardInsertExample {

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
			String sql=""+
					"INSERT INTO boards (bno, btitle, bcontent, bwriter, bdate, bfilename, bfiledata)"+
					"VALUES (SEQ_BNO.NEXTVAL, ?, ?, ?, SYSDATE, ?, ?)";
			PreparedStatement pstmt=conn.prepareStatement(sql, new String[] {"bno"});
			pstmt.setString(1,"눈오는 날");
			pstmt.setString(2,"함박눈이 내려요");
			pstmt.setString(3, "winter");
			pstmt.setString(4, "snow.jpg");
			pstmt.setBlob(5, new FileInputStream("D:\\유영근_source_2502\\JAVA\\java20\\src\\java20\\snow.jpg"));
//			pstmt.setString(1,"크리스마스");
//			pstmt.setString(2,"메리 크리스마스~");
//			pstmt.setString(3, "winter");
//			pstmt.setString(4, "chrismas.jpg");
//			pstmt.setBlob(5, new FileInputStream("D:\\유영근_source_2502\\JAVA\\java20\\src\\java20\\chrismas.jpg"));
//			pstmt.setString(1,"봄의 정원");
//			pstmt.setString(2,"정원의 꽃이 이쁘네요");
//			pstmt.setString(3, "winter");
//			pstmt.setString(4, "spring.jpg");
//			pstmt.setBlob(5, new FileInputStream("D:\\유영근_source_2502\\JAVA\\java20\\src\\java20\\spring.jpg"));
			
			int rows=pstmt.executeUpdate();
			System.out.println("저장된 행 수:"+rows);
			if(rows==1) {
				ResultSet rs=pstmt.getGeneratedKeys();
				if(rs.next()) {
					int bno=rs.getInt(1);
					System.out.println("저장된 bno: "+bno);
				}
				rs.close();
			}
			pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(conn != null) {
					try {
						conn.close(); 
					} catch (SQLException e) {}
				}
			}
		}

}
