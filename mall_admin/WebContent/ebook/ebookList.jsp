<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.util.*" %>
<%@ page import="java.util.*" %>
<%
	// 매니저인 사람들만 고객리스트에 접근할 수 있게 함
	// 매니저가 아니라면 다시 adminIndex로 보내버림
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

  <title>ebookList</title>
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
	// 현재 페이지
	int currentPage = 1; //현재 페이지 초기화
	if(request.getParameter("currentPage") != null){ // 숫자를 받아온다면 그 숫자로 바꿔준다
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
		
	// 페이지 당 행의 수
	int rowPerPage = 10; // 초기화
	if(request.getParameter("rowPerPage") != null){ // 숫자를 받아온다면 그 숫자로 바꿔준다
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	
	// 시작 행
	int beginRow = (currentPage - 1) * rowPerPage;
	
	// 전체 데이터의 개수
	int totalRow = EbookDao.totalCount();
	System.out.println("totalRow: "+ totalRow); // totalRow를 잘 받아오는지 디버깅
	
	// 카테고리별 목록
    String categoryName ="";
    if(request.getParameter("categoryName") != null){
       categoryName = request.getParameter("categoryName");
    }
    System.out.println("categoryName : " + categoryName);
    
 // list 생성
    ArrayList<Ebook> list = EbookDao.selectEbookList(rowPerPage, beginRow, categoryName);
%>
	<!-- 관리자 화면 메뉴(네비게이션) include -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include> 
		<!-- 인클루드는 프로젝트명을 안 붙인다, 다른 페이지를 현재 페이지에 포함하는 기능  -->
	</div>
	
	<!-- ======= Portfolio Section ======= -->
    <section id="faq" class="faq section-bg">
		<div class="container">

        <div class="section-title">
          <h2>EBOOKLIST</h2>
        </div>
		
		<!-- 카테고리별 목록을 볼 수 있는 메뉴(네비게이션) -->
		<div style="text-align:center;">
			<a class="btn btn-outline-success" href="<%=request.getContextPath()%>/ebook/ebookList.jsp">ALL</a>
		<%
			ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
			for(String s : categoryNameList){
		%>
				<a class="btn btn-outline-success" href="<%=request.getContextPath()%>/ebook/ebookList.jsp?categoryName=<%=s%>"><%=s %></a>
		<%
			}
		%>
        </div>
		
		<a href="<%=request.getContextPath()%>/ebook/insertEbookForm.jsp"><button class="btn btn-secondary" style="background-color: #5c9f24; border: none;">Add</button></a></li>
		
		<!-- rowPerPage별 페이징 -->	
		<table class="table">
			<thead>
				<th>Category</th>
				<th>ISBN</th>
				<th>Title</th> <!-- 상세보기 만들기 -->
				<th>Author</th>
				<th>Date</th>
				<th>Price</th>
			</thead>
			<tbody>
				<%
					for(Ebook e : list){
				%>
						<tr>
							<td><%=e.getCategoryName() %></td>
							<td><%=e.getEbookISBN() %></td>
							<!--  -->
							<td><a href="<%=request.getContextPath()%>/ebook/ebookOne.jsp?ebookISBN=<%=e.getEbookISBN()%>"><%=e.getEbookTitle() %></a></td>
							<td><%=e.getEbookAuthor() %></td>
							<td><%=e.getEbookDate().substring(0,11) %></td>
							<td><%=e.getEbookPrice() %></td>
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
				<a class="btn btn-secondary" href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage-1%>&categoryName=<%=categoryName%>">Previous</a>
		<%		
			}
			System.out.println("currentPage: " + currentPage);
			
			int lastPage = totalRow / rowPerPage; //마지막 페이지
			if(totalRow % rowPerPage != 0) {
				lastPage += 1;
			}
			
			if (currentPage < lastPage){
		%>
	    		<a class="btn btn-secondary" href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage+1%>&categoryName=<%=categoryName%>">Next</a>
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