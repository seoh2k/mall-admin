package gdu.mall.dao;
import java.sql.*;
import java.util.*;
import gdu.mall.util.*;
import gdu.mall.vo.*;

public class EbookDao {
	//전체 수정 메서드
	public static void updateEbookOne(Ebook ebook) throws Exception {
		// 1. sql
		//=?은 수정할 것을 나타낸다 
		String sql = "UPDATE ebook SET ebook_isbn=?, ebook_title=?, ebook_author=?, ebook_company=?, ebook_page_count=?, ebook_price=? WHERE ebook_isbn=?";
		
		// 2. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookISBN()); 
		stmt.setString(2, ebook.getEbookTitle());
		stmt.setString(3, ebook.getEbookAuthor());
		stmt.setString(4, ebook.getEbookCompany());
		stmt.setInt(5, ebook.getEbookPageCount());
		stmt.setInt(6, ebook.getEbookPrice());
		stmt.setString(7, ebook.getEbookISBN());

		System.out.println("updateEbook stmt: "+stmt);
		
		// void 메서드는 ResultSet 없음
		
		// 3. 실행
		stmt.executeUpdate();
	}
		
	//삭제 메서드
	public static void deleteEbook(String ebookISBN) throws Exception {
		// 1. sql
		String sql = "DELETE from ebook WHERE ebook_isbn=?";
		
		// 2. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebookISBN);  
	
		System.out.println("deleteEbook stmt: "+stmt);
		
		// 3. 실행
		stmt.executeUpdate();
	}
	
	//책상태 수정 메서드
	public static void updateEbookState(Ebook ebook) throws Exception {
		// 1. sql
		//=?은 수정할 것을 나타낸다 
		String sql = "UPDATE ebook SET ebook_state=? WHERE ebook_isbn=?";
		
		// 2. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookState()); 
		stmt.setString(2, ebook.getEbookISBN()); 

		System.out.println("updateEbookState stmt: "+stmt);
		
		// 3. 실행
		stmt.executeUpdate();
	}
	
