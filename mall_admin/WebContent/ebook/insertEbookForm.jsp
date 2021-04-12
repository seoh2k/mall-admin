<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	//관리자 인증 코드
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>insertEbookForm</title>
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
		ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
		System.out.println(categoryNameList.size()+ "<--categoryNameList");
	%>
	<!-- 관리자 화면 메뉴(네비게이션) include -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include> 
		<!-- 인클루드는 프로젝트명을 안 붙인다, 다른 페이지를 현재 페이지에 포함하는 기능  -->
	</div>
	
	<!-- ======= 요약리스트 Section ======= -->
    <section id="faq" class="faq section-bg">
      <div class="container">

        <div class="section-title">
          <h2>INSERT EBOOK</h2>
        </div>
		<form action="<%=request.getContextPath()%>/ebook/insertEbookAction.jsp" method="post">
			<table class="table">
				<tr>
					<th>Category</th>
					<td>
						<select name="categoryName" class="form-control" style="width: 30%;">
							<option value="">-----</option>
							<%
								for(String cn: categoryNameList){
							%>
									<option value="<%=cn%>"><%=cn%></option>
							<%
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<th>ISBN</th>
					<td><!-- #########(9)-#(1) 숫자만 가능 -->
						<input type="text" name="ebookISBN" class="form-control" required pattern="^\d{9}-\d{1}$" style="width: 30%;">
					</td>
				</tr>
				<tr>
					<th>Title</th>
					<td>
						<input type="text" name="ebookTitle" class="form-control" style="width: 30%;">
					</td>
				</tr>
				<tr>
					<th>Author</th><!-- 영어(대소문자), 한글 띄어쓰기 가능 -->
					<td>
						<input type="text" name="ebookAuthor" class="form-control" required pattern="^[a-zA-Z가-힣\s]+$" style="width: 30%;">
					</td>
				</tr>
				<tr>
					<th>Company</th>
					<td>
						<input type="text" name="ebookCompany" class="form-control" style="width: 30%;">
					</td>
				</tr>
				<tr>
					<th>Page</th><!-- 숫자만 가능 -->
					<td>
						<input type="text" name="ebookPageCount" class="form-control" required pattern="^[0-9]+$" style="width: 30%;">
					</td>
				</tr>
				<tr>
					<th>Price</th><!-- 숫자만 가능 -->
					<td>
						<input type="text" name="ebookPrice" class="form-control" required pattern="^[0-9]+$" style="width: 30%;">
					</td> 
				</tr>
				<tr>
					<th>Summary</th>
					<td>
						<textarea rows="5" cols="80" name="ebookSummary" class="form-control"></textarea>
					</td>
				</tr>
			</table>
			<button type="submit" class="btn btn-secondary" class="form-control">Add</button>
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