<%@page import="com.bitcamp.dao.BoardDAO"%>
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
		int no = Integer.parseInt(request.getParameter("no"));
		BoardDAO dao = BoardDAO.getInstance();
		int result = dao.delList(no);
		if (result > 0) {
	%>
	<script type="text/javascript">
		alert('삭제완료함!');
		location.href = "list.jsp";
	</script>
	<%
		}
		/* response.sendRedirect("list.jsp"); */
	%>

</body>
</html>
