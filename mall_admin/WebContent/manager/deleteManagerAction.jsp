<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.ManagerDao" %>
<!-- 레벨 2 이상만 들어올 수 있다 -->
<%
	//deleteManagerAction
	
	Manager manager = (Manager)(session.getAttribute("sessionManager"));
	if(manager == null) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(manager.getManagerLevel() < 2) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	request.setCharacterEncoding("UTF-8");
	
	// 수집 코드 구현
	int managerNo = Integer.parseInt(request.getParameter("managerNo"));
	System.out.println("deleteManagerAction managerNo: "+ managerNo);
	
	// dao 삭제 메서드 호출 코드 구현
	ManagerDao.deleteManager(managerNo);
	
	//삭제 후 멤버리스트로 이동
	response.sendRedirect(request.getContextPath()+"/manager/managerList.jsp");
%>