<%@page import="com.bitcamp.dao.BoardDAO"%>
<%@page import="com.bitcamp.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String writer = request.getParameter("writer");

		BoardDTO dto = new BoardDTO();
		dto.setTbltitle(title);
		dto.setTblcontent(content);
		dto.setTblwriter(writer);
		
		BoardDAO dao = BoardDAO.getInstance();
		dao.insertList(dto);
		response.sendRedirect("list.jsp");
	%>
</body>
</html>
