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
		int no = Integer.parseInt(request.getParameter("no"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		BoardDTO dto = new BoardDTO();
		dto.setTbltitle(title);
		dto.setTblcontent(content);
		dto.setTblno(no);
		BoardDAO dao = BoardDAO.getInstance();
		int result = dao.modiList(dto);
		if (result > 0) {
			/* response.sendRedirect("list.jsp"); */
	%>
	<script type="text/javascript">
		alert("수정완료함!");
		location.href = "list.jsp";
	</script>
	<%
		}
	%>
</body>
</html>
