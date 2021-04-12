<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//로그아웃 : 세션에서 모든 것을 지운다
	session.invalidate(); //기존의 세션을 초기화(로그인 정보도 사라지게 된다 -> 로그아웃)
	response.sendRedirect(request.getContextPath()+"/adminIndex.jsp"); //재요청
%>