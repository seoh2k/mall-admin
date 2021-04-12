<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%
	// deleteEbookAction
	request.setCharacterEncoding("UTF-8");

	Manager manager = (Manager)(session.getAttribute("sessionManager"));
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	// 수집 코드 구현
	String ebookISBN = request.getParameter("ebookISBN");
	System.out.println("deleteEbookAction ebookISBN: "+ebookISBN);
	
	// dao 삭제 메서드 호출 코드 구현
	EbookDao.deleteEbook(ebookISBN);
	
	//삭제 후 멤버리스트로 이동
	response.sendRedirect(request.getContextPath()+"/ebook/ebookList.jsp");
%>