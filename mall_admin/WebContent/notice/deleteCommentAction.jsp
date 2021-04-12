<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// deleteCommentAction

	// 관리자만 접근할 수 있게 하는 메소드 
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
	
	//인코딩
	request.setCharacterEncoding("UTF-8");
	
	// 수집
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String managerId= manager.getManagerId();
	
	// 디버깅
	System.out.println("deleteCommentAction commentNo: "+commentNo);
	System.out.println("deleteCommentAction noticeNo: "+noticeNo);
	System.out.println("deleteCommentAction noticeNo: "+managerId);
	
	if (manager.getManagerLevel() > 1){ // manager.managerLevel == 2
		CommentDao.deleteComment(commentNo);
	} else if(manager.getManagerLevel() > 0){ // manager.managerLevel == 1
		CommentDao.deleteComment(commentNo, managerId);
	}
	
	// 댓글 삭제 후 공지 상세정보로 재요청
	response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);
%>