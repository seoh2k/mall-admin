<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %> <!-- 목록 출력하려면 dao 필요 -->
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>managerList</title>
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
	//현재 페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage")); // 받아온 값 정수로 변환
	}
	
	// 페이지 당 행의 수
	int rowPerPage = 10;
	if(request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage")); // 받아온 값 정수로 변환
	}
	
	// 시작 행
	int beginRow = (currentPage - 1) * rowPerPage;
	
	// 전체 행의 개수
	int totalRow = ManagerDao.totalCount();
	System.out.println(totalRow+"<-- managerList totalRow"); // 디버깅
		
	Manager manager = (Manager)(session.getAttribute("sessionManager")); // 세션에 로그인 되어 있지 않으면 강제로 보내버린다
	if (manager == null) { //session.getAttribute가 널이면
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if (manager.getManagerLevel() < 2) { // 레벨이 낮아서 강제로 보내버린다
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
		
	<%
		ArrayList<Manager> list = ManagerDao.selectManagerList(rowPerPage, beginRow);
	%>
	
	<!-- 관리자 화면 메뉴(네비게이션) include -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include> <!-- 인클루드는 프로젝트명을 안 붙인다  -->
	</div>
	
	<section id="faq" class="faq section-bg">
		<div class="container">
		  <div class="section-title">
		    <h2>MANAGERLIST</h2>
		  </div>
		  
			<img src="">	  
		  
		<!-- 한 페이지당 몇 개씩 볼건지 선택하는 기능 -->
		<form action="<%=request.getContextPath()%>/manager/managerList.jsp" method="post">
			<button type="submit" class="btn btn-secondary">Showing</button>
			<select name="rowPerPage">
				<%
					for(int i=10; i<31; i+=5) {
						if(rowPerPage == i) {
				%>
						<!-- 옵션에서 선택한 개수만큼의 행이 보이게 함 -->
						<option value=<%=i%> selected="selected"><%=i%></option> 
				<%
						} else {
				%>
						<!-- 옵션 선택이 되어 있지 않으면 rowPerPage 설정 값으로 보이게 함 -->
						<option value=<%=i%>><%=i%></option>
				<%	
						}
					}
				%>
			</select>
		</form>
		<table class="table">
			<thead>
				<tr>
					<th>No.</th>
					<th>Id</th>
					<th>Name</th>
					<th>Date</th>
					<th>Level</th>
					<th>Delete</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Manager m: list){ // <tr> 전에 for 문 // foreach문 사용하기
				%>
						<tr>
							<td><%=m.getManagerNo() %></td>
							<td><%=m.getManagerId() %></td>
							<td><%=m.getManagerName() %></td>
							<td><%=m.getManagerDate().substring(0,10) %></td>
							<td>
								<!-- action으로 보내려면 form이 있어야 한다 -->
								<form action="<%=request.getContextPath() %>/manager/updateManagerLevelAction.jsp" method="post">
									<!-- updateManagerLevelAction으로 넘버는 넘어가지만 화면은 보이지 않는다 -->
									<!-- form 밑에 작성 -->
									<input type="hidden" name="managerNo" value="<%=m.getManagerNo()%>"> 
										<select name="managerLevel">
											<%
												for(int i=0; i<3; i++){
													if(m.getManagerLevel() == i){ // if 문의 의미는..?
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
							<td><a href="<%=request.getContextPath() %>/manager/deleteManagerAction.jsp?managerNo=<%=m.getManagerNo()%>" class="btn btn-secondary">Delete</a></td>
						</tr>
				<%
					}
				%>
			</tbody>
		</table>
	
	<!-- 페이징 (이전, 다음) 버튼 만들기 -->
	<% 
		// 맨 첫 페이지에서 이전 버튼이 나오지 않게 함
		if(currentPage > 1) {
	%>
			<a href="<%=request.getContextPath()%>/manager/managersList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">
				<button class="btn btn-secondary">Previous</button>
			</a>
	<%
		}
	
		// 맨 마지막 페이지에서 다음 버튼이 보이지 않도록 함
		int lastPage = totalRow / rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage += 1; // lastPage = lastPage+1; lastPage++;
		}
		
		if(currentPage < lastPage) {
	%>
			<a class="btn btn-secondary" href="<%=request.getContextPath()%>/manager/managersList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">Next</a>
	<%
		}
	%>
		</div>	
	</section>
	
	<!-- footer -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include> 
		<!-- 인클루드는 프로젝트명을 안 붙인다, 다른 페이지를 현재 페이지에 포함하는 기능  -->
	</div>
</body>
</html>