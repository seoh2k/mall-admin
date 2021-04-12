<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>updateEbookImgForm</title>
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
	<%
		String ebookISBN = request.getParameter("ebookISBN");
	%>
	
	<!-- 관리자 화면 메뉴(네비게이션) include -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include> 
		<!-- 인클루드는 프로젝트명을 안 붙인다, 다른 페이지를 현재 페이지에 포함하는 기능  -->
	</div>
	
	<section id="faq" class="faq section-bg">
		<div class="container">
		  <div class="section-title">
		    <h2>UPDATE Image</h2>
		  </div>
			<form action="<%=request.getContextPath() %>/ebook/updateEbookImgAction.jsp" method="post" enctype="multipart/form-data"> <!-- 데이터가 넘어간다 -->
				<input type="hidden" name="ebookISBN" value="<%=ebookISBN %>">
				<input type="file" name="ebookImg" class="form-control-file border">
				<button type="submit" class="btn btn-secondary">Update</button>
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