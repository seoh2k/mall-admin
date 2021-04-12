<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%
	//updateCategoryAction
	request.setCharacterEncoding("UTF-8");

	Manager manager = (Manager)(session.getAttribute("sessionManager"));
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} 
	
	// 1. 수집 코드
	String categoryName = request.getParameter("categoryName");
	int categoryWeight = Integer.parseInt(request.getParameter("categoryWeight"));
	System.out.println("categoryName : " + categoryName);
	System.out.println("categoryWeight  " + categoryWeight);
	
	// 2. 수정 메서드 호출
	CategoryDao.updateCategory(categoryName, categoryWeight);
	response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
%>