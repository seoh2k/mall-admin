package gdu.mall.dao;
import java.sql.*;
import java.util.*;
import gdu.mall.util.*;
import gdu.mall.vo.*;
public class ManagerDao {
	// 승인 대기중인 메니저 목록
	public static ArrayList<Manager> selectManagerListByZero() throws Exception {
		ArrayList<Manager> list = new ArrayList<>();
		String sql = "select manager_id managerId, manager_date managerDate from manager where manager_level=0";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Manager m = new Manager();
			m.setManagerId(rs.getString("managerId"));
			m.setManagerDate(rs.getString("managerDate"));
			list.add(m);
		}
		return list;
	}
	
	//수정 메서드
	public static int updateManagerLevel(int managerNo, int managerLevel) throws Exception {
		// 1. sql
		//=?은 수정할 것을 나타낸다 
		String sql = "UPDATE manager SET manager_level=? WHERE manager_no=?";
		
		// 2. 리턴값 초기화
		int rowCnt = 0;
		
		// 3. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, managerLevel); 
		stmt.setInt(2, managerNo); 
		rowCnt = stmt.executeUpdate();
		System.out.println("수정 stmt: "+stmt);
		
		// 4. 리턴
		return rowCnt;
	}
	
	//삭제 메서드
	public static int deleteManager(int managerNo) throws Exception {
		// 1. sql
		String sql = "DELETE from manager WHERE manager_no=?";
		
		// 2. 리턴값 초기화
		int rowCnt = 0;
		
		// 3. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, managerNo);  
		rowCnt = stmt.executeUpdate();
		System.out.println("삭제 stmt: "+stmt);
		
		// 4. 리턴
		return rowCnt;
	}
	
	//목록 메서드
	public static ArrayList<Manager> selectManagerList(int rowPerPage, int beginRow) throws Exception{
		// 1. sql ( 레벨 높은 순, 날짜 빠른 순)
		// where절 필요 없다
		String sql="SELECT manager_no, manager_id, manager_name, manager_date, manager_level FROM manager ORDER BY manager_date DESC limit ?, ?";
		
		// 2. 리턴값 초기화
		ArrayList<Manager> list = new ArrayList<Manager>(); // null 아님
		
		// 3. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		System.out.println("selectManagerList stmt: "+ stmt);
		ResultSet rs = stmt.executeQuery(); // 쿼리에 ? 없으니 바로 rs 실행문 작성
		while(rs.next()) { // 리스트 작성해야 하니 while문
			// 객체 생성
			Manager m = new Manager(); // 잠시 쓸때는 m과 같은 짧은 변수명 이용
			m.setManagerNo(rs.getInt("manager_no"));
			m.setManagerId(rs.getString("manager_id"));
			m.setManagerName(rs.getString("manager_name"));
			m.setManagerDate(rs.getString("manager_date"));
			m.setManagerLevel(rs.getInt("manager_level"));
			list.add(m);
		}
		// 4. 리턴
		return list;
	}
	
	//입력 메서드
	//null이면 입력 진행, null이 아니면 리턴
    public static int insertManager(String managerId, String managerPw, String managerName) throws Exception {
        
        String sql = "INSERT INTO manager(manager_id,manager_pw,manager_name,manager_date,manager_level) VALUES(?,?,?,now(),0)";
        int rowCnt = 0; // 입력 성공 시 1, 실패 시 0
        Connection conn = DBUtil.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, managerId);
        stmt.setString(2, managerPw);
        stmt.setString(3, managerName);
        rowCnt = stmt.executeUpdate();
        return rowCnt;
     }
	
	//id 사용 가능 여부
	public static String selectManagerId(String managerId) throws Exception { 
		// 1. sql문
		String sql = "SELECT manager_id FROM manager WHERE manager_id = ?";
		
		// 2. 리턴타입 초기화
		String returnManagerId = null;
		
		// 3.DB 핸들링
		Connection conn = DBUtil.getConnection(); 
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		System.out.print(stmt+" <--selectManagerId() sql"); //필수
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			returnManagerId = rs.getString("manager_id"); 
			//id가 있으면 아이디 달라해서 리턴매니저아이디에 넣었다. 
			//아이디가 나왔다는건 아이디가 존재 한다는 말, 널이 아니다(회원가입 된다) 
		}
		
		// 4.리턴
		return returnManagerId;
	}
	
	//로그인 메서드
	public static Manager login(String managerId, String managerPw) throws Exception{ //매니저 타입으로 묶어서 보낸다.
		// throws Exception: 예외가 발생하면 던져버린다
		
		//쿼리는 가장 위에 작성, 키워드는 대문자로, pw는 확인용이라 가져오지 않는다
		String sql="SELECT manager_id, manager_name, manager_level FROM manager WHERE manager_id=? AND manager_pw=? AND manager_level > 0"; 
		
		Manager manager = null; //로그인에 성공하면 정보를 넣는다
		
		Connection conn = DBUtil.getConnection();
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		stmt.setString(2, managerPw);
		System.out.print(stmt+" <--login() sql"); //필수
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			manager = new Manager();
			manager.setManagerId(rs.getString("manager_id"));
			manager.setManagerName(rs.getString("manager_name"));
			manager.setManagerLevel(rs.getInt("manager_level"));
		}
		return manager;
	}
	
	// 전체 행의 개수 세는 메소드
	public static int totalCount() throws Exception {
		// 변수 초기화
		int totalRow = 0;
		
		// 쿼리 작성
		String sql = "SELECT COUNT(*) cnt FROM manager";
		
		// DB 연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("totalCount stmt: "+ stmt); // 디버깅
		ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				totalRow = rs.getInt("cnt");
		}
		
		// 리턴값
		return totalRow;
	}
}