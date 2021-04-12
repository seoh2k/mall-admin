<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<!-- insertEbookAction -->
<%
	//관리자 인증 코드
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	request.setCharacterEncoding("UTF-8");
	
	// 수집
	String categoryName = request.getParameter("categoryName");
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookTitle = request.getParameter("ebookTitle");
	String ebookAuthor = request.getParameter("ebookAuthor");
	String ebookCompany = request.getParameter("ebookCompany");
	int ebookPageCount = Integer.parseInt(request.getParameter("ebookPageCount"));
	int ebookPrice = Integer.parseInt(request.getParameter("ebookPrice"));
	String ebookSummary = request.getParameter("ebookSummary");
	
	//디버깅 -> 확인
	System.out.println("insertEbookAction categoryName: "+categoryName);
	System.out.println("insertEbookAction ebookISBN: "+ebookISBN);
	System.out.println("insertEbookAction ebookTitle: "+ebookTitle);
	System.out.println("insertEbookAction ebookAuthor: "+ebookAuthor);
	System.out.println("insertEbookAction ebookCompany: "+ebookCompany);
	System.out.println("insertEbookAction ebookPageCount: "+ebookPageCount);
	System.out.println("insertEbookAction ebookPrice: "+ebookPrice);
	System.out.println("insertEbookAction ebookSummary: "+ebookSummary);
	
	// 전처리
	Ebook ebook =  new Ebook();
	ebook.setCategoryName(categoryName);
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookTitle(ebookTitle);
	ebook.setEbookAuthor(ebookAuthor);
	ebook.setEbookCompany(ebookCompany);
	ebook.setEbookPageCount(ebookPageCount);
	ebook.setEbookPrice(ebookPrice);
	ebook.setEbookSummary(ebookSummary);
	
	// ebookISBN 중복 확인 메서드 호출
	String returnEbookISBN = EbookDao.checkEbookISBN(ebookISBN);
	if(returnEbookISBN != null){ // 사용 중
		System.out.println("사용 중인 ebookISBN 입니다.");
		response.sendRedirect(request.getContextPath()+"/ebook/insertEbookForm.jsp");
		return;
	}
	
	EbookDao.insertEbook(ebook);
	response.sendRedirect(request.getContextPath()+"/ebook/ebookList.jsp");

%>