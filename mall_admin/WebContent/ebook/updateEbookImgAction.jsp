<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %> <!-- 파일을 넘기면 할일이 많은데 cos.jar를 이용하면 쉬워진다 -->
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%
	//updateEbookImgAction
	
	// String ebookISBN = request.getParameter("ebookISBN");
	// String ebookImg = request.getParameter("ebookImg");
	// System.out.println("ebookISBN: " + ebookISBN); // why null? enctype을 
	// System.out.println("ebookImg: " + ebookImg); // why null?
			
	// 파일 다운로드 받을 위치
	// 새로고침 바로 확인 가능하나 폴더에서는 확인x
	// String path = application.getRealPath("img"); // 이미지 폴더를 찾아서 위치를 말해준다 // img라는 폴더의 OS상의 실제 폴더를 텍스트 형태로 떨어져준다
	//새로고침하면 확인 가능하고 폴더에서도 확인 가능
	String path = "C:/goodee/web/mall_admin/WebContent/img"; // 집에선 경로 다르게 설정
	System.out.println(path);
	int size = 1024 * 1024 * 100 ; // 100 메가바이트
	// 1000 * 60 * 60 * 24 : 하루
	MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy() ); 
	// 첫번쨰 매개변수: 리퀘스트를 받았는데 해석을 못해서 리퀘이스 통째로 위임해버린다. 리퀘스트 해석하는 기능을 가지고잇다. 리퀘스트 안에는 이북의 이미지를 가지고있ㄴ다.
	// 두번째 매개변수: 파일 저장 위치
	// 세번째 매개변수 : 허용 파일크기
	// 네번째 : 인코딩 방식
	// 다섯번째: 중복된 이름 처리 방식
	
	String ebookISBN = multi.getParameter("ebookISBN");
	String ebookImg = multi.getFilesystemName("ebookImg");
	System.out.println("ebookISBN: "+ebookISBN);
	System.out.println("ebookImg: "+ebookImg);
	
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookImg(ebookImg);
	EbookDao.updateEbookImg(ebook);
	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebookISBN);
	
%>