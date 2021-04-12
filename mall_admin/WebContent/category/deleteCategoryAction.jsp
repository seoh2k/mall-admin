<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%
	// deleteCategoryAction
	request.setCharacterEncoding("UTF-8");

	Manager manager = (Manager)(session.getAttribute("sessionManager"));
	if(manager == null || manager.getManagerLevel() < 2) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	// 수집 코드 구현
	String categoryName = request.getParameter("categoryName");
	System.out.println("categoryName: "+categoryName);
	
	// dao 삭제 메서드 호출 코드 구현
	CategoryDao.deleteCategory(categoryName);
	
	//삭제 후 멤버리스트로 이동
	response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
%>