	// 책요약 수정 메서드
	public static void updateEbookSummary(Ebook ebook) throws Exception {
		// 1. sql
		String sql = "UPDATE ebook SET ebook_summary=? WHERE ebook_isbn = ?";
		
		// 2. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookSummary()); 
		stmt.setString(2, ebook.getEbookISBN()); 

		System.out.println("updateEbookSummary stmt: "+stmt);
		
		// 3. 실행
		stmt.executeUpdate();
	}
	// 이미지 수정
	public static int updateEbookImg(Ebook ebook) throws Exception {
		String sql="UPDATE ebook SET ebook_img=? WHERE ebook_isbn=?";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookImg());
		stmt.setString(2, ebook.getEbookISBN());
		int rowCnt = stmt.executeUpdate();
		return rowCnt;
	}
	
	// ISBN 중복 검사
	public static String checkEbookISBN(String ebookISBN) throws Exception {
		// sql
		String sql = "SELECT ebook_isbn FROM ebook WHERE ebook_isbn=?";
		// 초기화
		String returnEbookISBN = null;
		// DB 연동
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebookISBN);
		System.out.println("ebookISBN 중복검사 stmt: "+stmt); //디버깅
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			returnEbookISBN = rs.getString("ebook_isbn");
		}
		return returnEbookISBN;
	}
	
	// 상세정보
	public static Ebook selectEbookOne(String ebookISBN) throws Exception {
		//넘버 빼고 다 가져오기
		String sql = "SELECT ebook_isbn, category_name, ebook_title, ebook_author, ebook_company, ebook_page_count, ebook_price, ebook_img, ebook_summary, ebook_date, ebook_state FROM ebook WHERE ebook_isbn = ?";
		
		Ebook ebook = null;
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebookISBN);
		System.out.println("ebookISBN 상세보기 stmt: " + stmt);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			ebook = new Ebook();
			ebook.setEbookISBN(rs.getString("ebook_isbn"));
			ebook.setCategoryName(rs.getString("category_name"));
			ebook.setEbookTitle(rs.getString("ebook_title"));
			ebook.setEbookAuthor(rs.getString("ebook_author"));
			ebook.setEbookCompany(rs.getString("ebook_company"));
			ebook.setEbookPageCount(rs.getInt("ebook_page_count"));
			ebook.setEbookPrice(rs.getInt("ebook_price"));
			ebook.setEbookImg(rs.getString("ebook_img"));
			ebook.setEbookSummary(rs.getString("ebook_summary"));
			ebook.setEbookDate(rs.getString("ebook_date"));
			ebook.setEbookState(rs.getString("ebook_state"));
		}
		return ebook;
	}
	
	//입력 메서드
	public static int insertEbook(Ebook ebook) throws Exception{
			/*
			 * INSERT INTO ebook(
			 * 	ebook_isbn, 
			 * 	category_name,
			 * 	ebook_title,
			 * 	ebook_author,
			 * 	ebook_company,
			 * 	ebook_page_count,
			 * 	ebook_price,
			 * 	ebook_summary,
			 * 	ebook_img,
			 * 	ebook_date,
			 * 	ebook_state
			 * ) VALUE (
			 * 		?, ?, ?, ?, ?, ?, ?, ?, 'default.jsp', now(), '판매중' ?
			 * )
			 */
		String sql = "INSERT INTO ebook(ebook_isbn, category_name, ebook_title, ebook_author,ebook_company,ebook_page_count,ebook_price,ebook_summary, ebook_img, ebook_date,ebook_state) VALUE (?, ?, ?, ?, ?, ?, ?, ?,'default.jsp', now(), '판매중')";
		int rowCnt=0;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookISBN());
		stmt.setString(2, ebook.getCategoryName());
		stmt.setString(3, ebook.getEbookTitle());
		stmt.setString(4, ebook.getEbookAuthor());
		stmt.setString(5, ebook.getEbookCompany());
		stmt.setInt(6, ebook.getEbookPageCount());
		stmt.setInt(7, ebook.getEbookPrice());
		stmt.setString(8, ebook.getEbookSummary());
		rowCnt = stmt.executeUpdate();
		return rowCnt;
	}
	
	// 전체 행의 수 
	public static int totalCount() throws Exception {
		//sql문
		String sql = "SELECT COUNT(*) cnt FROM ebook";
		
		// 초기화
		int totalRow = 0;
		
		// db 연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt =conn.prepareStatement(sql);
		System.out.println("totalCount sql: " + stmt);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) { 
			totalRow = rs.getInt("cnt"); //데이터 값이 존재한다면 총 개수를 입력해준다.
		}
		
		// 리턴
		return totalRow; // 총 데이터 개수 반환
	}
		
	//목록 메서드
	public static ArrayList<Ebook> selectEbookList(int rowPerPage, int beginRow, String categoryName) throws Exception { //입력값 필요 없음
		// 리턴값 초기화
		ArrayList<Ebook> list = new ArrayList<>();
		
		// sql
		String sql="";
				
		// 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		
		if(categoryName.equals("")) { // 만약 카테고리를 누르지 않았다면
			sql = "SELECT ebook_isbn, category_name,  ebook_title,  ebook_author, ebook_company, ebook_page_count, ebook_price, ebook_date From ebook ORDER BY ebook_date DESC limit ?, ?";
			stmt = conn.prepareStatement(sql);
			System.out.println("selectEbookList stmt: "+ stmt);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
		} else { // 원하는 카테고리를 눌렀을 때
			sql = "SELECT ebook_isbn, category_name,  ebook_title,  ebook_author, ebook_company, ebook_page_count, ebook_price, ebook_date From ebook where category_name=? ORDER BY ebook_date DESC limit ?, ?";
			stmt = conn.prepareStatement(sql);
			System.out.println("selectEbookList stmt: "+ stmt);
			stmt.setString(1, categoryName);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
		}
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Ebook e = new Ebook(); //잠시 쓸 때는 e 처럼 짧은 변수명 사용
			e.setEbookISBN(rs.getString("ebook_isbn"));
			e.setCategoryName(rs.getString("category_name"));
			e.setEbookTitle(rs.getString("ebook_title"));
			e.setEbookAuthor(rs.getString("ebook_author"));
			e.setEbookCompany(rs.getString("ebook_company"));
			e.setEbookPageCount(rs.getInt("ebook_page_count"));
			e.setEbookPrice(rs.getInt("ebook_price"));
			e.setEbookDate(rs.getString("ebook_date"));
			list.add(e);
		}
		// 4. 리턴
		return list;
	}
}
