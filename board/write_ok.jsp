<%@page import="java.net.InetAddress"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.jspsmart.upload.File"%>
<%@page import="lifeBookBoard.BoardDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="board" class="lifeBookBoard.BoardBean"></jsp:useBean>
<jsp:setProperty property="*" name="board"/>
<%
	String path = request.getRealPath("boardUpload");	
	int size = 1024 * 1024;
	int fileSize = 0; 
	String file = "";
	String oriFile = "";
	
	MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
	Enumeration files = multi.getFileNames();
	String str = (String) files.nextElement();
	file = multi.getFilesystemName(str);
	
	if (file != null) {
		oriFile = multi.getOriginalFileName(str);
		fileSize = file.getBytes().length;
}
%>
	
<%
	board.setUserID(multi.getParameter("userID"));
	board.setBoardTitle(multi.getParameter("boardTitle"));
	board.setBoardContent(multi.getParameter("boardContent"));
	board.setRegDate(new Timestamp(System.currentTimeMillis()));
	
	InetAddress address = InetAddress.getLocalHost();
	String ip = address.getHostAddress();
	board.setUserIP(ip);
	
	if (file != null) {
		board.setFileName(file);
		board.setFileSize(fileSize);
		board.setRealFileName(oriFile);
	}
	
	BoardDBBean db = BoardDBBean.getInstance(); 
	
	int re = db.insertBoard(board);
	
	if (re == 1) {
		response.sendRedirect("../board/freeboard.jsp");
	} else {
		response.sendRedirect("../board/write.jsp");	
	}
%>