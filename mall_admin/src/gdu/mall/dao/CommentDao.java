package gdu.mall.dao;

import java.sql.*;
import java.util.*;
import gdu.mall.util.*;
import gdu.mall.vo.*;

public class CommentDao {
	
	public static int selectCommentCnt(int noticeNo) throws Exception {
		int rowCnt = 0;
		String sql = "select count(*) cnt from comment where notice_no=?";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		// 디버깅
		System.out.println("selectCommentCnt stmt: "+stmt);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			rowCnt = rs.getInt("cnt");
		}
		System.out.println(rowCnt+": rowCnt");
		// 리턴값
		return rowCnt; // 0이 리턴되면 댓글이 없다는 의미
	}
	public static int insertComment(Comment comment) throws Exception {
		// sql
		String sql = "INSERT INTO comment(notice_no, manager_id, comment_content, comment_date) VALUE(?, ?, ?, now())";
		// 초기화
		int rowCnt = 0;
		// DB연동
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, comment.getNoticeNo());
		stmt.setString(2, comment.getManagerId());
		stmt.setString(3, comment.getCommentContent());
		// 디버깅
		System.out.println("insertComment stmt: "+ stmt);
		
		stmt.executeUpdate();
		// 리턴값
		return rowCnt;
	}
	
	public static ArrayList<Comment> selectCommentListByNoticeNo(int noticeNo) throws Exception {
		// sql
		String sql = "select * from comment where notice_no=? ORDER BY comment_date DESC";
		// 초기화
		ArrayList<Comment> list = new ArrayList<Comment>();
		// DB연동
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		// 디버깅
		System.out.println("selectCommentListByNoticeNo stmt: "+stmt);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Comment c = new Comment();
			c.setCommentNo(rs.getInt("comment_no"));
			c.setNoticeNo(rs.getInt("notice_no"));
			c.setManagerId(rs.getString("manager_id"));
			c.setCommentContent(rs.getString("comment_content"));
			c.setCommentDate(rs.getString("comment_date"));
			list.add(c);
		}
		// 리턴값
		return list;
	}
	
	//level 2로 접근했을 때 삭제 가능
	// deleteComment 메서드 오버로딩 : 매개변수가 다르면 메서드 이름이 같아도 된다.
	public static int deleteComment(int commentNo) throws Exception { // commentNo 
		// delete from comment where comment_no=?
		// delete from comment where comment_no=? and managerId=?
		String sql = "delete from comment where comment_no=?";
		// 초기화
		int rowCnt = 0;
		// DB연동
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		rowCnt = stmt.executeUpdate();
		// 디버깅
		System.out.println("deleteComment stm: "+stmt);
		// 리턴값
		return rowCnt;
	}
	
	// 글 번호와 아이디가 동일할 때 삭제 가능
	public static int deleteComment(int commentNo, String managerId) throws Exception { // commentNo, managerId;
		// delete from comment where comment_no=?
		// delete from comment where comment_no=? and manager_id=?
		String sql = "delete from comment where comment_no=? and manager_id=?";
		// 초기화		
		int rowCnt = 0;
		// DB연동
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		stmt.setString(2, managerId);
		rowCnt = stmt.executeUpdate();
		// 디버깅
		System.out.println("deleteComment stm: "+stmt);
		// 리턴값
		return rowCnt;
	}
}	
