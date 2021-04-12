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

  <title>noticeOne</title>
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
	// 수집 (noticeList에서 클릭한 공지 noticeNo)
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println(noticeNo+"<-- noticeOne의 noticeNo"); // 디버깅
	
	// dao연결
	Notice notice = NoticeDao.selectNoticeOne(noticeNo);
	System.out.println(notice); // 디버깅
%>
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<!-- include 사용 시에 프로젝트명 필요없음 -->
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
		
	<!-- ======= 요약리스트 Section ======= -->
    <section id="faq" class="faq section-bg">
      <div class="container">

        <div class="section-title">
          <h2><%=notice.getNoticeTitle()%></h2>
        </div>
		<!-- noticeOne 테이블 생성 -->
		<table class="table">
			<tr>
				<th>No.</th>
				<td><%=notice.getNoticeNo()%></td>
			</tr>
			<tr>
				<th>Content</th>
				<td><%=notice.getNoticeContent()%></td>
			</tr>
			<tr>
				<th>Id</th>
				<td><%=notice.getManagerId()%></td>
			</tr>
			<tr>
				<th>Date</th>
				<td><%=notice.getNoticeDate().substring(0,11)%></td>
			</tr>
		</table>
		<a href="<%=request.getContextPath()%>/notice/updateNoticeOneForm.jsp?noticeNo=<%=notice.getNoticeNo()%>"><button class="btn btn-secondary">Update</button></a>
		<a href="<%=request.getContextPath()%>/notice/deleteNoticeAction.jsp?noticeNo=<%=notice.getNoticeNo()%>"><button class="btn btn-secondary">Delete</button></a>
		
		<!-- 댓글 입력 폼 -->
		<form action="<%=request.getContextPath() %>/notice/insertCommnetAction.jsp" method="post">
			<!-- 현재 공지글 넘버 사용 -->
			<input type="hidden" name="noticeNo" value="<%=noticeNo%>">
			<div class="form-group" style="margin-top: 10px;">
				<!-- managerId 세션값 사용 -->
				<label for="usr">Manager Id:</label>
				<input type="text" name="managerId" value="<%=manager.getManagerId() %>" readonly="readonly" class="form-control" style="width: 30%; ">
			</div>
			<div class="form-group">
				<textarea name="commentContent" rows="2" cols="80" class="form-control"></textarea>
			</div>
			<button type="submit" class="btn btn-secondary" style="background-color: #5c9f24; border: none;">Add</button>
		</form>
		
		<!-- 댓글 리스트 -->
		<%
			ArrayList<Comment> commentList = CommentDao.selectCommentListByNoticeNo(noticeNo);
			for(Comment c : commentList){
		%>
				<table class="table">
					<tr>
						<td><%=c.getCommentContent() %></td>
						<td><%=c.getCommentDate().substring(0,11) %></td>
						<td><%=c.getManagerId() %></td>
						<td><a class="btn btn-secondary" href="<%=request.getContextPath() %>/notice/deleteCommentAction.jsp?commentNo=<%=c.getNoticeNo()%>&noticeNo=<%=notice.getNoticeNo()%>">Delete</a></td>
					</tr>
				</table>
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