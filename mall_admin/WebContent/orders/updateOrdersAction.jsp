<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%
	//updateOrdersAction
	request.setCharacterEncoding("UTF-8");

	Manager manager = (Manager)(session.getAttribute("sessionManager"));
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} 
	
	// 1. 수집 코드
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	String ordersState = request.getParameter("ordersState");
	System.out.println("updateOrdersAction ordersNo : " + ordersNo);
	System.out.println("updateOrdersAction ordersState  " + ordersState);
	
	// 2. 수정 메서드 호출
	OrdersDao.updateOrders(ordersNo, ordersState);
	response.sendRedirect(request.getContextPath()+"/orders/ordersList.jsp");
%>