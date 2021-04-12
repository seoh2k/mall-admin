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

  <title>ClientList</title>
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
		// 현재 페이지
		int currentPage = 1; //현재 페이지 초기화
		if(request.getParameter("currentPage") != null){ //숫자를 받아온다면 그 숫자로 바꿔준다
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
			
		// 페이지 당 행의 수
		int rowPerPage = 10; // 초기화
		if(request.getParameter("rowPerPage") != null){ //숫자를 받아온다면 그 숫자로 바꿔준다
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		}
		
		// 검색어
		String searchWord = ""; //디폴트 값
		if(request.getParameter("searchWord") != null){
			searchWord = request.getParameter("searchWord");
		}
		
		// 시작 행
		int beginRow = (currentPage - 1) * rowPerPage;
		
		// 전체 데이터의 개수
		int totalRow = ClientDao.totalCount(searchWord);
		System.out.println("totalRow: "+ totalRow); // totalRow를 잘 받아오는지 디버깅
		
		// list 생성
		ArrayList<Client> list = ClientDao.selectClientListByPage(rowPerPage, beginRow, searchWord);
	%>
	<section id="faq" class="faq section-bg">
		<div class="container">
		  <div class="section-title">
		    <h2>CLIENTLIST</h2>
		  </div>
			<form action="<%=request.getContextPath() %>/client/clientList.jsp" method="post">
				<input type="hidden" name="searchWord" value="<%=searchWord%>"> <!-- rowPerPage와 연동 -->
				<button type="submit" class="btn btn-secondary">Showing</button>
				<select name="rowPerPage">
					<%
						for(int i=10; i<=30; i+=5){
							if(rowPerPage == i){
					%>		
								<option value="<%=i %>" selected="selected"><%=i %></option>	
					<%		
							
							} else {
					%>		
								<option value="<%=i %>"><%=i %></option>	
					<%			
							}
						}
					%>
				
				</select>
			</form>
			<table class="table">
				<thead>
					<tr>
						<th>Email</th>
						<th>Date</th>
						<th>Update</th>
						<th>Delete</th>
					</tr>
				</thead>
				<tbody>
					<%
						for(Client c: list){
					%>
							<tr>
								<td><%=c.getClienMail() %></td>
								<td><%=c.getClientDate().substring(0, 11) %></td> <!-- 0~11외에는 자름 -->
								<td><a class="btn btn-secondary" href="<%=request.getContextPath()%>/client/updateClientForm.jsp?clientMail=<%=c.getClienMail()%>">Update</a></td>
								<td><a class="btn btn-secondary" href="<%=request.getContextPath()%>/client/deleteClientAction.jsp?clientMail=<%=c.getClienMail()%>">Delete</a></td>
							</tr>
					<%
						}
					%>
				</tbody>
			</table>
		
			<!--  페이징 -->
			<%
				if(currentPage >1){
			%>
					<!-- List.jsp가 폴더 안에 있을 때 폴더명도 꼭 입력하기 -->
					<a class="btn btn-secondary" href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">Previous</a>
			<%		
				}
				System.out.println("currentPage: " + currentPage);
				
				int lastPage = totalRow / rowPerPage; //마지막 페이지
				if(totalRow % rowPerPage != 0) {
					lastPage += 1;
				}
				
				if (currentPage < lastPage){
			%>
		    		<a class="btn btn-secondary" href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">Next</a>
			<%
				}
			%>
			
			<form action="<%=request.getContextPath()%>/client/clientList.jsp" method="post" class="input-group mb-3" style="padding-top: 6px; width: 50%; margin: auto;">
				<input type="hidden" name="rowPerPage" value="<%=rowPerPage %>"> <!-- searchWord와 연동 -->
				<input type="text" name="searchWord" class="form-control" placeholder="Client Mail">
				<div class="input-group-append">
					<button type="submit" class="btn btn-success" style="background-color: #5c9f24; border: none;">SEARCH</button>
				</div>
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