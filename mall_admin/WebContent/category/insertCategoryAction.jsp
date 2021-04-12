<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertCategoryAction</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");

	//레벨이 1보다 작으면 권한이 없으므로 adminIndex 페이지로 돌아간다.
	Manager manager = (Manager) session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	//1. 수집 (Action에선 첫번째로 수집부터 해준다)
	String categoryName = request.getParameter("categoryName");
	int categoryWeight = Integer.parseInt(request.getParameter("categoryWeight"));
	System.out.println("categoryName: "+categoryName);
	System.out.println("categoryWeight: "+categoryWeight);
	
	// 중복된 아이디가 있으면 다시 입력 폼으로 가면서 끝난다. null이면 사용가능하고, else 사용불가하여 폼으로 이동한다.
	//리턴값 있는지 없는지만 받으면 된다.
	String returnCategoryName = CategoryDao.selectCategoryName(categoryName);
	if(returnCategoryName != null){ //이미 아이디가 존재한다
		System.out.println("사용 중인 카테고리 이름입니다.");
		//클라이언트한테 매니저 인서트 폼을 재요청	
		response.sendRedirect(request.getContextPath()+"/category/insertCategoryForm.jsp"); 
		return; //중간에서 끝내고 싶어서 이용(if문에 걸리면 끝내기 위해)
	}
	
	CategoryDao.insertCategory(categoryName, categoryWeight); 
	response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
%>	


</body>
</html>