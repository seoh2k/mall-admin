<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 관리자만 접근할 수 있게 하는 메소드 
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>orderList</title>
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
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<!-- include 사용 시에 프로젝트명 필요없음 -->
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<!-- ======= 요약리스트 Section ======= -->
    <section id="faq" class="faq section-bg">
      <div class="container">

        <div class="section-title">
          <h2>ORDERLIST</h2>
        </div>
	
		<!-- rowPerPage별 페이징 -->
	<%
		// 현재 페이지
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
		int totalRow = OrdersDao.totalCount();
		System.out.println(totalRow+"<-- ordersList totalRow"); // 디버깅
		
		// list 생성	
		ArrayList<OrdersAndEbookAndClient> list = OrdersDao.selectOrdersListByPage(rowPerPage, beginRow);
	%>
	
		<!-- 한 페이지당 몇 개씩 볼건지 선택하는 기능 -->
		<form action="<%=request.getContextPath()%>/orders/ordersList.jsp" method="post">
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
		
		<!-- 목록 테이블 -->
		<table class="table">
			<thead>
				<tr>
					<th>Order No.</th>
					<th>Ebook No.</th>
					<th>Ebook Title</th>
					<th>Client No.</th>
					<th>Client Mail</th>
					<th>Order Date</th>
					<th>Order State</th>
				</tr>
			</thead>
			<tbody>
			<%
				for(OrdersAndEbookAndClient oec : list) { // for each문
			%>
					<tr>
						<td><%=oec.getOrders().getOrdersNo()%></td>
						<td><%=oec.getOrders().getEbookNo()%></td>
						<td><a href="<%=request.getContextPath()%>/ebook/ebookOne.jsp?ebookISBN=<%=oec.getEbook().getEbookISBN()%>"><%=oec.getEbook().getEbookTitle() %></a></td>
						<td><%=oec.getOrders().getClientNo()%></td>
						<td><%=oec.getClient().getClienMail() %></td>
						<td><%=oec.getOrders().getOrdersDate().substring(0,10) %></td>
						<td>
							<form action="<%=request.getContextPath()%>/orders/updateOrdersAction.jsp" method="post">
								<input type="hidden" name="ordersNo" value="<%=oec.getOrders().getOrdersNo()%>">
								<select name="ordersState" class="form-control">
								<%
									String[] state = {"주문완료","주문취소"};
										for(String s: state){
											if(s.equals(oec.getOrders().getOrdersState())){
								%>			
												<option selected="selected" value="<%=s %>" ><%=s %></option>
								<%
											} else {
								%>			
												<option value="<%=s %>"><%=s %></option>
								<%			
											}
										}
								%>
								
								</select>
								<button type="submit" class="btn btn-secondary">Update</button>
							</form>
						</td>
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
					<a class="btn btn-secondary" href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">Previous</a>
		<%
			}
		
			// 맨 마지막 페이지에서 다음 버튼이 보이지 않도록 함
			int lastPage = totalRow / rowPerPage;
			if(totalRow % rowPerPage != 0) {
				lastPage += 1; // lastPage = lastPage+1; lastPage++;
			}
			
			if(currentPage < lastPage) {
		%>
				<a class="btn btn-secondary" href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">Next</a>
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