<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- ======= Header ======= -->
  <header id="header" class="fixed-top">
    <div class="container d-flex align-items-center">

      <h1 class="logo mr-auto"><a href="<%=request.getContextPath()%>/adminIndex.jsp">BOOKSTORE</a></h1>
      <!-- Uncomment below if you prefer to use an image logo -->
      <!-- <a href="index.html" class="logo mr-auto"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->

      <nav class="nav-menu d-none d-lg-block">
        <ul>
			<li class="active"><a href="<%=request.getContextPath()%>/adminIndex.jsp">Home</a></li>
			<li><a href="<%=request.getContextPath()%>/manager/managerList.jsp">Manager</a></li>
			<li><a href="<%=request.getContextPath()%>/client/clientList.jsp">Client</a></li>
			<li><a href="<%=request.getContextPath()%>/category/categoryList.jsp">Category</a></li>
			<li><a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">Ebook</a></li>
			<li><a href="<%=request.getContextPath()%>/orders/ordersList.jsp">Order</a></li>
			<!-- R(list, one) 레벨 1 이상, CUD 레벨 2 이상 -->
			<li><a href="<%=request.getContextPath()%>/notice/noticeList.jsp">Notice</a></li>
		</ul>
      </nav><!-- .nav-menu -->

      <a href="<%=request.getContextPath()%>/manager/logoutManagerAction.jsp" class="get-started-btn scrollto">Logout</a>

    </div>
  </header><!-- End Header -->