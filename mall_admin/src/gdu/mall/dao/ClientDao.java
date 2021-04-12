package gdu.mall.dao;
import gdu.mall.util.*;
import gdu.mall.vo.*;
import java.util.*;
import java.sql.*;
public class ClientDao {
	
	// 전체 행의 수 
	public static int totalCount(String searchWord) throws Exception {
		int totalRow = 0;
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		String sql = ""; // 클라이언트 테이블에서 전체 데이터 개수를 가져온다
		if(searchWord.equals("")) {
			sql = "SELECT COUNT(*) cnt FROM client";
			stmt = conn.prepareStatement(sql);
		} else  {
			sql = "SELECT COUNT(*) cnt FROM client WHERE client_mail LIKE ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
		}
		
		System.out.println("totalCount sql: " + stmt);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) { //데이터 값이 존재한다면 총 개수를 입력해준다.
			totalRow = rs.getInt("cnt");
		}
		
		// 4. 리턴
		return totalRow; // 총 데이터 개수 반환
	}
	 
	// 목록 메서드
	public static ArrayList<Client> selectClientListByPage(int rowPerPage, int beginRow, String searchWord) throws Exception{
		
		// 리턴값 초기화
		ArrayList<Client> list = new ArrayList<>();
		
		// 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		
		String sql = "";
		
		if(searchWord.equals("")) { //검색어가 없으면
			sql = "SELECT client_mail clientMail, client_date clientDate FROM client ORDER BY client_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
		} else { // 검색어가 있으면
			// like는 연산자, ?의 글자가 client_mail에 있는지
			sql = "SELECT client_mail clientMail, client_date clientDate FROM client WHERE client_mail like ? ORDER BY client_date DESC LIMIT ?, ?"; 
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			
		}
		
		ResultSet rs = stmt.executeQuery(); //rs는 Dao에서만 사용 가능
		
		while(rs.next()) {
			Client c = new Client();
			c.setClienMail(rs.getString("clientMail"));
			c.setClientDate(rs.getString("clientDate"));
			list.add(c);
		}
		
		// 4. 리턴
		return list;
	}
	//수정 메서드
	public static void updateClient(String clientMail, String clientPw) throws Exception {
		// 1. sql
		//=?은 수정할 것을 나타낸다 
		// PASSWORD(?): 패스워드 암호화
		String sql = "UPDATE client SET client_pw=PASSWORD(?) WHERE client_mail=?";
		
		// 2. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, clientPw); 
		stmt.setString(2, clientMail); 

		System.out.println("updateClient stmt: "+stmt);
		
		// 3. 실행
		stmt.executeUpdate();
	}
		
	//삭제 메서드
	public static void deleteClient(String clientMail) throws Exception {
		// 1. sql
		String sql = "DELETE from client WHERE client_mail=?";
		
		// 2. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, clientMail);  
	
		System.out.println("deleteClient stmt: "+stmt);
		
		// 3. 실행
		stmt.executeUpdate();
	}
}
