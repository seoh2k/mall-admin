<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %> <!-- 목록 출력하려면 dao 필요 -->
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>CategoryList</title>
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
	ArrayList<Category> list = CategoryDao.selectCategoryList();
	%>
	<!-- 관리자 화면 메뉴(네비게이션) include -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include> 
		<!-- 인클루드는 프로젝트명을 안 붙인다, 다른 페이지를 현재 페이지에 포함하는 기능  -->
	</div>
	<section id="faq" class="faq section-bg">
		<div class="container">
		  <div class="section-title">
		    <h2>CATEGORYLIST</h2>
		  </div>
			<a class="btn btn-secondary" style="background-color: #5c9f24; border: none;" href="<%=request.getContextPath()%>/category/insertCategoryForm.jsp">Add</a>
			<table class="table">
				<thead>
					<tr>
						<th>Name</th>
						<th>weight</th> <!-- 레벨 수정이랑 같게, weight만 수정 -->
						<th>Delete</th>
					</tr>
				</thead>
				<tbody>
					<%
						for(Category c: list){
					%>
							<tr>
								<td><%=c.getCategoryName() %></td>
								<td>
									<form action="<%=request.getContextPath()%>/category/updateCategoryAction.jsp" method="post">
										<input type="hidden" name="categoryName" value="<%=c.getCategoryName() %>">
										<select name="categoryWeight">
											<%
												for(int i=0; i<11; i++){
													if(c.getCategoryWeight() == i) {
											%>
														<option value="<%=i%>" selected="selected"><%=i%></option>
											<%
													} else {
											%>
														<option value="<%=i%>"><%=i%></option>
											<%	
													} 
												}
											%>
										</select>
										<button type="submit" class="btn btn-secondary">Update</button>
									</form>
								</td>	
								<td>
									<a href="<%=request.getContextPath() %>/category/deleteCategoryAction.jsp?categoryName=<%=c.getCategoryName()%>">
										<button type="submit" class="btn btn-secondary">Delete</button>
									</a>
								</td>
							</tr>
					<%
						}
					%>
				</tbody>
			</table>
			
		</div>	
	</section>
<!-- footer -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include> 
		<!-- 인클루드는 프로젝트명을 안 붙인다, 다른 페이지를 현재 페이지에 포함하는 기능  -->
	</div>
</body>
</html>