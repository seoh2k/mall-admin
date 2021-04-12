<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	Manager manager = (Manager)(session.getAttribute("sessionManager"));
	if(manager == null) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	// 수집 코드 구현
	String clientMail = request.getParameter("clientMail");
	System.out.println("clientMail: " + clientMail); // 디버깅
	
	// dao 삭제 메서드 호출 코드 구현
	ClientDao.deleteClient(clientMail);
	
	//삭제 후 멤버리스트로 이동
	response.sendRedirect(request.getContextPath()+"/client/clientList.jsp");
%>