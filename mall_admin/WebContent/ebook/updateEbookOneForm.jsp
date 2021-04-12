<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	//매니저만 고객리스트에 접근
	Manager manager = (Manager)(session.getAttribute("sessionManager"));
	if(manager == null) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>updateEbookOneForm</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="<%=request.getContextPath()%>/assets/img/favicon.png" rel="icon">
  <link href="<%=request.getContextPath()%>/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Roboto:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="<%=request.getContextPath()%>/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%=request.getContextPath()%>/assets/vendor/icofont/icofont.min.css" rel="stylesheet">
  <link href="<%=request.getContextPath()%>/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="<%=request.getContextPath()%>/assets/vendor/animate.css/animate.min.css" rel="stylesheet">
  <link href="<%=request.getContextPath()%>/assets/vendor/venobox/venobox.css" rel="stylesheet">
  <link href="<%=request.getContextPath()%>/assets/vendor/owl.carousel/assets/owl.carousel.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="<%=request.getContextPath()%>/assets/css/style.css" rel="stylesheet">
</head>
<body>
	<!-- 관리자 화면 메뉴(네비게이션) include -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include> 
		<!-- 인클루드는 프로젝트명을 안 붙인다, 다른 페이지를 현재 페이지에 포함하는 기능  -->
	</div>
	
	<% 	
		//수집
		String ebookISBN = request.getParameter("ebookISBN");
		System.out.println("updateEbookOneForm ebookISBN: "+ ebookISBN);
		
		// 데이터 가져오기
		Ebook ebook = EbookDao.selectEbookOne(ebookISBN);
	%>
	<section id="faq" class="faq section-bg">
		<div class="container">
		  <div class="section-title">
		    <h2>UPDATE EBOOKONE</h2>
		  </div>
		<form action="<%=request.getContextPath() %>/ebook/updateEbookOneAction.jsp" method="post">
			<input type="hidden" name="ebookISBN" value="<%=ebook.getEbookISBN()%>">
			<table class="table">
					<tr>
						<th>ISBN</th>
						<th><input type="text" name="ebookISBN" value="<%=ebook.getEbookISBN()%>" class="form-control" style="width: 30%;"></th>
					</tr>
					<tr>
						<th>Title</th>
						<th><input type="text" name="ebookTitle" class="form-control" style="width: 30%;"></th>
					</tr>
					<tr>
						<th>Author</th>
						<th><input type="text" name="ebookAuthor" class="form-control" style="width: 30%;"></th>
					</tr>
					<tr>
						<th>Company</th>
						<th><input type="text" name="ebookCompany" class="form-control" style="width: 30%;"></th>
					</tr>
					<tr>
						<th>Page</th>
						<th><input type="text" name="ebookPageCount" class="form-control" style="width: 30%;"></th>
					</tr>
					<tr>
						<th>Price</th>
						<th><input type="text" name="ebookPrice" class="form-control" style="width: 30%;"></th>
					</tr>
			</table>
			<button type="submit" class="btn btn-secondary" >Update</button>
		</form>
		</div>
	</section>
	<!-- footer -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include> 
		<!-- 인클루드는 프로젝트명을 안 붙인다, 다른 페이지를 현재 페이지에 포함하는 기능  -->
	</div>
</body>
</html>