package java20;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.ResultSet;
import java.sql.SQLException;

public class BoardSelectExample {

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
	                "SELECT bno, btitle, bcontent, bwriter, bdate, bfilename, bfiledata "+
					"FROM boards "+
	                "WHERE bwriter=?";
			
			PreparedStatement pstmt=conn.prepareCall(sql);
			pstmt.setString(1,"winter");
			
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()) {
				Board board=new Board();
				board.setBno(rs.getInt("bno"));
				board.setBtitle(rs.getString("btitle"));
				board.setBcontent(rs.getString("bcontent"));
				board.setBwriter(rs.getString("bwriter"));
				board.setBdate(rs.getDate("bdate"));
				board.setBfilename(rs.getString("bfilename"));
				board.setBfiledata(rs.getBlob("bfiledata"));
				
				System.out.println(board);
				
				Blob blob=board.getBfiledata();
				if(blob!=null) {
					InputStream is=blob.getBinaryStream();
					OutputStream os=new FileOutputStream("C:/Temp/"+board.getBfilename());
					is.transferTo(os);
					os.flush();
					os.close();
					is.close();
				}
				
			}
			rs.close();
			pstmt.close();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn != null) {
				try {
					conn.close();
				}catch(SQLException e) {}
			}
		}
	}

}
