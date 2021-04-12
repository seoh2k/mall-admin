package gdu.mall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import gdu.mall.util.DBUtil;
import gdu.mall.vo.*;

public class OrdersDao {
	// orders의 리스트가 아니고 -> orders join ebook join client 리스트
	/*
	SELECT
	o.orders_no ordersNo,
	o.ebook_no ebookNo,
	e.ebook_title ebookTitle,
	c.client_mail clientMail,
	o.orders_date ordersDate,
	o.orders_state ordersState
	FROM orders o INNER JOIN ebook e INNER JOIN client c
	ON o.ebook_no = e.ebook_no AND o.client_no=c.client_no
	order by o.orders_no desc
	*/
	public static ArrayList<OrdersAndEbookAndClient> selectOrdersListByPage(int rowPerPage, int beginRow) throws Exception {
		String sql="SELECT o.orders_no ordersNo, o.ebook_no ebookNo, e.ebook_title ebookTitle, o.client_no clientNo, c.client_mail clientMail, o.orders_date ordersDate, o.orders_state ordersState, e.ebook_isbn ebookISBN FROM orders o INNER JOIN ebook e INNER JOIN client c ON o.ebook_no = e.ebook_no AND o.client_no=c.client_no order by o.orders_date desc LIMIT ?, ?";
		
		ArrayList<OrdersAndEbookAndClient> list = new ArrayList<>();
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,beginRow);
		stmt.setInt(2,rowPerPage);
		ResultSet rs = stmt.executeQuery();
		System.out.println("ordersList stmt: " + stmt);
		while(rs.next()) {
			OrdersAndEbookAndClient oec = new OrdersAndEbookAndClient();
			Orders o = new Orders();
			o.setOrdersNo(rs.getInt("ordersNo"));
			o.setEbookNo(rs.getInt("ebookNo"));
			o.setClientNo(rs.getInt("clientNo"));
			o.setOrdersDate(rs.getString("ordersDate"));
			o.setOrdersState(rs.getString("ordersState"));
			oec.setOrders(o); // 위의 o들을 저장한다.
			
			Ebook e = new Ebook();
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookISBN(rs.getString("ebookISBN"));
			oec.setEbook(e);
			
			Client c = new Client();
			c.setClienMail(rs.getString("clientMail"));
			oec.setClient(c);
			
			list.add(oec);
		}
		return list;
	}
	
	// 전체 행의 개수 세는 메소드
	public static int totalCount() throws Exception {
		// 변수 초기화
		int totalRow = 0;
		
		// 쿼리 작성
		String sql = "SELECT COUNT(*) cnt FROM orders";
		
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
	
	//수정 메서드
	public static void updateOrders(int ordersNo, String ordersState) throws Exception {
		// 1. sql
		String sql = "UPDATE orders SET orders_state = ? WHERE orders_no = ?";
		
		// 2. DB 연결 및 SQL문 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ordersState);
		stmt.setInt(2, ordersNo);
		System.out.println("updateOrders stmt: "+stmt); // update sql문 디버깅
		
		stmt.executeUpdate();
	}
}
