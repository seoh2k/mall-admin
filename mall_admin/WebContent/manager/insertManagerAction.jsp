<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.ManagerDao" %>
<%@ page import="gdu.mall.vo.Manager" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>insertManagerAction</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Roboto:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/icofont/icofont.min.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/animate.css/animate.min.css" rel="stylesheet">
  <link href="assets/vendor/venobox/venobox.css" rel="stylesheet">
  <link href="assets/vendor/owl.carousel/assets/owl.carousel.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="assets/css/style.css" rel="stylesheet">
  
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>
<body>
<%
	//1. 수집 (Action에선 첫번째로 수집부터 해준다)
	request.setCharacterEncoding("UTF-8");
	String managerId = request.getParameter("managerId");
	String managerPw = request.getParameter("managerPw");
	String managerName = request.getParameter("managerName");
	//디버깅 코드 꼭 추가
	System.out.println(managerId+" <-- param managerId");
	System.out.println(managerPw+" <-- param managerPw");
	System.out.println(managerName+" <-- param managerName");
	
	
	//2-1. 중복된 아이디가 있으면 다시 입력 폼으로 가면서 끝난다. 
	//null이면 사용가능하고, else 사용불가하여 폼으로 이동한다.
	//리턴값 있는지 없는지만 받으면 된다.
	String returnManagerId = ManagerDao.selectManagerId(managerId);
	if(returnManagerId != null){ //이미 아이디가 존재한다
		System.out.println("사용 중인 아이디 입니다.");
		//클라이언트한테 매니저 인서트 폼을 재요청	
		response.sendRedirect(request.getContextPath()+"/manager/insertManagerForm.jsp"); 
		return; //중간에서 끝내고 싶어서 이용(if문에 걸리면 끝내기 위해)
	}
	
	//2-2. 입력
	// null이어서(아이디가 존재하지 않아서) 사용할 수 있으면
	ManagerDao.insertManager(managerId, managerPw, managerName); 
	
	//3. 출력
%>	
	<section id="services" class="services">
		<div class="container">
			<div class="section-title" style="width: 25%; padding-top: 200px;">
		<!-- 성공했을 때 -->
		<h2>Hello, <%=managerId %>!</h2>
		<p>Please wait for Authorization</p>
		<button class="btn btn-primary btn-block" style="background-color: #5c9f24; border: none;">
			<a href="<%=request.getContextPath()%>/adminIndex.jsp" >Home</a>
		</button>
	</div>
</body>
</html>