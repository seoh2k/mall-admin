package gdu.mall.dao;
import java.sql.*;

import java.util.*;
import gdu.mall.util.*;
import gdu.mall.vo.*;
public class CategoryDao {
	// 카테고리 네임 리스트
	public static ArrayList<String> categoryNameList() throws Exception { //입력값 필요 없음
		// 1. sql
		//레벨 높은 순, 날짜 빠른순
		String sql = "SELECT category_name categoryName From category ORDER BY category_weight DESC";
		
		// 2. 리턴값 초기화
		ArrayList<String> list = new ArrayList<String>();
		
		// 3. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			String cn = rs.getString("categoryName");
			list.add(cn); //리스트에 추가
		}
		// 4. 리턴
		return list;
	}
		
	//입력 메서드
    public static void insertCategory(String categoryName, int categoryWeight) throws Exception {
       
        String sql = null;
        if(categoryName.equals("")) {
        	
        }
        sql = "INSERT INTO category(category_name, category_weight, category_date) VALUES(?, ?, now())";
    
        Connection conn = DBUtil.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, categoryName);
        stmt.setInt(2, categoryWeight);
        System.out.println("insertCategory stmt: "+stmt);
        
        stmt.executeUpdate();
     }
	    
	//목록 메서드
	public static ArrayList<Category> selectCategoryList() throws Exception { //입력값 필요 없음
		// 1. sql
		//레벨 높은 순, 날짜 빠른순
		String sql = "SELECT category_no categoryNo, category_name categoryName, category_weight categoryWeight, category_date categoryDate From category ORDER BY category_weight DESC";
		
		// 2. 리턴값 초기화
		ArrayList<Category> list = new ArrayList<Category>();
		
		// 3. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Category c = new Category(); //잠시 쓸 때는 m 처럼 짧은 변수명 사용
			c.setCategoryNo(rs.getInt("categoryNo"));
			c.setCategoryName(rs.getString("categoryName"));
			c.setCategoryWeight(rs.getInt("categoryWeight"));
			c.setCategoryDate(rs.getString("categoryDate"));
			list.add(c);
		}
		// 4. 리턴
		return list;
	}
	//수정 메서드
	public static void updateCategory(String categoryName, int categoryWeight) throws Exception {
		// 1. sql
		String sql = "UPDATE category SET category_weight = ? WHERE category_Name = ?";
		
		// 2. DB 연결 및 SQL문 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryWeight);
		stmt.setString(2, categoryName);
		System.out.println("updateCategory stmt: "+stmt); // update sql문 디버깅
		
		stmt.executeUpdate();
	}
	
	//삭제 메서드
	public static void deleteCategory(String categoryName) throws Exception {
		// sql
		String sql = "DELETE from category WHERE category_name=?";
		
		// 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		System.out.println("deleteCategory stmt: "+stmt);
		
		stmt.executeUpdate();
	}
	
	//id 사용 가능 여부
	public static String selectCategoryName(String categoryName) throws Exception { 
		// 1. sql문
		String sql = "SELECT category_name FROM category WHERE category_name = ?";
		// 2. 리턴타입 초기화
		String returnCategoryName = null;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		System.out.print(stmt+" <--selectCategoryName() sql"); //필수
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			returnCategoryName = rs.getString("category_name"); 
			//id가 있으면 아이디 달라해서 리턴매니저아이디에 넣었다. 
			//아이디가 나왔다는건 아이디가 존재 한다는 말, 널이 아니다(회원가입 된다) 
		}
		return returnCategoryName;
	}
	
	
}
