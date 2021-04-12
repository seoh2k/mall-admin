<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>insertManagerForm</title>
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
	<section id="services" class="services">
      <div class="container">

        <div class="section-title">
          <h2>INSERT MANAGER</h2>
        </div>
        <div>
			<a href="<%=request.getContextPath()%>/adminIndex.jsp" class="btn btn-secondary" style="background-color: #5c9f24; border: none;">Home</a>
		</div>
		<form action="<%=request.getContextPath()%>/manager/insertManagerAction.jsp" method="post">
			<table class="table">
				<tr>
					<th>Id</th><!-- 중복되면 입력창으로 돌아옴 --><!-- 영어 소문자 5자에서 20자까지 생성 -->
					<td><input type="text" name="managerId" class="form-control" required pattern="^[a-z0-9]{5,20}$" style="width: 30%;"></td>
				</tr>
				<tr>
					<th>Password</th><!-- 4이상 10자리 이하 영소문자+숫자+특수문자  -->
					<td><input type="password" name="managerPw" class="form-control" required pattern="^[a-z0-9\W]{4,10}$" style="width: 30%;"></td>
				</tr>
				<tr>
					<th>Name</th><!-- 2글자 이상 100글자 이하 영어(대문자/소문자)+한글 입력 가능 -->
					<td><input type="text" name="managerName" class="form-control" required pattern="^[a-zA-Z가-힣]{2,100}$" style="width: 30%;"></td>
				</tr>
			</table>
			<button type="submit" class="btn btn-secondary">Add</button>
		</form>
		</div>
	</section>
</body>
</html>