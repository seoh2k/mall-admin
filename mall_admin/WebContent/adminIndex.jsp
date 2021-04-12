
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="gdu.mall.vo.*" %>
<%@page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>adminIndex</title>
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
	<!--
		- 2가지 화면을 분기
		- 로그인 정보는 Manager자료형 세션변수(sessionManager)를 이용
		1) 관리자 로그인 폼
		2) 관리자 인증 화면 & 몰 메인페이지
	 -->
<%
	if(session.getAttribute("sessionManager")==null){ //로그인 한번도 안했을 때
%>		
		<div class="container" style="width: 25%;">
	        <div class="section-title">
	          <h2>BOOKSTORE</h2>
	        </div>
			<!-- = 꼭 붙여주기 -->
			<form action="<%=request.getContextPath() %>/manager/loginManagerAction.jsp" method="post">
				<div class="form-group">
					<label for="usr">USER NAME:</label><!-- 영어 소문자+ 숫자 5자에서 20자까지 -->
					<input type="text" class="form-control" name="managerId" autocomplete="off" required pattern="^[a-z0-9]{5,20}$">
				</div>
				<div class="form-group">
					<label for="pwd">PASSWORD: </label><!-- 4이상 10자리 이하 영소문자+숫자+특수문자  -->
					<input type="password" class="form-control" name="managerPw" autocomplete="off" required pattern="^[a-z0-9\W]{4,10}$">
				</div>
				<div class="form-group">
					<button type="submit" class="btn btn-primary btn-block" style="background-color: #5c9f24; border: none;">LOGIN</button>
				</div>
				<div class="form-group">
					<a href="<%=request.getContextPath()%>/manager/insertManagerForm.jsp">SIGN IN?</a>
				</div>
			</form>
			
			<!-- ======= 요약리스트 Section ======= -->
			<div class="section-title">
	          <h4 style="color: #5c9f24;">Waiting For Authorization</h4>
	        </div>
			<table class="table">
				<thead>
					<tr>
						<th>Id</th>
						<th>Date</th>
					</tr>
				</thead>
				<tbody>		
	<%
					ArrayList<Manager> list = ManagerDao.selectManagerListByZero();
					for(Manager m : list) {
	%>
						<tr>
							<td><%=m.getManagerId()%></td>
							<td><%=m.getManagerDate().substring(0,10)%></td>
						</tr>
	<%					
					}
	%>
				</tbody>	
			</table>
		</div>
	<%
	} else {
		Manager manager = (Manager)(session.getAttribute("sessionManager")); //형변환 연산자
	%>
			<%
			 	ArrayList<Notice> noticeList = NoticeDao.selectNoticeListByPage(5, 0);
			 	// ManagerDao.selectManagerList() 메서드 페이징 기능 추가
			 	ArrayList<Manager> managerList = ManagerDao.selectManagerList(5, 0); 
			 	ArrayList<Client> clientList = ClientDao.selectClientListByPage(5, 0, "");
			 	ArrayList<Ebook> ebookList = EbookDao.selectEbookList(5, 0, "");
			 	ArrayList<OrdersAndEbookAndClient> oecList = OrdersDao.selectOrdersListByPage(5, 0);
			 %>
		<!-- 관리자 화면 메뉴(네비게이션) include -->
		<div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include> 
			<!-- 인클루드는 프로젝트명을 안 붙인다, 다른 페이지를 현재 페이지에 포함하는 기능  -->
		</div>
		<!-- ======= Hero Section ======= -->
		<section id="hero">
			<div class="hero-container">
				<div id="heroCarousel" class="carousel slide carousel-fade" data-ride="carousel">
	
						<ol class="carousel-indicators" id="hero-carousel-indicators"></ol>
		
					<div class="carousel-inner" role="listbox">
		
						<!-- Slide 1 -->
						<div class="carousel-item active" style="background: url(assets/img/slide/back1.jpg);"></div>
					 </div>
				 </div>
			</div>
		</section><!-- End Hero -->
  
  		<!-- ======= 요약리스트 Section ======= -->
	    <section id="services" class="services">
	      <div class="container">
	
	        <div class="section-title">
	          <h2>adminIndex</h2>
	        </div>
			<div class="row">
	        	
	          <div class="col-lg-4 col-md-6 icon-box">
	            <div class="icon"><i class="fas fa-heart"></i></div>
	            <h4 class="title"><a href="">Hello!</a></h4>
	            <p class="description">
					<div>Hello, <%=manager.getManagerName() %>!</div>
			 		<div>Level: <%=manager.getManagerLevel() %></div>
				</p>
	          </div>
	          	<!-- 최근 가입한 관리자 5개 -->
	          <div class="col-lg-4 col-md-6 icon-box">
	          	<div class="icon"><i class="glyphicon glyphicon-user"></i></div>
	            <h4 class="title"><a href="<%=request.getContextPath()%>/manager/managerList.jsp">managerList</a></h4>
	            <p class="description">
					<table class="table">
			 		<%
			 			for(Manager m: managerList){
			 		%>
			 				<tr>
			 					<td><%=m.getManagerId() %></td>
			 					<td><%=m.getManagerName() %></td>
			 				</tr>
			 		<%
			 			}
			 		%>
			 	</table>
				</p>
	          </div>
	          <!-- 최근 가입한 고객 5개 -->
	          <div class="col-lg-4 col-md-6 icon-box">
	          	<div class="icon"><i class="glyphicon glyphicon-user"></i></div>
	            <h4 class="title"><a href="<%=request.getContextPath()%>/client/clientList.jsp">clientList</a></h4>
	            <p class="description">
					<table class="table">
			 		<%
			 			for(Client c: clientList){
			 		%>
			 				<tr>
			 					<td><%=c.getClienMail() %></td>
			 					<td><%=c.getClientDate().substring(0,10) %></td>
			 				</tr>
			 		<%
			 			}
			 		%>
			 	</table>
				</p>
	          </div>
	          <!-- 최근 등록한 상품(Ebook) 5개 -->
	          <div class="col-lg-4 col-md-6 icon-box">
	          	<div class="icon"><i class="icofont-tasks-alt"></i></div>
	            <h4 class="title"><a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">ebookList</a></h4>
	            <p class="description">
					<table class="table">
			 		<%
			 			for(Ebook e: ebookList){
			 		%>
			 				<tr>
			 					<td><%=e.getEbookTitle() %></td>
			 					<td><%=e.getEbookPrice() %></td>
			 				</tr>
			 		<%
			 			}
			 		%>
			 		</table>
				</p>
	          </div>
	          <!-- 최근 주문한 주문 5개 -->
	          <div class="col-lg-4 col-md-6 icon-box">
	          	<div class="icon"><i class="fas fa-file"></i></div>
	            <h4 class="title"><a href="<%=request.getContextPath()%>/orders/ordersList.jsp">ordersList</a></h4>
	            <p class="description">
	            	<table class="table">
			 		<%
			 			for(OrdersAndEbookAndClient oec: oecList){
			 		%>
			 				<tr>
			 					<td><%=oec.getOrders().getOrdersNo() %></td>
			 					<td><%=oec.getEbook().getEbookTitle() %></td>
			 					<td><%=oec.getClient().getClienMail() %></td>
			 				</tr>
			 		<%
			 			}
			 		%>
			 	</table>
	            </p>
	          </div>
	          <!-- 최근 동륵한 공지 5개 -->
	          <div class="col-lg-4 col-md-6 icon-box">
	          	<div class="icon"><i class="material-icons">attachment</i></div>
	            <h4 class="title"><a href="<%=request.getContextPath()%>/notice/noticeList.jsp">noticeList</a></h4>
	            <p class="description">
					<table class="table">
			 		<%
			 			for(Notice n: noticeList){
			 		%>
			 				<tr>
			 					<td><%=n.getNoticeTitle() %></td>
			 					<td><%=n.getManagerId() %></td>
			 				</tr>
			 		<%
			 			}
			 		%>
			 		</table>
				</p>
	          </div>
	        </div>
	
	      </div>
	    </section><!-- End 요약리스트 Section -->
		<!-- footer -->
		<div>
			<jsp:include page="/inc/footer.jsp"></jsp:include> 
			<!-- 인클루드는 프로젝트명을 안 붙인다, 다른 페이지를 현재 페이지에 포함하는 기능  -->
		</div>
<%	
	}
%>
</body>
</html>