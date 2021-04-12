<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	//updateEbookStateAction

	Manager manager = (Manager)(session.getAttribute("sessionManager"));
	if(manager == null) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	request.setCharacterEncoding("UTF-8");
	
	// 수집 코드 구현
	String ebookState = request.getParameter("ebookState");
	String ebookISBN = request.getParameter("ebookISBN");
	System.out.println("updateEbookStateAction ebookState: "+ebookState);
	System.out.println("updateEbookStateAction ebookISBN: "+ebookISBN);
	
	Ebook ebook = new Ebook();
	
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookState(ebookState);
	
	// dao 수정 메서드 호출 코드 구현
	EbookDao.updateEbookState(ebook);
	
	//수정 후 매니저리스트로 이동
	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebookISBN);
%>