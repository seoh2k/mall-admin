<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.util.*" %>
<%@ page import="java.util.*" %>
<%
	//updateEbookOneAction
	
	Manager manager = (Manager)(session.getAttribute("sessionManager"));
	if(manager == null) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	// updateEbookOneAction 
	
	// 입력했을 때 한글 깨짐 방지
	request.setCharacterEncoding("UTF-8");
	
	// 수집 코드 구현
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookTitle = request.getParameter("ebookTitle");
	String ebookAuthor = request.getParameter("ebookAuthor");
	String ebookCompany = request.getParameter("ebookCompany");
	int ebookPageCount = Integer.parseInt(request.getParameter("ebookPageCount"));
	int ebookPrice = Integer.parseInt(request.getParameter("ebookPrice"));

	System.out.println("updateEbookOneAction ebookISBN: " +ebookISBN);
	System.out.println("updateEbookOneAction ebookTitle: " +ebookTitle);
	System.out.println("updateEbookOneAction ebookAuthor: " +ebookAuthor);
	System.out.println("updateEbookOneAction ebookCompany: " +ebookCompany);
	System.out.println("updateEbookOneAction ebookPageCount: " +ebookPageCount);
	System.out.println("updateEbookOneAction ebookPrice: " +ebookPrice);
	
	// 객체 생성
	Ebook ebook = new Ebook();
	
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookTitle(ebookTitle);
	ebook.setEbookAuthor(ebookAuthor);
	ebook.setEbookCompany(ebookCompany);
	ebook.setEbookPageCount(ebookPageCount);
	ebook.setEbookPrice(ebookPrice);
	
	// dao 수정 메서드 호출 코드 구현
	EbookDao.updateEbookOne(ebook);
	
	//수정 후 매니저리스트로 이동
	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN=" + ebookISBN);
%>