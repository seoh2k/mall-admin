<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	Manager manager = (Manager) session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>ebookOne</title>
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
		// 수집
		String ebookISBN = request.getParameter("ebookISBN");
		System.out.println("ebookOne ebookISBN: "+ ebookISBN);
		
		//Dao 연결
		Ebook ebook = EbookDao.selectEbookOne(ebookISBN);
	%>
	<!-- ======= 요약리스트 Section ======= -->
	<section id="faq" class="faq section-bg">
		<div class="container">

        <div class="section-title">
          <h2><%=ebook.getEbookTitle() %></h2>
        </div>
        
		<table class="table">
			<tr>
				<th>ISBN</th>
            	<td><%=ebook.getEbookISBN() %></td>
            	<td></td>
			</tr>
			<tr>
				<th>Name</th>
				<td><%=ebook.getCategoryName() %></td>
				<td></td>
			</tr>
			<tr>
				<th>Author</th>
				<td><%=ebook.getEbookAuthor() %></td>
				<td></td>
			</tr>
			<tr>
				<th>Company</th>
            	<td><%=ebook.getEbookCompany() %></td>
            	<td></td>
			</tr>
			<tr>
				<th>Page Count</th>
				<td><%=ebook.getEbookPageCount() %></td>
				<td></td>
			</tr>
			<tr>
				<th>Price</th>
				<td><%=ebook.getEbookPrice() %></td>
				<td></td>
			</tr>
			<tr>
				<th>Summary</th>
				<td><%=ebook.getEbookSummary() %></td>
				<!-- ?ebookISBN=<%=ebookISBN%> ... 잊기 않기 -->
				<td><a href="<%=request.getContextPath()%>/ebook/updateEbookSummaryForm.jsp?ebookISBN=<%=ebookISBN%>"><button class="btn btn-secondary"> Update Summary</button></a></td>
			</tr>
			<tr>
				<th>Image</th>
				<td><img src="<%=request.getContextPath()%>/img/<%=ebook.getEbookImg()%>" width="240" height="300"></td>
				<td><a href="<%=request.getContextPath()%>/ebook/updateEbookImgForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>"><button class="btn btn-secondary">Update Image</button></a></td>
			</tr>
			<tr>
				<th>Date</th>
				<td><%=ebook.getEbookDate().substring(0,11)%></td>
				<td></td>
			</tr>
			<tr>
				<th>State</th>
				<td><%=ebook.getEbookState() %></td>
				<td><a href="<%=request.getContextPath()%>/ebook/updateEbookStateForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>"><button class="btn btn-secondary">Update State</button></a></td>
			</tr>
		</table>
		<div>
			<a class="btn btn-secondary" href="<%=request.getContextPath()%>/ebook/updateEbookOneForm.jsp?ebookISBN=<%=ebookISBN%>">Update</a>
			<a class="btn btn-secondary" href="<%=request.getContextPath()%>/ebook/deleteEbookOneAction.jsp?ebookISBN=<%=ebookISBN%>">Delete</a>
		</div>
		</div>
	</section>
	<!-- footer -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include> 
		<!-- 인클루드는 프로젝트명을 안 붙인다, 다른 페이지를 현재 페이지에 포함하는 기능  -->
	</div>
</body>
</html>