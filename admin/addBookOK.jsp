<%@page import="userInfo.UserInfoDBBean"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="bookInfo.BookInfoDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<jsp:useBean id="book" class="bookInfo.BookInfoBean"></jsp:useBean>
<jsp:setProperty property="*" name="book"/>
<%
	String userID = (String)session.getAttribute("userID");
	UserInfoDBBean userDB = UserInfoDBBean.getInstance();
	int isAdmin = userDB.isAdmin(userID);
	
	if(isAdmin == 0){
		response.sendRedirect("../intro/intro.jsp");
	}
	String path = request.getRealPath("bookImgs");
	int size = 1024 * 1024;
	int fileSize = 0;
	String file = "";
	String orifile = "";
	
	MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
	Enumeration files = multi.getFileNames();
	String str = (String)files.nextElement();
	file = multi.getFilesystemName(str);
	
	if(file != null){
		orifile = multi.getOriginalFileName(str);
		fileSize = file.getBytes().length;
	}	

	BookInfoDBBean db = BookInfoDBBean.getInstance();
	String nation = multi.getParameter("nation");
	String kind = multi.getParameter("category");
	String category = nation + kind;
	int bookNum = db.getCategoryNumber(category);
	String bookName = multi.getParameter("bookName");
	int bookPrice = Integer.parseInt(multi.getParameter("bookPrice"));
	String bookDetails = multi.getParameter("bookDetails");
	String bookPub = multi.getParameter("bookPub");
	String author = multi.getParameter("author");
	int bookStock = Integer.parseInt(multi.getParameter("bookStock"));
	
	book.setBookNum(bookNum);
	book.setBookName(bookName);
	book.setBookPrice(bookPrice);
	book.setBookDetails(bookDetails);
	book.setBookPub(bookPub);
	book.setAuthor(author);
	book.setBookStock(bookStock);
	
	//책 표지가 없으면 디폴트 이미지를 삽입하게함
	if(file != null){
		book.setBookImg(file);
	}else{
		//디폴트이미지
		book.setBookImg("1982652580_Rduoi1ZX_72704eab8b8ec771df4571a53f770b306f576bc1.png");
	}
	
	int re = db.insertBookInfo(book);
	
	if(re == 1){
		response.sendRedirect("./index.jsp");
	}else{
%>
		<script>
			alert("추가에 실패했습니다.");
			history.back();
		</script>
<%		
	}
%>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
	
</body>
</html>