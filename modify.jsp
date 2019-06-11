<%@page import="com.bitcamp.dto.BoardDTO"%>
<%@page import="com.bitcamp.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
ul li {
	list-style: none;
}
</style>
</head>
<body>
	<%
		int no = Integer.parseInt(request.getParameter("no"));
		BoardDAO dao = BoardDAO.getInstance();
		BoardDTO dto = dao.detailList(no);
	%>
	<form method="post" action="moresult.jsp">
		<ul>
			<li><input type="hidden" id="no" name="no"
				value="<%=dto.getTblno()%>"></li>
			<li><label for="title">제목</label> <input type="text" id="title"
				name="title" value="<%=dto.getTbltitle()%>"></li>
			<li><label for="content">내용</label> <textarea rows="4" cols="20"
					id="content" name="content"> <%=dto.getTblcontent()%></textarea></li>
			<li><input type="submit" value="수정하기"> <input
				type="reset" value="취소하기"></li>
		</ul>
	</form>
</body>
</html>
