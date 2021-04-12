<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 관리자만 접근할 수 있게 하는 메소드 (level 2 이상만 공지 추가 가능함)
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 2) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
%>
<%
	// insertCommentAction

	// 입력했을 때 한글 깨짐 방지
	request.setCharacterEncoding("UTF-8");
	
	// noticeOne에서 값 받아옴
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String managerId = request.getParameter("managerId");
	String commentContent = request.getParameter("commentContent");
	
	// 디버깅
	System.out.println(noticeNo+"<-- insertCommentAction noticeNo");
	System.out.println(managerId+"<-- insertCommentAction managerId");
	System.out.println(commentContent+"<-- insertCommentAction commentContent");
	
	// 데이터 전처리
	Comment comment = new Comment();
	comment.setNoticeNo(noticeNo);
	comment.setManagerId(managerId);
	comment.setCommentContent(commentContent);
	
	// Dao 호출
	CommentDao.insertComment(comment);
	
	// 공지 추가 후 공지 목록으로 재요청
	response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);
%>